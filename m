From: christopher.spinrath@rwth-aachen.de (Christopher Spinrath)
Date: Sun, 15 Oct 2017 22:46:02 +0200
Subject: [PATCH 2/2] ARM: dts: imx6q-cm-fx6: Use the 'vpcie-supply'
 property
In-Reply-To: <b26ee565-89d6-4feb-a639-b4e6482425b6@rwthex-w1-b.rwth-ad.de>
References: <1508098744-12099-1-git-send-email-festevam@gmail.com>
 <b26ee565-89d6-4feb-a639-b4e6482425b6@rwthex-w1-b.rwth-ad.de>
Message-ID: <5c38abed-4d13-4c7a-b4dc-eef54786e5d8@rwthex-s3-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 10/15/2017 10:19 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> According to Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt,
> the correct property for specifying the PCIe regulator is 'vpcie-supply',
> so use the correct one.
> 
> Cc: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx6q-cm-fx6.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
> index fe6ab0a..5c1b1c3 100644
> --- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
> +++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
> @@ -362,7 +362,7 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_pcie>;
>  	reset-gpio = <&gpio1 26 GPIO_ACTIVE_LOW>;
> -	vdd-supply = <&reg_pcie_power_on_gpio>;
> +	vpcie-supply = <&reg_pcie_power_on_gpio>;
>  	status = "okay";
>  };
>

Unfortunately, this change breaks the PCI support on the Utilite (which
is based on the cm-fx6). Without this change the regulator framework
disables the pcie/vdd regulator and by doing so actually activates it
(which is weird and should definitely be changed).

With the following additional diff, which sets the correct polarity of
the regulator, it works again:

--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -77,8 +77,7 @@
                regulator-name = "regulator-pcie-power-on-gpio";
                regulator-min-microvolt = <3300000>;
                regulator-max-microvolt = <3300000>;
-               gpio = <&gpio2 24 GPIO_ACTIVE_HIGH>;
-               enable-active-high;
+               gpio = <&gpio2 24 GPIO_ACTIVE_LOW>;
        };

        reg_usb_h1_vbus: usb_h1_vbus {

Cheers,
Christopher
