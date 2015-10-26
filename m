From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Oct 2015 13:23:24 +0000
Subject: Possible Regression due to c074fef5d36e ("of/platform: Defer
 probes of registered devices").
In-Reply-To: <CAAObsKDScjsNgzrX6AJyT+21ameADY-2HepgGBa06jyLtos28w@mail.gmail.com>
References: <20151026032039.GA1950@verge.net.au>
 <20151026094027.GA25225@gradator.net>
 <CAMuHMdWmw8TqyOOMSPkh_1V+9OJeqPts1t3528ZQrJjzE6tmRA@mail.gmail.com>
 <20151026104149.GB8644@n2100.arm.linux.org.uk>
 <CAMuHMdUriYkDazewJH1LhG3=pFMQxqOo0gz6MYDpVkM+2=1MPQ@mail.gmail.com>
 <CAAObsKDScjsNgzrX6AJyT+21ameADY-2HepgGBa06jyLtos28w@mail.gmail.com>
Message-ID: <20151026132324.GF8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 01:47:06PM +0100, Tomeu Vizoso wrote:
> On 26 October 2015 at 12:02, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Hi Russell,
> >
> > On Mon, Oct 26, 2015 at 11:41 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >> On Mon, Oct 26, 2015 at 10:56:03AM +0100, Geert Uytterhoeven wrote:
> >>> On Mon, Oct 26, 2015 at 10:40 AM, Sylvain Rochet
> >>> <sylvain.rochet@finsecur.com> wrote:
> >>> > On Mon, Oct 26, 2015 at 12:20:39PM +0900, Simon Horman wrote:
> >>> >> I have observed a possible regression in next-20151022
> >>> >> due to c074fef5d36e ("of/platform: Defer probes of registered devices").
> >>> >>
> >>> >> The problem manifests on the r8a7791 based koelsch board.
> >>> >> With the above patch present booting the board using the shmobile_defconfig
> >>> >> results in no console output. While after reverting the above patch
> >>> >> the boot proceeds all the way to user-space.
> >>> >>
> >>> >> With DEBUG_LL and EARLY_PRINTK enabled I was able to capture some console
> >>> >> output. I have included both that boot log, and a log of boot all the way to
> >>> >> userspace with the patch in question reverted.
> >>> >>
> >>> >> The problem does not seem to manifiest on other boards for other
> >>> >> Renesas ARM  SoCs that I have access too. In particular the
> >>> >> r8a7790 based lager board; the r8a7790 and r8a7791 are both members
> >>> >> of the R-Car Gen2 family of SoCs.
> >>> >
> >>> > Atmel SoC hit this regresssion too, discussion about this issue is in
> >>> > the following thread:
> >>> >  https://lkml.org/lkml/2015/10/16/733
> >>>
> >>> More reading material in "[GIT PULL] On-demand device probing"
> >>> (https://lkml.org/lkml/2015/10/14/126)
> >>
> >> It's quite obvious from the thread that the on-demand device probing is
> >> *not* going to be merged for 4.4, and so it should not be in linux-next
> >> at all.  Having it in linux-next, it's disrupting people's testing of
> >> the 4.4 merge window material.
> >>
> >> Tomeu, please remove it so people can continue to test material
> >> sheduled for the 4.4 merge window.  Thanks.
> >
> > Unfortunately we'll be stuck with next-20151022 for a while, due to KS...
> >
> > So you're only option is manually reverting
> > commit 138d8b73e6a32aeacd3417106fbf740865da309e
> > Merge: 0f1cba62520b6119 c074fef5d36e1c27
> > Author: Rob Herring <robh@kernel.org>
> > Date:   Thu Oct 15 08:26:41 2015 -0500
> >
> >     Merge branch 'on-demand-probes-for-next' of git://git.collabora.com/git/user
> >
> >     Pull on-demand probing series from Tomeu Vizoso.
> >
> > "git revert 138d8b73e6a32aeacd3417106fbf740865da309e -m 2" and fix
> > the (many) conflicts :-(
> 
> It should be easier to just disable CONFIG_DELAY_DEVICE_PROBES. I sent
> a patch that disables it by default here:
> 
> https://lkml.kernel.org/g/1445267602-12576-1-git-send-email-tomeu.vizoso at collabora.com

The issue is not about whether it builds or not.  linux-next is an
integration tree.  It exists for several purposes, all centered around
gathering code aimed _solely_ at the next merge window.  Code which isn't
going into the 4.4 merge window should not be in linux-next at the moment.

linux-next exists not only to provide "final" build testing of queued code,
but also to flag up conflicts between git trees.

If code which is not for the next merge window is present in linux-next,
then linux-next can no longer do its job properly: it can no longer provide
a useful source of git conflict warnings.

When a git tree gets accepted into linux-next, Stephen replies with an
email indicating the terms on which the tree is present, which includes
this:

> You will need to ensure that the patches/commits in your tree/series have
> been:
>      * submitted under GPL v2 (or later) and include the Contributor's
>         Signed-off-by,
>      * posted to the relevant mailing list,
>      * reviewed by you (or another maintainer of your subsystem tree),
>      * successfully unit tested, and
>      * destined for the current or next Linux merge window.

The last point is the relevant point here.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
