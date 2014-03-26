From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 26 Mar 2014 09:39:31 +0100
Subject: [PATCH v7 2/3] ARM: sun7i/sun6i: dts: Add NMI irqchip support
In-Reply-To: <1395256879-8475-3-git-send-email-carlo@caione.org>
References: <1395256879-8475-1-git-send-email-carlo@caione.org>
 <1395256879-8475-3-git-send-email-carlo@caione.org>
Message-ID: <53329243.8090604@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/19/2014 08:21 PM, Carlo Caione wrote:
> This patch adds DTS entries for NMI controller as child of GIC.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>

Note this breaks the kernel on sun6i / A31 since we don't have a
pmic driver there yet, and thus the nmi gets constantly fired without
anything clearing it.

So the sun6i section needs a status = "disabled"; until we actually have pmic
support.

Regards,

Hans

> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 8 ++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index 5256ad9..eea6033 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -190,6 +190,14 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> +		nmi_intc: interrupt-controller at 01f00c0c {
> +			compatible = "allwinner,sun6i-a31-sc-nmi";
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			reg = <0x01f00c0c 0x38>;
> +			interrupts = <0 0 4>;
> +		};
> +
>  		pio: pinctrl at 01c20800 {
>  			compatible = "allwinner,sun6i-a31-pinctrl";
>  			reg = <0x01c20800 0x400>;
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 6f25cf5..7637f12 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -339,6 +339,14 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> +		nmi_intc: interrupt-controller at 01c00030 {
> +			compatible = "allwinner,sun7i-a20-sc-nmi";
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			reg = <0x01c00030 0x0c>;
> +			interrupts = <0 0 4>;
> +		};
> +
>  		emac: ethernet at 01c0b000 {
>  			compatible = "allwinner,sun4i-a10-emac";
>  			reg = <0x01c0b000 0x1000>;
> 
