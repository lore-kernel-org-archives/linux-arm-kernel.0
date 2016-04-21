From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 21 Apr 2016 08:24:23 +0200
Subject: SoCFPGA with CONFIG_THUMB2_KERNEL boot error
In-Reply-To: <20160420235059.GF19428@n2100.arm.linux.org.uk>
References: <20160419140220.GA9503@pengutronix.de>
 <20160420092516.GA21732@e103592.cambridge.arm.com>
 <CAKv+Gu8_hZvY1TK=D3bhwy6F2UW1kSeSGyRciU5wVQPHy0m7LA@mail.gmail.com>
 <CAKv+Gu9rzxtw2i1QJAU0C-y4Lmh6KDWH0p+TYNHsndr-6c11zw@mail.gmail.com>
 <20160420095541.GG31470@pengutronix.de>
 <CAKv+Gu_w-vXnB_56k2sNaTpo1k1DZuvmrS4rwi5kgx=MF4+e+Q@mail.gmail.com>
 <20160420110021.GH31470@pengutronix.de>
 <CAKv+Gu8dmYDqri7Nt_A6vKTQo1eqFa7G=wdYQ8ad7EaT_smA7Q@mail.gmail.com>
 <20160420235059.GF19428@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu_FPAaHtwL4XkBL-hzd_a1uSHNiHiuxwTprn6d3xzJmzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 April 2016 at 01:51, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Apr 20, 2016 at 01:06:28PM +0200, Ard Biesheuvel wrote:
>> @@ -21,15 +22,9 @@ ENTRY(secondary_trampoline)
>>          * where the physical memory does not start at 0x0.
>>         */
>>  ARM_BE8(setend be)
>> -       adr     r0, 1f
>> -       ldmia   r0, {r1, r2}
>> -       sub     r2, r2, #PAGE_OFFSET
>> +       ldr     r2, =socfpga_cpu1start_addr - PAGE_OFFSET
>
> NAK.  Where do you expect the assembler to place the literal pool for
> this constant?  The only way that'll work is if it's placed before
> "ENTRY(secondary_trampoline_end)" below, but there's no guarantee
> (afaik) where literal pools will be placed.
>

Ah yes, we'd still need to put an .ltorg directive before the end marker.

Alternatively, we could keep the explicit literal but subtract
PAGE_OFFSET there directly (but drop the unused '.' literal and
replace adr+ldmia with ldr)

>>         ldr     r3, [r2]
>>         ldr     r4, [r3]
>>  ARM_BE8(rev    r4, r4)
>>         bx      r4
>> -
>> -       .align
>> -1:     .long   .
>> -       .long   socfpga_cpu1start_addr
>>  ENTRY(secondary_trampoline_end)
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
