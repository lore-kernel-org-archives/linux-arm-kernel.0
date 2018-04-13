From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 13 Apr 2018 15:54:32 +0100
Subject: [RFC PATCH] arm64: fault: Don't leak data in ESR context for user
 fault on kernel VA
In-Reply-To: <20180413142101.GY16308@e103592.cambridge.arm.com>
References: <20180413100204.9674-1-peter.maydell@linaro.org>
 <20180413142101.GY16308@e103592.cambridge.arm.com>
Message-ID: <e17d802a-d949-2498-53ac-358ec0746221@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/04/18 15:21, Dave Martin wrote:
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
> 
> The usefulness of some of this information (particularly WnR) does not
> seem to be arch-dependent.  If this were reported in a portable way via
> siginfo, would it allow any known users to be simplified?
> 
> I'm wondering whether there's an argument for coming up with a generic
> solution for the future.  That wouldn't replace this patch though.
> 
>> able to report whether wild pointer accesses by the application are
>> reads or writes (since a wild write is a more serious bug than a
>> wild read), so we don't want to drop the ESR information entirely.
>>
>> For faulting addresses in the kernel, sanitize the ESR. We choose
>> to present userspace with the illusion that there is nothing mapped
>> in the kernel's part of the address space at all, by reporting all
>> faults as level 0 translation faults.
>>
>> These fields are safe to pass through to userspace as they depend
>> only on the instruction that userspace used to provoke the fault:
>>   EC IL ISV SAS SSE SRT SF AR CM WNR
>> All the other fields in ESR except DFSC are architecturally zero
>> for an L1 translation fault, so can be zeroed out without confusing
>> userspace.
> 
> While we're about it, it occurs to me that even for faults taken
> on user addresses, ESR exposes information that is not really
> relevant to userspace.  For example, the layout of the pagetables
> is not something that userspace can normally see, so it is strange
> to report the level at which a translation fault occurred etc.
> 
> If we are sanitising this information, we should perhaps squash
> all faults that specify a translation table level to a single level.
> 
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
> 
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

I think the problem with that is that memory type alignment faults also 
still have precedence over permission faults, meaning that valid device 
mappings could potentially be discovered by probing with deliberately 
misaligned accesses, which could give away the location of the vmalloc 
region.

Robin.

> If we err on the size of exposing too little information, we are less
> likely to get into problems later on...
> 
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> This RFC patch is an alternative proposal to Will's patch
>> https://patchwork.kernel.org/patch/10258781/
>> which simply removed the ESR record entirely for kernel addresses.
>>
>>   arch/arm64/mm/fault.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index bff11553eb05..933c6d3b906e 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -307,6 +307,57 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
>>   		__show_regs(regs);
>>   	}
>>   
>> +	/*
>> +	 * If the faulting address is in the kernel, we must sanitize the ESR.
>> +	 * From userspace's point of view, kernel-only mappings don't exist
>> +	 * at all, so we report them as level 0 translation faults.
>> +	 * (This is not quite the way that "no mapping there at all" behaves:
>> +	 * an alignment fault not caused by the memory type would take
>> +	 * precedence over translation fault for a real access to empty
>> +	 * space. Unfortunately we can't easily distinguish "alignment fault
>> +	 * not caused by memory type" from "alignment fault caused by memory
>> +	 * type", so we ignore this wrinkle and just return the translation
>> +	 * fault.)
>> +	 */
>> +	if (addr >= TASK_SIZE) {
>> +		switch (ESR_ELx_EC(esr)) {
>> +		case ESR_ELx_EC_DABT_CUR:
> 
> How do we hit the _CUR cases, and if we can, aren't we reporting
> information about an insn executed by the _kernel_ here?
> 
> Possibly we should delete those cases: if we took a _CUR exception with
> user_mode(regs) it looks a bit like we would have to have been executing
> at EL0 but somehow took the exception from EL1 to EL1.  That sounds like
> it should be impossible...
> 
> 
>> +		case ESR_ELx_EC_DABT_LOW:
>> +			/*
>> +			 * These bits provide only information about the
>> +			 * faulting instruction, which userspace knows already.
>> +			 * All other bits are architecturally required to be
>> +			 * zero for faults reported with a DFSCR indicating
>> +			 * a level 0 translation fault.
>> +			 */
>> +			esr &= ESR_ELx_EC_MASK | ESR_ELx_IL | ESR_ELx_ISV |
> 
> In the !ISV case, some of the other fields become architecturally
> UNKNOWN.  We should probably mask them out in that case, since they
> could expose something that EL0 is not supposed to see.
> 
>> +				ESR_ELx_SAS | ESR_ELx_SSE | ESR_ELx_SRT_MASK |
>> +				ESR_ELx_SF | ESR_ELx_AR | ESR_ELx_CM |
>> +				ESR_ELx_WNR;
>> +			esr |= ESR_ELx_FSC_FAULT;
>> +			break;
>> +		case ESR_ELx_EC_IABT_CUR:
>> +		case ESR_ELx_EC_IABT_LOW:
>> +			/*
>> +			 * Claim a level 0 translation fault.
>> +			 * All other bits are architecturally required to be
>> +			 * zero for faults reported with that DFSC value.
> 
> Nit: they're RES0, so they might become nonzero in the future, with
> unpredicatable (and possibly sensitive) meanings.  So it makes sense to
> hide them until we know they're safe to expose.
> 
>> +			 */
>> +			esr &= ESR_ELx_EC_MASK | ESR_ELx_IL;
>> +			esr |= ESR_ELx_FSC_FAULT;
>> +			break;
>> +		default:
>> +			/*
>> +			 * This should never happen (entry.S only brings us
>> +			 * into this code for insn and data aborts). Fail
>> +			 * safe by not providing an ESR context record at all.
>> +			 */
>> +			WARN(1, "ESR 0x%x is not DABT or IABT\n", esr);
>> +			esr = 0;
>> +			break;
>> +		}
>> +	}
>> +
>>   	tsk->thread.fault_address = addr;
>>   	tsk->thread.fault_code = esr;
>>   	si.si_signo = sig;
>> -- 
>> 2.16.2
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
