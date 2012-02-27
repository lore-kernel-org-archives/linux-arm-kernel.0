From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 27 Feb 2012 12:14:01 -0800
Subject: [PATCH] ARM: boot/compressed/misc.s: Include <linux/bug.h> to
 fix build break
In-Reply-To: <20120227195637.GE2440@n2100.arm.linux.org.uk>
References: <1330372350-6432-1-git-send-email-swarren@nvidia.com>
 <20120227195637.GE2440@n2100.arm.linux.org.uk>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BD04C@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote at Monday, February 27, 2012 12:57 PM:
> On Mon, Feb 27, 2012 at 12:52:30PM -0700, Stephen Warren wrote:
> > Commmit cf86c17 "kernel.h: doesn't explicitly use bug.h, so don't include
> > it." caused the following build failure on ARM:
> >
> >   CC      arch/arm/boot/compressed/misc.o
> > In file included from arch/arm/boot/compressed/misc.c:28:0:
> > arch/arm/mach-tegra/include/mach/uncompress.h: In function 'arch_decomp_setup':
> > arch/arm/mach-tegra/include/mach/uncompress.h:125:2: error: implicit declaration of function
> 'BUILD_BUG_ON_ZERO' [-Werror=implicit-function-declaration]
> > cc1: some warnings being treated as errors
> 
> Err no.  The decompressor is _not_ part of the kernel, it's a separate
> stand alone environment.  Including randomly kernel headers from the
> rest of the kernel is bad news, particularly if they start calling out
> to external code.
> 
> You should try to keep your uncompress.h as free of other dependencies
> as possible.

OK, It looks like all we need from <linux/kernel.h> is BIT() and
ARRAY_SIZE(). The latter requires <linux/bug.h>. Should I just redefine
those macros in our uncompress.h?

-- 
nvpublic
