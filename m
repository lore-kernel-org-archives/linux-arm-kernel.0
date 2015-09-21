From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 21 Sep 2015 14:15:54 +0200
Subject: [PATCH linux-next v9 2/3] mfd: devicetree: add bindings for Atmel
 Flexcom
In-Reply-To: <55F0C97B.80404@kernel.org>
References: <cover.1441118159.git.cyrille.pitchen@atmel.com>
 <90fa2e0ded92567a29c996658153d833aaa5e411.1441118159.git.cyrille.pitchen@atmel.com>
 <55EF7209.8060407@kernel.org> <55F0540F.6000102@atmel.com>
 <55F0C97B.80404@kernel.org>
Message-ID: <55FFF4FA.6050100@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Le 10/09/2015 02:06, Rob Herring a ?crit :
> On 09/09/2015 10:45 AM, Cyrille Pitchen wrote:
>> Hi Rob,
>>
>> Le 09/09/2015 01:40, Rob Herring a ?crit :
>>> On 09/01/2015 09:46 AM, Cyrille Pitchen wrote:
>>>> This patch documents the DT bindings for the Atmel Flexcom which will be
>>>> introduced by sama5d2x SoCs. These bindings will be used by the actual
>>>> Flexcom driver to be sent in another patch.
>>>>
>>>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>>>> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>>>> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>>
>>> A few comments, but in general looks fine.
>>>
>>>> ---
>>>>  .../devicetree/bindings/mfd/atmel-flexcom.txt      | 67 ++++++++++++++++++++++
>>>>  1 file changed, 67 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
>>>> new file mode 100644
>>>> index 000000000000..fc3511e41542
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
>>>> @@ -0,0 +1,67 @@
>>>> +* Device tree bindings for Atmel Flexcom (Flexible Serial Communication Unit)
>>>> +
>>>> +The Atmel Flexcom is just a wrapper which embeds a SPI controller, an I2C
>>>> +controller and an USART. Only one function can be used at a time and is chosen
>>>> +at boot time according to the device tree.
>>>
>>> Doesn't the board design choose (unless pins go to a header)?
>>>
>>
>> The function may be chosen once for all by the board design but if we take the
>> sama5d2 xplained board as an example, most Flexcoms output their pins to
>> headers.
>>
>>>> +
>>>> +Required properties:
>>>> +- compatible:		Should be "atmel,sama5d2-flexcom"
>>>> +- reg:			Should be the offset/length value for Flexcom dedicated
>>>> +			I/O registers (without USART, TWI or SPI registers).
>>>> +- clocks:		Should be the Flexcom peripheral clock from PMC.
>>>> +- #address-cells:	Should be <1>
>>>> +- #size-cells:		Should be <1>
>>>> +- ranges:		Should be one range for the full I/O register region
>>>> +			(including USART, TWI and SPI registers).
>>>> +- atmel,flexcom-mode:	Should be one of the 3 following macros as defined in
>>>> +			include/dt-bindings/mfd/atmel-flexcom.h:
>>>> +			- ATMEL_FLEXCOM_MODE_USART for USART
>>>> +			- ATMEL_FLEXCOM_MODE_SPI for SPI
>>>> +			- ATMEL_FLEXCOM_MODE_TWI for I2C
>>>> +
>>>> +Required child:
>>>> +a single child device of type matching the "atmel,flexcom-mode" property.
>>>
>>> Okay, but why not allow all children and use "status"?
>>>
>>
>> That is exactly what was proposed in v6 of this series: allow more than one
>> child so possibly all children but only one "available" child (status = 
>> "okay").
>>
>> The Flexocm driver still needs to find out the type of device of this
>> available child to know which function is to be enabled (USART, I2C or SPI).
>> So the "compatible" attribute was parsed using strstr() to search on of the
>> patterns "usart", "spi" or "i2c".
>>
>> However the use of strstr() was discussed to know whether the driver should
>> looks for a partial or an exact match of the "compatible" string.
>> An exact match would require to keep the Flexcom driver synchonized with the
>> 3 other drivers every time one of them introduces a new compatibility string,
>> which whould have made every driver more difficult to maintain by creating a
>> useless dependency.
>> So this implementation relying on the "compatible" attribute was abandoned.
>>
>> To sum up, no other reliable (and simple) means to guess/extact the device
>> type from its DT node was found so we got back to the "atmel,flexcom-mode"
>> property.
> 
> I wasn't thinking removing this property. If the mode is configured by
> the bootloader, then you want to make updates to the configuration as
> simple as possible. Updating atmel,flexcom-mode and status for the
> children would be much more simple than creating the whole child node.
> If that's not a valid usecase, then never mind.
> 
> Rob
> 

The Flexcom driver calls of_platform_populate(), so yes it's allowed and
supported to put the 3 children in the DT as long as only one is available.

Should I update the documentation to deal with optional children or leave it
as it is?

Best Regards,

Cyrille
