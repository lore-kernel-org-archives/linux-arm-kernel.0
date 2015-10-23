From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sat, 24 Oct 2015 00:38:08 +0200
Subject: [RFC] ARM: BCM: Add SMP support for Broadcom 4708
In-Reply-To: <20151015181409.GJ32089@broadcom.com>
References: <1444844820-24290-1-git-send-email-kapilh@broadcom.com>
 <1444844820-24290-4-git-send-email-kapilh@broadcom.com>
 <561ED691.8080407@hauke-m.de> <20151014224003.GO15160@broadcom.com>
 <20151015154934.GD32089@broadcom.com> <20151015181409.GJ32089@broadcom.com>
Message-ID: <562AB6D0.7060807@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2015 08:14 PM, Jon Mason wrote:
> ARM: BCM: Add SMP support for Broadcom 4708
> 
> Add SMP support for Broadcom's 4708 SoCs.

I tested this and it works on my device, it is also in OpenWrt now:
https://dev.openwrt.org/browser/trunk/target/linux/bcm53xx/patches-4.1/131-ARM-BCM-Add-SMP-support-for-Broadcom-4708.patch?rev=47247

> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---
>  arch/arm/boot/dts/bcm4708.dtsi | 2 ++
>  arch/arm/boot/dts/bcm94708.dts | 2 +-
>  arch/arm/mach-bcm/Kconfig      | 1 +
>  arch/arm/mach-bcm/Makefile     | 3 +++
>  4 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/bcm4708.dtsi b/arch/arm/boot/dts/bcm4708.dtsi
> index 31141e8..22a41df 100644
> --- a/arch/arm/boot/dts/bcm4708.dtsi
> +++ b/arch/arm/boot/dts/bcm4708.dtsi
> @@ -15,6 +15,8 @@
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		enable-method = "brcm,bcm-nsp-smp";
> +		secondary-boot-reg = <0xffff0400>;
>  
>  		cpu at 0 {
>  			device_type = "cpu";
> diff --git a/arch/arm/boot/dts/bcm94708.dts b/arch/arm/boot/dts/bcm94708.dts
> index f60bb1d..49682d6 100644
> --- a/arch/arm/boot/dts/bcm94708.dts
> +++ b/arch/arm/boot/dts/bcm94708.dts
> @@ -32,7 +32,7 @@
>  
>  /dts-v1/;
>  
> -#include "bcm5301x.dtsi"
> +#include "bcm4708.dtsi"

This is already changed in the patch adding this file.

>  
>  / {
>  	model = "NorthStar SVK (BCM94708)";
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 2e9dbb5..4fc8fa3 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -54,6 +54,7 @@ config ARCH_BCM_NSP
>  config ARCH_BCM_5301X
>  	bool "Broadcom BCM470X / BCM5301X ARM SoC" if ARCH_MULTI_V7
>  	select ARCH_BCM_IPROC
> +	select HAVE_SMP

probably this is also needed:
select ARM_ERRATA_764369 if SMP
The CPU should be affected by this issue.

>  	help
>  	  Support for Broadcom BCM470X and BCM5301X SoCs with ARM CPU cores.
>  
> diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> index 36a4ca30..3ca1cf1 100644
> --- a/arch/arm/mach-bcm/Makefile
> +++ b/arch/arm/mach-bcm/Makefile
> @@ -43,6 +43,9 @@ obj-$(CONFIG_ARCH_BCM2835)	+= board_bcm2835.o
>  
>  # BCM5301X
>  obj-$(CONFIG_ARCH_BCM_5301X)	+= bcm_5301x.o
> +ifeq ($(CONFIG_ARCH_BCM_5301X),y)
> +obj-$(CONFIG_SMP)		+= headsmp.o platsmp.o
> +endif
>  
>  # BCM63XXx
>  ifeq ($(CONFIG_ARCH_BCM_63XX),y)
> 
