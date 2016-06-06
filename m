From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 6 Jun 2016 09:49:26 +0300
Subject: [PATCH 1/2] ARM: dts: imx6q: extend support for the cm-fx6
In-Reply-To: <d0329c33bee14d6e8be8abef607dce3e@rwthex-s1-b.rwth-ad.de>
References: <709d6b3d522f4fcb8112830e0426dbb3@rwthex-s1-b.rwth-ad.de>
 <1463994191.2370.3.camel@pengutronix.de> <5746B8C4.6020406@compulab.co.il>
 <1464256217.14453.10.camel@pengutronix.de> <5746DFE2.9040903@compulab.co.il>
 <d083d0308abd48efbd4b6042e1f9c470@rwthex-s2-a.rwth-ad.de>
 <d0329c33bee14d6e8be8abef607dce3e@rwthex-s1-b.rwth-ad.de>
Message-ID: <57551CF6.2020602@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On 06/05/2016 08:32 PM, Christopher Spinrath wrote:
> Hi Igor,
> 
> On 06/05/2016 06:43 PM, Igor Grinberg wrote:
>> Hi Christopher,
>>
>> On 05/26/2016 02:37 PM, Igor Grinberg wrote:
>>> On 05/26/2016 12:50 PM, Lucas Stach wrote:
>>>> Hi Igor,
>>>>
>>>> Am Donnerstag, den 26.05.2016, 11:50 +0300 schrieb Igor Grinberg:
>>>>> Hi Lucas,
>>>>>
>>>>> Thanks for reviewing the patch(es).
>>>>>
>>>>> On 05/23/2016 12:03 PM, Lucas Stach wrote:
>>>>>> Am Montag, den 23.05.2016, 00:47 +0200 schrieb
>>>>>> christopher.spinrath at rwth-aachen.de:
>>>>>>> From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
>>>>>
>>>>> [...]
>>>>>
>>>>>>> +&ecspi1 {
>>>>>>> +	fsl,spi-num-chipselects = <2>;
>>>>>>> +	cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>;
>>>>>>> +	pinctrl-names = "default";
>>>>>>> +	pinctrl-0 = <&pinctrl_ecspi1>;
>>>>>>> +	status = "okay";
>>>>>>> +
>>>>>>> +	flash: m25p80 at 0 {
>>>>>>> +		#address-cells = <1>;
>>>>>>> +		#size-cells = <1>;
>>>>>>> +		compatible = "st,m25p", "jedec,spi-nor";
>>>>>>> +		spi-max-frequency = <20000000>;
>>>>>>> +		reg = <0>;
>>>>>>> +
>>>>>>> +		partition at 0 {
>>>>>>> +			label = "uboot";
>>>>>>> +			reg = <0x0 0xc0000>;
>>>>>>> +		};
>>>>>>> +
>>>>>>> +		partition at c0000 {
>>>>>>> +			label = "uboot environment";
>>>>>>> +			reg = <0xc0000 0x40000>;
>>>>>>> +		};
>>>>>>> +
>>>>>>> +		partition at 100000 {
>>>>>>> +			label = "reserved";
>>>>>>> +			reg = <0x100000 0x100000>;
>>>>>>> +		};
>>>>>>
>>>>>> Partition layouts don't belong in the upstream DT, as it a device
>>>>>> configuration thing. Please kep them in the bootloader/firmware and make
>>>>>> this one pass the partition layout to the kernel.
>>>>>
>>>>> I don't completely agree with this.
>>>>> We have lots of partition layouts in the upstream DT.
>>>>
>>>> No, we don't. At least not for the i.MX6. There are some for the earlier
>>>> i.MX boards, but IMO it's wrong to put device configuration into the
>>>> upstream DT. Let's not start doing this again.
>>>
>>> Why not?
>>> For i.MX6 there are 2 boards that have the partitioning scheme.
>>> I'm not considering this a device configuration, but rather
>>> a default partitioning layout/scheme.
>>> Current case is for the firmware storage device that is not likely
>>> to change.
>>> Moreover, a DT is not really a part of the kernel, but lays along the kernel
>>> sources for convenience and simplicity (at least IIRC as it was decided
>>> about 5 years ago). It is more a part of the firmware for a device, than
>>> an upstream kernel source code.
>>> I think it is only a meter of time when Linus will decide that he does not
>>> want it inside the kernel anymore...
>>>
>>>>
>>>>> Moreover, this is the default layout and changing it, will
>>>>> result in incompatibilities and also might result in device "bricking".
>>>>> Those can be changed from the boot loader in case you need those
>>>>> the other way around.
>>>>> Another question of mine is, why should you?
>>>>>
>>>> Partition layout is device configuration, which is governed by the
>>>> device firmware.
>>>
>>> Yet again, DT is a part of device firmware.
>>> Moreover, the firmware (in that case U-Boot), can be configured
>>> using the very same DT code, so not having this in, might force
>>> various w/a and hacks.
>>>
>>>> By not having the partition layout in the upstream DT
>>>> people are forced to set it from the firmware, which is exactly the
>>>> right thing to do, weather or not you plan to change it at any time.
>>>
>>> I might be ignorant, sorry for that.
>>> Why? Why is it right and why would you want to force people to do that?
>>>
>>>
>>
>> No answer?
>> I think it is worth keeping this as a default firmware layout.
>>
> 
> I was not happy removing the layout at first, too. However, they are
> added rarely (at least recently) and the binding documentation [1]
> states that they shall only be added if there are "strong conventions".

Well, not exactly, it says:

"Partitions can be represented by sub-nodes of an mtd device. This can be used
on platforms which have strong conventions about which portions of a flash are
used for what purposes, but which don't use an on-flash partition table such
as RedBoot."

In my understanding, "can" is _not_ exactly "shall only".

> 
> Moreover, it is really easy to pass the layout via firmware/u-boot.
> Unfortunately, the u-boot provided by CompuLab does not have the
> mtdparts commands built-in but the layout can be passed via cmdline as
> well. This seems more flexible to me (and I consider this to be good).

That means you need a different version of U-Boot if you want to use
an upstream kernel, or you need to play the bootargs games, or just leave
it a "black box".
So currently, from the three options above, the "black box" is chosen, right?
That's a pity, because I'd like things to be open...

> 
> Even if we want to have the layout in the devicetree one day (e.g. to
> use the same file for u-boot) we can send another follow-up patch adding
> them (and discuss this matter in more detail). But let's not prevent the
> remaining part of this patch series to enter mainline if there is a
> good, easy and flexible alternative.

That's a valid point from my POV.
I have never had an intent to prevent things going upstream.
This is something Compulab should have done years ago, but
unfortunately, due to some circumstances it haven't happened for cm-fx6...


-- 
Regards,
Igor.
