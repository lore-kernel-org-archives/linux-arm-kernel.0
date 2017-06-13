From: briannorris@chromium.org (Brian Norris)
Date: Tue, 13 Jun 2017 10:50:44 -0700
Subject: [PATCH v2 4/4] arm64: dts: rockchip: use cs-gpios for cros_ec_spi
In-Reply-To: <1497331543-8565-4-git-send-email-jeffy.chen@rock-chips.com>
References: <1497331543-8565-1-git-send-email-jeffy.chen@rock-chips.com>
 <1497331543-8565-4-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <20170613175043.GC9026@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 01:25:43PM +0800, Jeffy Chen wrote:
> The cros_ec requires CS line to be active after last message. But the CS
> would be toggled when powering off/on rockchip spi, which breaks ec xfer.
> Use GPIO CS to prevent that.

I suppose this change is fine. (At least, I don't have a good reason not
to do this.)

But I still wonder whether this is something that the SPI core can be
expected to handle. drivers/mfd/cros_ec_spi.c already sets the
appropriate trans->cs_change bits, to ensure CS remains active in
between certain messages (all under spi_bus_lock()). But you're
suggesting that your bus controller may deassert CS if you runtime
suspend the device (e.g., in between messages).

So, is your controller just peculiar? Or should the SPI core avoid
autosuspending the bus controller when it's been instructed to keep CS
active? Any thoughts Mark?

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v2:
> Fix wrong pinconf for spi5_cs0.
> 
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> index eb50593..b34a51d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -790,6 +790,8 @@ ap_i2c_audio: &i2c8 {
>  &spi5 {
>  	status = "okay";
>  
> +	cs-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;

This isn't actually true; it's not active high, it's active low. I guess it
doesn't really matter because the SPI framework uses the gpio_* APIs, which
don't account for the ACTIVE_* flags, and it has separate flags for uncommon
device polarity ("spi-cs-high").

Brian

> +
>  	cros_ec: ec at 0 {
>  		compatible = "google,cros-ec-spi";
>  		reg = <0>;
> @@ -813,6 +815,10 @@ ap_i2c_audio: &i2c8 {
>  	};
>  };
>  
> +&spi5_cs0 {
> +	rockchip,pins = <RK_GPIO2 23 RK_FUNC_GPIO &pcfg_output_high>;
> +};
> +
>  &tsadc {
>  	status = "okay";
>  
> -- 
> 2.1.4
> 
> 
