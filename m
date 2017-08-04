From: david@lechnology.com (David Lechner)
Date: Fri, 4 Aug 2017 11:51:22 -0500
Subject: [PATCH v3 3/6] dt-bindings: add binding for Sitronix ST7586
 display panels
In-Reply-To: <66f0b765-928e-1fca-9588-99da747749a5@tronnes.org>
References: <1501799630-1650-1-git-send-email-david@lechnology.com>
 <1501799630-1650-4-git-send-email-david@lechnology.com>
 <66f0b765-928e-1fca-9588-99da747749a5@tronnes.org>
Message-ID: <e824aca6-b668-1d63-65a0-c56bfd8bec79@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2017 04:48 AM, Noralf Tr?nnes wrote:
> 
> Den 04.08.2017 00.33, skrev David Lechner:
>> This adds a new binding for Sitronix ST7586 display panels.
>>
>> Using lego as the vendor prefix in the compatible string because the 
>> display
>> panel I am working with is an integral part of the LEGO MINDSTORMS EV3.
> 
> Is this display available outside of this Lego part?
No, it is not.

> If not you can remove the properties you don't need for this particular
> display setup. Another st7586 display with a different panel would need
> a different initialization sequence and compatible string, so we can
> add properties when/if that happens.

OK. so I will drop power-supply and backlight.

Should I remove these from the driver as well? There are some panels out 
there that could use them.[1]

[1]: 
http://www.buydisplay.com/download/manual/ERC240160-1_Series_Datasheet.pdf

> 
> Noralf.
> 
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   .../bindings/display/sitronix,st7586.txt           | 26 
>> ++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/display/sitronix,st7586.txt
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/display/sitronix,st7586.txt 
>> b/Documentation/devicetree/bindings/display/sitronix,st7586.txt
>> new file mode 100644
>> index 0000000..dfb0b7b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/sitronix,st7586.txt
>> @@ -0,0 +1,26 @@
>> +Sitronix ST7586 display panel
>> +
>> +Required properties:
>> +- compatible:    "lego,ev3-lcd".
>> +
>> +The node for this driver must be a child node of a SPI controller, hence
>> +all mandatory properties described in ../spi/spi-bus.txt must be 
>> specified.
>> +
>> +Optional properties:
>> +- dc-gpios:    D/C pin. The presence/absence of this GPIO determines
>> +        the panel interface operation mode (IF[3:1] pins):
>> +        - present: IF=011 4-wire 8-bit data serial interface
>> +        - absent:  IF=010 3-wire 9-bit data serial interface
>> +- reset-gpios:    Reset pin
>> +- power-supply:    A regulator node for the supply voltage.
>> +- backlight:    phandle of the backlight device attached to the panel
>> +- rotation:    panel rotation in degrees counter clockwise 
>> (0,90,180,270)
>> +
>> +Example:
>> +    display at 0{
>> +        compatible = "lego,ev3-lcd";
>> +        reg = <0>;
>> +        spi-max-frequency = <10000000>;
>> +        dc-gpios = <&gpio 43 GPIO_ACTIVE_HIGH>;
>> +        reset-gpios = <&gpio 80 GPIO_ACTIVE_HIGH>;
>> +    };
> 
