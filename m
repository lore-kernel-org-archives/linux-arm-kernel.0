From: patrice.chotard@st.com (Patrice Chotard)
Date: Fri, 21 Oct 2016 14:17:27 +0200
Subject: [PATCH] ARM: sti: stih407-clocks: Identify critical clocks
In-Reply-To: <1477040891-31611-1-git-send-email-peter.griffin@linaro.org>
References: <1477040891-31611-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <96d20fa1-c070-f36d-58ea-cba7ef2cae95@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2016 11:08 AM, Peter Griffin wrote:
> Lots of platforms contain clocks which if turned off would prove fatal.
> The only way to recover is to restart the board(s).  This driver takes
> references to clocks which are required to be always-on.  The Common
> Clk Framework will then take references to them.  This way they will
> not be turned off during the clk_disabled_unused() procedure.
> 
> In this patch we are identifying clocks, which if gated would render
> the STiH407 development board unserviceable.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-clock.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
> index 13029c0..34c119a 100644
> --- a/arch/arm/boot/dts/stih407-clock.dtsi
> +++ b/arch/arm/boot/dts/stih407-clock.dtsi
> @@ -101,6 +101,7 @@
>  				clocks = <&clk_sysin>;
>  
>  				clock-output-names = "clk-s-a0-pll-ofd-0";
> +				clock-critical = <0>; /* clk-s-a0-pll-ofd-0 */
>  			};
>  
>  			clk_s_a0_flexgen: clk-s-a0-flexgen {
> @@ -112,6 +113,7 @@
>  					 <&clk_sysin>;
>  
>  				clock-output-names = "clk-ic-lmi0";
> +				clock-critical = <CLK_IC_LMI0>;
>  			};
>  		};
>  
> @@ -126,6 +128,7 @@
>  					     "clk-s-c0-fs0-ch1",
>  					     "clk-s-c0-fs0-ch2",
>  					     "clk-s-c0-fs0-ch3";
> +			clock-critical = <0>; /* clk-s-c0-fs0-ch0 */
>  		};
>  
>  		clk_s_c0: clockgen-c at 09103000 {
> @@ -139,6 +142,7 @@
>  				clocks = <&clk_sysin>;
>  
>  				clock-output-names = "clk-s-c0-pll0-odf-0";
> +				clock-critical = <0>; /* clk-s-c0-pll0-odf-0 */
>  			};
>  
>  			clk_s_c0_pll1: clk-s-c0-pll1 {
> @@ -194,6 +198,12 @@
>  						     "clk-main-disp",
>  						     "clk-aux-disp",
>  						     "clk-compo-dvp";
> +				clock-critical = <CLK_PROC_STFE>,
> +						 <CLK_ICN_CPU>,
> +						 <CLK_TX_ICN_DMU>,
> +						 <CLK_EXT2F_A9>,
> +						 <CLK_ICN_LMI>,
> +						 <CLK_ICN_SBC>;
>  			};
>  		};
>  
> 

Acked-by: Patrice Chotard <patrice.chotard@st.com>

And applied !

Effectively, the job was done for STiH410 but i forgot to apply the same for STiH407

Thanks Peter  ;-)
