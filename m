From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 13 Oct 2016 14:27:15 +0200
Subject: [PATCH 2/2] power/reset: at91-poweroff: timely shitdown LPDDR
 memories
In-Reply-To: <20161013110317.ee6by6njrvs53ztx@piout.net>
References: <20161007163427.11454-1-alexandre.belloni@free-electrons.com>
 <20161007163427.11454-3-alexandre.belloni@free-electrons.com>
 <CACh+v5NCxPb_U8HOeczHicCD-Wp8BqBzvc1LtCzmEXZ74Cgshw@mail.gmail.com>
 <20161013110317.ee6by6njrvs53ztx@piout.net>
Message-ID: <CACh+v5PgwXsCoMROO+Vftx8bbhTXP1V-JdZmdwWJ0tgOUW1Axw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-10-13 13:03 GMT+02:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> On 12/10/2016 at 14:48:27 +0200, Jean-Jacques Hiblot wrote :
>> > +static void at91_lpddr_poweroff(void)
>> > +{
>> > +       asm volatile(
>> > +               /* Align to cache lines */
>> > +               ".balign 32\n\t"
>> > +
>> > +               "       ldr     r6, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
>> At first sight, it looks useless. I assume it's used to preload the
>> TLB before the LPDDR is turned off.
>> A comment to explain why this line is useful would prevent its removal.
>
> Yes, this is the case. I can add a comment.
>
> Anyway, I would prefer the whole thing to run from SRAM, as a PIE
> instead of relying on the cache.

Instead of copying into the SRAM, you can make the cache reliable by
preloading it, much like the TLB.
LDI is probably not available for most of atmel's SOC, so the only way
I can think of, is to execute code from the targeted area. here is an
example:
+               /*
+                * Jump to the end of the sequence to preload instruction cache
+                * It only works because the sequence is short enough not to
+                * sit accross more than 2 cache lines
+                */
+               "       b end_of_sequence\n\t"
+               "start_of_sequence:\n\t"
+
                /* Power down SDRAM0 */
                "       str     %1, [%0, #"
__stringify(AT91_DDRSDRC_LPR) "]\n\t"
                /* Shutdown CPU */
                "       str     %3, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"

                "       b       .\n\t"
+
+               /*
+                * we're now 100% sure that the code to shutdown the LPDDR and
+                * the CPU is in cache, go back to do the actual job
+                */
+               "end_of_sequence:\n\t"
+               "       b start_of_sequence\n\t"
                :


>
>> > +       ddr_type = readl(mpddrc_base + AT91_DDRSDRC_MDR) & AT91_DDRSDRC_MD;
>> > +       if ((ddr_type == AT91_DDRSDRC_MD_LPDDR2) ||
>> > +           (ddr_type == AT91_DDRSDRC_MD_LPDDR3))
>> Souldn't there be something like "pm_power_off = at91_lpddr_poweroff;" here ?
>>
>
> Indeed
>
>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
