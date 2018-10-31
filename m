From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Oct 2018 18:12:27 +0000
Subject: [PATCH 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
In-Reply-To: <99a5f366-4d96-1069-0638-4e036e57afc8@samsung.com>
References: <20180919094802.GH30658@n2100.armlinux.org.uk>
 <CGME20180919095028epcas3p3e1a927bb7e88c6891d43abfdc51603e7@epcas3p3.samsung.com>
 <E1g2Z6e-0003es-CI@rmk-PC.armlinux.org.uk>
 <20181005090941eucas1p14031cd38d78e9d561975925bf977727d~aq0-OFZeE1866318663eucas1p1b@eucas1p1.samsung.com>
 <20181005094618.GG30658@n2100.armlinux.org.uk>
 <20181030105017.GK30658@n2100.armlinux.org.uk>
 <99a5f366-4d96-1069-0638-4e036e57afc8@samsung.com>
Message-ID: <20181031181227.GM30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2018 at 04:21:30PM +0100, Marek Szyprowski wrote:
> Hi Russell,
> 
> On 2018-10-30 11:50, Russell King - ARM Linux wrote:
> > On Fri, Oct 05, 2018 at 10:46:19AM +0100, Russell King - ARM Linux wrote:
> >> On Fri, Oct 05, 2018 at 11:09:40AM +0200, Marek Szyprowski wrote:
> >>> This patch causes lots of kernel 'BUG' messages on all Samsung Exynos
> >>> boards.? It started to appear since it has been merged to linux-next
> >>> on 20181002.? I wonder if this issue is Exynos specific or there are
> >>> some patches missing in linux-next, which should fix those 'BUGS'.
> >>> If this is Exynos specific, please let us know what should be changed
> >>> in Exynos platform code to avoid this issue.
> >> Thanks for the report.
> >>
> >> It looks like my solution for big.Little isn't possible... back to
> >> the drawing board, and big.Little will have to remain vulnerable to
> >> Spectre for another release cycle.
> > I've pushed out a new version in my build branch for the autobuilders
> > to chew on, but I've little confidence in validating that the problem
> > is fixed because the boot results are completely unreliable.
> >
> > It really doesn't help that kernelci.org flags boot logs as "green"
> > and "successful" when they contain such stuff as:
> >
> > 01:08:40.181846  [    9.309984] Unable to handle kernel paging request at virtual address e7fddef0
> >
> > which is the kernel hitting a BUG() - for the full log, see:
> >
> > https://storage.kernelci.org/rmk/to-build/v4.16-38-g9fa10446d304/arm/multi_v7_defconfig/lab-collabora/boot-exynos5800-peach-pi.html
> >
> > This means the only way to check is to _manually_ go through reading
> > each and every boot log - to see if your reported BUG: messages are
> > there - no thanks.
> >
> > If kernelci thinks that a boot which hits a kernel BUG(), but still
> > manages to get to a shell prompt is successful, it's giving very
> > misleading boot results.  What about a WARN_ON() or an oops that
> > still allows it to reach a shell prompt.
> >
> > Yes, these may be "successful" in so far as reaching the shell prompt,
> > but they should at least be flagged for further inspection, not
> > effectively marked as "there is nothing wrong here".
> 
> I've run my own tests on various Exynos SoC based boards and your
> 'for-next' branch works fine and don't cause any regressions.

The code isn't in for-next because we're in a merge window, and
linux-next is supposed to be stable for the duration of that, only
accepting bug fixes.

It was added briefly to for-next (carefully timed and discussed
with Stephen to ensure it didn't appear in linux-next), to try
and get fuller builder coverage, which is when the above issue was
found.

If you want to test, please use its separate branch, 'spectre'.
Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
