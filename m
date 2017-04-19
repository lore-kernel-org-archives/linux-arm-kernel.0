From: rafal@milecki.pl (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 19 Apr 2017 20:10:02 +0200
Subject: [PATCH] ARM: dts: BCM5301X: Specify MDIO bus in the DT
In-Reply-To: <221a0208-8a64-6bd8-f6b2-39e845520a83@gmail.com>
References: <20170402210840.11429-1-zajec5@gmail.com>
 <5a6ecda9-2cf6-2171-7210-6b3a1d4c6012@gmail.com>
 <c3a0455a-821f-d8a8-bf8a-7ad06ad0466e@milecki.pl>
 <94250925-7d5d-ac31-58ad-918406d904f1@gmail.com>
 <cd324440-ad88-0981-1577-822d39ee289d@gmail.com>
 <221a0208-8a64-6bd8-f6b2-39e845520a83@gmail.com>
Message-ID: <ab696d24-3544-a554-82d1-18839b29caa0@milecki.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2017 07:52 PM, Florian Fainelli wrote:
> On 04/19/2017 10:35 AM, Rafa? Mi?ecki wrote:
>> On 04/19/2017 06:43 PM, Florian Fainelli wrote:
>>> On 04/02/2017 02:25 PM, Rafa? Mi?ecki wrote:
>>>> On 04/02/2017 11:14 PM, Florian Fainelli wrote:
>>>>> Le 04/02/17 ? 14:08, Rafa? Mi?ecki a ?crit :
>>>>>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>>>>>
>>>>>> Northstar devices have MDIO bus that may contain various PHYs
>>>>>> attached.
>>>>>> A common example is USB 3.0 PHY (that doesn't have an MDIO driver
>>>>>> yet).
>>>>>>
>>>>>> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
>>>>>> ---
>>>>>>  arch/arm/boot/dts/bcm5301x.dtsi | 7 +++++++
>>>>>>  1 file changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi
>>>>>> b/arch/arm/boot/dts/bcm5301x.dtsi
>>>>>> index acee36a61004..6a2afe7880ae 100644
>>>>>> --- a/arch/arm/boot/dts/bcm5301x.dtsi
>>>>>> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
>>>>>> @@ -320,6 +320,13 @@
>>>>>>          };
>>>>>>      };
>>>>>>
>>>>>> +    mdio at 18003000 {
>>>>>> +        compatible = "brcm,iproc-mdio";
>>>>>> +        reg = <0x18003000 0x8>;
>>>>>> +        #size-cells = <1>;
>>>>>> +        #address-cells = <0>;
>>>>>> +    };
>>>>>
>>>>> This looks fine, but usually the block should be enabled on a per-board
>>>>> basis, such that there should be a status = "disabled" property here by
>>>>> default.
>>>>
>>>> I think we have few blocks in bcm5301x.dtsi enabled by default. I guess
>>>> it's
>>>> for stuff that is always present on every SoC family board: rng, nand,
>>>> spi to
>>>> name few.
>>>>
>>>> It makes some sense, consider e.g. spi. Every Northstar board has SPI
>>>> controller so it's enabled by default. Not every board has SPI flash, so
>>>> it's
>>>> disabled by default.
>>>>
>>>> It's there and it make sense to me. Is that OK or not?
>>>
>>> Even though there are devices that are always enabled on a given SoC,
>>> because the board designs are always consistent does not necessarily
>>> make them good candidates to be enabled at the .dtsi level. This is
>>> particularly true when there are external connections to blocks (SPI,
>>> NAND, USB, Ethernet, MDIO to name a few), having them disabled by
>>> default is safer as a starting point to begin with.
>>
>> In case of Northstar there is USB 3.0 PHY connected *internally* to this
>> MDIO.
>> I don't think any board manufacturer is able to rip SoC out of the MDIO
>> or the
>> USB 3.0 PHY.
>
> OK, then can you still resubmit a proper patch that a) puts that
> information in the commit message, and b) also adds a proper label to
> the mdio node such that it can later on be referenced by label in
> board-level DTS files? By that I mean:
>
> mdio: mdio at 18003000 {
>
> Thank you
>
>>
>>
>>>> I find MDIO situation quite simiar. It seems every Northstar board has
>>>> MDIO bus
>>>> just devices may differ and should not be enabled by default.
>>>
>>> In which case, the only difference, for you would be to do to, at the
>>> board-level DTS:
>>>
>>> &mdio {
>>>     status = "okay";
>>>
>>>     phy at 0 {
>>>         reg = <0>;
>>>         ...
>>>     };
>>> };
>>>
>>> versus:
>>>
>>> &mdio {
>>>     phy at 0 {
>>>         reg = <0>;
>>>         ...
>>>     };
>>> };
>>>
>>> I think we can afford putting the mdio node's status property in each
>>> board-level DTS and make it clear that way that it is enabled because
>>> there are child nodes enabled?
>>
>> This will be a pretty big effort because every Northstar device I know
>> has USB
>> 3.0 PHY in the SoC.
>
> Adding a one liner is a "pretty big effort", for sure.

Sorry, we got a misunderstanding here.

I thought you meant adding something like this for every device:

&mdio {
	status = "okay";

	usb3_phy: usb-phy at 10 {
		compatible = "brcm,ns-ax-usb3-phy";
		reg = <0x10>;
		usb3-dmp-syscon = <&usb3_dmp>;
		#phy-cells = <0>;
	};
};

usb3_dmp: syscon at 18105000 {
	reg = <0x18105000 0x1000>;
};

So I clearly missed something important. Did you want to have USB 3.0 PHY
defined in the dtsi file?
