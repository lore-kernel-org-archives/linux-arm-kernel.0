From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Jul 2014 13:35:49 +0200
Subject: [GIT PULL] nommu fixes for 3.17-rc1
In-Reply-To: <20140630170738.GB30740@arm.com>
References: <20140630144355.GH14781@pengutronix.de>
 <CACRpkdZkwzEi2fYqRS-6o_EM-BeOS26Z2uS4DwEmaVT+FEW6eg@mail.gmail.com>
 <20140630170738.GB30740@arm.com>
Message-ID: <4831043.FLJmCthlNt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 June 2014 18:07:38 Will Deacon wrote:
> On Mon, Jun 30, 2014 at 06:00:37PM +0100, Linus Walleij wrote:
> > However if it is a good testbase for people synthesizing these old non-MMU
> > ARM cores still and using Linux with them, then it would make sense to
> > get that into shape and supported I guess? Especially now that the
> > Integrator machine is soon-ish even multiplatform (famous last words).
> > 
> > So we need some input here ...

(adding Greg Ungerer to Cc)

FWIW, qemu supports integrator with arm946e in principle. There are a few
bugs that I found recently with the qemu model running recent Linux kernels,
but they are all trivially fixable. I haven't tried running !MMU though,
only ARM926 and ARM1026 with MMU, as I haven't managed to find or build
a user space image.

> To be honest, I'm finding it more and more difficult to care about uclinux
> outside of Cortex-M. Could we simply decide to support only v7m and rip out
> the code for other !MMU targets, or are there actually users of those things
> with mainline kernels?

As I said here earlier, at91x40 is the only pre-v7-m platform we support
upstream that doesn't have an MMU, and we are going to remove it at the
point when mach-at91 moves to multiplatform.

I suppose uClinux is the place for arm7tdmi these days, I just downloaded
their latest release and found support for these additional platforms
that were never upstreamed:

* S5C7375 (arm940t)
* S3C2500 (arm940t)
* S3C3410 (arm7tdmi)
* S3C4510B (arm7tdmi)
* S3C44B0 (arm7tdmi)
* P2001 (arm9tdmi)
* LPC22XX (arm7tdmi)
* LPC28XX (arm7tdmi)

The last one of these is the only one that actually builds, all the other
ones have been broken for many years as far as I can tell and were just
kept in the tree for reference, or because nobody bothered to remove
them. In contrast, the latest uclinux-2.4 kernel supports 23 (!) platforms
that I assume all work to some degree. This supports the position that
people using armv4t-nommu are either going to stay on ancient kernels
or moving on to other CPUs later.

There are a few other semi-recent kernel trees outside of uClinux-dist:

* at91x40 (to be dropped, as mentioned above)
* lapis ml67xxxx (also mentioned before)
* nuvoton nuc700 (abandoned at 3.1?)
  https://github.com/rhuitl/linux/commits/nuc700
* multiple cortex-m on 2.6.33 (actively maintained by emcraft)
  https://github.com/EmcraftSystems/linux-emcraft

Greg, do you have any other input? Do you think anybody is still
interested in upstream !MMU Linux on ARMv4T or ARMv5?

	Arnd
