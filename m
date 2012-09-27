From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 27 Sep 2012 17:26:18 +0200
Subject: [PATCH] ARM: mvebu: fix build breaks from multi-platform
 conversion
In-Reply-To: <1348758612-27012-1-git-send-email-robherring2@gmail.com>
References: <1348758612-27012-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120927172618.7ba233f0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rob Herring,

On Thu, 27 Sep 2012 10:10:12 -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Moving ARCH_MVEBU for multi-platform support caused several breakages
> in recently added addr-map and pinctrl support for mvebu. This adds
> the necessary selects and include paths to fix the build.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/mach-mvebu/Kconfig  |    2 ++
>  arch/arm/mach-mvebu/Makefile |    3 ++-
>  arch/arm/plat-orion/Makefile |    1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 26a817d..416d46e 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -6,6 +6,8 @@ config ARCH_MVEBU
>  	select GENERIC_IRQ_CHIP
>  	select IRQ_DOMAIN
>  	select MULTI_IRQ_HANDLER
> +	select PINCTRL

This select was already part added as a part of:

commit 7e8d941567c99a03390154a7bb116d1b03db82b3
Author: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date:   Thu Sep 13 17:41:43 2012 +0200

    pinctrl: mvebu: pinctrl driver core
    
    This patch adds a pinctrl driver core for Marvell SoCs plus DT
    binding documentation. This core driver will be used by SoC family
    specific drivers, i.e. Armada XP, Armada 370, Dove, Kirkwood, aso.
    
    Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
    Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
    Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
    Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
    Reviewed-by: Stephen Warren <swarren@wwwdotorg.org>
    Signed-off-by: Jason Cooper <jason@lakedaemon.net>
    
    Conflicts:
    
        arch/arm/Kconfig

which was requested for pull from the kirkwood/drivers branch of Jason
Cooper repository. If it is no longer there, then it is a merge
conflict resolution mistake.

> +	select PLAT_ORION

This other select was already added as a part of:

commit abcda1dc3e23366c8543b372e9bf4e9086d5cca1
Author: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date:   Tue Sep 11 14:27:27 2012 +0200

    arm: plat-orion: introduce PLAT_ORION_LEGACY hidden config option
    
    Until now, the PLAT_ORION configuration option was common to all the
    Marvell EBU SoCs, and selecting this option had the effect of enabling
    the MPP code, GPIO code, address decoding and PCIe code from
    plat-orion, as well as providing access to driver-specific header
    files from plat-orion/include.
    
    However, the Armada 370 and XP SoCs will not use the MPP and GPIO code
    (instead some proper pinctrl and gpio drivers are in preparation), and
    generally, we want to move away from plat-orion and instead have
    everything in mach-mvebu.
    
    That said, in the mean time, we want to leverage the driver-specific
    headers as well as the address decoding code, so we introduce
    PLAT_ORION_LEGACY. The older Marvell SoCs need to select
    PLAT_ORION_LEGACY, while the newer Marvell SoCs need to select
    PLAT_ORION. Of course, when PLAT_ORION_LEGACY is selected, it
    automatically selects PLAT_ORION.
    
    Then, with just PLAT_ORION, you have the address decoding code plus
    the driver-specific headers. If you add PLAT_ORION_LEGACY to this, you
    gain the old MPP, GPIO and PCIe code.
    
    Again, this is only a temporary solution until we make all Marvell EBU
    platforms converge into the mach-mvebu directory. This solution avoids
    duplicating the existing address decoding code into mach-mvebu.
    
    Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
    Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Tested-by: Andrew Lunn <andrew@lunn.ch>
    Signed-off-by: Jason Cooper <jason@lakedaemon.net>

Coming from the kirkwood/addr_decode branch of Jason Cooper repository.

So it looks strange that you don't have both selects.

Otherwise, for the rest of patch:

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
