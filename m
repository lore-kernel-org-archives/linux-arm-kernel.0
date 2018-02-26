From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 26 Feb 2018 23:48:53 +0900
Subject: [PATCH 2/4] usb: dwc3: add dwc3 glue layer for UniPhier SoCs
In-Reply-To: <87a7x3l8gr.fsf@linux.intel.com>
References: <1516712454-2915-3-git-send-email-hayashi.kunihiko@socionext.com>
 <87o9lklnwb.fsf@linux.intel.com> <20180124215228.ED43.4A936039@socionext.com>
 <87a7x3l8gr.fsf@linux.intel.com>
Message-ID: <CAK7LNARE0YT8HQ-shz=Kg9eaB0pZzaefoqMe-ZnE=eqSQWFp-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,


2018-01-24 21:58 GMT+09:00 Felipe Balbi <balbi@kernel.org>:
>
> Hi,
>
> Kunihiko Hayashi <hayashi.kunihiko@socionext.com> writes:
>> Hello Felipe,
>>
>> Thank you for your comments.
>>
>> On Tue, 23 Jan 2018 15:12:36 +0200 <balbi@kernel.org> wrote:
>>
>>>
>>> Hi,
>>>
>>> Kunihiko Hayashi <hayashi.kunihiko@socionext.com> writes:
>>> > Add a specific glue layer for UniPhier SoC platform to support
>>> > USB host mode. It manages hardware operating sequences to enable multiple
>>> > clock gates and assert resets, and to prepare to use dwc3 controller
>>> > on the SoC.
>>> >
>>> > This patch also handles the physical layer that has same register space
>>> > as the glue layer, because it needs to integrate initialziation sequence
>>> > between glue and phy.
>>> >
>>> > In case of some SoCs, since some initialization values for PHY are
>>> > included in nvmem, this patch includes the way to get the values from nvmem.
>>> >
>>> > It supports PXs2 and LD20 SoCs.
>>> >
>>> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>> > Signed-off-by: Motoya Tanigawa <tanigawa.motoya@socionext.com>
>>> > Signed-off-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>
>>> > ---
>>> >  drivers/usb/dwc3/Kconfig         |   9 +
>>> >  drivers/usb/dwc3/Makefile        |   1 +
>>> >  drivers/usb/dwc3/dwc3-uniphier.c | 554 +++++++++++++++++++++++++++++++++++++++
>>> >  3 files changed, 564 insertions(+)
>>> >  create mode 100644 drivers/usb/dwc3/dwc3-uniphier.c
>>
>> ...snip...
>>
>>> > +
>>> > +static void dwc3u_ssphy_testio_write(struct dwc3u_priv *priv, int port,
>>> > +                               u32 data)
>>>
>>> anything with sshphy or hsphy in the name should probably be part of a
>>> PHY driver using drivers/phy/ framework.
>>
>> I can try to separate phy control from this driver.
>> However, phy registers belongs to "dwc3-glue" IO map area (65b00000),
>> and this area also contains a reset bit for "dwc3-core" hardware.
>>
>> Although the phy driver is called from dwc3-core driver,
>> we need to deassert the reset bit before probing dwc3-core driver.
>>
>> As shown later, I think that it's difficut to determine the order of
>> initializing the registers in this area.
>>
>>> > +static void dwc3u_vbus_disable(struct dwc3u_priv *priv)
>>> > +{
>>> > +  int i;
>>> > +
>>> > +  for (i = 0; i < priv->nvbus; i++) {
>>> > +          dwc3u_maskwrite(priv, VBUS_CONTROL(i),
>>> > +                          DRVVBUS_REG_EN | DRVVBUS_REG,
>>> > +                          DRVVBUS_REG_EN | 0);
>>> > +  }
>>> > +}
>>>
>>> drivers/regulator maybe?
>>
>> VBUS_CONTROL register is used for determing whether "dwc3-glue" hardware
>> enables vbus connected with "regulator" hardware.
>>
>> The regulator driver should manage "regulator" hardware, and
>> I don't think that the driver should manage this register.
>>
>>> > +static void dwc3u_reset_init(struct dwc3u_priv *priv)
>>> > +{
>>> > +  dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, 0);
>>> > +  usleep_range(1000, 2000);
>>> > +  dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, LINK_RESET);
>>> > +}
>>> > +
>>> > +static void dwc3u_reset_clear(struct dwc3u_priv *priv)
>>> > +{
>>> > +  dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, 0);
>>> > +}
>>>
>>> drivers/reset ?
>>
>> The reset driver manages "sysctrl" IO map area in our SoC.
>>
>> RESET_CTL register belongs to "dwc3-glue" IO map area,
>> and the kernel can't access this area until enabling usb clocks and
>> deasserting usb resets in "sysctrl".
>>
>> I think that "dwc3-glue" register control should be separated from
>> "sysctrl".
>
> Just split your address space and treat your glue as a device with
> several children:
>
> glue at 65b00000 {
>         compatible = "foo"
>
>         phy at bar {
>                 ...
>         };
>
>         sysctrl at baz {
>                 ...
>         };
>
>         dwc3 at foo {
>                 compatible = "snps, dwc3";
>                 ...
>         };
> };
>
> Then you know that you can let dwc3/core.c handle the PHY for you. If we
> need to teach dwc3/core.c about regulators, we can do that. But we don't
> need SoC-specific hacks ;-)
>
> --
> balbi


Slightly related question.


Why don't we put clocks and resets to dwc3/core.c?

dwc3-of-simple.c only handles clocks and resets.
This is generic enough to be added to dwc3/core.c, I think.


I checked the two instances of dwc3-of-simple.

"qcom,dwc3"
https://github.com/torvalds/linux/blob/v4.16-rc3/arch/arm64/boot/dts/qcom/msm8996.dtsi#L780

"rockchip,rk3399-dwc3"
https://github.com/torvalds/linux/blob/v4.16-rc3/arch/arm64/boot/dts/rockchip/rk3399.dtsi#L395


They just contain clocks, resets, and "snps,dwc3" sub-node.


If we do that,

usb at 7600000 {
        compatible = "qcom,dwc3";
        clocks = ...;

        dwc3 at 7600000 {
                compatible = "snps,dwc3";
                reg = ...;
                interrupts = ...;
                phys = ...;
        }
};


will be turned into


dwc3 at 7600000 {
        compatible = "qcom,dwc3", "snps,dwc3";
        reg = ...;
        clocks = ...;
        interrupts = ...;
        phys = ...;
};


This looks simpler.




Also, dwc3/core.c and dwc3-of-simple.c
duplicate runtime PM.



-- 
Best Regards
Masahiro Yamada
