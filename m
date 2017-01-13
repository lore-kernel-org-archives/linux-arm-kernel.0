From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 13 Jan 2017 17:13:55 +0100
Subject: [PATCH v1 2/2] arm: dts: mt2701: add nor flash node
In-Reply-To: <d7b866ad-5b2f-62d3-3aa3-6fa42803d625@gmail.com>
References: <1484291609-20195-1-git-send-email-guochun.mao@mediatek.com>
 <1484291609-20195-3-git-send-email-guochun.mao@mediatek.com>
 <20170113151747.6bc85245@bbrezillon>
 <d7b866ad-5b2f-62d3-3aa3-6fa42803d625@gmail.com>
Message-ID: <b850b751-1d8d-0053-cf1f-d5314542e5c3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2017 04:12 PM, Matthias Brugger wrote:
> 
> 
> On 13/01/17 15:17, Boris Brezillon wrote:
>> On Fri, 13 Jan 2017 15:13:29 +0800
>> Guochun Mao <guochun.mao@mediatek.com> wrote:
>>
>>> Add Mediatek nor flash node.
>>>
>>> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
>>> ---
>>>  arch/arm/boot/dts/mt2701-evb.dts |   25 +++++++++++++++++++++++++
>>>  arch/arm/boot/dts/mt2701.dtsi    |   12 ++++++++++++
>>>  2 files changed, 37 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/mt2701-evb.dts
>>> b/arch/arm/boot/dts/mt2701-evb.dts
>>> index 082ca88..85e5ae8 100644
>>> --- a/arch/arm/boot/dts/mt2701-evb.dts
>>> +++ b/arch/arm/boot/dts/mt2701-evb.dts
>>> @@ -24,6 +24,31 @@
>>>      };
>>>  };
>>>
>>> +&nor_flash {
>>> +    pinctrl-names = "default";
>>> +    pinctrl-0 = <&nor_pins_default>;
>>> +    status = "okay";
>>> +    flash at 0 {
>>> +        compatible = "jedec,spi-nor";
>>> +        reg = <0>;
>>> +    };
>>> +};
>>> +
>>> +&pio {
>>> +    nor_pins_default: nor {
>>> +        pins1 {
>>> +            pinmux = <MT2701_PIN_240_EXT_XCS__FUNC_EXT_XCS>,
>>> +                 <MT2701_PIN_241_EXT_SCK__FUNC_EXT_SCK>,
>>> +                 <MT2701_PIN_239_EXT_SDIO0__FUNC_EXT_SDIO0>,
>>> +                 <MT2701_PIN_238_EXT_SDIO1__FUNC_EXT_SDIO1>,
>>> +                 <MT2701_PIN_237_EXT_SDIO2__FUNC_EXT_SDIO2>,
>>> +                 <MT2701_PIN_236_EXT_SDIO3__FUNC_EXT_SDIO3>;
>>> +            drive-strength = <MTK_DRIVE_4mA>;
>>> +            bias-pull-up;
>>> +        };
>>> +    };
>>> +};
>>> +
>>>  &uart0 {
>>>      status = "okay";
>>>  };
>>> diff --git a/arch/arm/boot/dts/mt2701.dtsi
>>> b/arch/arm/boot/dts/mt2701.dtsi
>>> index bdf8954..1eefce4 100644
>>> --- a/arch/arm/boot/dts/mt2701.dtsi
>>> +++ b/arch/arm/boot/dts/mt2701.dtsi
>>> @@ -227,6 +227,18 @@
>>>          status = "disabled";
>>>      };
>>>
>>> +    nor_flash: spi at 11014000 {
>>> +        compatible = "mediatek,mt2701-nor",
>>> +                 "mediatek,mt8173-nor";
>>
>> Why define both here? Is "mediatek,mt8173-nor" really providing a
>> subset of the features supported by "mediatek,mt2701-nor"?
>>
> 
> I think even if the ip block is the same, we should provide both
> bindings, just in case in the future we find out that mt2701 has some
> hidden bug, feature or bug-feature. This way even if we update the
> driver, we stay compatible with older device tree blobs in the wild.
> 
> We can drop the mt2701-nor in the bindings definition if you want.

This exactly. We should have a DT compat in the form:
compatible = "vendor,<soc>-block", "vendor,<oldest-compat-soc>-block";
Then if we find a problem in the future, we can match on the
"vendor,<soc>-block" and still support the old DTs.

The question is, does the "vendor,<soc>-block" go into the binding
document as well or do we only have "vendor,<oldest-compat-soc>-block"
there ?

-- 
Best regards,
Marek Vasut
