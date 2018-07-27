From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 27 Jul 2018 11:33:51 +0100
Subject: [linux-sunxi] Re: [PATCH v2 06/18] arm64: dts: allwinner: a64:
 Orange Pi Win: Add UARTs
In-Reply-To: <8d309202-05f1-d024-ae98-6a6baf03e888@arm.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
 <20180726003532.18751-7-andre.przywara@arm.com>
 <20180726073911.ualwgf3t2bboeuy5@flea>
 <E978AF7E-4802-4429-99A2-4724EB68FFA9@aosc.io>
 <71e5f296-a8f6-062c-6e55-86c8b07ed0a6@arm.com>
 <20180726093247.3hesukln2n3fhqeg@flea>
 <8d309202-05f1-d024-ae98-6a6baf03e888@arm.com>
Message-ID: <e4af10fb-6f3b-7693-28db-ca155dcd807a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26/07/18 14:04, Andre Przywara wrote:
> Hi,
> 
> On 26/07/18 10:32, Maxime Ripard wrote:
>> On Thu, Jul 26, 2018 at 09:30:14AM +0100, Andre Przywara wrote:
>>> Hi,
>>>
>>> On 26/07/18 08:42, Icenowy Zheng wrote:
>>>>
>>>>
>>>> ? 2018?7?26? GMT+08:00 ??3:39:11, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>>>>> On Thu, Jul 26, 2018 at 01:35:20AM +0100, Andre Przywara wrote:
>>>>>> From: Samuel Holland <samuel@sholland.org>
>>>>>>
>>>>>> The Orange Pi Win exposes several UARTs on header pin, and connects
>>>>> one
>>>>>> to the on-board WiFi/Bluetooth chip.
>>>>>> Add the pinmux definitions to the UART nodes, but keep them disabled.
>>>>>>
>>>>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>>>> ---
>>>>>>  .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 33
>>>>> ++++++++++++++++++++++
>>>>>>  1 file changed, 33 insertions(+)
>>>>>>
>>>>>> diff --git
>>>>> a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
>>>>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
>>>>>> index 0cadcd59edd9..10f63d0b99cb 100644
>>>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
>>>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
>>>>>> @@ -54,6 +54,10 @@
>>>>>>  	aliases {
>>>>>>  		ethernet0 = &emac;
>>>>>>  		serial0 = &uart0;
>>>>>> +		serial1 = &uart1;
>>>>>> +		serial2 = &uart2;
>>>>>> +		serial3 = &uart3;
>>>>>> +		serial4 = &uart4;
>>>>>>  	};
>>>>>>  
>>>>>>  	chosen {
>>>>>> @@ -237,12 +241,41 @@
>>>>>>  	vcc-hdmi-supply = <&reg_dldo1>;
>>>>>>  };
>>>>>>  
>>>>>> +/* On debug connector */
>>>>>>  &uart0 {
>>>>>>  	pinctrl-names = "default";
>>>>>>  	pinctrl-0 = <&uart0_pins_a>;
>>>>>>  	status = "okay";
>>>>>>  };
>>>>>>  
>>>>>> +/* Wi-Fi/BT */
>>>>>> +&uart1 {
>>>>>> +	pinctrl-names = "default";
>>>>>> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
>>>>>> +	status = "okay";
>>>>>> +};
>>>>>
>>>>> What BT chip is there? Does it have serdev support? If so, that should
>>>>> be enabled here.
>>>>
>>>> RTL8723BS, no serdev.
>>
>> https://www.spinics.net/lists/linux-bluetooth/msg76376.html
>>
>> Not very far off though.
>>
>>> Yes. A while ago I managed to enable Bluetooth (on the Pine64 with the
>>> same chip), but that involved a lot of hacking with a special userland
>>> tool (not hciattach and no serdev).
>>>
>>> What this node means to say is: The UART1 is hardwired to some on-board
>>> device and those pins are not available for GPIO, for instance.
>>>
>>> At least that was my understanding when it comes to enabling devices in
>>> the DT. Is that correct?
>>
>> Well, yes and no. Arguably, any device connected to the other side of
>> the serial bus should have been there from the beginning. However,
>> there wasn't any way to do that in Linux before serdev was introduced,
>> so we weren't doing that. That resulted in hacky userspace tools to
>> work around that, and other work arounds in the DT to for example
>> tying BT resources (clock, regulators, resets) to the WiFi chip hoping
>> that someone would use both all the time.
>>
>> Now that it's just around the corner, we don't have any excuse to do
>> these kind of hacks anymore.
> 
> That's true. Also I see that the serdev binding itself is not serdev
> specific, it just puts the Bluetooth node as a child of an UART node.
> But we would still need a compatible string for that child, wouldn't we?
> I guess we can't autodetect this? From what I can see from Hans' series
> there is no DT compatible string defined?
> 
> So do we just put a node there, specifying the resources it needs? Like
> the wake-up interrupt or regulators, if any? And leave out the
> compatible string, at least for now?

So I tried this:
https://github.com/apritzel/linux/commit/da8e1beadd2737067c#diff-1c31e6cad6646026007c68fe9d4a5079R257

but wasn't really happy with it. Without a proper binding we can't
describe all the resources yet: what's the prefix for -supply, is the
wake-up line a GPIO or an interrupt, is the reset line a GPIO or a reset
property, and so on.

So I can use either an empty node, which would more serve as
documentation, or at least put the wakeup line as an interrupt there.

Was there at least a proposed binding? I tried to look for other BT
chips, but they don't seem to agree on some common properties.

Cheers,
Andre.
