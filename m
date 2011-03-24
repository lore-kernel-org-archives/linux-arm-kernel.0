From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 24 Mar 2011 16:52:06 +0000
Subject: RFC: ARM: Support for VFP/NEON registers in coredumps
In-Reply-To: <OFAB8D9B91.5F6DE70D-ONC125785D.0059E446-C125785D.005B916C@de.ibm.com>
References: <20110324141826.GA3810@arm.com>
	<OF1A9833E7.A620B0FF-ONC125785D.004F4BC3-C125785D.0052255A@de.ibm.com>
	<AANLkTin+X7BNBE9ZuDQhHVeNQqeNPjqj16pZDLTag_n+@mail.gmail.com>
	<OFAB8D9B91.5F6DE70D-ONC125785D.0059E446-C125785D.005B916C@de.ibm.com>
Message-ID: <AANLkTinzxmULwhgXHbAUw0zveYXYj8zxRgZkoPYdOPhc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2011 at 4:40 PM, Ulrich Weigand
<Ulrich.Weigand@de.ibm.com> wrote:
> Dave Martin <dave.martin@linaro.org> wrote:
>> On Thu, Mar 24, 2011 at 2:57 PM, Ulrich Weigand
> <Ulrich.Weigand@de.ibm.com> wrote:
>> > 1) Have *two* new note types, one for VFP, and one for NEON
>>
>> That may not make sense, since really it's a single register file
>> shared by VFP and NEON. ?With NEON, you always have 32 x 64-bit regs,
>> but it's possible (although rare) to have this many regs on ARMv7 even
>> if NEON is absent.
>
> OK, agreed.
>
>> > 2) Have GDB look into the AT_HWCAP setting in the NT_AUXV note
>> >
>> > Option 2) seems preferable to me, since NT_AUXV is already there,
>> > and it can also be used to detect the integer-only NEON case.
>>
>> We could also dump the relevant hardware capability registers, which
>> can be more informative, though I'm in two minds about whether this is
>> appropriate / beneficial. ?A layout something like this might work:
>>
>> NT_VFPREGSET*
>>
>> ? ? unsigned long flags;
>> ? ? unsigned long feature_registers[3];
>> ? ? unsigned long fpscr;
>> ? ? unsigned long long regs[16 or 32];
>>
>> There are currently 3 relevant feature registers, the main
>> floating-point ID register FPSID, and the floating-point / SIMD
>> feature registers MVFR0, MVFR1.
>>
>> In either case, we define the contents of the flags field in such a
>> way as to allow gdb to understand the format, and to allow for future
>> expansion if this is ever needed.
>>
>> (*The note types seem to use different names in linux/elf.h compared
>> with /usr/include/elf.h and GDB. ?I've followed the outside world's
>> convention here.)
>
> I would prefer to keep the contents of NT_VFPREGSET identical to the
> contents of the PTRACE_GETVPFREGS/PTRACE_SETVPFREGS buffer:
>
> - This would allow implementation via the new generic user_regset_view
> ?mechanism (which the ARM kernel doesn't use yet, but probably should)
>
> - In any case, GDB likes to have the same set of information available
> ?when debugging core files and native targets
>
> So if there is indeed additional information that would be interesting,
> I'd argue this should be presented as a *new* core file note, *and* as
> a new set of PTRACE_... APIs. ? (But for GDB's purpose NT_AUXV right
> now is sufficent. ?Everything else could be displayed to the user if
> of interest.)

OK, that sounds reasonable.

If I'm reading the kernel code correctly, the size of the data
returned by PTRACE_GETVFPREGS is already dependent on the number of
registers (D16/D32) implemented by the hardware, and this is
determinable from the auxv contents; so I guess we don't have a new
problem to solve here.

The other info can always be added in a later pass, if it looks like
it would be useful...

Cheers
---Dave
