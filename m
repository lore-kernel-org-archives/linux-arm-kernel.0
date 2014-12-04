From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 04 Dec 2014 11:22:01 +0000
Subject: [PATCH] ARM: kbuild: Fix forced rebuild after 'make dtbs'
In-Reply-To: <547C7364.8000009@suse.cz>
References: <CACRpkdYmJWy1_vs0tWRA7SvkQnvbXXKqf7pHpH5b5tZ6vR+KJg@mail.gmail.com>
 <1414961549-31666-1-git-send-email-jason@lakedaemon.net>
 <5474F78F.2060906@suse.cz> <20141125235150.GH3836@n2100.arm.linux.org.uk>
 <20141126005710.GE22670@titan.lakedaemon.net>
 <CACRpkdZJoWbQeuZ4ZXGbQr0+SNG_9ZA+cQkAA0C2F9rnZDYtyQ@mail.gmail.com>
 <20141126144153.GK3836@n2100.arm.linux.org.uk>
 <CACRpkdYwQT3+RLxP_b_kYJoHV4L7sZ7yiU=JZWVq_zHKz0EY_g@mail.gmail.com>
 <547C7364.8000009@suse.cz>
Message-ID: <20141204112201.C824AC40992@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 01 Dec 2014 14:55:48 +0100
, Michal Marek <mmarek@suse.cz>
 wrote:
> On 2014-11-28 15:10, Linus Walleij wrote:
> > On Wed, Nov 26, 2014 at 3:41 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >> On Wed, Nov 26, 2014 at 02:57:42PM +0100, Linus Walleij wrote:
> >>> make -f Makefile -j5 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
> >>> KBUILD_OUTPUT=build-u300 u300_defconfig
> >>> make -f Makefile -j5 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
> >>> KBUILD_OUTPUT=build-u300 zImage CONFIG_DEBUG_SECTION_MISMATCH=y
> >>> make -f Makefile -j5 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
> >>> KBUILD_OUTPUT=build-u300 dtbs
> >>> make -f Makefile -j5 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
> >>> KBUILD_OUTPUT=build-u300 zImage CONFIG_DEBUG_SECTION_MISMATCH=y
> >>>
> >>> -> Rebuilds everything.
> >>>
> >>> This doesn't occur before the offending commit. So it only happens
> >>> when specifying extra environment variables on the command line.
> >>
> >> I suspect if you also provide the CONFIG_DEBUG_SECTION_MISMATCH=y on the
> >> dtbs line, everything will work properly.
> > 
> > Yay, it works! :)
> > 
> >> The problem is that dtbs line executes a prepare, which I guess rebuilds
> >> the bounds stuff.  So, the dtbs target results in it being rebuilt without
> >> the section mismatch, and then you re-execute a make with it, causing
> >> the bounds stuff to be rebuilt again.
> > 
> > Yep. Not very intuitive to require passing section mismatch debug
> > flags to DTB rebuilding but whatever, it's not so bad I can't live with
> > it.
> 
> Still, the dependency on the 'prepare' target is superfluous, if the
> only requirement is that $(KERNELRELEASE) be set properly.

So, I've lost track of where things stand on this issue. What is the
current proposed fix? Make dtbs depend on 'scripts' and dtbs_install
depend on 'prepare scripts'? Or is there a better way to make sure
KERNELRELEASE is set for the dtbs_install target?

g.
