From: sr@denx.de (Stefan Roese)
Date: Thu, 24 Mar 2016 18:51:53 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <30176583.aSTyzO0qS3@wuerfel>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <3250653.vvT0RgK8yg@wuerfel> <56F412B5.2080200@denx.de>
 <30176583.aSTyzO0qS3@wuerfel>
Message-ID: <56F42939.4020803@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.03.2016 17:48, Arnd Bergmann wrote:
> On Thursday 24 March 2016 17:15:49 Stefan Roese wrote:
>>>
>>>        soc@ {
>>>                spi0 {
>>>                          compatible = "marvell,armada-370-spi",
>>>                                       "marvell,orion-spi";
>>>                        reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>,
>>>                              <MBUS_ID(0x01, 0x5e) 0 0x100000>;
>>>                          #address-cells = <1>;
>>>                          #size-cells = <0>;
>>>                          pinctrl-0 = <&spi0_pins1>;
>>>                          pinctrl-names = "default";
>>>                          cell-index = <0>;
>>>                          interrupts = <30>;
>>>                          clocks = <&coreclk 0>;
>>>                          status = "disabled";
>>>                };
>>>        };
>>
>> Do I understand this correctly, that you suggest to list all MBus
>> windows here, that the SoC supports (e.g. 8 for the Armada XP).
>> And let the SPI driver then extract and dynamically enable (map)
>> the one that is currently used?
>
> Actually the syntax above doesn't imply any mapping at all, it
> just describes how the hardware is wired up, so that really
> needs to list all windows, and then the ranges property in the
> soc node can statically map the ones that are used on the
> particular machine.

I see. But with this we are back to statically mapping the MBus
windows that are used. Resulting in potentially multiple windows
per SPI controller, which is not necessary (Andrew and Mark
objected against that).

>> We also need a per-SPI-device DT property to enable this direct
>> access mode for this specific SPI device. As not all SPI devices
>> support this mode - at least not yet. How about this one:
>>
>>                  flash0: flash at 0 {
>>                          compatible = "m25p128";
>>                          reg = <0>;
>>                          direct-access-enable;
>>                          ...
>>                  };
>>
>> ?
>
> Maybe the spi driver can just check whether the window is mapped
> or not, and then have no ranges entry for the devices that don't
> support it?

Sure, if its statically mapped (via 'ranges' in the soc node),
then this is easy to implement in the driver. Its similar to what
the RFC version of the patch did.

> Alternatively, we might encode this in the 'reg' property in
> some way?
>
> How do we know whether a device supports the mode or not?

Currently, only a very limited number of SPI devices will support
it. As its really only useful right now for full-speed tx-transfer.
In my case its downloading a bitstream into a FPGA (only SPI
writes). In the future, SPI NOR flash devices can be supported.
But this needs additional work. So SPI devices should not use
this direct access mode as default for now. It needs to get
opted-in via some DT property.

Thanks,
Stefan

PS: I'm off into Easter vacation in a few hours. So I will follow-up
on this earliest in week 14.
