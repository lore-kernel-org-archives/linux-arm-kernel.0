From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 17 Apr 2013 11:35:24 +0200
Subject: [RFC PATCH 2/2] ARM: DT: kernel: DT cpu node bindings update
In-Reply-To: <1366042402-8987-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366042402-8987-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366042402-8987-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <516E6CDC.9010005@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2013 06:13 PM, Lorenzo Pieralisi :
> In order to extend the current cpu nodes bindings to newer CPUs
> inclusive of AArch64 and to update support for older ARM CPUs this
> patch updates device tree documentation for the cpu nodes bindings.
> 
> Main changes:
> 
> - adds 64-bit bindings (inclusive of cpus node #address-cells updates)
> - defines behaviour on pre and post v7 uniprocessor systems
> - adds ARM 11MPcore specific reg property definition
> 
> DT cpu map parsing code must be made compliant with the latest bindings
> updates, hence this patch also updates the arm_dt_init_cpu_maps() function
> with checks and additional parsing rules.
> 
> Uniprocessor systems predating v7 do not parse the cpus node at all
> since the reg property is meaningless on those systems.
> 
> Device trees for 64-bit systems can be taken as device tree input also
> for 64-bit CPUs running in 32-bit mode. The code checks that the reg entries
> are zeroed as required in the respective fields and detects automatically
> the cpus node #address-cells value so that device tree written for
> 64-bit ARM platforms (cpus #address-cells == 2) can still be taken as
> input. The correct device tree entries are to be set up by the boot
> loader, kernel code just checks that device tree entries in the cpus
> node are as expected for a 32-bit CPU (reg[63:24] == 0).
> 
> cpu node entries with invalid reg property or containing duplicates are
> ignored and the device tree parsing is not stopped anymore when such
> entries are encountered, the device tree cpu entry is just skipped.
> 
> A device tree with cpu nodes missing the boot CPU MPIDR is considered a
> hard error and the kernel flags this up as a bug to force firmware updates.
> 
> The updates to cpus/cpu node bindings for ARM require all in-kernel dts files
> present in the mainline to be made compliant to the latest specification.
> 
> This patch also updates ARM in-kernel non-compliant dts files to the latest
> cpus/cpu nodes bindings specification.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 335 +++++++++++++++++++++----
>  arch/arm/boot/dts/exynos5440.dtsi              |   7 +
>  arch/arm/boot/dts/omap3.dtsi                   |   4 +
>  arch/arm/boot/dts/omap4.dtsi                   |   5 +
>  arch/arm/boot/dts/omap5.dtsi                   |   5 +
>  arch/arm/boot/dts/r8a7740.dtsi                 |   3 +
>  arch/arm/boot/dts/sh7372.dtsi                  |   4 +
>  arch/arm/boot/dts/sunxi.dtsi                   |   4 +

Hi,

If it can be done easily, can you please consider the upcoming (3.10)
cortex-a5 SoC:

arch/arm/boot/dts/sama5d3.dtsi

It is in linux-next through arm-soc/at91/at91/soc


>  arch/arm/kernel/devtree.c                      |  82 +++---
>  9 files changed, 377 insertions(+), 72 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index f32494d..b1ef3d8 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -1,4 +1,6 @@
> -* ARM CPUs binding description
> +=============================
> +ARM CPUs bindings description
> +=============================
>  
>  The device tree allows to describe the layout of CPUs in a system through
>  the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
> @@ -8,70 +10,317 @@ Bindings for CPU nodes follow the ePAPR standard, available from:
>  
>  http://devicetree.org
>  
> -For the ARM architecture every CPU node must contain the following properties:
> -
> -- device_type:	must be "cpu"
> -- reg:		property matching the CPU MPIDR[23:0] register bits
> -		reg[31:24] bits must be set to 0
> -- compatible:	should be one of:
> -		"arm,arm1020"
> -		"arm,arm1020e"
> -		"arm,arm1022"
> -		"arm,arm1026"
> -		"arm,arm720"
> -		"arm,arm740"
> -		"arm,arm7tdmi"
> -		"arm,arm920"

Here we have: "arm,arm920t" for at91rm9200.dtsi

> -		"arm,arm922"
> -		"arm,arm925"
> -		"arm,arm926"

Oh, I missed this one: the strange thing is that *all* arm926 variants
have a compatible string of this form: "arm,arm926ejs"

(using: git grep "arm,arm9" next/master)

Should we change? Is there a rule for this naming?

> -		"arm,arm940"
> -		"arm,arm946"
> -		"arm,arm9tdmi"
> -		"arm,cortex-a5"
> -		"arm,cortex-a7"
> -		"arm,cortex-a8"
> -		"arm,cortex-a9"
> -		"arm,cortex-a15"
> -		"arm,arm1136"
> -		"arm,arm1156"
> -		"arm,arm1176"
> -		"arm,arm11mpcore"
> -		"faraday,fa526"
> -		"intel,sa110"
> -		"intel,sa1100"
> -		"marvell,feroceon"
> -		"marvell,mohawk"
> -		"marvell,xsc3"
> -		"marvell,xscale"

[..]

Thanks, best regards,
-- 
Nicolas Ferre
