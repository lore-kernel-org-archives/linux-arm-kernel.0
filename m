From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 13 Jan 2017 18:33:40 +0100
Subject: [PATCH v1 2/2] arm: dts: mt2701: add nor flash node
In-Reply-To: <20170113175628.1793f433@bbrezillon>
References: <1484291609-20195-1-git-send-email-guochun.mao@mediatek.com>
 <1484291609-20195-3-git-send-email-guochun.mao@mediatek.com>
 <20170113151747.6bc85245@bbrezillon>
 <d7b866ad-5b2f-62d3-3aa3-6fa42803d625@gmail.com>
 <b850b751-1d8d-0053-cf1f-d5314542e5c3@gmail.com>
 <20170113172825.75d545a3@bbrezillon>
 <86c997be-f500-eaa1-3ba5-d21cff6223b7@gmail.com>
 <20170113175628.1793f433@bbrezillon>
Message-ID: <0fafcd8d-cf99-de6b-728f-5e3637810b68@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2017 05:56 PM, Boris Brezillon wrote:
> On Fri, 13 Jan 2017 17:44:12 +0100
> Marek Vasut <marek.vasut@gmail.com> wrote:
> 
>> On 01/13/2017 05:28 PM, Boris Brezillon wrote:
>>> On Fri, 13 Jan 2017 17:13:55 +0100
>>> Marek Vasut <marek.vasut@gmail.com> wrote:
>>>   
>>>> On 01/13/2017 04:12 PM, Matthias Brugger wrote:  
>>>>>
>>>>>
>>>>> On 13/01/17 15:17, Boris Brezillon wrote:    
>>>>>> On Fri, 13 Jan 2017 15:13:29 +0800
>>>>>> Guochun Mao <guochun.mao@mediatek.com> wrote:
>>>>>>    
>>>>>>> Add Mediatek nor flash node.
>>>>>>>
>>>>>>> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
>>>>>>> ---
>>>>>>>  arch/arm/boot/dts/mt2701-evb.dts |   25 +++++++++++++++++++++++++
>>>>>>>  arch/arm/boot/dts/mt2701.dtsi    |   12 ++++++++++++
>>>>>>>  2 files changed, 37 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm/boot/dts/mt2701-evb.dts
>>>>>>> b/arch/arm/boot/dts/mt2701-evb.dts
>>>>>>> index 082ca88..85e5ae8 100644
>>>>>>> --- a/arch/arm/boot/dts/mt2701-evb.dts
>>>>>>> +++ b/arch/arm/boot/dts/mt2701-evb.dts
>>>>>>> @@ -24,6 +24,31 @@
>>>>>>>      };
>>>>>>>  };
>>>>>>>
>>>>>>> +&nor_flash {
>>>>>>> +    pinctrl-names = "default";
>>>>>>> +    pinctrl-0 = <&nor_pins_default>;
>>>>>>> +    status = "okay";
>>>>>>> +    flash at 0 {
>>>>>>> +        compatible = "jedec,spi-nor";
>>>>>>> +        reg = <0>;
>>>>>>> +    };
>>>>>>> +};
>>>>>>> +
>>>>>>> +&pio {
>>>>>>> +    nor_pins_default: nor {
>>>>>>> +        pins1 {
>>>>>>> +            pinmux = <MT2701_PIN_240_EXT_XCS__FUNC_EXT_XCS>,
>>>>>>> +                 <MT2701_PIN_241_EXT_SCK__FUNC_EXT_SCK>,
>>>>>>> +                 <MT2701_PIN_239_EXT_SDIO0__FUNC_EXT_SDIO0>,
>>>>>>> +                 <MT2701_PIN_238_EXT_SDIO1__FUNC_EXT_SDIO1>,
>>>>>>> +                 <MT2701_PIN_237_EXT_SDIO2__FUNC_EXT_SDIO2>,
>>>>>>> +                 <MT2701_PIN_236_EXT_SDIO3__FUNC_EXT_SDIO3>;
>>>>>>> +            drive-strength = <MTK_DRIVE_4mA>;
>>>>>>> +            bias-pull-up;
>>>>>>> +        };
>>>>>>> +    };
>>>>>>> +};
>>>>>>> +
>>>>>>>  &uart0 {
>>>>>>>      status = "okay";
>>>>>>>  };
>>>>>>> diff --git a/arch/arm/boot/dts/mt2701.dtsi
>>>>>>> b/arch/arm/boot/dts/mt2701.dtsi
>>>>>>> index bdf8954..1eefce4 100644
>>>>>>> --- a/arch/arm/boot/dts/mt2701.dtsi
>>>>>>> +++ b/arch/arm/boot/dts/mt2701.dtsi
>>>>>>> @@ -227,6 +227,18 @@
>>>>>>>          status = "disabled";
>>>>>>>      };
>>>>>>>
>>>>>>> +    nor_flash: spi at 11014000 {
>>>>>>> +        compatible = "mediatek,mt2701-nor",
>>>>>>> +                 "mediatek,mt8173-nor";    
>>>>>>
>>>>>> Why define both here? Is "mediatek,mt8173-nor" really providing a
>>>>>> subset of the features supported by "mediatek,mt2701-nor"?
>>>>>>    
>>>>>
>>>>> I think even if the ip block is the same, we should provide both
>>>>> bindings, just in case in the future we find out that mt2701 has some
>>>>> hidden bug, feature or bug-feature. This way even if we update the
>>>>> driver, we stay compatible with older device tree blobs in the wild.
>>>>>
>>>>> We can drop the mt2701-nor in the bindings definition if you want.   
>>>
>>> Oh, sorry, I misunderstood. What I meant is that if you want to
>>> list/support all possible compatibles, maybe you should just put one
>>> compatible in your DT and patch your driver (+ binding doc) to define
>>> all of them.  
>>
>> Uh, what ? I lost you here :-)
>>
>>>> This exactly. We should have a DT compat in the form:
>>>> compatible = "vendor,<soc>-block", "vendor,<oldest-compat-soc>-block";
>>>> Then if we find a problem in the future, we can match on the
>>>> "vendor,<soc>-block" and still support the old DTs.  
>>>
>>> Not sure it's only in term of whose IP appeared first. My understanding
>>> is that it's a way to provide inheritance. For example:
>>>
>>> 	"<soc-vendor>,<ip-version>", "<ip-vendor>,<ip-version>";
>>>
>>> or
>>>
>>> 	"<soc-vendor>,<full-featured-ip-version>","<soc-vendor>,<basic-feature-ip-version>";
>>>
>>> BTW, which one is the oldest between mt8173 and mt2701? :-)  
>>
>> And that's another thing and I agree with you, but I don't think that's
>> what we're discussing in this thread. But (!), OT, I think we should
>> codify the rules in Documentation/ . This discussion came up multiple
>> times recently.
>>
>> And my question still stands, what do we put into the DT here, IMO
>> compatible = "mediatek,mt2701-nor", "mediatek,mt8173-nor";
> 
> I'd say
> 
> 	compatible = "mediatek,mt8173-nor";
> 
> because both compatible are referring to very specific IP version. It's
> not the same as

But then you don't have the ability to handle a block in this particular
SoC in case there's a bug found in it in the future,
so IMO it should be:

compatible = "mediatek,mt2701-nor", "mediatek,mt8173-nor";

> 	compatible = "mediatek,mt8173-nor", "mediatek,mt81xx-nor";

This doesn't look right, since here we add two new compatibles ...

> where you clearly have a generic compatible which is overloaded by a
> specific one.
> 
> But anyway, I'm not the one taking the decision here, let's wait for DT
> maintainers reviews.
> 
>> and what goes into the binding document ? I guess both too ?
> 
> If both exist, they should be both documented.
> 


-- 
Best regards,
Marek Vasut
