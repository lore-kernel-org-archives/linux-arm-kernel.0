From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 20 Jun 2016 19:26:51 +0800
Subject: [PATCH 08/12] doc: binding: pwrseq-usb-generic: add binding doc
 for generic usb power sequence driver
In-Reply-To: <CAL_JsqLvs0s2TyfqPM5vtmyY81_X84VjCGjsGYbTgT4syOfp9Q@mail.gmail.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
 <1466158165-9380-9-git-send-email-peter.chen@nxp.com>
 <CAL_JsqLvs0s2TyfqPM5vtmyY81_X84VjCGjsGYbTgT4syOfp9Q@mail.gmail.com>
Message-ID: <20160620112651.GA26936@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 12:16:48PM -0500, Rob Herring wrote:
> On Fri, Jun 17, 2016 at 5:09 AM, Peter Chen <peter.chen@nxp.com> wrote:
> > Add binding doc for generic usb power sequence driver, and update
> > generic usb device binding-doc accordingly.
> >
> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > ---
> >  .../bindings/power/pwrseq/pwrseq-usb-generic.txt   | 31 ++++++++++++++++++++++
> >  .../devicetree/bindings/usb/usb-device.txt         |  2 ++
> >  2 files changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
> >
> > diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
> > new file mode 100644
> > index 0000000..8ad98382
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
> > @@ -0,0 +1,31 @@
> > +The power sequence for generic USB Devices
> > +
> > +Some hard-wired USB devices need to do power sequence to let the
> > +device work normally, the typical power sequence like: enable USB
> > +PHY clock, toggle reset pin, etc. But current Linux USB driver
> > +lacks of such code to do it, it may cause some hard-wired USB devices
> > +works abnormal or can't be recognized by controller at all. The
> > +power sequence will be done before this device can be found at USB
> > +bus.
> > +
> > +Required properties:
> > +- compatible : contains "usb-pwrseq-generic".
> 
> In case I have not been clear, no.
> 
> I am not going to accept anything along the lines of the current mmc
> pwrseq. I am basically okay with Krzysztof's proposal as it is *only*
> an added property and not a duplication of information. I'd suggest
> you figure out how to make the kernel work with that rather than
> trying to work-around whatever kernel limitations there are.
> 

I see.

Would you agree with below:

&usbotg1 {
	vbus-supply = <&reg_usb_otg1_vbus>;
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_usb_otg1_id>;
	status = "okay";

	#address-cells = <1>;
	#size-cells = <0>;
	hub: genesys at 1 {
		compatible = "usb5e3,608";
		reg = <1>;

		power-sequence;
		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
		reset-duration-us = <10>;
		clocks = <&clks IMX6SX_CLK_CKO>;

		#address-cells = <1>;
		#size-cells = <0>;
		ethernet: asix at 1 {
			compatible = "usbb95,1708";
			reg = <1>;

			power-sequence;
			reset-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>; /* ethernet_rst */
			reset-duration-us = <15>;
			clocks = <&clks IMX6SX_CLK_IPG>;
		};
	};
};

If the node has property "power-sequence", the pwrseq core will create
related platform device, and the driver under pwrseq driver will handle
power sequence stuffs. The property below "power-sequence" will be
handled at pwrseq driver.

-- 

Best Regards,
Peter Chen
