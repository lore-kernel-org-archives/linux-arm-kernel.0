From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Nov 2016 12:26:32 -0600
Subject: [PATCH v2 4/6] pinctrl: aspeed: Read and write bits in LPCHC and
 GFX controllers
In-Reply-To: <1478097481-14895-5-git-send-email-andrew@aj.id.au>
References: <1478097481-14895-1-git-send-email-andrew@aj.id.au>
 <1478097481-14895-5-git-send-email-andrew@aj.id.au>
Message-ID: <20161109182632.etsvezgfu7nhtl55@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 01:07:59AM +1030, Andrew Jeffery wrote:
> The System Control Unit IP block in the Aspeed SoCs is typically where
> the pinmux configuration is found, but not always. A number of pins
> depend on state in one of LPC Host Control (LPCHC) or SoC Display
> Controller (GFX) IP blocks, so the Aspeed pinmux drivers should have the
> means to adjust these as necessary.
> 
> We use syscon to cast a regmap over the GFX and LPCHCR blocks, which is
> used as an arbitration layer between the relevant driver and the pinctrl
> subsystem. The regmaps are then exposed to the SoC-specific pinctrl
> drivers by phandles in the devicetree, and are selected during a mux
> request by querying a new 'ip' member in struct aspeed_sig_desc.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> Since v1:
> 
> The change is now proactive: instead of reporting that we need to flip bits in
> controllers we can't access, the patch provides access via regmaps for the
> relevant controllers. The implementation also splits out the IP block ID into
> its own variable rather than packing the value into the upper bits of the reg
> member of struct aspeed_sig_desc. This drives some churn in the diff, but I've
> tried to minimise it.
> 
>  .../devicetree/bindings/pinctrl/pinctrl-aspeed.txt | 50 +++++++++++++---
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c         | 18 +++---
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c         | 39 ++++++++++---
>  drivers/pinctrl/aspeed/pinctrl-aspeed.c            | 66 +++++++++++++---------
>  drivers/pinctrl/aspeed/pinctrl-aspeed.h            | 32 ++++++++---
>  5 files changed, 144 insertions(+), 61 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
> index 2ad18c4ea55c..115b0cce6c1c 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
> @@ -4,12 +4,19 @@ Aspeed Pin Controllers
>  The Aspeed SoCs vary in functionality inside a generation but have a common mux
>  device register layout.
>  
> -Required properties:
> -- compatible : Should be any one of the following:
> -		"aspeed,ast2400-pinctrl"
> -		"aspeed,g4-pinctrl"
> -		"aspeed,ast2500-pinctrl"
> -		"aspeed,g5-pinctrl"
> +Required properties for g4:
> +- compatible : 			Should be any one of the following:
> +				"aspeed,ast2400-pinctrl"
> +				"aspeed,g4-pinctrl"
> +
> +Required properties for g5:
> +- compatible : 			Should be any one of the following:
> +				"aspeed,ast2500-pinctrl"
> +				"aspeed,g5-pinctrl"
> +
> +- aspeed,external-nodes:	A cell of phandles to external controller nodes:
> +				0: compatible with "aspeed,ast2500-gfx", "syscon"
> +				1: compatible with "aspeed,ast2500-lpchc", "syscon"
>  
>  The pin controller node should be a child of a syscon node with the required
>  property:
> @@ -47,7 +54,7 @@ RGMII1 RGMII2 RMII1 RMII2 SD1 SPI1 SPI1DEBUG SPI1PASSTHRU TIMER4 TIMER5 TIMER6
>  TIMER7 TIMER8 VGABIOSROM
>  
>  
> -Examples:
> +g4 Example:
>  
>  syscon: scu at 1e6e2000 {
>  	compatible = "syscon", "simple-mfd";
> @@ -63,5 +70,34 @@ syscon: scu at 1e6e2000 {
>  	};
>  };
>  
> +g5 Example:
> +
> +apb {
> +	gfx: display at 1e6e6000 {
> +		compatible = "aspeed,ast2500-gfx", "syscon";
> +		reg = <0x1e6e6000 0x1000>;
> +	};
> +
> +	lpchc: lpchc at 1e7890a0 {
> +		compatible = "aspeed,ast2500-lpchc", "syscon";
> +		reg = <0x1e7890a0 0xc4>;
> +	};
> +
> +	syscon: scu at 1e6e2000 {
> +		compatible = "syscon", "simple-mfd";
> +		reg = <0x1e6e2000 0x1a8>;
> +
> +		pinctrl: pinctrl {

Why the single child node here? Doesn't look like any reason for it in 
the example. 

> +			compatible = "aspeed,g5-pinctrl";
> +			aspeed,external-nodes = <&gfx, &lpchc>;
> +
> +			pinctrl_i2c3_default: i2c3_default {
> +				function = "I2C3";
> +				groups = "I2C3";
> +			};
> +		};
> +	};
> +};
> +
>  Please refer to pinctrl-bindings.txt in this directory for details of the
>  common pinctrl bindings used by client devices.
