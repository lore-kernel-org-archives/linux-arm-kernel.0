From: grundler@google.com (Grant Grundler)
Date: Thu, 4 May 2017 10:47:54 -0700
Subject: ARMv7 doesn't define CR_U?
In-Reply-To: <20170504165450.GG22219@n2100.armlinux.org.uk>
References: <CANEJEGv2snHD8vcAu2Hyu1839VdkCwUsRKOa28AsuHnvyZWwBw@mail.gmail.com>
 <20170504165450.GG22219@n2100.armlinux.org.uk>
Message-ID: <CANEJEGuBCkr+BYPaOrpSFjM2befmZKGWnXynGPdVH1T5rpDnFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 4, 2017 at 9:54 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, May 04, 2017 at 09:35:15AM -0700, Grant Grundler wrote:
>> I'm seeing unaligned accesses from sadc[1] (compiled with llvm) are
>> getting SIGBUS on an QCA IPQ4019 chipset despite ARMv7 CPU claiming to
>> support unaligned accesses[1].   My question is about use of CR_U on
>> ARMv7 in cpu_is_v6_unaligned().
>
> Not every ARM instruction can cope with unaligned accesses.  Single
> integer instructions can (LDR/STR, LDRH/STRH) but not LDM/STM or
> the VFP instructions.
>
>> And kernel output from a different invocation:
>> [  226.596867] Alignment trap: not handling instruction f9602aef at [<2a0062b6>]
>> [  226.596925] Unhandled fault: alignment exception (0x001) at 0x2a014088
>
> This seems to be this instruction:
>    0:   f960 2aef       vld1.64 {d18-d19}, [r0 :128]
>
> which is a SIMD load, which specifies an alignment of 128 bits.
>
>> But it looks like our kernel[2] should be handling this unaligned access:
>> # cat /proc/cpu/alignment
>> User:           16
>> System:         0
>> Skipped:        16
>> Half:           0
>> Word:           0
>> DWord:          0
>> Multi:          0
>> User faults:    2 (fixup)
>>
>> Since Documentation/arm/mem_alignment doesn't seem to match the
>> code[2], I'm not sure what to expect here.
>
> Only known instructions (LDR/STR/LDM/STM) are fixed up.  VFP and SIMD
> are never fixed up (to do so would be very complex.)
>
>> arch/arm/include/asm/cp15.h:
>> #define CR_U    (1 << 22)       /* Unaligned access operation           */
>>
>> But bit 22 isn't defined in the Cortex A7 (an ARMv7-A cpu).
>>
>> "Cortex-A7 MPCore Technical Reference Manual"
>> "4.3.27. System Control Register"
>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0464f/BABJAHDA.html
>>
>> says bit 22 is "Reserved, RAO/SBOP."
>
> RAO = read as one.  The bit _is_ the unaligned access operation, and what
> the ARM ARM is telling you is that the bit has been retired, and it is now
> defined to always be '1', meaning the CPU fixes up the single integer
> load/store instructions.

Ah - thanks Russell!

>
> You're basically out of luck if you want to do a SIMD unaligned load.
> These are simply not supported.

ACK - thanks - I didn't know what RAO meant (I had guessed RAZ == Read
as Zero) and didn't know this was a SIMD instruction.

I'll see if I can tell clang to just not emit SIMD instructions when
building sys-stat (which provides sadc) package.


Robin - thanks for info on alignment hints - I'll forward to our
compiler team so they can follow up.  They've already expressed
concern that sadc code is loaded with incorrect casts (aliasing) to
pointers and I'm not sure what the "right" options are here given sadc
is more or less "legacy" code.

cheers,
grant
