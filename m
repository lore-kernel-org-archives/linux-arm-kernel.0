From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 26 Jan 2015 16:57:33 +0100
Subject: [PATCH v3 2/3] dt-bindings: Add pinctrl bindings for
 mt65xx/mt81xx.
In-Reply-To: <CACRpkdYmjrEtds4wLr0cOmCPOLhS9xisfrY-cNZ3r0oh8n489Q@mail.gmail.com>
References: <20141127101830.GP30369@pengutronix.de>
 <CACRpkdbMdJT6y-NL36RgQe0-CAFAVGqKiwY9+yFcwA7JDLmA+Q@mail.gmail.com>
 <20141202135527.GM30369@pengutronix.de>
 <CACRpkdZeRd+j7d_iRphruHRg8p3XjqWK8_HQzLH2PTZ_pqOrYA@mail.gmail.com>
 <20150112122200.GC18908@pengutronix.de>
 <CACRpkdYXrdiRWMV8YpxrSLe2rLEV-ZnX7=36w21zGquh==6WgA@mail.gmail.com>
 <20150113161614.GF23940@pengutronix.de>
 <CACRpkdYRrs2=gNM1XGSh1cSo5Pvx6iNLt4HjL6gdTqGPWYSRDw@mail.gmail.com>
 <1421403805.11671.58.camel@mtksdaap41>
 <CACRpkdYmjrEtds4wLr0cOmCPOLhS9xisfrY-cNZ3r0oh8n489Q@mail.gmail.com>
Message-ID: <20150126155733.GQ12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Jan 20, 2015 at 10:45:09AM +0100, Linus Walleij wrote:
> On Fri, Jan 16, 2015 at 11:23 AM, Yingjoe Chen
> <yingjoe.chen@mediatek.com> wrote:
> > On Fri, 2015-01-16 at 10:53 +0100, Linus Walleij wrote:
> >> On Tue, Jan 13, 2015 at 5:16 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >> > On Tue, Jan 13, 2015 at 11:05:22AM +0100, Linus Walleij wrote:
> >>
> >> >> > You often talk about ambiguities. Could you give an example what
> >> >> > ambiguities you mean?
> >> >>
> >> >> What happened was this pins = ; arguments were sometimes
> >> >> strings and sometimes integers, that becomes strange to handle
> >> >> in code, ambiguous.
> >> >
> >> > I see. I like naming it 'pinmux' because that's what it is: pins and
> >> > mux settings. A plain 'pinno' suggests that it contains only pin mubers,
> >> > without mux setting. How about 'pin-no-mux'? We also could add an
> >> > explicit "pins-are-numbered" property instead of distinguishing this
> >> > by property names.
> >>
> >> I kind of like this "pins-are-numbered" thing.
> >>
> >> The other property for the pin, whether pinmux or pin-no-mux or
> >> pin-num-and-mux etc is no such big deal, as long as it's
> >> consistent and documented with the generic bindings.
> >
> > Hi Linus,
> >
> > To make sure I understand it correct, you think something like this is
> > OK?
> >
> >         pinctrl at 01c20800 {
> >                 compatible = "mediatek,mt8135-pinctrl";
> > [...]
> >                 pins-are-numbered;
> >
> >                 i2c0_pins_a: i2c0 at 0 {
> >                         pins1 {
> >                                 pins = <MT8135_PIN_100_SDA0__FUNC_SDA0>,
> >                                         <MT8135_PIN_101_SCL0__FUNC_SCL0>;
> >                                 bias-disable;
> >                         };
> >                 };
> 
> As discussed with Sascha Hauer it is ambigous to use "pins" for
> a numerical value indicating both a mux setting and a pin. Sascha
> suggests using "pinmux" and adding this as a secondary generic
> binding for this type of pin controllers that use numbers and #defines
> to set up bindings.
> 
> We should still move these parsing functions to the core.

I tried that for the last few days and failed.

Part of the problem is that the core lacks the data structures to put
the information in. There is

struct pinctrl_map_mux {
	const char *group;
	const char *function;
};

but its meaning is SoC specific. Some SoCs combine the pins found in a
dt subnode to one group (i.MX, rockchip, at91) while others make an
individual group from each single pin (Tegra, others?). Also the
function string is SoC specific. Some SoCs just define functions like
"alt1".."altn" which are valid for all groups, others define different
function names for each group.

Another thing is that the binding gives us numbers, but struct
pinctrl_map_mux expects strings, so the numbers would have to be
converted to strings. This is crude since the contents of struct
pinctrl_map_mux are converted from strings back to numbers later from
the pinctrl core with the help of the driver. So we would have to
translate the numbers from the bindings to strings just to convert them
back to numbers before passing them to the driver later.

Given that the best I can come up with is something like:

int pinctrl_parse_pinmux(struct device_node *np, int index,
			 unsigned int *pinno, unsigned int *funcno)
{
	u32 val;
	int ret;

	ret = of_property_read_u32_index(np, "pinmux", index, &val);
	if (ret)
		return ret;

	*pinno = val >> 8
	*funcno = val & 0xff;

	return 0;
}

Is that what you expect from a common parser?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
