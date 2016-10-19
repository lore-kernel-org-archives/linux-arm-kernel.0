From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 19 Oct 2016 10:02:57 +0200
Subject: [PATCH/RFC 4/4] soc: renesas: Identify SoC and register with the
 SoC bus
In-Reply-To: <1560471.cOCZ4VcGTh@wuerfel>
References: <1475572167-29581-1-git-send-email-geert+renesas@glider.be>
 <1475572167-29581-5-git-send-email-geert+renesas@glider.be>
 <1560471.cOCZ4VcGTh@wuerfel>
Message-ID: <CAMuHMdU=iTps+YfyeUyhPQkgSYHuG1hCLMFUTVOcPsHgbiPgSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Oct 10, 2016 at 4:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday, October 4, 2016 11:09:27 AM CEST Geert Uytterhoeven wrote:
>> Identify the SoC type and revision, and register this information with
>> the SoC bus, so it is available under /sys/devices/soc0/, and can be
>> checked where needed using soc_device_match().
>>
>> In addition, on SoCs that support it, the product ID is read from a
>> hardware register and validated, to catch accidental use of a DTB for a
>> different SoC.
>>
>> Example:
>>
>>     Detected Renesas r8a7791 ES1.0
>>     ...
>>     # cat /sys/devices/soc0/{family,machine,soc_id,revision}
>>     R-Car Gen2
>>     Koelsch
>>     r8a7791
>>     ES1.0
>>
>
> Seems all reasonable.
>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> This patch does NOT add a call to
>>
>>         of_platform_default_populate(NULL, NULL,
>>                                      soc_device_to_device(soc_dev));
>>
>> Contrary to suggested by commit 74d1d82cdaaec727 ("drivers/base: add bus
>> for System-on-Chip devices), doing so would not only move on-SoC devices
>> from /sys/devices/platform/ to /sys/devices/soc0/, but also all other
>> board (off-SoC) devices specified in the DTB.
>
> Right, we have moved away from that a while ago, and now just
> use the device for identification, not to model the device
> hierarchy.

OK.

>> diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
>> new file mode 100644
>> index 0000000000000000..74b72e4112b8889e
>> --- /dev/null
>> +++ b/drivers/soc/renesas/renesas-soc.c
>> @@ -0,0 +1,266 @@
>> +/*
>> + * Renesas SoC Identification
>> + *
>> + * Copyright (C) 2014-2016 Glider bvba
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +#include <linux/string.h>
>> +#include <linux/sys_soc.h>
>> +
>> +
>> +struct renesas_family {
>> +     const char name[16];
>> +     u32 reg;                        /* CCCR, PVR, or PRR */
>> +};
>> +
>> +static const struct renesas_family fam_emev2 __initconst = {
>> +     .name   = "Emma Mobile EV2",
>> +};
>
> As this is not related to the others and doesn't have the respective
> register, I'd leave the platform out of this, and possibly have
> a separate driver for it.

OK. Emma Mobile is special, as it doesn't share any drivers with the
other SoCs (NEC vs. Hitachi origin).

>> +static const struct renesas_family fam_rza __initconst = {
>> +     .name   = "RZ/A",
>> +};
>
> I'm not sure about the relationship between this one and the others,
> maybe it should be treated in the same way as emev2 and left out from
> this driver?

While RZ/A doesn't have a version registers (AFAIK), it shares several
drivers with the other SoCs (SH/R-Mobile, R-Car).
Hence I'd like to keep it, so we can match for it in these drivers when
needed. It has e.g. a different variant of the serial port (SCIF), more
closely to the one on SH2 rather than SH4.

>> +static const struct renesas_family fam_rmobile __initconst = {
>> +     .name   = "R-Mobile",
>> +     .reg    = 0xe600101c,           /* CCCR (Common Chip Code Register) */
>> +};
>> +
>> +static const struct renesas_family fam_rcar_gen1 __initconst = {
>> +     .name   = "R-Car Gen1",
>> +     .reg    = 0xff000044,           /* PRR (Product Register) */
>> +};
>> +
>> +static const struct renesas_family fam_rcar_gen2 __initconst = {
>> +     .name   = "R-Car Gen2",
>> +     .reg    = 0xff000044,           /* PRR (Product Register) */
>> +};
>> +
>> +static const struct renesas_family fam_rcar_gen3 __initconst = {
>> +     .name   = "R-Car Gen3",
>> +     .reg    = 0xfff00044,           /* PRR (Product Register) */
>> +};
>> +
>> +static const struct renesas_family fam_rzg __initconst = {
>> +     .name   = "RZ/G",
>> +     .reg    = 0xff000044,           /* PRR (Product Register) */
>> +};
>> +
>> +static const struct renesas_family fam_shmobile __initconst = {
>> +     .name   = "SH-Mobile",
>> +     .reg    = 0xe600101c,           /* CCCR (Common Chip Code Register) */
>> +};
>
> These seem to fall into two distinct categories, maybe there is a
> better way to group them. What device contain the two kinds of
> registers (PRR, CCCR)?

Actually there are three (notice the extra "f" on R-Car Gen3 ;-)

Some SoCs have only CCCR, others have only PRR, some have both.
On some SoCs one of them can be accessed from the RealTime CPU
core (SH) only.
On some SoCs the register is not documented, but present.
If the PRR exists, it's a better choice, as it contains additional information
in the high order bits (representing the presence of each big (CA15/CA57),
little (CA7/CA53), and RT (CR7) CPU core). Currently we don't use that
information, though.

Grouping them in some other way means we would loose the family name,
which is exposed through soc_dev_attr->family.
The usefulness of family names is debatable though, as this is more an
issue of marketing business.

> Hardcoding the register address seems rather ugly here, so maybe
> there is a way to have two separate probe methods based on the
> surrounding register range, and then bind to that?

There's no simple relation between CCCR/PRR and other register blocks.
I prefer not to add these to DT, as that would add one more worm to the
backwards compatibility can.

>> +static const struct of_device_id renesas_socs[] __initconst = {
>> +#ifdef CONFIG_ARCH_EMEV2
>> +     { .compatible = "renesas,emev2",        .data = &soc_emev2 },
>> +#endif
>> +#ifdef CONFIG_ARCH_R7S72100
>> +     { .compatible = "renesas,r7s72100",     .data = &soc_rz_a1h },
>> +#endif
>> +#ifdef CONFIG_ARCH_R8A73A4
>
> I think the #ifdefs here will result in warnings for unused symbols
> when the Kconfig symbols are disabled.

Originally I had __maybe_unused, but it didn't seem to be needed.
Do you know which compiler needs it, so I can check?

Thanks for your comments!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
