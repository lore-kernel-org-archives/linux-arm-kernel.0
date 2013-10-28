From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 28 Oct 2013 14:28:43 -0500
Subject: [PATCH v6 2/8] pinctrl: imx27: imx27 pincontrol driver
In-Reply-To: <20131028164338.GA20839@pengutronix.de>
References: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
 <1382950843-26066-3-git-send-email-mpa@pengutronix.de>
 <B923ADBC-0C66-45D0-B9FE-F1038F93B176@codeaurora.org>
 <20131028164338.GA20839@pengutronix.de>
Message-ID: <8BADA94D-064E-4E7D-B698-BEB029412650@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 28, 2013, at 11:43 AM, Markus Pargmann wrote:

> On Mon, Oct 28, 2013 at 06:17:41AM -0500, Kumar Gala wrote:
>> 
>> On Oct 28, 2013, at 4:00 AM, Markus Pargmann wrote:
>> 
>>> imx27 pincontrol driver using the imx1 core driver. The DT bindings are
>>> similar to other imx pincontrol drivers.
>>> 
>>> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>>> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>>> ---
>>> .../bindings/pinctrl/fsl,imx27-pinctrl.txt         |  89 ++++
>>> drivers/pinctrl/Kconfig                            |   8 +
>>> drivers/pinctrl/Makefile                           |   1 +
>>> drivers/pinctrl/pinctrl-imx27.c                    | 477 +++++++++++++++++++++
>>> 4 files changed, 575 insertions(+)
>>> create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt
>>> create mode 100644 drivers/pinctrl/pinctrl-imx27.c
>>> 
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt
>>> new file mode 100644
>>> index 0000000..32c81c8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt
>>> @@ -0,0 +1,89 @@
>>> +* Freescale IMX27 IOMUX Controller
>>> +
>>> +Required properties:
>>> +- compatible: "fsl,imx27-iomuxc"
>>> +
>>> +The iomuxc driver node should define subnodes containing of pinctrl configuration subnodes.
>> 
>> Here would probably be a good point to reference "pinctrl/pinctrl-bindings.txt"
> 
> Okay.
> 
>> 
>>> +
>>> +Required properties for pin configuration node:
>>> +- fsl,pins: three integers array, represents a group of pins mux and config
>>> +  setting. The format is fsl,pins = <PIN MUX_ID CONFIG>.
>>> +
>>> +  PIN is an integer between 0 and 0xbf. imx27 has 6 ports with 32 configurable
>>> +  configurable pins each. PIN is PORT * 32 + PORT_PIN, PORT_PIN is the pin
>>> +  number on the specific port (between 0 and 31).
>> 
>> I might be coming late to this, so feel free to ignore if this has already been discussed.
>> 
>> Why not encode PORT in fsl,pins so it would be <PORT PORT_PIN MUX_ID CONFIG> ?
> 
> The port is still visible in the pin id as each port has 32 pins = 0x20.
> So the ports start at 0x00, 0x20, 0x40, 0x60, 0x80 and 0xa0. So I am not
> sure if it is necessary to seperate PORT and PORT_PIN, I personally
> prefer only one PIN_ID field.

It goes to readability, but I guess its hidden by the #defines in imx27-pinfunc.h

> 
>> 
>>> +
>>> +  MUX_ID is
>>> +    function + (direction << 2) + (gpio_oconf << 4) + (gpio_iconfa << 8) + (gpio_iconfb << 10)
>>> +
>>> +    function:      0 - Primary function
>>> +                   1 - Alternate function
>>> +                   2 - GPIO
>>> +      Registers GIUS (GPIO In Use) and GPR (General Purpose Register)
>>> +
>>> +    direction:     0 - Input
>>> +                   1 - Output
>>> +      Register DDIR
>>> +
>>> +    gpio_oconf:    0 - A_IN
>>> +                   1 - B_IN
>>> +                   2 - C_IN
>>> +                   3 - Data Register
>> 
>> what does this mean?
> 
> These are additional output configurations for GPIO. 3 is normal GPIO,
> 0-2 are other pinfunctions that are mapped as output to this pin. It is
> described in the i.MX27 reference manual in detail.



> 
>> 
>>> +      Registers OCR1 and OCR2
>>> +
>>> +    gpio_iconfa/b: 0 - GPIO_IN
>>> +                   1 - Interrupt Status Register
>>> +                   2 - 0
>>> +                   3 - 1
>> 
>> What does any of these option mean (especially 2 & 3)?
> 
> This is the input configuration for a pin in GPIO mode. 0 will connect
> it to GPIO input of the pad, 1 to the interrupt status register, 2 and 3
> to constant low or high.
> 
>> 
>>> +      Registers ICONFA1, ICONFA2, ICONFB1 and ICONFB2
>>> +
>>> +
>> 
>> Someone should be able to reasonable read this and determine how to set MUX_ID w/o having to reference the HW manual.
> 
> I will add a little bit more documentation here. But in general the
> corresponding reference manual chapters should be used to create a
> correct MUX_ID. I don't think DT binding documentation is the right
> place to describe the hardware.

I'm not asking for full detail of the ref manual, but enough that I'm not scratching my head and have to actual pull up the manual to review the binding.

>>> +  CONFIG can be 0 or 1, meaning Pullup disable/enable.
>> 
>> just for clarity do:
>>    CONFIG: 0 - Pullup disabled
>>            1 - Pullup enabled
> 
> Okay, will change.
> 
> Thanks,
> 
> Markus Pargmann
> 
>> 
>>> +
>>> +
>>> +
>>> +
>>> +Example:
>>> +
>>> +iomuxc: iomuxc at 10015000 {
>>> +	compatible = "fsl,imx27-iomuxc";
>>> +	reg = <0x10015000 0x600>;
>>> +
>>> +	uart {
>>> +		pinctrl_uart1: uart-1 {
>>> +			fsl,pins = <
>>> +				0x8c 0x004 0x0 /* UART1_TXD__UART1_TXD */
>>> +				0x8d 0x000 0x0 /* UART1_RXD__UART1_RXD */
>>> +				0x8e 0x004 0x0 /* UART1_CTS__UART1_CTS */
>>> +				0x8f 0x000 0x0 /* UART1_RTS__UART1_RTS */
>>> +			>;
>>> +		};
>>> +
>>> +		...
>>> +	};
>>> +};
>>> +
>>> +
>>> +For convenience there are macros defined in imx27-pinfunc.h which provide PIN
>>> +and MUX_ID. They are structured as MX27_PAD_<Pad name>__<Signal name>. The names
>>> +are defined in the i.MX27 reference manual.
>> 
>> 
>>> +
>>> +The above example using macros:
>>> +
>>> +iomuxc: iomuxc at 10015000 {
>>> +	compatible = "fsl,imx27-iomuxc";
>>> +	reg = <0x10015000 0x600>;
>>> +
>>> +	uart {
>>> +		pinctrl_uart1: uart-1 {
>>> +			fsl,pins = <
>>> +				MX27_PAD_UART1_TXD__UART1_TXD 0x0
>>> +				MX27_PAD_UART1_RXD__UART1_RXD 0x0
>>> +				MX27_PAD_UART1_CTS__UART1_CTS 0x0
>>> +				MX27_PAD_UART1_RTS__UART1_RTS 0x0
>>> +			>;
>>> +		};
>>> +
>>> +		...
>>> +	};
>>> +};
>> 
>> - k
>> 
>> -- 
>> Employee of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>> 
>> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
