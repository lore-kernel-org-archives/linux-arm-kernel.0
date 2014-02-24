From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 24 Feb 2014 11:53:33 -0700
Subject: [PATCH] ARM: tegra: add device tree for SHIELD
In-Reply-To: <1393237593-28121-1-git-send-email-acourbot@nvidia.com>
References: <1393237593-28121-1-git-send-email-acourbot@nvidia.com>
Message-ID: <530B952D.2000006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2014 03:26 AM, Alexandre Courbot wrote:
> Add a device tree for NVIDIA SHIELD. The set of enabled features is
> still minimal with no display option (although HDMI should be easy
> to get to work) and USB requiring external power.

You could add a simple-framebuffer node for now, I think?

> diff --git a/arch/arm/boot/dts/tegra114-roth.dts b/arch/arm/boot/dts/tegra114-roth.dts

> +	memory {
> +		reg = <0x80000000 0x79600000>;

It might be worth a comment here pointing out that the rest of RAM is
reserved for some carveouts/..., or at least that these values are set
this way in order to match what the bootloader usually passes to
downstream kernels in the command-line?

> +	i2c at 7000d000 {

> +		palmas: pmic at 58 {
> +			compatible = "ti,palmas";
> +			reg = <0x58>;
> +			interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
> +			ti,irq-externally-inverted;

Unfortunately, the patch I sent to document/implement that last property
hasn't yet been ack'd/applied, so I'll hold off applying this until it has.

> +	/* Wifi */
> +	sdhci at 78000000 {
> +		status = "okay";
> +		bus-width = <4>;
> +		broken-cd;
> +		keep-power-in-suspend;
> +		cap-sdio-irq;

Is non-removable better than broken-cd, or are they entirely unrelated?

Should we add broken-cd and/or cap-sdio-irq to the SDIO WiFi on other
boards (Springbank, Ventana, Cardhu)?

> +	usb-phy at 7d000000 {
> +		status = "okay";
> +		nvidia,xcvr-setup = <7>;
> +		nvidia,xcvr-lsfslew = <2>;
> +		nvidia,xcvr-lsrslew = <2>;
> +		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> +		dr_mode = "otg";

While opt is probably accurate, we don't actually support otg upstream,
but only host. While the DT is supposed to represent HW rather than
SW/OS details, I've tried to avoid putting otg into the DT, since I'm
not sure that the DT binding for otg is stable, since we can't test it,
whereas host probably is. Still, this is a pretty minor detail, and we
can ignore that if you want ("otg" evidently /works/ fine on Seaboard,
so it's OK if you keep this).
