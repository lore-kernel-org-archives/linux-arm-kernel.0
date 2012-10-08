From: florian@openwrt.org (Florian Fainelli)
Date: Mon, 08 Oct 2012 13:50:08 +0200
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <20121007015405.958959522@gmail.com>
References: <20121007015300.828366635@gmail.com>
 <20121007015405.958959522@gmail.com>
Message-ID: <19574322.MHE4gIJg5N@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Domenico,

On Sunday 07 October 2012 03:53:01 Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> BCM476x's minimal infrastructure, Kernel's great reuse.
> 
> Look mom, no include/mach directory!

This is going to be in the commit, use something more sensible ;)

> 
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> ---
[snip]
> Index: b/arch/arm/boot/dts/bcm476x.dtsi
> ===================================================================
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm476x.dtsi
> @@ -0,0 +1,31 @@
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	compatible = "brcm,bcm476x";
> +	model = "Broadcom BCM476x";
> +
> +	chosen {
> +		bootargs = "earlyprintk";
> +	};
> +
> +	amba {

I would rather explicitely mention that the peripheral base address is at 0
so something like this:

amba at 0 {

to make it clear that the peripherals declared as leaf nodes of this one are
at a relative address.

> +		compatible = "arm,amba-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		vic0: interrupt-controller at 80000 {
> +			compatible = "brcm,bcm476x-pl192", "arm,pl192-vic", "arm,primecell";
> +			reg = <0x80000 0x1000>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		vic1: interrupt-controller at 81000 {
> +			compatible = "brcm,bcm476x-pl192", "arm,pl192-vic", "arm,primecell";
> +			reg = <0x81000 0x1000>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +	};
> +};
> Index: b/arch/arm/configs/bcm476x_defconfig
> ===================================================================
> --- /dev/null
> +++ b/arch/arm/configs/bcm476x_defconfig
> @@ -0,0 +1,352 @@
[snip]
> +CONFIG_ARM_APPENDED_DTB=y
> +CONFIG_ARM_ATAG_DTB_COMPAT=y
> +CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
> +CONFIG_CMDLINE="root=/dev/mmcblk0p2 ro console=ttyAMA1,115200 rootwait init=/bin/bash"

remove the specific init=, let people use the defaults.
--
Florian
