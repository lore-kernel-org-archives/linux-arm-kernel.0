From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 Jul 2013 15:06:10 +0200
Subject: [PATCH 4/5] iio: at91: add an optional dt property for for adc
 clock hz.
In-Reply-To: <1373789069-11604-5-git-send-email-josh.wu@atmel.com>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
 <1373789069-11604-5-git-send-email-josh.wu@atmel.com>
Message-ID: <20130715130610.GD2962@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Sun, Jul 14, 2013 at 04:04:28PM +0800, Josh Wu wrote:
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-adc.txt |    2 ++
>  drivers/iio/adc/at91_adc.c                          |    8 +++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> index 16769d9..0db2945 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> @@ -27,6 +27,8 @@ Optional properties:
>  		       resolution will be used.
>    - atmel,adc-sleep-mode: Boolean to enable sleep mode when no conversion
>    - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
> +  - atmel,adc-clock-rate: ADC clock rate. If not specified, use the default
> +			  adc_op_clk.
>   
>  Optional trigger Nodes:
>    - Required properties:
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index e93a075..8f1386f 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -47,6 +47,7 @@ struct at91_adc_caps {
>  
>  struct at91_adc_state {
>  	struct clk		*adc_clk;
> +	u32			adc_clk_rate;
>  	u16			*buffer;
>  	unsigned long		channels_mask;
>  	struct clk		*clk;
> @@ -448,6 +449,10 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
>  	if (!node)
>  		return -EINVAL;
>  
> +	prop = 0;
> +	of_property_read_u32(node, "atmel,adc-clock-rate", &prop);
> +	st->adc_clk_rate = prop;
> +
>  	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
>  
>  	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop)) {
> @@ -723,7 +728,8 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	 * specified by the electrical characteristics of the board.
>  	 */
>  	mstrclk = clk_get_rate(st->clk);
> -	adc_clk = clk_get_rate(st->adc_clk);
> +	adc_clk = st->adc_clk_rate ?
> +		st->adc_clk_rate : clk_get_rate(st->adc_clk);

Why is that needed? Isn't it completely redundant with the clocks
property?

Maxime


-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130715/bc33e590/attachment-0001.sig>
