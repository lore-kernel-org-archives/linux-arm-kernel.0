From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 16 Nov 2010 18:24:44 +0100
Subject: [RFC][PATCH 00/11] ARM: imx: Add initial i.MX28 support
In-Reply-To: <AANLkTim=ACL-PW-n0MWu_+KD8n19ttq_NfEnRzsMp6SU@mail.gmail.com>
References: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
	<20101116101508.GK6017@pengutronix.de>
	<AANLkTim=ACL-PW-n0MWu_+KD8n19ttq_NfEnRzsMp6SU@mail.gmail.com>
Message-ID: <20101116172444.GS8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Tue, Nov 16, 2010 at 08:42:29PM +0800, Shawn Guo wrote:
> On Tue, Nov 16, 2010 at 6:15 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Hello Shawn,
> >
> > On Mon, Nov 15, 2010 at 10:36:24PM +0800, Shawn Guo wrote:
> >> This patchset adds the initial support of i.MX28, and the target device
> >> is i.MX28 EVK Rev C. It's based on the imx-single-kernel branch below,
> >> and adding codes into arch/arm/mxc and arch/arm/mach-imx.
> >
> > Without further looking at the patch I agree with Uwe: The i.MX23/28
> > are totally different from the other i.MX SoCs and should not be
> > integrated in current i.MX support. And definitely it should not be
> > integrated by adding cpu_is_* into each and every function.
> >
> cpu_is_* is not being added into each and every function. Uwe had this
> comment on only two files, arch/arm/plat-mxc/gpio.c and
I consider the irq handling very ugly, but I didn't feel like repeating
the same argument gives much value.  (And OK, the irq handling was ugly
already before, that's on my plate to evaluate.)  I didn't recheck where
I thought the runtime checks were non-optimal, but seeing to much of
them makes me feel that this is the wrong approach.  This is more a
subjective thing and for that it's independant if there are one, two or
five instances.

> arch/arm/plat-mxc/time.c. As there are big percentage of
> infrastructural common codes that are IP block independent, I though
> it's good to use the same file.  But since you are not in this
> position, I would propose another option. Like what I'm doing with
> iomux-pinctrl, we can create arch/arm/plat-mxc/gpio-pinctrl.c and
> arch/arm/plat-mxc/time-timrot.c for PINCTRL based gpio and TIMROT
> based time implementation.
> 
> The philosophy behind this is we treat arch/arm/plat-mxc as the
> Freescale IP block pool.  The driver in this folder is IP block
> oriented other than SoC oriented.  And SoC is actually a collection of
> IP blocks.  MX23/MX28 integrates PINCTRL, TIMROT, ICOLL, and
> MX21/MX25/MX27/MX31/MX35/MX51 integrates GPIO/IOMUXC, GPT and
> AVIC/TZIC.  Accordingly, MX23/MX28 builds gpio-pinctrl.c, timrot.c and
> icoll.c in, and other i.MX builds gpio.c, iomux-v1//v2/v3,
> avic.c/tzic.c in.  The only thing we need to deal with is picking up
> the file name to stand for the IP block.
For me (not having seen mx50) integrating mx28 into mach-imx seems
wrong.  Currently they are completely orthogonal for the components that
matter for architecture support (i.e. timer, irq handling, clocks, pin
muxing, power management and to a slightly lesser degree gpio and memory
mapping).

> > Now you have two choices: Add the code to plat-stmp3xxx (for the
> > interested reader: the i.MX23/28 are based on former Sigmatel SoCs), or
> > add a new mach-mxs like you did in the Freescale Kernel.
> > I'm not sure which choice of these two is best. It would be good to get
> > some other opinions from people who already had the situation that a
> > vendor got sold and we get the same old metal with new names.
> >
> Yes, MX23/28 are based on former Sigmatel SoCs.  The imx-single-kernel
> demonstrates the possibility of single image for different SoCs from
> same vendor.  My patchset somehow adds the the possibility for SoCs
> even from different vendors, even though I'm unsure if single image
> for SoCs from different vendor is something ARM Kernel will possibly
> go in the future?
That's one of the goals of Linaro.  I'd prefer to get an
"really-all-i.MX" image via this more global approach.

> The plat-stmp3xxx is not an option for me because of the Freescale
> marketing concern.  For the choice of what Freescale Kernel is doing,
I prefer technical arguments here.  Just because some guys in the
marketing department consider giving similar names to completely
different products *I* don't believe grouping them together in the
source code makes more sense.  (It just reinforces my opinion about
marketing guys :-)

> there is no mach-mxs.  Instead, there are arch/arm/plat-mxs,
> arch/arm/mach-mx23 and arch/arm/mach-mx28.  Going this way, MX23/28
> will be totally separated from i.MX family, though their name tells
Adding mach-mx23, mach-mx28 and plat-mxs is (IMHO) too much.  mx23 and
mx28 are similar enough to put both of the two into a single mach
directory.  So seeing the naming choices Freescale did for their kernel
mach-mxs looks reasonable to me.

> the relationship with i.MX family.  Also, Freescale is merging the
This wouldn't be worse than what we had before I merged mach-mx1 and
mach-mx2 into mach-imx for 2.6.36: mach-mx1, mach-mx2, mach-mx25,
mach-mx3 and mach-mx5.

> Sigmatel IP pool into i.MX one and will only maintain the same pool.
> In another words, Sigmatel IP block are getting consolidated with i.MX
> ones. You can still say MX28 are former Sigmatel based, but it gets
> i.MX IP blocks, FEC(ENET), FlexCAN integrated.  If MX28 is not so
This is natural and OK.  But these components are no reason to put mx28
into mach-imx.  The respective drivers live in drivers/net and
drivers/net/can.  So at best they can share the imx_add_device_du_jour
functions.  Here I'd suggest to make these functions available for all
ARMs (or even all archs).

> typical, MX50 can be the one.  It primarily derives from MX51/MX53 and
> will go into plat-mxc and mach-mx5 in common understanding, but it
Let's discuss that when you come up with mx50 patches :-)

> gets a lot of MX28 (Sigmatel) based IP blocks integrated, LCDIF, PXP,
> GPMI, DCP, APHB DMA, and so on.  SoC is merging these two families
> into one.  It makes no sense for SW to keeps them separated.
I don't want to separate things artificially that belong together, but I
don't want to put things together that are really seperate, too.
 
> Can you please think about the IP oriented way I mentioned above to
> see if there is any problem that stops us going?  Also do you want to
> eventually include MX23/28 into imx-single-kernel image?  If you do,
> don't you think my proposal will make it a little bit easier?
It might be easier, yes, but there are also some other criterias that
matter, like maintainability, efficiency of compiled code etc.  And I
think when taking these into account using a different machine directory
is the right choice.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
