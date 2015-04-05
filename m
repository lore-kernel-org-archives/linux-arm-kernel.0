From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 5 Apr 2015 17:02:03 +0100
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <20150405160203.GF13898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 03:48:38AM +0000, Chris Brandt wrote:
> I've been running XIP_KERNEL with linux-3.14 on a Renesas RZ/A1
> (ARCH_R7S72100) for a while now (with some bug fixes of course) so I
> thought I'd see if my fixes should be pushed back upstream.
> 
> However, I see that all the Renesas parts are being moved to
> ARCH_MULTIPLATFORM, which by means of arch/arm/Kconfig disallows
> XIP_KERNEL.

Having fixed the ARM946 code last night, I ran into a similar problem
with Integrator - the platform which ARM946 is supposed to be buildable
for.

ARM946 is a noMMU device, but the conversion of Integrator to
multiplatform left no way to select ARM946 (or, indeed, ARM940).

Both this case, and your case, are both /regressions/ - they're bugs
which we have introduced by preventing previously working configurations
from working today.  As long as we have people wanting to build these,
that matters, and we have to fix it.

There's been some discussion around this at length already.  However,
my view is that we do *not* want to remove interaction between !MMU/XIP
and multiplatform.  That's crazy - it opens the door to having lots of
buildable but un-runnable configurations, and searching the configuration
for that unexpected option which needs to be turned off for things to
work is a real pain - especially if it is buried behind a whole truck
load of select statements.

We have had something that worked very well for this kind of stuff for
many many years - that is the top level choice statement where the
multi-platform option can be found.

For Integrator, for example, we can restore !MMU building very easily:

1. Fix dc680b989d51 ("ARM: fix multiplatform allmodcompile") in a way
   that extends what's already done for ARMv6 and ARMv7 CPUs, but in
   a cleaner manner by introducing a set of class symbols:

   config CPU_CLASS_xx
	def_bool ARCH_MULTI_xx || !ARCH_MULTIPLATFORM

   and use these, in part, to control the visibility of CPU options.

2. Effectively restore Integrator to the top level choice for !MMU:

   config ARM_SINGLE_INTEGRATOR
	bool "ARM Ltd. Integrator family (noMMU)"
	depends on !MMU

   and change arch/arm/mach-integrator/Kconfig thusly:

 config ARCH_INTEGRATOR
	bool "ARM Ltd. Integrator family" if (ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V6)
+	default y if ARM_SINGLE_INTEGRATOR
	select ARM_AMBA
-	select ARM_PATCH_PHYS_VIRT if MMU
-	select AUTO_ZRELADDR

The same can be done for !XIP_KERNEL builds too (which is why I decided
not to use ARM_NOMMU_xxx in its name).

We can _also_ allow a certain amount of multiplatform building too.
Consider, for example, Cortex-M3, where each M3 based platform has a
similar memory layout.  For that, we can have top level choice statement
for all M3 platforms, and add the appropriate "default y if
ARM_SINGLE_CORTEXM3" or augment the "bool" visibility in mach-*/Kconfig.

Shmobile is slightly more complicated as I'm not aware of what the
differences are as far as XIP goes.  I'm sure something along these
lines can be done to restore the old situation which you were using for
XIP support there.  So, we have multiplatform for MMU && !XIP builds,
but go back to something along the lines of the class-of-machines
implementation before hand.

I think many people forget what we _used_ to have already largely solved
the noMMU/XIP build issue, and I think people are rushing too quickly
into multiplatform and kicking out all the "eww, legacy, hates that we
do" stuff which _actually_ worked fairly well.

Now for the niggle that the above causes - that's with UNCOMPRESS_INCLUDE.
For Integrator, we go back to expecting mach/uncompress.h because
multiplatform isn't enabled anymore.  I'm debating whether we should
provide a default implementation for that which the compiler finds by
having it last on its list of directories to search.  We can then get
rid of UNCOMPRESS_INCLUDE entirely, and just use the lack of include
file to fall back to the default debug/uncompress.h, which sounds like
another simple solution.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
