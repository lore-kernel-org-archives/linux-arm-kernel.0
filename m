From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 13 Apr 2018 15:47:08 +0100
Subject: [RFC PATCH] arm64: fault: Don't leak data in ESR context for user
 fault on kernel VA
In-Reply-To: <20180413142101.GY16308@e103592.cambridge.arm.com>
References: <20180413100204.9674-1-peter.maydell@linaro.org>
 <20180413142101.GY16308@e103592.cambridge.arm.com>
Message-ID: <CAFEAcA8vw1YGKfFcd4dszBXAMLN1e1Qmat=msuE+HCfpMrGtGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 April 2018 at 15:21, Dave Martin <Dave.Martin@arm.com> wrote:
> On Fri, Apr 13, 2018 at 11:02:04AM +0100, Peter Maydell wrote:
>> If userspace faults on a kernel address, handing them the raw ESR
>> value on the sigframe as part of the delivered signal can leak data
>> useful to attackers who are using information about the underlying hardware
>> fault type (e.g. translation vs permission) as a mechanism to defeat KASLR.
>>
>> However there are also legitimate uses for the information provided
>> in the ESR -- notably the GCC and LLVM sanitizers would like to be
>
> "would like to" or "currently rely on for correct behaviour"?

Closer to the latter -- certainly if we just dropped ESR we would
change their behaviour in those situations, though they have a
fallback codepath I think so they wouldn't die entirely.

> The usefulness of some of this information (particularly WnR) does not
> seem to be arch-dependent.  If this were reported in a portable way via
> siginfo, would it allow any known users to be simplified?
>
> I'm wondering whether there's an argument for coming up with a generic
> solution for the future.  That wouldn't replace this patch though.

That would certainly be nice. QEMU has accumulated a collection
of per-arch per-OS signal handlers that have code of varying
degrees of ugliness to try to determine "was this a write"
when in a SIGSEGV/SIGBUS handler:

https://git.qemu.org/?p=qemu.git;a=blob;f=accel/tcg/user-exec.c;h=26a3ffbba1de229060f683f9f6a0ca80db988eb9;hb=refs/heads/master#l180

as has the LLVM sanitizer code:

https://github.com/llvm-mirror/compiler-rt/blob/master/lib/sanitizer_common/sanitizer_linux.cc#L1724

(though they seem to have managed to make it a bit less ugly
than QEMU :-))

> While we're about it, it occurs to me that even for faults taken
> on user addresses, ESR exposes information that is not really
> relevant to userspace.  For example, the layout of the pagetables
> is not something that userspace can normally see, so it is strange
> to report the level at which a translation fault occurred etc.
>
> If we are sanitising this information, we should perhaps squash
> all faults that specify a translation table level to a single level.

Mmm, maybe (though I guess level 0 fault is not so appropriate
here). TBH it feels a bit like an unnecessary level of gold-plating.

> There are certain fault types that should never be exposed to
> userspace, such as TLB conflict aborts, access flag faults, etc.
> See the changes upstream between v4.16 and torvalds/master (which I had
> temporarily forgotten about...)
>
> Now, __do_user_fault() is called for these cases but the signal has
> already been mapped to SIGKILL by this point via the fault_info[]
> table.  It doesn't matter too much what we do in such cases because
> the user task will be killed on signal delivery and so doesn't get a
> chance to inspect the ESR contents anyway.  It might be worth expanding
> the WARN() to catch mismaintenance of the fault_info[] table -- but that
> may be overkill.  Maybe adding some comments explaining the dependency
> is sufficient.

I don't entirely understand this paragraph, but if you want to
provide a comment I'm happy to fill it into a v2 of this patch :-)

