From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 17:05:46 +0100
Subject: [GIT PULL] RealView multiplatform support
In-Reply-To: <CACRpkdbtieUpUcmWG1KAOet9h+UO-KGTnCrj8OywcxcS77ojcA@mail.gmail.com>
References: <CACRpkdbtieUpUcmWG1KAOet9h+UO-KGTnCrj8OywcxcS77ojcA@mail.gmail.com>
Message-ID: <1677367.LaMm7US3D4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 December 2015 14:40:33 Linus Walleij wrote:
> Hi ARM SoC people,
> 
> Here is the result of my application of the second part of Arnds
> patchset, actually enabling multiplatform and getting the RealView
> off the ground as a multiplatform target.
> 
> It is dependent on an outstanding patch to the irqchips tree bumping
> the number of GICs to 2 for the RealView platform. I cannot say I will
> be sleepless if these go in side by side: each branch will compile but
> will not boot until both trees have been pulled hurting bisectability a
> bit.
> 
> It is based on the top commit of the previous pull request for the
> tag named realview-base-armsoc-1-tag, so it should be possible to
> pull in on to of that.
> 
> Please resolve and pull this in for v4.5 if you can!
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit 5420b4b156179ec634d9e42279b6898b85852960:
> 
>   ARM: realview: add an DT SMP boot method (2015-12-15 09:42:52 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/realview-multiplatform-tag
> 
> for you to fetch changes up to 93b2d7b15af2805ae10db76c651684c5b88b1e9d:
> 
>   ARM: realview: select apropriate targets (2015-12-18 14:31:00 +0100)
> 
> ----------------------------------------------------------------
> Multiplatform support for the RealView
> - Tested on the ARM PB11MPCore
> - Tested with boardfile boot
> - Tested with DeviceTree boot

Pulled into next/multiplatform now, with part of your introduction above
added to the merge commit.

I also found a small bug that I fixed with the patch below.

Thanks for all your work on this!

	Arnd

commit 3f93c644c92db1abb6149da712713132e0b37cfc
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Dec 18 17:01:58 2015 +0100

    ARM: realview: build realview-dt SMP support only when used
    
    The platsmp-dt.c file does not build when CONFIG_SMP is disabled:
    
    platsmp-dt.c:84:2: error: unknown field 'smp_prepare_cpus' specified in initializer
    
    This changes the Makefile to build it conditionally on CONFIG_SMP.
    The legacy platsmp.c file is only used for ATAGS based builds, so
    we can move it into the CONFIG_ATAGS conditional.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index a4392f5..8be6632 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -5,14 +5,16 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-versatile/include
 
 
-obj-$(CONFIG_REALVIEW_DT)		+= realview-dt.o platsmp-dt.o
+obj-$(CONFIG_REALVIEW_DT)		+= realview-dt.o
+obj-$(CONFIG_SMP)			+= platsmp-dt.o
 obj-y					:= core.o
+
 ifdef CONFIG_ATAGS
 obj-$(CONFIG_MACH_REALVIEW_EB)		+= realview_eb.o
 obj-$(CONFIG_MACH_REALVIEW_PB11MP)	+= realview_pb11mp.o
 obj-$(CONFIG_MACH_REALVIEW_PB1176)	+= realview_pb1176.o
 obj-$(CONFIG_MACH_REALVIEW_PBA8)	+= realview_pba8.o
 obj-$(CONFIG_MACH_REALVIEW_PBX)		+= realview_pbx.o
-endif
 obj-$(CONFIG_SMP)			+= platsmp.o
+endif
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
