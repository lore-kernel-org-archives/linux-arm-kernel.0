From: sr@denx.de (Stefan Roese)
Date: Thu, 24 Mar 2016 17:15:49 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <3250653.vvT0RgK8yg@wuerfel>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <12458203.7DzKuGjIvi@wuerfel> <56F395BC.6070108@denx.de>
 <3250653.vvT0RgK8yg@wuerfel>
Message-ID: <56F412B5.2080200@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.03.2016 13:42, Arnd Bergmann wrote:
> On Thursday 24 March 2016 08:22:36 Stefan Roese wrote:
>>
>> Arnd, thanks for your comments.
>>
>> So we seem to agree, that one MBus window per SPI controller is the
>> way to go. Only how should this be described in the DT? I've come up
>> with these new DT properties in v2:
>>
>> +- da-reg : The physical memory area that will be used for the direct
>> +           access mode, if enabled in one of the SPI devices.
>> +
>> +Per SPI device:
>> +- da-target-attribute : The target and attribute value for a specific
>> +                        SPI-controller / SPI-device combination.
>> +                       E.g. <0x01 0x5e>: SPI0-CS1 target and attribute
>>
>> ...
>>
>> +Example with direct access mode:
>> +       spi at 10600 {
>> +               compatible = "marvell,orion-spi";
>> +               status = "okay";
>> +               da-reg = <0xf2000000 0x100000>;
>> +
>> +               spi-fpga at 1 {
>> +                       compatible = "altera,stratix-v";
>> +                       reg = <1>;
>> +                       /* 0x01 0x5e: SPI0-CS1 target and attribute */
>> +                       da-target-attribute = <0x01 0x5e>;
>> +               };
>> +       };
>>
>> I've added the "da-*" (Direct Access) properties to enable the
>> SPI driver to dynamically allocate the MBus windows. Do you find
>> these new bindings reasonable? Or do you have better suggestions for
>> this per-SPI-device dynamic MBus allocation, perhaps by using
>> MBUS_ID somehow?
>
> I was thinking it would be statically set up,

Really statically? Please see below.

> but then we have a
> problem with how it uses both internal-regs and and its own mbus
> based reg, so we probably have to move the spi node outside of
> the internal-regs node to achieve that, similar to how we handle
> the devbus devices:
>
>
> 	soc@ {
> 		spi0 {
>                         compatible = "marvell,armada-370-spi",
>                                      "marvell,orion-spi";
> 			reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>,
> 			      <MBUS_ID(0x01, 0x5e) 0 0x100000>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         pinctrl-0 = <&spi0_pins1>;
>                         pinctrl-names = "default";
>                         cell-index = <0>;
>                         interrupts = <30>;
>                         clocks = <&coreclk 0>;
>                         status = "disabled";
> 		};
> 	};

Do I understand this correctly, that you suggest to list all MBus
windows here, that the SoC supports (e.g. 8 for the Armada XP).
And let the SPI driver then extract and dynamically enable (map)
the one that is currently used?

We also need a per-SPI-device DT property to enable this direct
access mode for this specific SPI device. As not all SPI devices
support this mode - at least not yet. How about this one:

		flash0: flash at 0 {
			compatible = "m25p128";
			reg = <0>;
			direct-access-enable;
			...
		};

?

Thanks,
Stefan
