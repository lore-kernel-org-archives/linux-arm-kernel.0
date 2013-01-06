From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 6 Jan 2013 12:41:58 -0500
Subject: [PATCH] arm: mvebu: Use dw-apb-uart instead of ns16650 as UART
 driver
In-Reply-To: <1354640699-6066-1-git-send-email-gregory.clement@free-electrons.com>
References: <1354640699-6066-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130106174158.GD5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 06:04:59PM +0100, Gregory CLEMENT wrote:
> The UART controller used in the Armada 370 and Armada XP SoCs is the
> Synopsys DesignWare 8250 (aka Synopsys DesignWare ABP UART). The
> improper use of the ns16550 can lead to a kernel oops during boot if
> a character is sent to the UART before the initialization of the
> driver. The DW APB has an extra interrupt that gets raised when
> writing to the LCR when busy. This explains why we need to use
> dw-apb-uart driver to handle this.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied to mvebu/fixes.

thx,

Jason.

> ---
> 
> This patch fixed a bug introduced in 3.7, but as there are very few
> boards supported in 3.7 (only the Armada 370 and Armada XP evaluation
> boards), it is not a big deal if this patch is only applied for 3.8.
> 
> This patch is based on 3.7-rc8 and can be applied on top of the
> current arm-soc/for-next with a trivial conflict on mvebu_defconfig.
> 
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi |    6 ++++--
>  arch/arm/boot/dts/armada-xp.dtsi     |    6 ++++--
>  arch/arm/configs/mvebu_defconfig     |    2 +-
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 16cc82c..03640f7 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -44,17 +44,19 @@
>  		ranges;
>  
>  		serial at d0012000 {
> -				compatible = "ns16550";
> +				compatible = "snps,dw-apb-uart";
>  				reg = <0xd0012000 0x100>;
>  				reg-shift = <2>;
>  				interrupts = <41>;
> +				reg-io-width = <4>;
>  				status = "disabled";
>  		};
>  		serial at d0012100 {
> -				compatible = "ns16550";
> +				compatible = "snps,dw-apb-uart";
>  				reg = <0xd0012100 0x100>;
>  				reg-shift = <2>;
>  				interrupts = <42>;
> +				reg-io-width = <4>;
>  				status = "disabled";
>  		};
>  
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index 71d6b5d..9a0e744 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -29,17 +29,19 @@
>  
>  	soc {
>  		serial at d0012200 {
> -				compatible = "ns16550";
> +				compatible = "snps,dw-apb-uart";
>  				reg = <0xd0012200 0x100>;
>  				reg-shift = <2>;
>  				interrupts = <43>;
> +				reg-io-width = <4>;
>  				status = "disabled";
>  		};
>  		serial at d0012300 {
> -				compatible = "ns16550";
> +				compatible = "snps,dw-apb-uart";
>  				reg = <0xd0012300 0x100>;
>  				reg-shift = <2>;
>  				interrupts = <44>;
> +				reg-io-width = <4>;
>  				status = "disabled";
>  		};
>  
> diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
> index 3458752..9e34084 100644
> --- a/arch/arm/configs/mvebu_defconfig
> +++ b/arch/arm/configs/mvebu_defconfig
> @@ -22,7 +22,7 @@ CONFIG_VFP=y
>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
> -CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_SERIAL_8250_DW=y
>  CONFIG_GPIOLIB=y
>  CONFIG_GPIO_SYSFS=y
>  # CONFIG_USB_SUPPORT is not set
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
