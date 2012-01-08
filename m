From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 8 Jan 2012 22:52:56 +0800
Subject: [PATCH 4/6] arm/dts: imx6q-sabrelite: add sgtl5000 audio codec
In-Reply-To: <1325820343-11875-5-git-send-email-richard.zhao@linaro.org>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
 <1325820343-11875-5-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120108145254.GE20216@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2012 at 11:25:41AM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index 3f4b45e..567b664 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -44,6 +44,18 @@
>  			uart2: uart at 021e8000 {
>  				status = "okay";
>  			};
> +
> +			i2c at 021a0000 { /* I2C1 */
> +				status = "okay";
> +				clock-frequency = <100000>;
> +
> +				codec: sgtl5000 at 0a {
> +					compatible = "fsl,sgtl5000";
> +					reg = <0x0a>;
> +					VDDA-supply = <&reg_2P5V>;
> +					VDDIO-supply = <&reg_3P3V>;

I would prefer to have them named vdda-supply and vddio-supply.  But
I just learnt that they do not work, because sgtl5000 driver
(sound/soc/codecs/sgtl5000.c) has the supply_names in upper case, while
unlike of_node_cmp() is strcasecmp(), of_prop_cmp() is just strcmp().

But the convention on property name is really all using lower case,
and mixing cases there looks odd, so I'm thinking about the changes
below on of_get_regulator().

Mark, how do you think?

8<---
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ca86f39..b89eb43 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -17,6 +17,7 @@

 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/slab.h>
@@ -147,10 +148,15 @@ static struct device_node *of_get_regulator(struct device *dev, const char *supp
 {
        struct device_node *regnode = NULL;
        char prop_name[32]; /* 32 is max size of property name */
+       int i = 0;

        dev_dbg(dev, "Looking up %s-supply from device tree\n", supply);

        snprintf(prop_name, 32, "%s-supply", supply);
+       while (prop_name[i] && i < 32) {
+               prop_name[i] = tolower(prop_name[i]);
+               i++;
+       }
        regnode = of_parse_phandle(dev->of_node, prop_name, 0);

        if (!regnode) {
--->8
 
Regards,
Shawn

> +				};
> +			};
>  		};
>  	};
>  
> -- 
> 1.7.5.4
> 
> 
