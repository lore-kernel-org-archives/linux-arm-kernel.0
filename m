From: luto@amacapital.net (Andy Lutomirski)
Date: Sun, 16 Nov 2014 10:27:04 -0800
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141116171055.GM4042@n2100.arm.linux.org.uk>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141116165017.GT22465@brightrain.aerifal.cx>
 <20141116171055.GM4042@n2100.arm.linux.org.uk>
Message-ID: <CALCETrWiX-+tfucSd-ukS1ehUxT0Xx6N58DXHhpWuG+61=qMVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16, 2014 at 9:10 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Nov 16, 2014 at 11:50:17AM -0500, Rich Felker wrote:
>> On Sun, Nov 16, 2014 at 04:33:56PM +0000, Russell King - ARM Linux wrote:
>> > On Sun, Nov 16, 2014 at 12:56:56AM -0500, Rich Felker wrote:
>> > > Aside from that, the only case among the above that's "right" already
>> > > is v7+. Hard-coding the mcr-based barrier on v6 is wrong because it's
>> >
>> > I don't think it's wrong at all.  The instruction isn't going away from
>> > ARMv7, because ARMv7 deprecates it, but it _still_ has to be implemented
>> > by a CPU conforming to ARMv7.  As ARMv7 is going to be the last 32-bit
>> > ARM architecture, we aren't going to see the MCR instruction disappearing
>> > on 32-bit CPUs.
>> >
>> > On ARMv8, it may have been removed, but we have already decided that the
>> > kernel _must_ provide emulation for this op-code, because otherwise we
>> > are breaking existing userspace, which is just not permissible.  However,
>> > you are absolutely right that running on ARMv8 should use the new
>> > instruction where possible.
>>
>> Thanks for the clarification on the current and intended future
>> compatibility status!
>>
>> Emulation by the kernel would be something like 100x slower though,
>> no? While it's better than not working at all, I think that would be a
>> good argument for never using mcr explicitly unless either it's known
>> to be supported in hardware or there's no alternative (because kuser
>> helper is missing).
>
> Right, and that is "ARMv8 or later".
>
>> > > However neither is really very easy because it seems impossible to
>> > > detect whether the mcr-based barrier or the dmb-based barrier should
>> > > be used -- there's no hwcap flag to indicate support for the latter.
>> > > This also complicates what to do in builds for v6.
>> >
>> > It is entirely possible to detect whether you should use mcr or dmb, and
>> > you've said how to do that all the way through this message.  The mcr
>> > instruction is present on ARMv6, and present but deprecated on ARMv7.
>> > dmb is only present on ARMv7.  So, if you know the CPU architecture, you
>> > know whether you should be using nothing, mcr, or dmb.
>> >
>> > There's two ways to get that - firstly, the uname syscall, which gives
>> > a string in the form "armv..." which gives the CPU architecture.  The
>>
>> Isn't it clear from the "Windows 10" fiasco that strcmp on a version
>> string is NOT an acceptable way to determine version/capabilities?
>
> Would there be a "Windows 10" fiasco if there had been better control of
> the version numbering?  No.
>
> However, this is already in use as a CPU architecture thing.  It's had a
> /very/ long history of being used by package managers to detect which
> packages are suitable for installation on a platform, whether it be an
> x86 platform, PowerPC, or ARM platform.
>
>> > second way is the ELF AT_PLATFORM entry.  AT_PLATFORM has well defined
>> > format, and is already used to select between different library versions
>> > (so is already a user API, and is subject to user API rules).  See:
>> >
>> > $ grep string.*elf_name arch/arm/mm/proc*.S
>> >
>> > for a list of the prefixes - the last character is always the endian-ness.
>> > >From that, you can see that the format is "v" (for version), then the CPU
>> > architecture number, followed (optionally) by any suffixes.  Parse that
>> > wisely, and you have the CPU architecture version, and the CPU architecture
>> > version defines whether the MCR or DMB variant should be used.
>>
>> That seems much more acceptable to use.
>>
>> > See http://lwn.net/Articles/519085/ for a way to get at the ELF aux info
>> > with recent glibc.  I'm sure other C libraries will be getting their own
>> > implementation of that for compatibility with glibc.
>>
>> Yes, we have access to the aux vector, so this should work in
>> principle.
>
> In both of these cases, we know that:
> - ARMv1-ARMv3 is no longer supported (for several years)
> - ARMv4 and ARMv5 do not have either the MCR or DMB instructions.
> - ARMv6 has the MCR instruction only
> - ARMv7 has the MCR instruction and the DMB instruction.
> - ARMv8 has the DMB instruction, and MCR emulation.
>
> A safe bet would be that DMB is going to be there in the future (if that
> goes, then the ARM architecture will be regarded as even more of a toy
> architecture by Linus than he already regards it today, and he'll probably
> stop giving a damn about whether any changes break ARM.)
>
> Now, there is a twist here: ARM64 decided to use an ELF platform string
> of "aarch64" for everything, which means that rather than encoding the
> CPU architecture (like with every other Linux architecture), we have a
> string which encodes the kernel architecture instead, which is absurd.
> Obviously, the plan for ARM64 is that there will never be an ARMv9
> architecture, and ARMv8 is the perfect architecture for the future. :p
>
> So, a reasonable parsing of this would be:
>
>         const char *ptr;
>         int architecture;
>
>         ptr = (const char *)(uintptr_t)getauxval(AT_PLATFORM);
>         assert(ptr);
>
>         if (!strncmp(ptr, "aarch64", 7))
>                 architecture = 8;
>         else
>                 assert(sscanf(ptr, "v%d", &architecture) == 1);
>
>         switch (architecture) {
>         case 4:
>         case 5:
>                 no_mcr_dmb;
>                 break;
>         case 6:
>                 use_mcr;
>                 break;
>         default:
>                 use_dmb;
>                 break;
>         }
>
> That will be safe - we can't really predict what future architectures will
> do, but as I say above, if dmb vanishes in future with a preference for
> yet another different method, I think the ARM architecture will be laughed
> at even more than it is today.
>
> Before this is finalised, I think the ARM64 maintainers need to have a long
> think about the wiseness of their existing AT_PLATFORM string, and consider
> whether they have created something of a cockup there.  But that's /their/
> problem, it isn't an ARM32 problem, on ARM32 this is the solution which
> should be used.

Would it make sense for arm and arm64 to add bits for these features
to AT_HWCAP, along with an extra bit indicating that the kernel
provides these bits?

--Andy
