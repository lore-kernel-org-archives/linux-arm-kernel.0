From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Fri, 4 Aug 2017 19:36:06 +0200
Subject: [PATCH v3 3/6] dt-bindings: add binding for Sitronix ST7586
 display panels
In-Reply-To: <2434051.fAH1OaXNrL@avalon>
References: <1501799630-1650-1-git-send-email-david@lechnology.com>
 <1501799630-1650-4-git-send-email-david@lechnology.com>
 <2434051.fAH1OaXNrL@avalon>
Message-ID: <226e7391-2f4f-60ca-f258-ad7b02463359@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,


Den 04.08.2017 16.54, skrev Laurent Pinchart:
> Hi David,
>
> Thank you for the patch.
>
> On Thursday 03 Aug 2017 17:33:47 David Lechner wrote:
>> This adds a new binding for Sitronix ST7586 display panels.
>>
>> Using lego as the vendor prefix in the compatible string because the display
>> panel I am working with is an integral part of the LEGO MINDSTORMS EV3.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   .../bindings/display/sitronix,st7586.txt           | 26 +++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/display/sitronix,st7586.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/sitronix,st7586.txt
>> b/Documentation/devicetree/bindings/display/sitronix,st7586.txt new file
>> mode 100644
>> index 0000000..dfb0b7b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/sitronix,st7586.txt
>> @@ -0,0 +1,26 @@
>> +Sitronix ST7586 display panel
>> +
>> +Required properties:
>> +- compatible:	"lego,ev3-lcd".
>> +
>> +The node for this driver must be a child node of a SPI controller, hence
>> +all mandatory properties described in ../spi/spi-bus.txt must be specified.
>> +
>> +Optional properties:
>> +- dc-gpios:	D/C pin. The presence/absence of this GPIO determines
>> +		the panel interface operation mode (IF[3:1] pins):
>> +		- present: IF=011 4-wire 8-bit data serial interface
>> +		- absent:  IF=010 3-wire 9-bit data serial interface
> How does this work ? Do you have a single GPIO on your system connected to
> IF[1], with IF[3:2] hardwired to 01 ?
>
>> +- reset-gpios:	Reset pin
>> +- power-supply:	A regulator node for the supply voltage.
>> +- backlight:	phandle of the backlight device attached to the panel
>> +- rotation:	panel rotation in degrees counter clockwise (0,90,180,270)
> Please use the OF graph DT bindings (a.k.a. ports) to describe the connection
> between the panel and its source.

This display has a controller with onboard memory that is scanned out
to the panel. The controller is connected, in this instance, through SPI.
Both initialization and pixel data is transferred over SPI. It resembles
the MIPI DCS/DBI standard except that it misses some of the commands and
has non standard formats: 2-bit greyscale and monochrome. MIPI DBI only
supports rgb formats (3, 8, 12, 16 and 18-bits). So it isn't a drm panel
in the sense as one connected through MIPI DSI or MIPI DPI.

MIPI DBI has 3 interface types:
- 8/9/16/18 bit parallel bus + Data/Command signal (8080 or motorola bus)
- 8/16 bit SPI + D/C signal
- 9 bit SPI (D/C as first bit)

Noralf.

>> +Example:
>> +	display at 0{
>> +		compatible = "lego,ev3-lcd";
>> +		reg = <0>;
>> +		spi-max-frequency = <10000000>;
>> +		dc-gpios = <&gpio 43 GPIO_ACTIVE_HIGH>;
>> +		reset-gpios = <&gpio 80 GPIO_ACTIVE_HIGH>;
>> +	};
