From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Dec 2015 10:36:05 +0100
Subject: [PATCH v2 4/9] ARM: dts: add dts files for hi3519-demb board
In-Reply-To: <1449110668-23647-1-git-send-email-xuejiancheng@huawei.com>
References: <1449110668-23647-1-git-send-email-xuejiancheng@huawei.com>
Message-ID: <1728470.0OiiXMcl88@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 December 2015 10:44:28 Jiancheng Xue wrote:

> +
> +/dts-v1/;
> +#include "hi3519.dtsi"
> +
> +/ {
> +	model = "HiSilicon HI3519 DEMO Board";
> +	compatible = "hisilicon,hi3519";
> +
> +	chosen {
> +		bootargs = "mem=64M console=ttyAMA0,115200 early_printk \
> +root=/dev/mtdblock2 rootfstype=jffs2 \
> +mtdparts=hi_sfc:1M(boot),4M(kernel),11M(rootfs)";
> +	};

Most of the arguments should be dropped and replaced with the respective
DT properties in this file:

mem:		/memory (you have that already, but the size seems wrong)
console:	/chosen/stdout-path
early_printk:	just drop this, maybe use "earlycon")
root:		this one is fine
rootfstype:	should not be needed
mtdparts:	use nodes below the MTD device


> +
> +#include "skeleton.dtsi"
> +#include <dt-bindings/clock/hi3519-clock.h>
> +/ {
> +	aliases {
> +		serial0 = &uart0;
> +	};

Move this into the .dts file.

> +
> +			uart0: uart at 12100000 {

rename to serial at 12100000

> +			dual_timer1: dual_timer at 12001000 {
> +				compatible = "arm,sp804", "arm,primecell";
> +				interrupts = <0 66 4>, <0 67 4>;
> +				reg = <0x12001000 0x1000>;
> +				clocks = <&crg HI3519_FIXED_3M>;
> +				status = "disable";
> +			};

rename to timer at 12001000

> +		sysctrl: system-controller at 12020000 {
> +			compatible = "hisilicon,sysctrl";
> +			reg = <0x12020000 0x1000>;
> +			reboot-offset = <0x4>;
> +		};

Is this one identical to the one in hip04?

If not, pick a new unique compatible string

> +
> +		crg: crg at 12010000 {
> +			compatible = "hisilicon,hi3519-crg";


what is a "crg"? Is there a standard name for these?

	Arnd
