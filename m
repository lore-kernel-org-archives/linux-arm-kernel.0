From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 9 May 2014 10:19:09 +0800
Subject: [PATCH v2] ARM: dts: imx6: add new board RIoTboard
In-Reply-To: <536BBAE2.7060203@gmail.com>
References: <53695C34.5000604@gmail.com>
 <CAOMZO5AMf74btETX9zM97B-rCRAVh9-s=N4=xqTMifuucwqURg@mail.gmail.com>
 <536B9654.7020509@gmail.com> <1399560632.547109991@f294.i.mail.ru>
 <536BBAE2.7060203@gmail.com>
Message-ID: <20140509021908.GJ2794@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 06:12:02PM +0100, Iain Paton wrote:
> On 08/05/14 15:50, Alexander Shiyan wrote:
> 
> > I think you should make patch series:
> > 1. Add missing clock into imx6dl.dtsi
> > 2. Add label to AIPS2 to imx6qdl.dtsi and use this label in imx6dl.dtsi
> > 3. This patch
> 
> I'm not sure I follow 1/2.  You mean something like this 
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index eca0971..0645069 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -767,7 +767,7 @@
>                         };
>                 };
>  
> -               aips-bus at 02100000 { /* AIPS2 */
> +               aips2: aips-bus at 02100000 { /* AIPS2 */
>                         compatible = "fsl,aips-bus", "simple-bus";
>                         #address-cells = <1>;
>                         #size-cells = <1>;
> 
> followed by 
> 
> 
> diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> index 5c5f574..81b7501 100644
> --- a/arch/arm/boot/dts/imx6dl.dtsi
> +++ b/arch/arm/boot/dts/imx6dl.dtsi
> @@ -80,16 +80,6 @@
>                         };
>                 };
>  
> -               aips2: aips-bus at 02100000 {
> -                       i2c4: i2c at 021f8000 {
> -                               #address-cells = <1>;
> -                               #size-cells = <0>;
> -                               compatible = "fsl,imx1-i2c";
> -                               reg = <0x021f8000 0x4000>;
> -                               interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
> -                               status = "disabled";
> -                       };
> -               };
>         };
>  
>         display-subsystem {
> @@ -98,6 +88,18 @@
>         };
>  };
>  
> +&aips2 {
> +        i2c4: i2c at 021f8000 {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                compatible = "fsl,imx1-i2c";
> +                reg = <0x021f8000 0x4000>;
> +                interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&clks 116>;
> +                status = "disabled";
> +        };
> +};
> +
>  &hdmi {
>         compatible = "fsl,imx6dl-hdmi";
>  };

I do not think we need so many changes.  The only necessary changes
would be something like below.

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 5c5f574..12d582a 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -84,9 +84,10 @@
                        i2c4: i2c at 021f8000 {
                                #address-cells = <1>;
                                #size-cells = <0>;
-                               compatible = "fsl,imx1-i2c";
+                               compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
                                reg = <0x021f8000 0x4000>;
                                interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
+                               clocks = <&clks 116>;
                                status = "disabled";
                        };
                };
