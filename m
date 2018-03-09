From: balbi@kernel.org (Felipe Balbi)
Date: Fri, 09 Mar 2018 11:04:58 +0200
Subject: [PATCH 2/4] usb: dwc3: add dwc3 glue layer for UniPhier SoCs
In-Reply-To: <CAK7LNARE0YT8HQ-shz=Kg9eaB0pZzaefoqMe-ZnE=eqSQWFp-w@mail.gmail.com>
References: <1516712454-2915-3-git-send-email-hayashi.kunihiko@socionext.com>
 <87o9lklnwb.fsf@linux.intel.com> <20180124215228.ED43.4A936039@socionext.com>
 <87a7x3l8gr.fsf@linux.intel.com>
 <CAK7LNARE0YT8HQ-shz=Kg9eaB0pZzaefoqMe-ZnE=eqSQWFp-w@mail.gmail.com>
Message-ID: <87y3j1aabp.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>>>> > +static void dwc3u_reset_init(struct dwc3u_priv *priv)
>>>> > +{
>>>> > +  dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, 0);
>>>> > +  usleep_range(1000, 2000);
>>>> > +  dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, LINK_RESET);
>>>> > +}
>>>> > +
>>>> > +static void dwc3u_reset_clear(struct dwc3u_priv *priv)
>>>> > +{
>>>> > +  dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, 0);
>>>> > +}
>>>>
>>>> drivers/reset ?
>>>
>>> The reset driver manages "sysctrl" IO map area in our SoC.
>>>
>>> RESET_CTL register belongs to "dwc3-glue" IO map area,
>>> and the kernel can't access this area until enabling usb clocks and
>>> deasserting usb resets in "sysctrl".
>>>
>>> I think that "dwc3-glue" register control should be separated from
>>> "sysctrl".
>>
>> Just split your address space and treat your glue as a device with
>> several children:
>>
>> glue at 65b00000 {
>>         compatible = "foo"
>>
>>         phy at bar {
>>                 ...
>>         };
>>
>>         sysctrl at baz {
>>                 ...
>>         };
>>
>>         dwc3 at foo {
>>                 compatible = "snps, dwc3";
>>                 ...
>>         };
>> };
>>
>> Then you know that you can let dwc3/core.c handle the PHY for you. If we
>> need to teach dwc3/core.c about regulators, we can do that. But we don't
>> need SoC-specific hacks ;-)
>>
>> --
>> balbi
>
>
> Slightly related question.
>
>
> Why don't we put clocks and resets to dwc3/core.c?

We can do that for the simpler platforms, no worries.

> dwc3-of-simple.c only handles clocks and resets.
> This is generic enough to be added to dwc3/core.c, I think.
>
>
> I checked the two instances of dwc3-of-simple.
>
> "qcom,dwc3"
> https://github.com/torvalds/linux/blob/v4.16-rc3/arch/arm64/boot/dts/qcom/msm8996.dtsi#L780
>
> "rockchip,rk3399-dwc3"
> https://github.com/torvalds/linux/blob/v4.16-rc3/arch/arm64/boot/dts/rockchip/rk3399.dtsi#L395
>
>
> They just contain clocks, resets, and "snps,dwc3" sub-node.
>
>
> If we do that,
>
> usb at 7600000 {
>         compatible = "qcom,dwc3";
>         clocks = ...;
>
>         dwc3 at 7600000 {
>                 compatible = "snps,dwc3";
>                 reg = ...;
>                 interrupts = ...;
>                 phys = ...;
>         }
> };
>
>
> will be turned into
>
>
> dwc3 at 7600000 {
>         compatible = "qcom,dwc3", "snps,dwc3";
>         reg = ...;
>         clocks = ...;
>         interrupts = ...;
>         phys = ...;
> };
>
>
> This looks simpler.

yup. This will only work for the simpler platforms, though. TI platforms
and PCI-based platforms, this really won't work :-)

> Also, dwc3/core.c and dwc3-of-simple.c
> duplicate runtime PM.

they "kinda" duplicate :-) Some platforms have platform-specific clocks
which are not generic enough to be stuffed into dwc3/core.c. Some of
those clocks may need special handling of some sorts. It's best to keep
the option for peculiar clock tree setups available.

If your platform is simple enough that you can get away without a glue
layer, sure thing. More power for you :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180309/ad3034ea/attachment-0001.sig>
