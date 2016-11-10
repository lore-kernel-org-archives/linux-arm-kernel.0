From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 10 Nov 2016 11:19:20 +0100
Subject: [PATCH v2 7/7] soc: renesas: Identify SoC and register with the
 SoC bus
In-Reply-To: <3693445.TSdZGaiT9S@wuerfel>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
 <1477913455-5314-8-git-send-email-geert+renesas@glider.be>
 <3693445.TSdZGaiT9S@wuerfel>
Message-ID: <CAMuHMdX+T=Y--F6KXZwFmZwWFdfP5mL5Tar-wKwRM2p6Hh2-sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for your comments!

On Wed, Nov 9, 2016 at 5:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday, October 31, 2016 12:30:55 PM CET Geert Uytterhoeven wrote:
>> v2:
>>   - Drop SoC families and family names; use fixed "Renesas" instead,
>
> I think I'd rather have seen the family names left in there, but it's
> not important, so up to you.

They're not useful for matching, as family names may change anytime, and don't
always say much about the hardware capabilities.
E.g. SH-Mobile -> R-Mobile -> R-Car | RZ/A | RZ/G
Some SH-Mobile (even some R-Car) parts are SuperH only, others have ARM and
SuperH.

At least the SoC part numbers are stable (hmm, sh73a0 == r8a73a0).

>>   - Use "renesas,prr" and "renesas,cccr" device nodes in DT if
>>     available, else fall back to hardcoded addresses for compatibility
>>     with existing DTBs,
>
> I only see patches 2, 3, 5, and 7 in my inbox, so I'm lacking the DT
> binding for these, among other things.

I understand you've received them in the mean time?

> It does seem wrong to have a device node for a specific register though.
> Shouldn't the node be for the block of registers that these are inside
> of?

On R-Mobile APE6, R-Car Gen2 and Gen3, PRR is a lone register.
On R-Car Gen1, it's not even documented (and doesn't exist on all parts).

On SH-Mobile/R-Mobile, CCCR may be part of the HPB/APB register block, which
we further don't touch at all.
On R-Car Gen2, it's not documented, but does exist.

BTW, see why I'd prefer not to have it in DT at all, and go for KISS in code
we can change at any time? To avoid mistakes we have to keep on supporting
forever.

>>   - Don't register the SoC bus if the chip ID register is missing,
>
> Why? My objection was to hardcoding the register, not to registering
> the device? I think I'd rather see the device registered with an
> empty revision string.

If there's no chip ID register, there's no reason to use soc_device_match(),
as we can always look at a compatible value. All SoCs listed in this driver
have a chip ID register.

if you want me to register the soc_bus for  those SoCs regardless, I want to
re-add r7s72100 (RZ/A) and r8a7778 (R-Car M1A), who don't have chip ID
registers ;-)

>> +#define CCCR   0xe600101c      /* Common Chip Code Register */
>> +#define PRR    0xff000044      /* Product Register */
>> +#define PRR3   0xfff00044      /* Product Register on R-Car Gen3 */
>> +
>> +static const struct of_device_id renesas_socs[] __initconst = {
>> +#ifdef CONFIG_ARCH_R8A73A4
>> +       { .compatible = "renesas,r8a73a4",      .data = (void *)PRR, },
>> +#endif
>> +#ifdef CONFIG_ARCH_R8A7740
>> +       { .compatible = "renesas,r8a7740",      .data = (void *)CCCR, },
>> +#endif
>
> My preference here would be to list the register address only for
> SoCs that are known to need them, while also having .dtb files that
> don't have the nodes.

Even if drivers don't have to handle differences, there's been a long
outstanding request to print SoC revision information during bootup
(E.g. "Does it still work on ES1.0?"). Hence that covers all SoCs.

>> +static int __init renesas_soc_init(void)
>> +{
>> +       struct soc_device_attribute *soc_dev_attr;
>> +       const struct of_device_id *match;
>> +       void __iomem *chipid = NULL;
>> +       struct soc_device *soc_dev;
>> +       struct device_node *np;
>> +       unsigned int product;
>> +
>> +       np = of_find_matching_node_and_match(NULL, renesas_socs, &match);
>> +       if (!np)
>> +               return -ENODEV;
>> +
>> +       of_node_put(np);
>> +
>> +       /* Try PRR first, then CCCR, then hardcoded fallback */
>> +       np = of_find_compatible_node(NULL, NULL, "renesas,prr");
>> +       if (!np)
>> +               np = of_find_compatible_node(NULL, NULL, "renesas,cccr");
>> +       if (np) {
>> +               chipid = of_iomap(np, 0);
>> +               of_node_put(np);
>> +       } else if (match->data) {
>> +               chipid = ioremap((uintptr_t)match->data, 4);
>> +       }
>> +       if (!chipid)
>>
>
> Here, I'd turn the order around and look for the DT nodes of the
> devices first. Only if they are not found, look at the compatible
> string of the root node. No need to search for a node though,
> you know which one it is when you look for a compatible =
> "renesas,r8a73a4".

"renesas,r8a73a4" is the root node, not the device, so it does not have the
"reg" property for reading the chip ID?

There is no SoC part number in the "renesas,prr" and "renesas,cccr" nodes.
Hence I always need to look at the root nodes.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
