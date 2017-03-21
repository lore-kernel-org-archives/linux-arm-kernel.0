From: gerg@linux-m68k.org (Greg Ungerer)
Date: Tue, 21 Mar 2017 12:05:20 +1000
Subject: [PATCH 2/2] spi: imx: fix use of native chip-selects with
 devicetree
In-Reply-To: <f1cf2001-28b4-6a74-b98a-13336d74ff9d@mentor.com>
References: <1489726983-17706-1-git-send-email-gerg@linux-m68k.org>
 <1489726983-17706-3-git-send-email-gerg@linux-m68k.org>
 <f1cf2001-28b4-6a74-b98a-13336d74ff9d@mentor.com>
Message-ID: <4a8449d9-cc38-d642-0853-246f46ee7059@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 20/03/17 23:22, Vladimir Zapolskiy wrote:
> On 03/17/2017 07:03 AM, Greg Ungerer wrote:
>> The commonly used mechanism of specifying the hardware or native
>> chip-select on an SPI device in devicetree (that is "cs-gpios = <0>")
>> does not result in the native chip-select being configured for use.
>> So external SPI devices that require use of the native chip-select
>> will not work.
>>
>> You can successfully specify native chip-selects if using a platform
>> setup by specifying the cs-gpio as negative offset by 32. And that
>> works correctly. You cannot use the same method in devicetree.
>>
>> The logic in the spi-imx.c driver during probe uses core spi function
>> of_spi_register_master() in spi.c to parse the "cs-gpios" devicetree tag.
>> For valid GPIO values that will be recorded for use, all other entries in
>> the cs_gpios list will be set to -ENOENT. So entries like "<0>" will be
>> set to -ENOENT in the cs_gpios list.
>>
>> When the SPI device registers are setup the code will use the GPIO
>> listed in the cs_gpios list for the desired chip-select. If the cs_gpio
>> is less then 0 then it is intended to be for a native chip-select, and
>> its cs_gpio value is added to 32 to get the chipselect number to use.
>> Problem is that with devicetree this can only ever be -ENOENT (which
>> is -2), and that alone results in an invalid chip-select number. But also
>> doesn't allow selection of the native chip-select at all.
>>
>> To fix, if the cs_gpio specified for this spi device is not a
>> valid GPIO then use the "chip_select" (that is the native chip-select
>> number) for hardware setup.
>>
> 
> Can you please share an example of "cs-gpios" property for a particular
> case, which I'm able to test? It is an Atmel AT93C66A EEPROM connected
> to CSPI1 and sitting on chip select 2 (= selected by CSPI1_SS2), there
> is no other SPI devices on CSPI1.

Is the AT93C66A going to work if you use native chip selects?

I have an iMX25 based board with a NOR flash on SPI1 using
a GPIO chip select, and on SPI2 a Silicon Labs 32260 SLIC
using the native chip select 1. It requires the chip select line
to be asserted and de-asserted between each byte, as done when
using the native chip select setup of the iMX SPI module.

Anyway, the cs-gpio I use is:

  cs-gpios = <0>, <0>, <0>, <0>;


> Since I raise the question, please add the correspondent updates and
> and an example to Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt

Ok.

There is a few other devicetrees in arc/arm/boot/dts that use the "<0>"
notation for cs-gpios. Documentation/devicetree/bindings/spi/spi-davinci.txt
does describe its meaning.


> In fact my expectation would be to have a device description like one
> below:
> 
> &spi1 {
> 	status = "okay";
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&pinctrl_cspi1>;
> 
> 	eeprom at 2 {
> 		compatible = "atmel,at93c66a";
> 		reg = <2>;
> 		spi-cs-high;
> 		spi-max-frequency = <1000000>;
> 	};
> };
> 
> Note, that there is no cs-gpios property at all, which is mandatory
> at the moment, and unit address / reg property defines chip select
> number.

Ideally it would be allowed to have no cs-gpios at all. But currently
the spi-imx driver explicitly fails on this:

  spi.1: No CS GPIOs available

As an example my devicetree entry is similar to your above, but
it has "cs-gpios = <0>, <0>, <0>, <0>;" as well. Thats all.


> For that type of bindings locally I have a hackish spi-imx driver change,
> which supports this option, but I'm unsure if it is universal enough.

Do you mean supporting no cs-gpios tag?
That would be nice, but it would seem not many users of this are
using native chip selects. 

Regards
Greg
