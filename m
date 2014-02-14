From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 14 Feb 2014 10:39:01 +0000
Subject: [PATCH 2/2] ARM: bcm2835: fix clock DT node names
In-Reply-To: <1392358613-19962-2-git-send-email-swarren@wwwdotorg.org>
References: <1392358613-19962-1-git-send-email-swarren@wwwdotorg.org>
 <1392358613-19962-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140214103901.GD9907@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 06:16:53AM +0000, Stephen Warren wrote:
> DT nodes should be named according to the type of object that they
> represent rather than the identity. DT nodes that contain a reg
> property should include a unit address in their name. Fix these issues.

As mentioned on patch one, I don't think this makes sense. clock at N is
simply not correct, and if simple-bus weren't being abused it would be
far clearer that that is the case.

Please use clock_N rather than clock at N here, and get rid of the
meaningless reg values.

The simple-bus should either be removed or fixed up to meet the
requirements of the simple-bus binding (i.e. add a ranges property). I
would prefer the former.

Thanks,
Mark.

> 
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> This is the bcm2835 patch which depends on patch 1. I guess this could
> also go through the clk tree if that makes it easier, although there's
> always the small risk of conflicts if you do that.
> 
>  arch/arm/boot/dts/bcm2835.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
> index a2d4889..1cf1ae7 100644
> --- a/arch/arm/boot/dts/bcm2835.dtsi
> +++ b/arch/arm/boot/dts/bcm2835.dtsi
> @@ -155,21 +155,21 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		clk_mmc: mmc {
> +		clk_mmc: clock at 0 {
>  			compatible = "fixed-clock";
>  			reg = <0>;
>  			#clock-cells = <0>;
>  			clock-frequency = <100000000>;
>  		};
>  
> -		clk_i2c: i2c {
> +		clk_i2c: clock at 1 {
>  			compatible = "fixed-clock";
>  			reg = <1>;
>  			#clock-cells = <0>;
>  			clock-frequency = <250000000>;
>  		};
>  
> -		clk_spi: spi {
> +		clk_spi: clock at 2 {
>  			compatible = "fixed-clock";
>  			reg = <2>;
>  			#clock-cells = <0>;
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
