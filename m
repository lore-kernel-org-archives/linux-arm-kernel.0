From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 22 Jul 2015 12:23:11 +0200
Subject: [PATCH v4 1/2] mfd: devicetree: add bindings for Atmel Flexcom
In-Reply-To: <20150721151035.GK3061@x1>
References: <cover.1434967670.git.cyrille.pitchen@atmel.com>
 <337ab4936bd6ec2f24c42e2f8f363df21f491a02.1434967670.git.cyrille.pitchen@atmel.com>
 <20150721090910.GG3061@x1> <55AE53F2.5080904@atmel.com>
 <20150721151035.GK3061@x1>
Message-ID: <55AF6F0F.30100@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 21/07/2015 17:10, Lee Jones a ?crit :
> On Tue, 21 Jul 2015, Cyrille Pitchen wrote:
> 
>> Hi Lee,
>>
>> Le 21/07/2015 11:09, Lee Jones a ?crit :
>>> On Mon, 22 Jun 2015, Cyrille Pitchen wrote:
>> ...
>>>> +- atmel,flexcom-mode: shall be a string among { "spi", "usart", "i2c", "twi" }.
>>>> +  "i2c" and "twi" are synonymous.
>>>
>>> Please use a numerical value instead.  You can then define it in
>>> include/dt-bindings/*
>>>
>>> This is only required if you supply more than one child node.  Is that
>>> the plan?  I ask because you only have one child node in the example
>>> below.
>>>
>> The "atmel,flexcom-mode" property is always required. The reset value of the
>> Operating Mode bit field inside the Flexcom Mode Register is 0 for "no serial
>> device". So none of the 3 embedded serial devices is clocked and all of their
>> registers are inaccessible (read as zero).
>> Before using any of the 3 serial devices, the Operating Mode must be set
>> accordingly by updating the Mode Register. Once done, only the selected serial
>> device is clocked. Also the external I/O lines of the Flexcom are muxed to
>> reach the selected serial device.
>>
>> The muxing is given by the following table:
>>
>> Flexcom pin    USART pin    SPI pin    I2C pin
>>         IO0          TXD       MOSI        TWD
>>         IO1          RXD       MISO       TWCK
>>         IO2          SCK       SPCK          -
>>         IO3          CTS      NPCS0          - 
>>         IO4          RTS      NPCS1          -
>>
>>
>> Bus conflicting configuration:
>>  ______________________________________
>> |               Flexcom                |
>> |  _____         _____         _____   |
>> | |     |__CLK__| SPI |__I/O__|     |  |    ___________       ___________
>> | |     |       |_____|       |     |  |   | SPI Slave |     | I2C Slave |
>> | | CLK |                     | I/O |  |   |___________|     |___________|
>> |_| MUX |        _____        | MUX |__|_________|________________|
>> | |     |__CLK__| I2C |__I/O__|     |  |             shared bus
>> | |_____|       |_____|       |_____|  |
>> |______________________________________|
>>
>>
>> For instance, it is very unlikely to connect both I2C and SPI slaves to
>> the very same Flexcom because I/O lines are shared. The operating mode is
>> selected once for all during the boot and will never change during runtime.
>> That's why the Flexcom DT node should have exactly one child.
> 
> You have contradicted your self here.  Firstly you say that the
> "atmel,flexcom-mode" property is always required, then you say that
> the DT node should only ever have one child.  If the latter is true,
> then you can infer which mode Flexcom needs to be in by which node is
> present.
> 
OK, you're right. So on the next series (v6), I will simply remove the
"atmel,flexcom-mode" property from the DT bindings. Then, the driver will
look for the first available child node which "compatible" property contains
one of the substrings "-usart", "-spi" or "-i2c", setting the Flexcom operating
mode accordingly. This child node should be unique.

>>>> +Example:
>>>> +
>>>> +flx0: flexcom at f8034000 {
>>>
>>> What references this node?  If nothing, then you can remove the label.
>> OK, I will remove the label in the next series.
>>>
>>>> +	compatible = "atmel,sama5d2-flexcom";
>>>> +	reg = <0xf8034000 0x200>;
>>>> +	clocks = <&flx0_clk>;
>>>> +	#address-cells = <1>;
>>>> +	#size-cells = <1>;
>>>> +	ranges = <0x0 0xf8034000 0x800>;
>>>> +	atmel,flexcom-mode = "spi";
>>>> +
>>>> +	spi at f8034400 {
>>>> +		compatible = "atmel,at91rm9200-spi";
>>>> +		reg = <0x400 0x200>;
>>>> +		interrupts = <19 IRQ_TYPE_LEVEL_HIGH 7>;
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&pinctrl_flx0_ioset1>;
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <0>;
>>>> +		clocks = <&flx0_clk>;
>>>> +		clock-names = "spi_clk";
>>>> +		atmel,fifo-size = <32>;
>>>> +
>>>> +		mtd_dataflash at 0 {
>>>> +			compatible = "atmel,at25f512b";
>>>> +			reg = <0>;
>>>> +			spi-max-frequency = <20000000>;
>>>> +		};
>>>> +	};
>>>> +};
>>>
>>
>> Thanks for your review :)
>>
>> Best Regards,
>>
>> Cyrille
> 
