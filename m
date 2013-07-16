From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Jul 2013 12:30:14 +0200
Subject: [PATCH 4/5] iio: at91: add an optional dt property for for adc
 clock hz.
In-Reply-To: <51E4FC70.3050207@atmel.com>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
 <1373789069-11604-5-git-send-email-josh.wu@atmel.com>
 <20130715130610.GD2962@lukather> <51E4FC70.3050207@atmel.com>
Message-ID: <20130716103014.GB3125@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 03:55:28PM +0800, Josh Wu wrote:
> >On Sun, Jul 14, 2013 at 04:04:28PM +0800, Josh Wu wrote:
> >>diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> >>index e93a075..8f1386f 100644
> >>--- a/drivers/iio/adc/at91_adc.c
> >>+++ b/drivers/iio/adc/at91_adc.c
> >>@@ -47,6 +47,7 @@ struct at91_adc_caps {
> >>  struct at91_adc_state {
> >>  	struct clk		*adc_clk;
> >>+	u32			adc_clk_rate;
> >>  	u16			*buffer;
> >>  	unsigned long		channels_mask;
> >>  	struct clk		*clk;
> >>@@ -448,6 +449,10 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
> >>  	if (!node)
> >>  		return -EINVAL;
> >>+	prop = 0;
> >>+	of_property_read_u32(node, "atmel,adc-clock-rate", &prop);
> >>+	st->adc_clk_rate = prop;
> >>+
> >>  	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
> >>  	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop)) {
> >>@@ -723,7 +728,8 @@ static int at91_adc_probe(struct platform_device *pdev)
> >>  	 * specified by the electrical characteristics of the board.
> >>  	 */
> >>  	mstrclk = clk_get_rate(st->clk);
> >>-	adc_clk = clk_get_rate(st->adc_clk);
> >>+	adc_clk = st->adc_clk_rate ?
> >>+		st->adc_clk_rate : clk_get_rate(st->adc_clk);
> >Why is that needed? Isn't it completely redundant with the clocks
> >property?
> 
> As st->adc_clk rate is specified in arch/arm/mach-at91/sama5d3.c
> (take sama5d3 for example), changing the clock rate should recompile
> the kernel binary.
> Use dt parameter will let us easily specify the clock rate instead
> of recompile the code.
>
> And yes, it is redundant that we can define the adc_op_clk rate in
> two places (clock property in .c and adc-clock-rate in dts). But
> this can be compatible with the non-dt platform.

Yet, it's not, while, like you pointed at, the common clock framework
actually *is* usable for both DT and non-DT platforms at no cost.

The fact that AT91 isn't using the DT to retrieve its clock tree yet is
another story (but I believe that it's a work in progress).

> After a further thinking of this, maybe remove the adc_op_clk is
> better since it is a fake clock, and only used to specify the clock
> rate.
> To specify the clock rate use a dt property or platform data
> parameter is better.

No, to specify *any* clock, the common clock framework is the better
solution.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130716/4fd79342/attachment-0001.sig>
