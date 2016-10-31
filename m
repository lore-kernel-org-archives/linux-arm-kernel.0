From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 31 Oct 2016 11:30:05 +0100
Subject: [PATCH/RFC 4/4] soc: renesas: Identify SoC and register with the
 SoC bus
In-Reply-To: <7122001.MSFYYEpnBs@wuerfel>
References: <1475572167-29581-1-git-send-email-geert+renesas@glider.be>
 <12094567.68HcWl4d5O@wuerfel>
 <CAMuHMdUwS=F-803_i=Zour+jo1T43KFO=t53XgcPBeiuF7e7DQ@mail.gmail.com>
 <7122001.MSFYYEpnBs@wuerfel>
Message-ID: <CAMuHMdVTP4YqwWjPQAvJJYqX7F3uviGC62GEop1zeLn8RDTuXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Sat, Oct 29, 2016 at 11:27 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday, October 22, 2016 9:44:11 AM CEST Geert Uytterhoeven wrote:
>> On Fri, Oct 21, 2016 at 11:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Friday, October 21, 2016 8:16:00 PM CEST Geert Uytterhoeven wrote:
>> >> On Wed, Oct 19, 2016 at 12:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >> > On Wednesday, October 19, 2016 10:02:57 AM CEST Geert Uytterhoeven wrote:
>> >> >> On Mon, Oct 10, 2016 at 4:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >> > I'd prefer seeing a separate soc driver for that one.
>> >> >> Some SoCs have only CCCR, others have only PRR, some have both.
>> >> >> On some SoCs one of them can be accessed from the RealTime CPU
>> >> >> core (SH) only.
>> >> >> On some SoCs the register is not documented, but present.
>> >> >> If the PRR exists, it's a better choice, as it contains additional information
>> >> >> in the high order bits (representing the presence of each big (CA15/CA57),
>> >> >> little (CA7/CA53), and RT (CR7) CPU core). Currently we don't use that
>> >> >> information, though.
>> >> >>
>> >> >> Grouping them in some other way means we would loose the family name,
>> >> >> which is exposed through soc_dev_attr->family.
>> >> >> The usefulness of family names is debatable though, as this is more an
>> >> >> issue of marketing business.
>> >> >
>> >> > How about having a table to look up the family name by the value
>> >> > of the PRR or CCCR then?
>> >>
>> >> Unfortunately there exist SoCs from different families using the same
>> >> product ID.
>> >>
>> >> And different SoCs from the same family may have a revision register
>> >> or not (e.g. R-Car H1 has, M1A hasn't).
>> >
>> > Is this something we expect to see more of in the future, or can
>> > we expect future chips to handle this more consistently?
>>
>> I expect to see more of these in the future.
>>
>> Perhaps I just should forget about the product IDs and (marketing) families,
>> and just stick the CCCR/PRR addresses in the of_device_ids?
>> Then we'll have SoC names (e.g. "r8a7791") and (optional) revisions
>> (e.g. "ES1.0") to match on.
>
> I don't think listing the marketing names is a problem if we need a
> full list of all chips in of_device_ids anyway.

I'm removing the marketing names. We don't match them anyway (and probably
shouldn't, as we don't control them anyway, cfr.
https://www.renesas.com/en-us/solutions/automotive/products.html).

> I'm still hoping to be able to limit the need for specifying the
> register addresses in the driver instead.

Adding DT binding...

>> >> > How about this:
>> >> >
>> >> > The driver could report the hardcoded strings for the SoCs it already
>> >> > knows about (you have the table anyway) and not report the revision
>> >> > unless there is a regmap containing the CCCR or the PRR, in which
>> >> > case you use that. Future SoCs will provide the PRR (I assume
>> >> > CCCR is only used on the older ones) through a syscon regmap
>> >> > that we can use to find out the exact revision as well.
>> >> >
>> >> > The existing DT files can gain the syscon device so you can report
>> >> > the revision on those machines as well, unless you use an old DTB.
>> >>
>> >> Hmm... That means that if we have to add a driver quirk to distinguish
>> >> between different revisions of the same SoC, we have to update the
>> >> DTB anyway, to add the CCCR/PRR device node.
>> >> We might as well just change the compatible value in that DTB for the
>> >> device that needs the quirk. Which is what we'd like to avoid in the
>> >> first place.
>> >
>> > Do you have a specific example in mind? If this is only a theoretical
>> > problem, we can worry about it when we get there, and then decide
>> > if we add a hardcoded register after all.
>>
>> For R-Car H3, there are small differences between ES1.0 and ES1.1,
>> and more and larger differences between ES1.x and ES2.0, which
>> need different handling (patches already floating around).
>>
>> For (old) R-Car H1, the SATA driver already handles "renesas,sata-r8a7790-es1",
>> but so far there didn't exist an established process to specify how that
>> compatible value would end up in the DTB (the in-kernel DTS doesn't have it).
>>
>> There may be more differences I'm not aware of.
>
> Ok, so for R-Car H1, I assume we don't need the driver, it would just
> be a way to replace the current workaround with a different one, right?
>
> For R-Car H3, do we just require driver changes to work with ES2.0,
> or also DT changes? If the new chip version already implies a new DT,
> we can require the presence of a device node that has the correct
> register number.

H3 also needs DT changes for some features (e.g. different number of USB
channels, different topology for graphics).

soc_device_match() would mostly (only?) be used to handle limitations and
quirks in early revisions. These are intended to be removed once production
has been ramped up, and there's no longer a need to support them.
However, that also means soc_device_match() would be used to match against
early revisions, not against late revisions. I.e. the early SoCs need the chip
ID registers declared, not the new ones.

Stay tuned for v2...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
