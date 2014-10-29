From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 29 Oct 2014 11:42:42 +0100
Subject: [PATCH 6/8] regulator: max77686: Add external GPIO control
In-Reply-To: <1414498308.24949.32.camel@AMDC1943>
References: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
 <1414422226-10948-7-git-send-email-k.kozlowski@samsung.com>
 <544EA4FA.6040704@collabora.co.uk> <1414486356.24949.19.camel@AMDC1943>
 <1414498308.24949.32.camel@AMDC1943>
Message-ID: <1414579362.18868.11.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wto, 2014-10-28 at 13:11 +0100, Krzysztof Kozlowski wrote:
> On wto, 2014-10-28 at 09:52 +0100, Krzysztof Kozlowski wrote:
> > On pon, 2014-10-27 at 21:03 +0100, Javier Martinez Canillas wrote:
> > > Hello Krzysztof,
> > > 
> > > On 10/27/2014 04:03 PM, Krzysztof Kozlowski wrote:
> > > > @@ -85,6 +91,9 @@ struct max77686_data {
> > > >  	struct max77686_regulator_data *regulators;
> > > >  	int num_regulators;
> > > >  
> > > > +	/* Array of size num_regulators with GPIOs for external control. */
> > > > +	int *ext_control_gpio;
> > > > +
> > > 
> > > The integer-based GPIO API is deprecated in favor of the descriptor-based GPIO
> > > interface (Documentation/gpio/consumer.txt). Could you please use the later?
> > 
> > Sure, I can. Please have in mind that regulator core still accepts old
> > GPIO so I will have to use desc_to_gpio(). That should work... and
> > should be future-ready.
> 
> It seems I was too hasty... I think usage of the new gpiod API implies
> completely different bindings.
> 
> The gpiod_get() gets GPIO from a device level, not from given sub-node
> pointer. This means that you cannot have DTS like this:
> ldo21_reg: ldo21 {
> 	regulator-compatible = "LDO21";
> 	regulator-name = "VTF_2.8V";
> 	regulator-min-microvolt = <2800000>;
> 	regulator-max-microvolt = <2800000>;
> 	ec-gpio = <&gpy2 0 0>;
> };
> 
> ldo22_reg: ldo22 {
> 	regulator-compatible = "LDO22";
> 	regulator-name = "VMEM_VDD_2.8V";
> 	regulator-min-microvolt = <2800000>;
> 	regulator-max-microvolt = <2800000>;
> 	ec-gpio = <&gpk0 2 0>;
> };
> 
> 
> I could put GPIOs in device node:
> 
> max77686_pmic at 09 {
> 	compatible = "maxim,max77686";
> 	interrupt-parent = <&gpx0>;
> 	interrupts = <7 0>;
> 	reg = <0x09>;
> 	#clock-cells = <1>;
> 	ldo21-gpio = <&gpy2 0 0>;
> 	ldo22-gpio = <&gpk0 2 0>;
> 
> 	ldo21_reg: ldo21 {
> 		regulator-compatible = "LDO21";
> 		regulator-name = "VTF_2.8V";
> 		regulator-min-microvolt = <2800000>;
> 		regulator-max-microvolt = <2800000>;
> 	};
> 
> 	ldo22_reg: ldo22 {
> 		regulator-compatible = "LDO22";
> 		regulator-name = "VMEM_VDD_2.8V";
> 		regulator-min-microvolt = <2800000>;
> 		regulator-max-microvolt = <2800000>;
> 	};
> 
> This would work but I don't like it. The properties of a regulator are
> above the node configuring that regulator.
> 
> Any ideas?
> 

Continuing talking to myself... I found another problem - GPIO cannot be
requested more than once (-EBUSY). In case of this driver (and board:
Trats2) one GPIO is connected to regulators. The legacy GPIO API and
regulator core handle this.

With new GPIO API I would have to implement some additional steps in
such case...

So there are 2 issues:
1. Cannot put GPIO property in regulator node.
2. Cannot request some GPIO more than once.

I'm going back to legacy API for now.

Best regards,
Krzysztof
