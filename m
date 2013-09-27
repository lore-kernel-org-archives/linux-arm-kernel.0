From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 27 Sep 2013 16:32:03 +0200
Subject: imprecise external abort using the flexcan driver on i.MX6Q
In-Reply-To: <CAOMZO5AODznB9D+J2D1juoL=f5eBuJEyuNtN+DEYFuSdhNdt5g@mail.gmail.com>
References: <21060.15934.600859.167074@ipc1.ka-ro>
 <CAOMZO5AODznB9D+J2D1juoL=f5eBuJEyuNtN+DEYFuSdhNdt5g@mail.gmail.com>
Message-ID: <21061.38627.854812.311229@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Fabio Estevam writes:
> Hi Lothar,
> 
> On Thu, Sep 26, 2013 at 11:01 AM, Lothar Wa?mann
> <LW@karo-electronics.de> wrote:
> > Does anyone have any clue how this can happen?
> >
> > Can anyone reproduce this on another machine?
> 
> Is the change below needed?
> 
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -310,7 +310,7 @@
>                         };
> 
>                         can1: flexcan at 02090000 {
> -                               compatible = "fsl,imx6q-flexcan";
> +                               compatible = "fsl,imx6q-flexcan",
> "fsl,p1010-flexcan";
>                                 reg = <0x02090000 0x4000>;
>                                 interrupts = <0 110 0x04>;
>                                 clocks = <&clks 108>, <&clks 109>;
> @@ -318,7 +318,7 @@
>                         };
> 
>                         can2: flexcan at 02094000 {
> -                               compatible = "fsl,imx6q-flexcan";
> +                               compatible = "fsl,imx6q-flexcan",
> "fsl,p1010-flexcan";
>                                 reg = <0x02094000 0x4000>;
>                                 interrupts = <0 111 0x04>;
>                                 clocks = <&clks 110>, <&clks 111>;
The driver contains:
|static const struct of_device_id flexcan_of_match[] = {
|	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
|	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
|	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
|	{ /* sentinel */ },

Thus, with your proposed change the DT data would become ambiguous and
the driver might use &fsl_p1010_devtype_data rather than
&fsl_imx6q_devtype_data depending how the matching algorithm works.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
