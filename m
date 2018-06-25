From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 25 Jun 2018 18:42:30 +0800
Subject: [PATCHv2 5/5] arm64: allwinner: a64: Add support for TERES-I
 laptop
In-Reply-To: <5B30A40D.3070509@broadcom.com>
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-6-harald@ccbib.org>
 <a7011fe78d171658742406bf01d50b7e3d7eaf1d.camel@aosc.io>
 <E1fX7yK-0000OC-HA@stardust.g4.wien.funkfeuer.at>
 <5B309D37.80207@broadcom.com> <1CF519CD-D44E-4959-8951-27CE710E0984@aosc.io>
 <5B30A40D.3070509@broadcom.com>
Message-ID: <C9EE9283-66CB-4B0F-853E-3D6DC746C20E@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?6?25? GMT+08:00 ??4:13:01, Arend van Spriel <arend.vanspriel@broadcom.com> ??:
>On 6/25/2018 9:47 AM, Icenowy Zheng wrote:
>>
>>
>> ? 2018?6?25? GMT+08:00 ??3:43:51, Arend van Spriel
><arend.vanspriel@broadcom.com> ??:
>>> On 6/24/2018 6:34 PM, Harald Geyer wrote:
>>>> Icenowy Zheng writes:
>>>>>> ? 2018-03-15?? 16:25 +0000?Harald Geyer???
>>>>>>>> +&mmc1 {
>>>>>>>> +	pinctrl-names = "default";
>>>>>>>> +	pinctrl-0 = <&mmc1_pins>;
>>>>>>>> +	vmmc-supply = <&reg_aldo2>;
>>>>>>>> +	vqmmc-supply = <&reg_dldo4>;
>>>>>>>> +	mmc-pwrseq = <&wifi_pwrseq>;
>>>>>>>> +	bus-width = <4>;
>>>>>>>> +	non-removable;
>>>>>>>> +	status = "okay";
>>>>>>>> +
>>>>>>>> +	rtl8723bs: wifi at 1 {
>>>>>>>> +		reg = <1>;
>>>>>>>> +		interrupt-parent = <&r_pio>;
>>>>>>>> +		interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 */
>>>>>>>> +		interrupt-names = "host-wake";
>>>>>>>> +	};
>>>
>>> [...]
>>>
>>>>>> - This device node has no binding. The "host-wake" interrupt is
>>> part of
>>>>>>   Broadcom SDIO Wi-Fi binding, rather than a generic one.
>>>> I think the general mmc and interrupts bindings apply. And the mmc
>>> binding
>>>> clearly states that for sub-nodes a compatible string is optional.
>>>>
>>>> However I just realized that the 'interrupt-names' property is not
>>> part
>>>> of the general interrupts binding, so I guess at least this
>property
>>> should
>>>> be removed.
>>>
>>> Indeed. If the device just used the SDIO interrupt this is not
>needed.
>>> The Broadcom device can use either SDIO interrupt or a so-called
>>> out-of-band host-wake interrupt, which is what the above represents.
>>
>> RTL8....S is also capable of use OOB interrupt.
>
>Ok. Is it also in-place in this TERES-I laptop? Anyway, if RTL8...S

In fact it's a regexp here, mean Realtek SDIO WLAN NICs.

>does 
>not have a binding specification there is not much to do about it. In
>my 
>opinion it does not make sense to add it to the generic mmc/sdio
>binding 
>as this interrupt does not involve the mmc/sdio hardware hence the term
>
>OOB. There is generic wifi binding net/wireless/ieee80211.txt in which 

It seems ok. Maybe it can be used for all interfaces, not
SDIO, although I don't think there's any other interfaces
that can use OOB IRQ except SPI and SDIO, maybe UART? :-)

>this could be added. Obviously it would just be a binding and no 
>guarantee that the actual device driver supports it so the RTL driver 
>would need modification for that.

Yes. Currently OOB interrupt is not used at all.

>
>Regards,
>Arend
