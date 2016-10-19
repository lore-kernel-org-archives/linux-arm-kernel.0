From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Oct 2016 12:59:01 +0200
Subject: [PATCH/RFC 4/4] soc: renesas: Identify SoC and register with the
 SoC bus
In-Reply-To: <CAMuHMdU=iTps+YfyeUyhPQkgSYHuG1hCLMFUTVOcPsHgbiPgSw@mail.gmail.com>
References: <1475572167-29581-1-git-send-email-geert+renesas@glider.be>
 <1560471.cOCZ4VcGTh@wuerfel>
 <CAMuHMdU=iTps+YfyeUyhPQkgSYHuG1hCLMFUTVOcPsHgbiPgSw@mail.gmail.com>
Message-ID: <7196231.EBkNfFgrcH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, October 19, 2016 10:02:57 AM CEST Geert Uytterhoeven wrote:
> On Mon, Oct 10, 2016 at 4:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday, October 4, 2016 11:09:27 AM CEST Geert Uytterhoeven wrote:

> >> +static const struct renesas_family fam_rza __initconst = {
> >> +     .name   = "RZ/A",
> >> +};
> >
> > I'm not sure about the relationship between this one and the others,
> > maybe it should be treated in the same way as emev2 and left out from
> > this driver?
> 
> While RZ/A doesn't have a version registers (AFAIK), it shares several
> drivers with the other SoCs (SH/R-Mobile, R-Car).
> Hence I'd like to keep it, so we can match for it in these drivers when
> needed. It has e.g. a different variant of the serial port (SCIF), more
> closely to the one on SH2 rather than SH4.

I'd prefer seeing a separate soc driver for that one.

> >> +static const struct renesas_family fam_rmobile __initconst = {
> >> +     .name   = "R-Mobile",
> >> +     .reg    = 0xe600101c,           /* CCCR (Common Chip Code Register) */
> >> +};
> >> +
> >> +static const struct renesas_family fam_rcar_gen1 __initconst = {
> >> +     .name   = "R-Car Gen1",
> >> +     .reg    = 0xff000044,           /* PRR (Product Register) */
> >> +};
> >> +
> >> +static const struct renesas_family fam_rcar_gen2 __initconst = {
> >> +     .name   = "R-Car Gen2",
> >> +     .reg    = 0xff000044,           /* PRR (Product Register) */
> >> +};
> >> +
> >> +static const struct renesas_family fam_rcar_gen3 __initconst = {
> >> +     .name   = "R-Car Gen3",
> >> +     .reg    = 0xfff00044,           /* PRR (Product Register) */
> >> +};
> >> +
> >> +static const struct renesas_family fam_rzg __initconst = {
> >> +     .name   = "RZ/G",
> >> +     .reg    = 0xff000044,           /* PRR (Product Register) */
> >> +};
> >> +
> >> +static const struct renesas_family fam_shmobile __initconst = {
> >> +     .name   = "SH-Mobile",
> >> +     .reg    = 0xe600101c,           /* CCCR (Common Chip Code Register) */
> >> +};
> >
> > These seem to fall into two distinct categories, maybe there is a
> > better way to group them. What device contain the two kinds of
> > registers (PRR, CCCR)?
> 
> Actually there are three (notice the extra "f" on R-Car Gen3 ;-)

I see. Hopefully this is just the same register block at a different
location though.

> Some SoCs have only CCCR, others have only PRR, some have both.
> On some SoCs one of them can be accessed from the RealTime CPU
> core (SH) only.
> On some SoCs the register is not documented, but present.
> If the PRR exists, it's a better choice, as it contains additional information
> in the high order bits (representing the presence of each big (CA15/CA57),
> little (CA7/CA53), and RT (CR7) CPU core). Currently we don't use that
> information, though.
> 
> Grouping them in some other way means we would loose the family name,
> which is exposed through soc_dev_attr->family.
> The usefulness of family names is debatable though, as this is more an
> issue of marketing business.

How about having a table to look up the family name by the value
of the PRR or CCCR then?

> > Hardcoding the register address seems rather ugly here, so maybe
> > there is a way to have two separate probe methods based on the
> > surrounding register range, and then bind to that?
> 
> There's no simple relation between CCCR/PRR and other register blocks.
> I prefer not to add these to DT, as that would add one more worm to the
> backwards compatibility can.

Hmm, I understand the concern about compatibility with existing DT files,
but I also really hate to see hardcoded register addresses.

Any reason against requiring the DT node for future chips though?
How about this:

The driver could report the hardcoded strings for the SoCs it already
knows about (you have the table anyway) and not report the revision
unless there is a regmap containing the CCCR or the PRR, in which
case you use that. Future SoCs will provide the PRR (I assume
CCCR is only used on the older ones) through a syscon regmap
that we can use to find out the exact revision as well.

The existing DT files can gain the syscon device so you can report
the revision on those machines as well, unless you use an old DTB.

> >> +static const struct of_device_id renesas_socs[] __initconst = {
> >> +#ifdef CONFIG_ARCH_EMEV2
> >> +     { .compatible = "renesas,emev2",        .data = &soc_emev2 },
> >> +#endif
> >> +#ifdef CONFIG_ARCH_R7S72100
> >> +     { .compatible = "renesas,r7s72100",     .data = &soc_rz_a1h },
> >> +#endif
> >> +#ifdef CONFIG_ARCH_R8A73A4
> >
> > I think the #ifdefs here will result in warnings for unused symbols
> > when the Kconfig symbols are disabled.
> 
> Originally I had __maybe_unused, but it didn't seem to be needed.
> Do you know which compiler needs it, so I can check?

Ah, I remember now: gcc doesn't warn for 'static const' variables
unless we pass -Wunused-const, which should be enabled with "make W=1",
and we might make that the default in the future (after fixing the
handful of drivers currently relying on this).

Why not just drop all the #ifdef here? There should be very little
overhead in size, especially if all the data is __initconst.

	Arnd
