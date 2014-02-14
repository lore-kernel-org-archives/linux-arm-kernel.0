From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 14 Feb 2014 10:35:56 +0000
Subject: [PATCH 1/2] clk: fixed-rate: use full DT node name
In-Reply-To: <1392358613-19962-1-git-send-email-swarren@wwwdotorg.org>
References: <1392358613-19962-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140214103556.GC9907@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 06:16:52AM +0000, Stephen Warren wrote:
> clk-fixed-rate currently names clocks according to a node's name without
> the unit address. When faced with the legal and technically correct DT
> structure below, this causes rgistration attempts for 3 clocks with the
> same name, 2 of which fail.
> 
> 	clocks {
> 		compatible = "simple-bus";
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		clk_mmc: clock at 0 {
> 			compatible = "fixed-clock";
> 			reg = <0>;
> ...
> 		clk_i2c: clock at 1 {
> 			compatible = "fixed-clock";
> 			reg = <1>;
> ...
> 		clk_spi: clock at 2 {
> 			compatible = "fixed-clock";
> 			reg = <2>;
> ...

I'd argue that this case isn't valid.

The fixed-clock binding doesn't define a reg, yet simple bus binding
implies that the reg property of child nodes should be interpretted as
the same address space as their parent (MMIO in this case?). The
fixed-clock nodes reg proeprties clearly aren't MMIO addresses.

Additionally, the _requred_ ranges property is missing.

It's just nonsensical; rename them to clock_{0,1,..} instead and get rid
of the reg properties. Then they're named uniquely.

However, for cases where the reg value is meaningful the below patch
makes sense.

Thanks,
Mark.

> 
> Solve this by naming the clocks after the full node name rather than the
> short version (e.g. /clocks/clock at 0).
> 
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> Note that if this is accepted, I intend to submit a patch for the RPi DTS
> which uses the naming structure above, so it might be useful to place this
> patch in its own branch. Or, I could submit the cleanup after 3.15-rc1.
> ---
>  drivers/clk/clk-fixed-rate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
> index 0fc56ab..3335b3c 100644
> --- a/drivers/clk/clk-fixed-rate.c
> +++ b/drivers/clk/clk-fixed-rate.c
> @@ -115,7 +115,7 @@ EXPORT_SYMBOL_GPL(clk_register_fixed_rate);
>  void of_fixed_clk_setup(struct device_node *node)
>  {
>  	struct clk *clk;
> -	const char *clk_name = node->name;
> +	const char *clk_name = node->full_name;
>  	u32 rate;
>  	u32 accuracy = 0;
>  
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
