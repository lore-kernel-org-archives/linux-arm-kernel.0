From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 4 May 2011 10:48:40 -0500
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51 and
	i.MX53
In-Reply-To: <20110413124149.GR18850@pengutronix.de>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110413122503.GB1897@S2100-06.ap.freescale.net>
	<20110413124149.GR18850@pengutronix.de>
Message-ID: <BANLkTinaFVXP10vbaF_We+kS2onwZAugQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/13 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hi Shawn,
>
> On Wed, Apr 13, 2011 at 08:25:04PM +0800, Shawn Guo wrote:
>> On Sun, Apr 10, 2011 at 09:49:01PM +0200, Uwe Kleine-K?nig wrote:
>> [...]
>> > + ? ? This enables support for machines using Freescale's i.MX50 and i.MX51
>> s/MX51/MX53/
> yeah, thanks, as you're not the first one to point this out I already
> sent a fixup to Sascha.

Can someone confirm the following for me (Uwe probably as it's his
patch most recently)

CONFIG_RUNTIME_PHYS_OFFSET
CONFIG_ARM_PATCH_PHYS_VIRT

These two config options, with absolutely no bootloader changes, will
basically mask off some address (instruction pointer?) at the time of
the check and therefore derive a perfectly good PHYS_OFFSET at runtime
and make sure it is in use... within some limits (first 128MB, assumes
that start of memory is at some particular alignment)?

I am confused about Nicolas' CONFIG_AUTO_ZRELADDR comment and how this
applies. I am working out a way to have U-Boot ignore the hardcoded
image entry point in a uImage to enable the above.

I consider that the problem with the above is not so much with
supporting multiple SoCs in the same kernel of the same pedigree
(MX5x) but with completely different vendor SoCs and anything where
PHYS_OFFSET is somehow differently masked off of the abovementioned
address. I noticed in a patch somewhere last night that if MACH_MX5 is
enabled, it uses 'and' instead of 'andne' to perform the masking. This
will basically mean the derived address is still entirely CPU
specific... unless I am out of date on the patches I am reviewing..

Uwe you had a patch about a year ago that passed PHYS_OFFSET in r3,
that isn't true anymore? Is there potential for an override, such that
if if r3 is set and valid, it is used, if not a determination is made
at runtime which may possibly fail? Is compiling an unbootable kernel
for an old firmware an acceptable scenario for the edge case where
MX50, MX51, MX53 are in the kernel along with.. say.. OMAP? Wouldn't
we consider this a distro tool problem and not a kernel problem?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
