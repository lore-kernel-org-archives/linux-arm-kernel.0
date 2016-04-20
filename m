From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 20 Apr 2016 13:06:28 +0200
Subject: SoCFPGA with CONFIG_THUMB2_KERNEL boot error
In-Reply-To: <20160420110021.GH31470@pengutronix.de>
References: <20160419140220.GA9503@pengutronix.de>
 <20160420092516.GA21732@e103592.cambridge.arm.com>
 <CAKv+Gu8_hZvY1TK=D3bhwy6F2UW1kSeSGyRciU5wVQPHy0m7LA@mail.gmail.com>
 <CAKv+Gu9rzxtw2i1QJAU0C-y4Lmh6KDWH0p+TYNHsndr-6c11zw@mail.gmail.com>
 <20160420095541.GG31470@pengutronix.de>
 <CAKv+Gu_w-vXnB_56k2sNaTpo1k1DZuvmrS4rwi5kgx=MF4+e+Q@mail.gmail.com>
 <20160420110021.GH31470@pengutronix.de>
Message-ID: <CAKv+Gu8dmYDqri7Nt_A6vKTQo1eqFa7G=wdYQ8ad7EaT_smA7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 April 2016 at 13:00, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, Apr 20, 2016 at 12:26:22PM +0200, Ard Biesheuvel wrote:
>> On 20 April 2016 at 11:55, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> > On Wed, Apr 20, 2016 at 11:43:30AM +0200, Ard Biesheuvel wrote:
>> >> (replying to self)
>> >>
>> >> On 20 April 2016 at 11:39, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> >> > (+ Arnd)
>> >> >
>> >> > On 20 April 2016 at 11:25, Dave Martin <Dave.Martin@arm.com> wrote:
>> >> >> On Tue, Apr 19, 2016 at 04:02:20PM +0200, Steffen Trumtrar wrote:
>> >> >>> Hi!
>> >> >>>
>> >> >>> According to kernelci.org (and validating on my own hardware), the current
>> >> >>> socfpga mainline kernel has an issue with CONFIG_THUMB2_KERNEL enabled.
>> >> >>>
>> >> >>> https://storage.kernelci.org/mainline/v4.6-rc4-11-g12566cc35d0e/arm-multi_v7_defconfig/lab-khilman/boot-socfpga_cyclone5_de0_sockit.html
>> >> >>>
>> >> >>> vs
>> >> >>>
>> >> >>> https://storage.kernelci.org/mainline/v4.6-rc4-11-g12566cc35d0e/arm-multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y/lab-khilman/boot-socfpga_cyclone5_de0_sockit.html
>> >> >>>
>> >> >>> Both boot successfully, but notice that the board fails to bring up CPU1 if
>> >> >>> thumb2 support is enabled.
>> >> >>>
>> >> >>> Any ideas why this might be happening?
>> >> >>
>> >>
>> >> Actually, this looks like a problem with the secondary entry point to
>> >> me. Could you try this?
>> >
>> > Been there, done that. Unfortunately this does not solve the problem.
>> >
>>
>> How about if you put this on top?
>>
>> diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
>> index 5d94b7a2fb10..c160fa3007e9 100644
>> --- a/arch/arm/mach-socfpga/headsmp.S
>> +++ b/arch/arm/mach-socfpga/headsmp.S
>> @@ -13,6 +13,7 @@
>>  #include <asm/assembler.h>
>>
>>         .arch   armv7-a
>> +       .arm
>
> \o/
>
> This did the trick, it now boots with two cpus up. Thanks for looking
> into this issue.
>
> I'll create a patch for this.
>

Great. I think just the last part may be sufficient, since the bx r4
in headsmp.S will do an interworking branch to Thumb2

Also, I noticed that the code in headsmp.S looks a bit strange. You
should really only need this:

-------8<-----------
diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
index 5d94b7a2fb10..7e4ab55cc529 100644
--- a/arch/arm/mach-socfpga/headsmp.S
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -13,6 +13,7 @@
 #include <asm/assembler.h>

        .arch   armv7-a
+       .arm

 ENTRY(secondary_trampoline)
        /* CPU1 will always fetch from 0x0 when it is brought out of reset.
@@ -21,15 +22,9 @@ ENTRY(secondary_trampoline)
         * where the physical memory does not start at 0x0.
        */
 ARM_BE8(setend be)
-       adr     r0, 1f
-       ldmia   r0, {r1, r2}
-       sub     r2, r2, #PAGE_OFFSET
+       ldr     r2, =socfpga_cpu1start_addr - PAGE_OFFSET
        ldr     r3, [r2]
        ldr     r4, [r3]
 ARM_BE8(rev    r4, r4)
        bx      r4
-
-       .align
-1:     .long   .
-       .long   socfpga_cpu1start_addr
 ENTRY(secondary_trampoline_end)
