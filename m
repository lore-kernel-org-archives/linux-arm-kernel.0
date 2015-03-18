From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 18 Mar 2015 13:30:12 +0100
Subject: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
In-Reply-To: <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20150318123012.GA3580@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 01:21:05PM +0100, Sebastian Hesselbarth wrote:
> I2C mux pinctrl driver currently determines the number of sub-busses by
> counting available pinctrl-names. Unfortunately, this requires each
> incarnation of the devicetree node with different available sub-busses
> to be rewritten.
> 
> This patch reworks i2c-mux-pinctrl driver to count the number of
> available sub-nodes instead. The rework should be compatible to the old
> way of probing for sub-busses and additionally allows to disable unused
> sub-busses with standard DT property status = "disabled".

Not sure about this change. With DYNAMIC_OF these days, you can't rely
that 'disabled' stays disabled all the time. My gut feeling tells me
that people will want to use this someday.

> 
> This also amends the corresponding devicetree binding documentation to
> reflect the new functionality to disable unused sub-nodes. While at it,
> also fix two references to binding documentation files that miss an "i2c-"
> prefix.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Tested-by: Stephen Warren <swarren@nvidia.com>
> ---
> Changelog:
> 
> v2->v3:
> - remove mention of "I2C bus numbers" (Suggested by Stephen Warren)
> - require pinctrl-names property for "each child" instead of
>   "each enabled child" (Suggested by Stephen Warren)
> - swap enabled/disabled child nodes (Suggested by Stephen Warren)
> 
> v1->v2:
> - added a Tested-by for i2c-mux-pinctrl changes from Stepen Warren.
> - reworded i2c-mux-pinctrl devicetree doc changes
>   (Suggested by Stephen Warren).
> 
> Patches 2/4 - 4/4 remain unchanged.
> 
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Gabriel Dobato <dobatog@gmail.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: linux-i2c at vger.kernel.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  .../devicetree/bindings/i2c/i2c-mux-pinctrl.txt    | 21 ++++---
>  drivers/i2c/muxes/i2c-mux-pinctrl.c                | 70 ++++++++++++++--------
>  2 files changed, 58 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt
> index ae8af1694e95..cd94a0f64d76 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt
> @@ -28,17 +28,18 @@ Also required are:
>  * Standard pinctrl properties that specify the pin mux state for each child
>    bus. See ../pinctrl/pinctrl-bindings.txt.
>  
> -* Standard I2C mux properties. See mux.txt in this directory.
> +* Standard I2C mux properties. See i2c-mux.txt in this directory.
>  
> -* I2C child bus nodes. See mux.txt in this directory.
> +* I2C child bus nodes. See i2c-mux.txt in this directory.
>  
> -For each named state defined in the pinctrl-names property, an I2C child bus
> -will be created. I2C child bus numbers are assigned based on the index into
> -the pinctrl-names property.
> +For each enabled child node an I2C child bus will be created.
>  
> -The only exception is that no bus will be created for a state named "idle". If
> -such a state is defined, it must be the last entry in pinctrl-names. For
> -example:
> +There must be a corresponding pinctrl-names entry for each child node at the
> +position of the child node's "reg" property.
> +
> +Also, there can be an idle pinctrl state defined at the end of possible pinctrl
> +states. If such a state is defined, it must be the last entry in pinctrl-names.
> +For example:
>  
>  	pinctrl-names = "ddc", "pta", "idle"  ->  ddc = bus 0, pta = bus 1
>  	pinctrl-names = "ddc", "idle", "pta"  ->  Invalid ("idle" not last)
> @@ -68,10 +69,12 @@ Example:
>  		pinctrl-1 = <&state_i2cmux_pta>;
>  		pinctrl-2 = <&state_i2cmux_idle>;
>  
> +		/* Disabled child bus 0 */
>  		i2c at 0 {
>  			reg = <0>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +			status = "disabled";
>  
>  			eeprom {
>  				compatible = "eeprom";
> @@ -79,10 +82,12 @@ Example:
>  			};
>  		};
>  
> +		/* Enabled child bus 1 */
>  		i2c at 1 {
>  			reg = <1>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +			status = "okay";
>  
>  			eeprom {
>  				compatible = "eeprom";
> diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
> index b48378c4b40d..033dacfabfdf 100644
> --- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
> +++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
> @@ -56,9 +56,12 @@ static int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pinctrl *mux,
>  				struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> -	int num_names, i, ret;
> +	struct device_node *child;
> +	struct property *prop;
> +	int num_names, num_children, ret;
>  	struct device_node *adapter_np;
>  	struct i2c_adapter *adapter;
> +	const char *state;
>  
>  	if (!np)
>  		return 0;
> @@ -77,32 +80,16 @@ static int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pinctrl *mux,
>  		return num_names;
>  	}
>  
> -	mux->pdata->pinctrl_states = devm_kzalloc(&pdev->dev,
> -		sizeof(*mux->pdata->pinctrl_states) * num_names,
> -		GFP_KERNEL);
> -	if (!mux->pdata->pinctrl_states) {
> -		dev_err(mux->dev, "Cannot allocate pinctrl_states\n");
> -		return -ENOMEM;
> +	num_children = of_get_available_child_count(np);
> +	if (num_children < 0) {
> +		dev_err(mux->dev, "Unable to count available children: %d\n",
> +			num_children);
> +		return num_children;
>  	}
>  
> -	for (i = 0; i < num_names; i++) {
> -		ret = of_property_read_string_index(np, "pinctrl-names", i,
> -			&mux->pdata->pinctrl_states[mux->pdata->bus_count]);
> -		if (ret < 0) {
> -			dev_err(mux->dev, "Cannot parse pinctrl-names: %d\n",
> -				ret);
> -			return ret;
> -		}
> -		if (!strcmp(mux->pdata->pinctrl_states[mux->pdata->bus_count],
> -			    "idle")) {
> -			if (i != num_names - 1) {
> -				dev_err(mux->dev, "idle state must be last\n");
> -				return -EINVAL;
> -			}
> -			mux->pdata->pinctrl_state_idle = "idle";
> -		} else {
> -			mux->pdata->bus_count++;
> -		}
> +	if (num_names < num_children) {
> +		dev_err(mux->dev, "Found less pinctrl states than children\n");
> +		return -EINVAL;
>  	}
>  
>  	adapter_np = of_parse_phandle(np, "i2c-parent", 0);
> @@ -118,6 +105,39 @@ static int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pinctrl *mux,
>  	mux->pdata->parent_bus_num = i2c_adapter_id(adapter);
>  	put_device(&adapter->dev);
>  
> +	mux->pdata->pinctrl_states = devm_kzalloc(&pdev->dev,
> +		sizeof(*mux->pdata->pinctrl_states) * num_children,
> +		GFP_KERNEL);
> +	if (!mux->pdata->pinctrl_states) {
> +		dev_err(mux->dev, "Cannot allocate pinctrl_states\n");
> +		return -ENOMEM;
> +	}
> +
> +	of_property_for_each_string(np, "pinctrl-names", prop, state)
> +		if (!strcmp(state, "idle"))
> +			mux->pdata->pinctrl_state_idle = "idle";
> +
> +	for_each_available_child_of_node(np, child) {
> +		u32 reg;
> +
> +		ret = of_property_read_u32(child, "reg", &reg);
> +		if (ret < 0) {
> +			dev_err(mux->dev, "Missing reg property for child node: %d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		ret = of_property_read_string_index(np,
> +				    "pinctrl-names", reg, &state);
> +		if (ret < 0) {
> +			dev_err(mux->dev, "Cannot parse pinctrl-names for mux %d: %d\n",
> +				reg, ret);
> +			return ret;
> +		}
> +
> +		mux->pdata->pinctrl_states[mux->pdata->bus_count++] = state;
> +	}
> +
>  	return 0;
>  }
>  #else
> -- 
> 2.1.0
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/e482ce95/attachment.sig>
