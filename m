From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 4 Mar 2016 09:30:02 +0100
Subject: [PATCH] arm64: tegra210-smaug: Add gpio-key nodes
In-Reply-To: <1457034865-17826-1-git-send-email-rklein@nvidia.com>
References: <1457034865-17826-1-git-send-email-rklein@nvidia.com>
Message-ID: <20160304083002.GA4038@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 02:54:25PM -0500, Rhyland Klein wrote:
> Add gpio-key nodes for the volumn controls, lid switch,
> tablet mode and power button.
> 
> Signed-off-by: Rhyland Klein <rklein@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 43 +++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> index 750e85c45135..9c0ec3031e98 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> @@ -1,5 +1,7 @@
>  /dts-v1/;
>  
> +#include <dt-bindings/input/input.h>
> +
>  #include "tegra210.dtsi"
>  
>  / {
> @@ -76,6 +78,47 @@
>  		};
>  	};
>  
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		gpio-keys,name = "gpio-keys";
> +
> +		power {
> +			label = "Power";
> +			gpios = <&gpio TEGRA_GPIO(X, 5) GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_POWER>;
> +			debounce-interval = <30>;
> +			gpio-key,wakeup;

This property was recently deprecated in favour of the standard generic
wakeup-source property.

> +		};
> +
> +		lid {
> +			label = "Lid";
> +			gpios = <&gpio TEGRA_GPIO(B, 4) GPIO_ACTIVE_LOW>;
> +			linux,input-type = <5>; /* EV_SW */
> +			linux,code = <0>; /* SW_LID */

The dt-bindings/input/input.h header defines the symbolic names for
these in upstream versions of the Linux kernel.

> +			gpio-key,wakeup;
> +		};
> +
> +		tablet_mode {
> +			label = "Tablet Mode";
> +			gpios = <&gpio TEGRA_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
> +			linux,input-type = <5>; /* EV_SW */
> +			linux,code = <1>; /* SW_TABLET_MODE */

Same here.

I've made all the above changes when applying, so no need to resend.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160304/4587fb98/attachment.sig>
