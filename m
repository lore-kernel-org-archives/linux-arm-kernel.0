From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 27 Jun 2016 12:11:40 -0700
Subject: [PATCH] extcon: Add support for qcom SPMI PMIC USB id detection
 hardware
In-Reply-To: <CAGTfZH3ireJWo5-Jd5SEiSy-WMTsw43pweruOqwSesAZqagvtg@mail.gmail.com>
References: <20160626055647.18898-1-stephen.boyd@linaro.org>
 <CAGTfZH3ireJWo5-Jd5SEiSy-WMTsw43pweruOqwSesAZqagvtg@mail.gmail.com>
Message-ID: <146705470025.30684.13257433085055355379@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Chanwoo Choi (2016-06-26 04:20:43)
> 2016-06-26 14:56 GMT+09:00 Stephen Boyd <stephen.boyd@linaro.org>:
> > +PROPERTIES
> > +
> > +- compatible:
> > +    Usage: required
> > +    Value type: <string>
> > +    Definition: Should contain "qcom,pm8941-misc";
> > +
> > +- reg:
> > +    Usage: required
> > +    Value type: <u32>
> > +    Definition: Should contain the offset to the misc address space
> 
> 'reg' property is used on extcon-qcom-spmi-misc.c?
> I think that you don't need to include this property.

No it isn't used in the driver right now, but there is a register offset
for this module and there are registers that can be read/written in this
module. I'd like to keep it as required so we can easily read the
registers in the future if needed.

> 
> > +
> > +- interrupts:
> > +    Usage: required
> > +    Value type: <prop-encoded-array>
> > +    Definition: Should contain the usb id interrupt
> > +
> > +- interrupt-names:
> > +    Usage: required
> > +    Value type: <stringlist>
> > +    Definition: Should contain the string "usb_id" for the usb id interrupt
> > +
> > +Example:
> > +
> > +       pmic {
> > +               usb_id: misc at 900 {
> > +                       compatible = "qcom,pm8941-misc";
> > +                       reg = <0x900>;
> > +                       interrupts = <0x0 0x9 0 IRQ_TYPE_EDGE_BOTH>;
> > +                       interrupt-names = "usb_id";
> > +               };
> > +       }
> > +
> > +       usb-controller {
> > +               extcon = <&usb_id>;
> > +       };
> > diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> > index 3d89e60a3e71..b2ee47cb10ca 100644
> > --- a/drivers/extcon/Kconfig
> > +++ b/drivers/extcon/Kconfig
> > @@ -119,6 +119,12 @@ config EXTCON_SM5502
> >           Silicon Mitus SM5502. The SM5502 is a USB port accessory
> >           detector and switch.
> >
> > +config EXTCON_QCOM_SPMI_MISC
> > +       tristate "Qualcomm USB extcon support"
> > +       help
> > +         Say Y here to enable SPMI PMIC based USB cable detection
> > +         support on Qualcomm PMICs such as PM8941.
> 
> You need to reorder the entry alphabetically. You better to move
> it below

Ok.
