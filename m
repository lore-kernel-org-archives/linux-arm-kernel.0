From: lukma@denx.de (Lukasz Majewski)
Date: Sat, 19 May 2018 14:02:02 +0200
Subject: [PATCH] ARM: DTS: imx53: Add support for imx53 HSC/DDC boards
 from K+P
In-Reply-To: <CAOMZO5AexXNEGVoXa9K_GAm+aFLNRQOXOhF_SdKAjV1qmuD2nA@mail.gmail.com>
References: <20180509153428.1440-1-lukma@denx.de>
 <CAOMZO5AexXNEGVoXa9K_GAm+aFLNRQOXOhF_SdKAjV1qmuD2nA@mail.gmail.com>
Message-ID: <20180519140202.3449e3c1@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Thanks for your feedback.

> Hi Lukasz,
> 
> On Wed, May 9, 2018 at 12:34 PM, Lukasz Majewski <lukma@denx.de>
> wrote:
> 
> > +&iomuxc {
> > +       imx53-kp-ddc {  
> 
> No need for keeping this imx53-kp-ddc.
> 
> > diff --git a/arch/arm/boot/dts/imx53-kp-hsc.dts
> > b/arch/arm/boot/dts/imx53-kp-hsc.dts new file mode 100644
> > index 000000000000..fff358395c9d
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx53-kp-hsc.dts
> > @@ -0,0 +1,53 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2018
> > + * Lukasz Majewski, DENX Software Engineering, lukma at denx.de
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx53-kp.dtsi"
> > +
> > +/ {
> > +       model = "K+P imx53 HSC";
> > +       compatible = "kiebackpeter,imx53-hsc", "fsl,imx53";
> > +  
> 
> No need for this blank line.
> 
> > +};
> > +
> > +&fec {
> > +       status = "okay";  
> 
> We usually put the status in the last line.

After moving status property to the end:

Error: arch/arm/boot/dts/imx53-kp-hsc.dts:21.2-18 Properties must
precede subnodes FATAL ERROR: Unable to parse input tree

So I opt for leaving it as it was.

> 
> > +       gpio_buttons {
> > +               compatible = "gpio-keys";
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pinctrl_gpiobuttons>;
> > +
> > +               button at 1 {  
> 
> You pass @1 without a reg property. This triggers a warning when
> building with W=1.
> 
> You could remove the @1.
> 
> Please make sure this patch does not introduce any W=1 dtc warning.
> 
> > +&iomuxc {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_kp_common>;
> > +
> > +       imx53-kp-common {  
> 
> No need for this  imx53-kp-common

After removing imx53-kp-ddc and imx53-kp-common iomux subnodes I do see
following errors in the dmesg (v4.17-rc5):

imx53-pinctrl 53fa8000.iomuxc: function 'iomuxc' not supported
imx53-pinctrl 53fa8000.iomuxc: invalid function iomuxc in map table

Above statements are not visible when I use the v1 code of this patch.

> 
> > +&uart4 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_uart4>;
> > +  
> 
> No need for this blank line.


I will sent fixed version in v2.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180519/1f5a7146/attachment.sig>
