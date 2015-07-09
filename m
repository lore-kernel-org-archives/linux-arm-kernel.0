From: yh.huang@mediatek.com (YH Huang)
Date: Thu, 9 Jul 2015 14:36:16 +0800
Subject: [PATCH v4 1/3] dt-bindings: pwm: add MediaTek display PWM bindings
In-Reply-To: <CAGS+omAZismuEYXsUkHEAec4xF+KRWm62AuCUmrmso6p+DKQ4Q@mail.gmail.com>
References: <1436189368-1826-1-git-send-email-yh.huang@mediatek.com>
 <1436189368-1826-2-git-send-email-yh.huang@mediatek.com>
 <CAGS+omAWNwk_PRy-eeC4bgHQ-ZC2Kvh0sqpF47VD1sfJOhHWUw@mail.gmail.com>
 <1436409944.4915.6.camel@mtksdaap41>
 <CAGS+omAZismuEYXsUkHEAec4xF+KRWm62AuCUmrmso6p+DKQ4Q@mail.gmail.com>
Message-ID: <1436423776.32314.9.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-07-09 at 12:47 +0800, Daniel Kurtz wrote:
> On Thu, Jul 9, 2015 at 10:45 AM, YH Huang <yh.huang@mediatek.com> wrote:
> >
> > On Wed, 2015-07-08 at 20:11 +0800, Daniel Kurtz wrote:
> > > On Mon, Jul 6, 2015 at 9:29 PM, YH Huang <yh.huang@mediatek.com> wrote:
> > > > Document the device-tree binding of MediatTek display PWM.
> > > > The PWM has one channel to control the backlight brightness for display.
> > > > It supports MT8173 and MT6595.
> > > >
> > > > Signed-off-by: YH Huang <yh.huang@mediatek.com>
> > > > ---
> > > >  .../devicetree/bindings/pwm/pwm-mtk-disp.txt       | 24 ++++++++++++++++++++++
> > > >  1 file changed, 24 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> > > > new file mode 100644
> > > > index 0000000..757b974
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> > > > @@ -0,0 +1,24 @@
> > > > +MediaTek display PWM controller
> > > > +
> > > > +Required properties:
> > > > + - compatible: should be "mediatek,<name>-disp-pwm"
> > > > +   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC
> > > > +   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC
> > > > + - reg: physical base address and length of the controller's registers
> > > > + - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
> > > > +   the cell format
> > > > + - clocks: phandle and clock specifier of the PWM reference clock
> > > > + - clock-names: must contain the following
> > > > +   - "main": clock used to generate PWM signals
> > > > +   - "mm": sync signals from the modules of mmsys

- pinctrl-names: Must contain a "default" entry.
- pinctrl-0: One property must exist for each entry in pinctrl-names.
  See pinctrl/pinctrl-bindings.txt for details of the property values.

> > > > +
> > > > +Example:
> > > > +       pwm0: pwm at 1401e000 {
> > > > +               compatible = "mediatek,mt8173-disp-pwm",
> > > > +                            "mediatek,mt6595-disp-pwm";
> > > > +               reg = <0 0x1401e000 0 0x1000>;
> > > > +               #pwm-cells = <2>;
> > > > +               clocks = <&mmsys CLK_MM_DISP_PWM026M>,
> > > > +                        <&mmsys CLK_MM_DISP_PWM0MM>;
> > > > +               clock-names = "main", "mm";

pio: pinctrl at 10005000 {
...

   disp_pwm0_pins: disp_pwm0_pins {
	pins1 {
		pinmux = <MT8173_PIN_87_DISP_PWM0__FUNC_DISP_PWM0>;
        	bias-pull-up;
        };
   };

...
}

pwm0: pwm at 1401e000 {
	compatible = "mediatek,mt8173-disp-pwm";
	reg = <0 0x1401e000 0 0x1000>;
	#pwm-cells = <2>;
	clocks = <&mmsys CLK_MM_DISP_PWM0MM>,
		 <&mmsys CLK_MM_DISP_PWM026M>;
	clock-names = "mm", "main";
	pinctrl-names = "default";
	pinctrl-0 = <&disp_pwm0_pins>;
	status = "disabled";
};

So should I change dtsi like this?

Regards,
YH Huang

> > >
> > > Should we include the pinctrl settings here to enable the PWM output?
> > >
> >
> > Since we use pwm-backlight driver to control backlight, we should enable
> > PWM output in the backlight node.
> >
> > Ref:
> > https://www.kernel.org/doc/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> >
> 
> The pwm-backlight binding specifies which pwm the backlight driver
> should use, and how to use it.
> 
> I believe actually configuring the output pin for the pwm via pinctl
> belongs to the pwm binding.
> 
> Regards,
> 0Dan
> 
> >
> > Regards,
> > YH Huang
> >
