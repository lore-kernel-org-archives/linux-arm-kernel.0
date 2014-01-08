From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Jan 2014 09:20:10 +0100
Subject: [PATCH] Fix select-induced Kconfig warning for ZBOOT_ROM
In-Reply-To: <CAOh2x==c+O9SwaeCOOSDkFUgSYnY=1Y-7C=Ti_5ceiyUUiQw1Q@mail.gmail.com>
References: <E1Vyl3Q-0005Lt-Lo@rmk-PC.arm.linux.org.uk>
 <CAOh2x==c+O9SwaeCOOSDkFUgSYnY=1Y-7C=Ti_5ceiyUUiQw1Q@mail.gmail.com>
Message-ID: <3792319.Wf518ByjFs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 January 2014 13:32:35 Viresh Kumar wrote:
> On Thu, Jan 2, 2014 at 9:53 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > warning: (ARCH_MULTIPLATFORM && ARCH_CLPS711X && ARCH_PXA &&
> >  SOC_EXYNOS5440 && ARCH_EMEV2) selects AUTO_ZRELADDR which
> >  has unmet direct dependencies (!ZBOOT_ROM)
> >
> > This is because it's possible to have ZBOOT_ROM enabled, but at the
> > same time have another option enabled which selects AUTO_ZRELADDR
> > overriding the !ZBOOT_ROM dependency.  Fix this by reversing the
> > dependencies between ZBOOT_ROM and the options which depend on
> > !ZBOOT_ROM.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> 
> After this patch I see these warnings with exynos_defconfig
> 
> arch/arm/Kconfig:1963:error: recursive dependency detected!
> arch/arm/Kconfig:1963: symbol ZBOOT_ROM depends on AUTO_ZRELADDR
> arch/arm/Kconfig:2151: symbol AUTO_ZRELADDR is selected by ZBOOT_ROM
> 
> I am not really sure why this happened as I don't see AUTO_ZRELADDR
> selected by ZBOOT_ROM in Kconfig :)

It's a weird dependency. You need this hunk:

--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -3,7 +3,7 @@ config ARCH_MXC
        select ARCH_REQUIRE_GPIOLIB
        select ARM_CPU_SUSPEND if PM
        select ARM_PATCH_PHYS_VIRT
-       select AUTO_ZRELADDR if !ZBOOT_ROM
+       select AUTO_ZRELADDR
        select CLKSRC_MMIO
        select COMMON_CLK
        select GENERIC_ALLOCATOR
