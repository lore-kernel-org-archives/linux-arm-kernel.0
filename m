From: matt.porter@linaro.org (Matt Porter)
Date: Tue, 16 Jul 2013 19:52:44 -0400
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X SoC
 with ARM CPU
In-Reply-To: <51E58D35.4060602@hauke-m.de>
References: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
 <20130716151435.GB3871@linaro.org> <51E56942.8030801@hauke-m.de>
 <51E58D35.4060602@hauke-m.de>
Message-ID: <20130716235244.GE3871@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 08:13:09PM +0200, Hauke Mehrtens wrote:
> On 07/16/2013 05:39 PM, Hauke Mehrtens wrote:
> > On 07/16/2013 05:14 PM, Matt Porter wrote:
> >> Hi Hauke,
> >>
> >> On Tue, Jul 16, 2013 at 03:52:07PM +0200, Hauke Mehrtens wrote:
> >>> This patch adds support for the BCM5301/BCM470X SoCs with an ARM CPU.
> >>> Currently just booting to a shell is working and nothing else, no
> >>> Ethernet, wifi, flash, ...
> >>>
> >>> This SoC uses a Dual core CPU, but this is currently not implemented.
> >>> More information about this SoC can be found here:
> >>> http://www.anandtech.com/show/5925/broadcom-announces-bcm4708x-and-bcm5301x-socs-for-80211ac-routers
> >>>
> >>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> >>> ---
> 
> ....
> 
> >>> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
> >>> new file mode 100644
> >>> index 0000000..638350d
> >>> --- /dev/null
> >>> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
> >>> @@ -0,0 +1,72 @@
> >>> +/*
> >>> + * Broadcom BCM47XX / BCM53XX ARM platform code.
> >>> + *
> >>> + * Copyright 2013 Hauke Mehrtens <hauke@hauke-m.de>
> >>> + *
> >>> + * Licensed under the GNU/GPL. See COPYING for details.
> >>> + */
> >>> +
> >>> +/include/ "skeleton.dtsi"
> >>> +
> >>> +/ {
> >>> +	compatible = "brcm,bcm5301x";
> >>
> >> Ok, this was nagging at me before I went on my very long vacation. I see
> >> the "brcm" vendor prefix as a real consistency problem. I noticed on the
> >> bcm281xx/kona family, we have been using "bcm" which is not logged in
> >> vendor-prefixes.txt as a legitimate prefix. I see that bcm2835 had
> >> already established use of "brcm" before any of the bcm281xx support
> >> came in. Ideally, the vendor prefix should change to "bcm" since every
> >> reference in the family names is BCM. However, if others want the least
> >> amount of churn in making this consistent, we might have to go with
> >> "brcm" across the board.
> >>
> >> Arnd, any thoughts here?
> > 
> > I have no problem with bcm or with brcm. This is a Broadcom Chip and
> > their names are starting with bcm.
> > 
> >> Another thing is that this is missing a binding definition for this
> >> compatible string. See Documentation/devicetree/bindings/arm/bcm2835.txt
> >> for an example. You should split this patch out separately as the DT
> >> maintainers generally want to see bindings as a separate patch for easy
> >> independent review.
> > 
> > Ok I will do that. This will then be merged by Linus in the 3.12 merge
> > window into a working version or how does this work?
> > 
> > Currently I have based this patch on top of 3.11-rc1 on which tree
> > should I base my changes?
> 
> Should I split out the *.dts files in arch/arm/boot/dts/ and the
> documentation for brcm,bcm4708 into an other patch?

It's common to keep the binding separate for easy standalone review by
the DT maintainers (now changing) and on devicetree-discuss). Since the
.dts files are separate logical change, it's common to separate that out
as well.

> >> Last thing, compatible strings are not to have wildcards in them. See
> >> http://devicetree.org/Device_Tree_Usage#Understanding_the_compatible_Property
> >> and note the Warning at the bottom. Also see how bcm2835.txt and
> >> bcm11351.txt use a specific model.
> > 
> > Ok will do that.
> 
> Do I understand this right that I should currently name it exactly like
> the SoC I know and when a new SoC pops up I should make it compatible to
> this SoC?

Yes.

> I would change this to:
> compatible = "brcm,bcm4708";
> 
> If I find a BCM4709 SoC I will add this like to its dts file, assuming
> they are mostly the same?
> compatible = "brcm,bcm4709", "brcm,bcm4708";

You want the base one to be the first in the family as best as you
know. Everything else is then compatible to that. On the bcm281xx
family side, you can see that the numbering scheme is wacky such that
the first in family is bcm11351, but we refer to it by the wildcarded
name of the latest parts in the family.

-Matt
