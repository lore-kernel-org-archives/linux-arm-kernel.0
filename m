From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 10 Nov 2016 08:06:52 +0000
Subject: [PATCH v4] regulator: lp873x: Add support for populating input
 supply
In-Reply-To: <20161110052915.4898-1-lokeshvutla@ti.com>
References: <20161110052915.4898-1-lokeshvutla@ti.com>
Message-ID: <20161110080652.GM13127@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Nov 2016, Lokesh Vutla wrote:

> In order to have a proper topology of regulators for a platform, each
> registering regulator needs to populate supply_name field for identifying
> its supply's name. Add supply_name field for lp873x regulators.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Changes since v3:
> - Applied Rob's ack.
> - Sending this patch separately so that this can be merged via Regulator tree.
> - Link to v3: https://patchwork.kernel.org/patch/9408545/
> 
>  Documentation/devicetree/bindings/mfd/lp873x.txt | 8 ++++++++

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
  
>  drivers/regulator/lp873x-regulator.c             | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/lp873x.txt b/Documentation/devicetree/bindings/mfd/lp873x.txt
> index 52766c2..ae9cf39 100644
> --- a/Documentation/devicetree/bindings/mfd/lp873x.txt
> +++ b/Documentation/devicetree/bindings/mfd/lp873x.txt
> @@ -7,6 +7,9 @@ Required properties:
>    - #gpio-cells:	Should be two.  The first cell is the pin number and
>  			the second cell is used to specify flags.
>  			See ../gpio/gpio.txt for more information.
> +  - xxx-in-supply:	Phandle to parent supply node of each regulator
> +			populated under regulators node. xxx can be
> +			buck0, buck1, ldo0 or ldo1.
>    - regulators:	List of child nodes that specify the regulator
>  			initialization data.
>  Example:
> @@ -17,6 +20,11 @@ pmic: lp8733 at 60 {
>  	gpio-controller;
>  	#gpio-cells = <2>;
>  
> +	buck0-in-supply = <&vsys_3v3>;
> +	buck1-in-supply = <&vsys_3v3>;
> +	ldo0-in-supply = <&vsys_3v3>;
> +	ldo1-in-supply = <&vsys_3v3>;
> +
>  	regulators {
>  		lp8733_buck0: buck0 {
>  			regulator-name = "lp8733-buck0";
> diff --git a/drivers/regulator/lp873x-regulator.c b/drivers/regulator/lp873x-regulator.c
> index e504b91..70e3df6 100644
> --- a/drivers/regulator/lp873x-regulator.c
> +++ b/drivers/regulator/lp873x-regulator.c
> @@ -24,6 +24,7 @@
>  	[_id] = {							\
>  		.desc = {						\
>  			.name			= _name,		\
> +			.supply_name		= _of "-in",		\
>  			.id			= _id,			\
>  			.of_match		= of_match_ptr(_of),	\
>  			.regulators_node	= of_match_ptr("regulators"),\

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
