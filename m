From: simon@sequanux.org (Simon Guinot)
Date: Tue, 8 Nov 2011 10:56:26 +0100
Subject: [PATCH] ARM: kirkwood: add LaCie Network Space Lite v2 support
In-Reply-To: <1320661790-7066-1-git-send-email-cvubrugier@lacie.com>
References: <1320661790-7066-1-git-send-email-cvubrugier@lacie.com>
Message-ID: <20111108095626.GE18750@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christophe,

On Mon, Nov 07, 2011 at 11:29:50AM +0100, Christophe Vu-Brugier wrote:
> The LaCie Network Space Lite v2 shares most of its characteristics
> with the LaCie Network Space v2.
> 
> Hardware:
>  * CPU: Marvell 88F6192 800Mhz
>  * SDRAM memory: 128 MiB DDR2
>  * Gigabit ethernet: PHY Marvell 88E1318
>  * Flash memory: Macronix MX25L4005A 512 KiB
>  * i2c EEPROM: 512 bytes
>  * 2 USB2 ports: host and host/device
>  * 1 push button
>  * 2 LEDs (red and blue)

As you are here, could you as well add support for the Network Space
Mini board ? The only difference between the Lite and the Mini boards
is that a GPIO fan is provided on the last.

Thanks in advance.

Simon

> 
> Signed-off-by: Christophe Vu-Brugier <cvubrugier@lacie.com>
> ---
>  arch/arm/mach-kirkwood/Kconfig             |    6 ++++++
>  arch/arm/mach-kirkwood/Makefile            |    1 +
>  arch/arm/mach-kirkwood/netspace_v2-setup.c |   13 +++++++++++++
>  3 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index 7fc603b..3f64872 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -94,6 +94,12 @@ config MACH_NETSPACE_V2
>  	  Say 'Y' here if you want your kernel to support the
>  	  LaCie Network Space v2 NAS.
>  
> +config MACH_NETSPACE_LITE_V2
> +	bool "LaCie Network Space Lite v2 NAS Board"
> +	help
> +	  Say 'Y' here if you want your kernel to support the
> +	  LaCie Network Space Lite v2 NAS.
> +
>  config MACH_INETSPACE_V2
>  	bool "LaCie Internet Space v2 NAS Board"
>  	help
> diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> index 5dcaa81..6e408df 100644
> --- a/arch/arm/mach-kirkwood/Makefile
> +++ b/arch/arm/mach-kirkwood/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o tsx1x-common.o
>  obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
>  obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
>  obj-$(CONFIG_MACH_NETSPACE_V2)		+= netspace_v2-setup.o lacie_v2-common.o
> +obj-$(CONFIG_MACH_NETSPACE_LITE_V2)	+= netspace_v2-setup.o lacie_v2-common.o
>  obj-$(CONFIG_MACH_INETSPACE_V2)		+= netspace_v2-setup.o lacie_v2-common.o
>  obj-$(CONFIG_MACH_NETSPACE_MAX_V2)	+= netspace_v2-setup.o lacie_v2-common.o
>  obj-$(CONFIG_MACH_D2NET_V2)		+= d2net_v2-setup.o lacie_v2-common.o
> diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
> index 8849bcc..0977d11 100644
> --- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
> +++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
> @@ -237,6 +237,8 @@ static void __init netspace_v2_init(void)
>  		lacie_v2_hdd_power_init(1);
>  
>  	kirkwood_ehci_init();
> +	if (machine_is_netspace_lite_v2())
> +		netspace_v2_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
>  	kirkwood_ge00_init(&netspace_v2_ge00_data);
>  	kirkwood_sata_init(&netspace_v2_sata_data);
>  	kirkwood_uart0_init();
> @@ -267,6 +269,17 @@ MACHINE_START(NETSPACE_V2, "LaCie Network Space v2")
>  MACHINE_END
>  #endif
>  
> +#ifdef CONFIG_MACH_NETSPACE_LITE_V2
> +MACHINE_START(NETSPACE_LITE_V2, "LaCie Network Space Lite v2")
> +	.atag_offset	= 0x100,
> +	.init_machine	= netspace_v2_init,
> +	.map_io		= kirkwood_map_io,
> +	.init_early	= kirkwood_init_early,
> +	.init_irq	= kirkwood_init_irq,
> +	.timer		= &kirkwood_timer,
> +MACHINE_END
> +#endif
> +
>  #ifdef CONFIG_MACH_INETSPACE_V2
>  MACHINE_START(INETSPACE_V2, "LaCie Internet Space v2")
>  	.atag_offset	= 0x100,
> -- 
> 1.7.7
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111108/bd407d8a/attachment.sig>
