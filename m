From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Oct 2016 23:16:19 +0200
Subject: [PATCH/RFC 4/4] soc: renesas: Identify SoC and register with the
 SoC bus
In-Reply-To: <CAMuHMdVv+K=NVpmn-H72m159sDXnsAydMT-FQHq1is67_Nw3mQ@mail.gmail.com>
References: <1475572167-29581-1-git-send-email-geert+renesas@glider.be>
 <7196231.EBkNfFgrcH@wuerfel>
 <CAMuHMdVv+K=NVpmn-H72m159sDXnsAydMT-FQHq1is67_Nw3mQ@mail.gmail.com>
Message-ID: <12094567.68HcWl4d5O@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 21, 2016 8:16:00 PM CEST Geert Uytterhoeven wrote:
> On Wed, Oct 19, 2016 at 12:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday, October 19, 2016 10:02:57 AM CEST Geert Uytterhoeven wrote:
> >> On Mon, Oct 10, 2016 at 4:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > I'd prefer seeing a separate soc driver for that one.
> >> Some SoCs have only CCCR, others have only PRR, some have both.
> >> On some SoCs one of them can be accessed from the RealTime CPU
> >> core (SH) only.
> >> On some SoCs the register is not documented, but present.
> >> If the PRR exists, it's a better choice, as it contains additional information
> >> in the high order bits (representing the presence of each big (CA15/CA57),
> >> little (CA7/CA53), and RT (CR7) CPU core). Currently we don't use that
> >> information, though.
> >>
> >> Grouping them in some other way means we would loose the family name,
> >> which is exposed through soc_dev_attr->family.
> >> The usefulness of family names is debatable though, as this is more an
> >> issue of marketing business.
> >
> > How about having a table to look up the family name by the value
> > of the PRR or CCCR then?
> 
> Unfortunately there exist SoCs from different families using the same
> product ID.
> 
> And different SoCs from the same family may have a revision register
> or not (e.g. R-Car H1 has, M1A hasn't).

Is this something we expect to see more of in the future, or can
we expect future chips to handle this more consistently?

> > How about this:
> >
> > The driver could report the hardcoded strings for the SoCs it already
> > knows about (you have the table anyway) and not report the revision
> > unless there is a regmap containing the CCCR or the PRR, in which
> > case you use that. Future SoCs will provide the PRR (I assume
> > CCCR is only used on the older ones) through a syscon regmap
> > that we can use to find out the exact revision as well.
> >
> > The existing DT files can gain the syscon device so you can report
> > the revision on those machines as well, unless you use an old DTB.
> 
> Hmm... That means that if we have to add a driver quirk to distinguish
> between different revisions of the same SoC, we have to update the
> DTB anyway, to add the CCCR/PRR device node.
> We might as well just change the compatible value in that DTB for the
> device that needs the quirk. Which is what we'd like to avoid in the
> first place.

Do you have a specific example in mind? If this is only a theoretical
problem, we can worry about it when we get there, and then decide
if we add a hardcoded register after all.

> > Why not just drop all the #ifdef here? There should be very little
> > overhead in size, especially if all the data is __initconst.
> 
> It still saves ca. 3 KiB for a kernel for a single SoC.

Fair enough, that is more than I was expecting from looking at the
source. It's probably the of_device_id structures for the most part.

Please just add the __maybe_unused then, to save us a patch in case
we make -Wunused-const the default in the future.

	Arnd