>> The illusion is not entirely perfect, as there is a tiny wrinkle
>> where we will report an alignment fault that was not due to the memory
>> type (for instance a LDREX to an unaligned address) as a translation
>> fault, whereas if you do this on real unmapped memory the alignment
>> fault takes precedence. This is not likely to trip anybody up in
>> practice, as the only users we know of for the ESR information who
>> care about the behaviour for kernel addresses only really want to
>> know about the WnR bit.
>
> I tend to agree with this.  We could probably allow the alignment fault
> to show through, but I can't think of a reasonable scenario where
> userspace would legitimately rely on this.

If you always allow "alignment fault" DFSC values through, then you
are permitting userspace to distinguish kernel-space memory that
is Device memory from (unmapped or Normal), because it can do an
unaligned LDR access or similar, and see whether it gets a DFSC
for alignment fault or one for a translation error.

>> +     if (addr >= TASK_SIZE) {
>> +             switch (ESR_ELx_EC(esr)) {
>> +             case ESR_ELx_EC_DABT_CUR:
>
> How do we hit the _CUR cases, and if we can, aren't we reporting
> information about an insn executed by the _kernel_ here?
>
> Possibly we should delete those cases: if we took a _CUR exception with
> user_mode(regs) it looks a bit like we would have to have been executing
> at EL0 but somehow took the exception from EL1 to EL1.  That sounds like
> it should be impossible...

Yes, you're right that we shouldn't get here with the _CUR cases.
I think I was thinking there might be cases where the kernel
accessed userspace memory and reported faults with a signal,
but looking at the code we can't get to this function unless
user_mode() returned true. So we can let the default case handle
the _CUR cases too.

>> +             case ESR_ELx_EC_DABT_LOW:
>> +                     /*
>> +                      * These bits provide only information about the
>> +                      * faulting instruction, which userspace knows already.
>> +                      * All other bits are architecturally required to be
>> +                      * zero for faults reported with a DFSCR indicating
>> +                      * a level 0 translation fault.
>> +                      */
>> +                     esr &= ESR_ELx_EC_MASK | ESR_ELx_IL | ESR_ELx_ISV |
>
> In the !ISV case, some of the other fields become architecturally
> UNKNOWN.  We should probably mask them out in that case, since they
> could expose something that EL0 is not supposed to see.

The spec says they're RES0 when ISV is 0, and only UNKNOWN if ISV
is UNKNOWN (which only happens for Debug state accesses, which I
think are not relevant here).

We can certainly mask out the RES0 bits in the ISV==0 case, though.

>> +                             ESR_ELx_SAS | ESR_ELx_SSE | ESR_ELx_SRT_MASK |
>> +                             ESR_ELx_SF | ESR_ELx_AR | ESR_ELx_CM |
>> +                             ESR_ELx_WNR;
>> +                     esr |= ESR_ELx_FSC_FAULT;
>> +                     break;
>> +             case ESR_ELx_EC_IABT_CUR:
>> +             case ESR_ELx_EC_IABT_LOW:
>> +                     /*
>> +                      * Claim a level 0 translation fault.
>> +                      * All other bits are architecturally required to be
>> +                      * zero for faults reported with that DFSC value.
>
> Nit: they're RES0, so they might become nonzero in the future, with
> unpredicatable (and possibly sensitive) meanings.  So it makes sense to
> hide them until we know they're safe to expose.

OK, I'll tweak the comment text.

>> +                      */
>> +                     esr &= ESR_ELx_EC_MASK | ESR_ELx_IL;
>> +                     esr |= ESR_ELx_FSC_FAULT;
>> +                     break;
>> +             default:
>> +                     /*
>> +                      * This should never happen (entry.S only brings us
>> +                      * into this code for insn and data aborts). Fail
>> +                      * safe by not providing an ESR context record at all.
>> +                      */
>> +                     WARN(1, "ESR 0x%x is not DABT or IABT\n", esr);
>> +                     esr = 0;
>> +                     break;
>> +             }
>> +     }
>> +
>>       tsk->thread.fault_address = addr;
>>       tsk->thread.fault_code = esr;
>>       si.si_signo = sig;

thanks
-- PMM
