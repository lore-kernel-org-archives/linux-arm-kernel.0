From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 26 Feb 2015 19:03:56 +0800
Subject: [PATCH] pinctrl: dt: at91: new binding
In-Reply-To: <20150226104319.GE20718@odux.rfo.atmel.com>
References: <1424943294-8805-1-git-send-email-plagnioj@jcrosoft.com>
 <20150226104319.GE20718@odux.rfo.atmel.com>
Message-ID: <F74AA2E0-606F-419D-9ADD-3C24CA0973DD@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Feb 26, 2015, at 6:43 PM, Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> 
> Hi Jean-Christophe,
> 
> On Thu, Feb 26, 2015 at 10:34:54AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> Today if we want to disable a pio bank we may will siliently break pinctrl
>> configuration in the DT. This will be detected only at runtime.
> 
> Do you have a case where it breaks pinctrl? I can do more tests but with
> the latest patch "pinctrl: at91: allow to have disabled gpio bank", I
> had no issue.

simple disable the PIO bank and if one device use it as pinctrl and no gpio is used in the DT
then you get a broken platform but dtb is generated

as all the node are enabled for pinctrl

> 
>> 
>> So move the pinctrl configuration to the bank instead of the bus.
>> This allow to detect pinctrl issue at DT compiling time when disable a bank.
>> 
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: devicetree at vger.kernel.org
>> ---
>> .../bindings/pinctrl/atmel,at91-pinctrl.txt        | 66 ++++++++++++++++++++++
>> 1 file changed, 66 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
>> index b7a93e8..78355ee 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
>> +++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
>> @@ -148,3 +148,69 @@ dbgu: serial at fffff200 {
>> 	pinctrl-0 = <&pinctrl_dbgu>;
>> 	status = "disabled";
>> };
>> +
>> +II) New Bindings per PIO Block
>> +
>> +This allow to detect pinctrl issue at DT compiling time when disable a bank
>> +
>> +Required properties for iomux controller:
>> +- compatible: "atmel,at91rm9200-pio-pinctrl" or "atmel,at91sam9x5-pio-pinctrl"
>> +		or "atmel,sama5d3-pio-pinctrl"
>> +- atmel,mux-mask: array of mask (periph per bank) to describe if a pin can be
>> +  configured in this periph mode. All the periph and bank need to be describe.
>> +
>> +How to create such array:
>> +
>> +Each column will represent the possible peripheral of the pinctrl for the bank
>> +
>> +Take an example on the 9260
>> +Peripheral: 2 ( A and B)
>> +=>
>> +
>> +  /*    A         B     */
>> +  0xffffffff 0xffc00c3b  /* pioA */
>> +
>> +For each peripheral/bank we will descibe in a u32 if a pin can be
>> +configured in it by putting 1 to the pin bit (1 << pin)
>> +
>> +Required properties for pin configuration node:
>> +- atmel,pins: 3 integers array, represents a group of pins mux and config
>> +  setting. The format is atmel,pins = <PIN_NUM PERIPH CONFIG>.
>> +  The PERIPH 0 means gpio, PERIPH 1 is periph A, PERIPH 2 is periph B...
>> +
>> +Bits used for CONFIG:
>> +cf atmel,at91-pinctrl
>> +
>> +pioB: gpio at fffff600 {
>> +	compatible = "atmel,at91rm9200-gpio", "atmel,at91rm9200-pio-pinctrl";
>> +	reg = <0xfffff600 0x200>;
>> +	interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
>> +	#gpio-cells = <2>;
>> +	gpio-controller;
>> +	interrupt-controller;
>> +	#interrupt-cells = <2>;
>> +	clocks = <&pioB_clk>;
>> +
>> +			 /*    A         B     */
>> +	atmel,mux-mask = <0xffffffff 0x7fff3ccf>;
>> +
>> +	dbgu {
>> +		pinctrl_dbgu: dbgu-0 {
>> +			atmel,pins =
>> +				<14 0x1 0x0	/* PB14 periph A */
>> +				 15 0x1 0x1>;	/* PB15 periph A with pullup */
>> +		};
>> +	};
> 
> So we have to update all device tree files, that's a lot of work?
break nothing both binding support will be in the kernel

but only one enable at a time, so basically mainline will drop the old one

and as today 99% of the pinctrl are at SoC level so it?s not a big work at all
> Moreover it adds complexity if we have a device using pins from
> different pio controllers.

put 2 phandle means complexity please

and it?s the key point of the new binding

Best Regards,
J.
