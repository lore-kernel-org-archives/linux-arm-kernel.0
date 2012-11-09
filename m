From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Nov 2012 20:24:33 -0700
Subject: [PATCH] Add support for generic BCM SoC chipsets
In-Reply-To: <1352391196-9984-1-git-send-email-csd@broadcom.com>
References: <1352391196-9984-1-git-send-email-csd@broadcom.com>
Message-ID: <509C7771.9020400@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2012 09:13 AM, Christian Daudt wrote:
> In order to start upstreaming Broadcom SoC support, create
> a starting hierarchy, arch and dts files.
> The first support SoC family that is planned is the
>  BCM281XX (BCM28145/28150/28155) family of dual A9 mobile SoC cores
> This code is just the skeleton code for get the machine upstreamed. It
> has been made MULTIPLATFORM compatible.

Christian,

Is the intent for this to support other BCM SoCs in the future, such as
the bcm2835 in the Raspberry Pi, and the mach-bcm476x which Domenico
Andreoli recently sent patches for? It'd be awesome if Broadcom could
provide MMC and USB drivers for the bcm2835 for example.

>  arch/arm/boot/dts/capri-brt.dts |   32 +++++++++++
>  arch/arm/boot/dts/capri.dtsi    |   50 +++++++++++++++++

What does the name "capri" refer to? I assume it's a code-name for the
SoC/series. My inclination is that naming those files bcm28145.dtsi and
bcm28145-brt.dts (or 28150/28155 as appropriate) might be a little more
obvious to people unfamiliar with the code-names.

> diff --git a/arch/arm/boot/dts/capri-brt.dts b/arch/arm/boot/dts/capri-brt.dts

> +/ {
> +	model = "Capri BRT board";
> +	compatible = "bcm,capri";

The individual board file's compatible property should contain both a
board-specific value and the generic SoC value. This allows the SoC
support in the kernel to match on the generic SoC compatible value, yet
still allow the kernel to match the board-specific value in case any
quirks are required. For example,

	compatible = "bcm,brt", "bcm,capri";

(assuming that "brt" is the full board name)

> +	interrupt-parent = <&gic>;

That's already in capri.dtsi; there's no advantage to repeating it.

> +	memory {
> +		device_type = "memory";

That property already exists in skeleton.dtsi, which is included via
capri.dtsi.

> diff --git a/arch/arm/boot/dts/capri.dtsi b/arch/arm/boot/dts/capri.dtsi

> +	gic: interrupt-controller at 3ff00100 {
> +		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";

The commit description says it's an A9 not an A15.

> +	uart at 3e000000 {
> +		compatible = "snps,dw-apb-uart";

You probably want to include SoC-specific compatible values for all the
IP blocks too.

There need to be device tree bindings written to describe to contents of
all these device-tree files; see Documentation/devicetree/bindings/.

> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig

> +config ARCH_BCM
> +	bool "Broadcom SoC" if ARCH_MULTI_V7
> +	depends on MMU
> +	select CPU_V7
> +	select ARM_GIC
> +	select GENERIC_GPIO
> +	select GPIO_BCM
> +	select ARCH_REQUIRE_GPIOLIB
> +	select GENERIC_TIME
> +	select GENERIC_CLOCKEVENTS
> +	select TICK_ONESHOT
> +	select ARM_ERRATA_754322
> +	select ARM_ERRATA_764369 if SMP
> +	select SPARSE_IRQ

Those select statements should be alphabetically sorted.

> diff --git a/arch/arm/mach-bcm/board_bcm.c b/arch/arm/mach-bcm/board_bcm.c

> +
> +
> +

> +
> +

Nit: A couple of instances of multiple newlines, but not a big deal.
