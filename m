From: rjui@broadcom.com (Ray Jui)
Date: Fri, 18 Sep 2015 15:11:27 -0700
Subject: [PATCH v2 5/9] ARM: dts: Move all Cygnus peripherals into soc bus
In-Reply-To: <1929872.EmD9YkfFuv@wuerfel>
References: <1442611454-16331-1-git-send-email-rjui@broadcom.com>
 <1442611454-16331-6-git-send-email-rjui@broadcom.com>
 <1929872.EmD9YkfFuv@wuerfel>
Message-ID: <55FC8C0F.9020308@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/18/2015 2:34 PM, Arnd Bergmann wrote:
> On Friday 18 September 2015 14:24:10 Ray Jui wrote:
>> +       soc {
>> +               compatible = "simple-bus";
>> +               ranges;
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
> 
>> +               pinctrl: pinctrl at 0301d0c8 {
>>
> 
> Similarly to the core bus, this seems to have address ranges 0x03xxxxxx and
> 0x18xxxxxx on it, so put those into the ranges.
>

Okay we have an issue here. For whatever reason, the Cygnus ASIC team
decided to put registers for the same block in random locations. We see
similar issues in all of our other iProc based SoCs. We have
communicated this to our ASIC team, and hopefully they can revert the
trend for the next SoC.

For example, the gpio_ccm has registers in the following regions:

gpio_ccm: gpio at 1800a000 {
    compatible = "brcm,cygnus-ccm-gpio";
    reg = <0x1800a000 0x50>,
          <0x0301d164 0x20>;

NAND is worse, it has registers in 3 different separate regions:

nand: nand at 18046000 {
    compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1",
                 "brcm,brcmnand";
    reg = <0x18046000 0x600>, <0xf8105408 0x600>,
          <0x18046f00 0x20>;

As you can see, this makes it impossible to define a proper address
range for the bus; therefore, I'll have to keep the ranges undefined and
a simple 1:1 mapping under this bus.

> It probably also makes sense to name the bus according to what kind of
> bus (axi, ahb, plb, ...) is used here. If the soc has nested buses
> (e.g. an ahb connected to an axi bus,) then model both of them in the DT.

Based on the block diagram from the ASIC team, it looks like all of them
are connected to one major AXI fabric. I can rename the bus to AXI.

> 
> 	Arnd
> 

Thanks,

Ray
