From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 1 Sep 2011 21:54:41 +0530
Subject: [PATCH] ARM: mach-davinci: Select PHYLIB for ARCH_DAVINCI_DM644x
In-Reply-To: <1313903348.25059.3.camel@phoenix>
References: <1313903348.25059.3.camel@phoenix>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930257268D10@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Axel,

On Sun, Aug 21, 2011 at 10:39:08, Axel Lin wrote:
> We call phy_register_fixup_for_uid in davinci_evm_init, thus we need 
> select PHYLIB to fix below build error: (with "make davinci_all_defconfig")

This shouldn't happen with davinci_all_defconfig as it
selects PHYLIB (this doesn't undermine the need for a fix).

> 
>   LD      .tmp_vmlinux1
> arch/arm/mach-davinci/built-in.o: In function `davinci_phy_fixup':
> pm.c:(.text+0x35b8): undefined reference to `mdiobus_read'
> pm.c:(.text+0x35d4): undefined reference to `mdiobus_write'
> arch/arm/mach-davinci/built-in.o: In function `davinci_evm_init':
> pm.c:(.init.text+0x237c): undefined reference to `phy_register_fixup_for_uid'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  arch/arm/mach-davinci/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
> index c0deaca..029ec46b 100644
> --- a/arch/arm/mach-davinci/Kconfig
> +++ b/arch/arm/mach-davinci/Kconfig
> @@ -18,6 +18,7 @@ config ARCH_DAVINCI_DM644x
>  	bool "DaVinci 644x based system"
>  	select AINTC
>  	select ARCH_DAVINCI_DMx
> +	select PHYLIB

Selecting PHYLIB for the SoC isn't right because
only the EVM is affected by this issue.

Also, instead of selecting PHYLIB, a better fix
would be to define the fixup function within
#ifdef PHYLIB and have an empty fixup registration
function in case PHYLIB is not defined (which
should happen only when EMAC driver is not configured
in which case a fixup is not required anyway).

Thanks,
Sekhar
