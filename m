From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 19 Apr 2017 19:35:56 +0200
Subject: [PATCH] ARM: dts: BCM5301X: Specify MDIO bus in the DT
In-Reply-To: <94250925-7d5d-ac31-58ad-918406d904f1@gmail.com>
References: <20170402210840.11429-1-zajec5@gmail.com>
 <5a6ecda9-2cf6-2171-7210-6b3a1d4c6012@gmail.com>
 <c3a0455a-821f-d8a8-bf8a-7ad06ad0466e@milecki.pl>
 <94250925-7d5d-ac31-58ad-918406d904f1@gmail.com>
Message-ID: <cd324440-ad88-0981-1577-822d39ee289d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2017 06:43 PM, Florian Fainelli wrote:
> On 04/02/2017 02:25 PM, Rafa? Mi?ecki wrote:
>> On 04/02/2017 11:14 PM, Florian Fainelli wrote:
>>> Le 04/02/17 ? 14:08, Rafa? Mi?ecki a ?crit :
>>>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>>>
>>>> Northstar devices have MDIO bus that may contain various PHYs attached.
>>>> A common example is USB 3.0 PHY (that doesn't have an MDIO driver yet).
>>>>
>>>> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
>>>> ---
>>>>  arch/arm/boot/dts/bcm5301x.dtsi | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi
>>>> b/arch/arm/boot/dts/bcm5301x.dtsi
>>>> index acee36a61004..6a2afe7880ae 100644
>>>> --- a/arch/arm/boot/dts/bcm5301x.dtsi
>>>> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
>>>> @@ -320,6 +320,13 @@
>>>>          };
>>>>      };
>>>>
>>>> +    mdio at 18003000 {
>>>> +        compatible = "brcm,iproc-mdio";
>>>> +        reg = <0x18003000 0x8>;
>>>> +        #size-cells = <1>;
>>>> +        #address-cells = <0>;
>>>> +    };
>>>
>>> This looks fine, but usually the block should be enabled on a per-board
>>> basis, such that there should be a status = "disabled" property here by
>>> default.
>>
>> I think we have few blocks in bcm5301x.dtsi enabled by default. I guess
>> it's
>> for stuff that is always present on every SoC family board: rng, nand,
>> spi to
>> name few.
>>
>> It makes some sense, consider e.g. spi. Every Northstar board has SPI
>> controller so it's enabled by default. Not every board has SPI flash, so
>> it's
>> disabled by default.
>>
>> It's there and it make sense to me. Is that OK or not?
>
> Even though there are devices that are always enabled on a given SoC,
> because the board designs are always consistent does not necessarily
> make them good candidates to be enabled at the .dtsi level. This is
> particularly true when there are external connections to blocks (SPI,
> NAND, USB, Ethernet, MDIO to name a few), having them disabled by
> default is safer as a starting point to begin with.

In case of Northstar there is USB 3.0 PHY connected *internally* to this MDIO.
I don't think any board manufacturer is able to rip SoC out of the MDIO or the
USB 3.0 PHY.


>> I find MDIO situation quite simiar. It seems every Northstar board has
>> MDIO bus
>> just devices may differ and should not be enabled by default.
>
> In which case, the only difference, for you would be to do to, at the
> board-level DTS:
>
> &mdio {
> 	status = "okay";
>
> 	phy at 0 {
> 		reg = <0>;
> 		...
> 	};
> };
>
> versus:
>
> &mdio {
> 	phy at 0 {
> 		reg = <0>;
> 		...
> 	};
> };
>
> I think we can afford putting the mdio node's status property in each
> board-level DTS and make it clear that way that it is enabled because
> there are child nodes enabled?

This will be a pretty big effort because every Northstar device I know has USB
3.0 PHY in the SoC.


> NB: with a CONFIG_OF system, there is no automatic probing of MDIO child
> devices because it relies on child nodes being declared, but you would
> still get the driver to be probed and enabled, which is a waste of
> resources at best.

Right, but DT role is to describe device/board and not really care if operating
system handles that efficiently.
