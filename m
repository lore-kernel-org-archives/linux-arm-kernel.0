From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 8 Dec 2017 14:16:39 -0800
Subject: [PATCH 2/9] ASoC: sun4i-i2s: Add compatibility with A64 codec I2S
In-Reply-To: <CAEKpxBnG2DXxZ=qMJBPDq5MZzo-eo7-D7n51n0rySDA-Qua9-A@mail.gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-3-anarsoul@gmail.com>
 <CAEKpxBmHhZ+2WNXJEPbQFS6KeKsqRrZeNodRnu1M5yLc15DerA@mail.gmail.com>
 <CA+E=qVd+uM0Aq_=sf+fomQ-m+3Oy0MdG7OPjF5tVagG1UgKYzg@mail.gmail.com>
 <CAEKpxBnWYiSq-Xrzj9MET61kGyVSJZPNnWpDh8jwnmdtw=GKtA@mail.gmail.com>
 <CA+E=qVdcmPpUT0ddjdwY96ORiU5rQvMsYcfsEhOUsYQyKRgbRA@mail.gmail.com>
 <CAEKpxBnG2DXxZ=qMJBPDq5MZzo-eo7-D7n51n0rySDA-Qua9-A@mail.gmail.com>
Message-ID: <CA+E=qVdcAX=Dm0MqwooKHTcZJeB9Do+KDjz4CpZMWxgSydKaKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 7, 2017 at 10:40 PM, Code Kipper <codekipper@gmail.com> wrote:
> On 7 December 2017 at 23:48, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>> On Thu, Dec 7, 2017 at 1:21 AM, Code Kipper <codekipper@gmail.com> wrote:
>>> On 4 December 2017 at 08:34, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>>>> I'd keep it sun50i_a64_acodec_i2s, since other 3 I2S modules aren't
>>>> compatible with this one, but similar to H3.
>>>
>>> Well I wouldn't and the description of it is usage is clearly stated
>>> in the devicetree
>>> for the dai.
>>
>> OK, how would you name 3 other I2S modules that are present in A64?
> https://github.com/codekipper/linux-sunxi/commit/34f37778fbc08247e3bd1556f7ed02303053f5ab
>>
>>>> On Sun, Dec 3, 2017 at 10:42 PM, Code Kipper <codekipper@gmail.com> wrote:
>>>>> On 3 December 2017 at 21:41, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>>>>>> From: Marcus Cooper <codekipper@gmail.com>
>>>>>>
>>>>>> The I2S block used for the audio codec in the A64 is very similar
>>>>>> to what is used by the A10(sun4i) devices. However, its TX FIFO is
>>>>>> located at a different address.
>>>>>>
>>>>>> [vasilykh: - added fixed_wss and wss_value to A64 quirks,
>>>>>>            - changed compatible to 'allwinner,sun50i-a64-acodec-i2s,
>>>>>>              since A64 has 3 more I2S blocks that are not compatible
>>>>>>              with audio codec I2S]
>>> This needs to be investigated more...I'm suspicious of the
>>> SUN8I_I2S_FMT0_LRCK_PERIOD value which is hardcoded to 0x1f.
>>> I've made this following change
>>> https://github.com/codekipper/linux-sunxi/commit/4c5fe5f5576cfbb2e1e94a99cd19dfdc9403ea50
>>> which seems to work for me but I would like to look at it with a logic

I tried this change and now it works fine for me as well without
hardcoded WSS value. So problem was in hardcoded
LRCK period. Are you OK with me submitting this patch as a part of my
A64 audio series?

>>> analyser and test other sample depths.
>>> CK
>>
>> I'm afraid it's not possible to get inside of SoC, since internal I2S
>> pins do not go out. And other 3 I2S modules are different from one for
>> internal codec.
> I just think this needs more of an investigation, I've git a similar patch
> https://github.com/codekipper/linux-sunxi/commit/282d986b6f9ed441ecdc996c6dceed63cbe32652
> which I've not delivered for that very reason.
> CK
>>
>>>>>>
>>>>>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>>>>>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>>>>>> ---
>>>>>>  .../devicetree/bindings/sound/sun4i-i2s.txt        |  2 ++
>>>>>>  sound/soc/sunxi/sun4i-i2s.c                        | 23 ++++++++++++++++++++++
>>>>>>  2 files changed, 25 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>>>>>> index 05d7135a8d2f..ab86f266962a 100644
>>>>>> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>>>>>> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>>>>>> @@ -9,6 +9,7 @@ Required properties:
>>>>>>     - "allwinner,sun4i-a10-i2s"
>>>>>>     - "allwinner,sun6i-a31-i2s"
>>>>>>     - "allwinner,sun8i-h3-i2s"
>>>>>> +   - "allwinner,sun50i-a64-acodec-i2s"
>>>>>>  - reg: physical base address of the controller and length of memory mapped
>>>>>>    region.
>>>>>>  - interrupts: should contain the I2S interrupt.
>>>>>> @@ -24,6 +25,7 @@ Required properties:
>>>>>>  Required properties for the following compatibles:
>>>>>>         - "allwinner,sun6i-a31-i2s"
>>>>>>         - "allwinner,sun8i-h3-i2s"
>>>>>> +       - "allwinner,sun50i-a64-acodec-i2s"
>>>>> I would keep the compatible format the same. ie.
>>>>> allwinner,sun50i-a64-i2s. The A33 for example uses the sun6i-a31-i2s
>>>>> for it's dai.
>>>>>
>>>>>>  - resets: phandle to the reset line for this codec
>>>>>>
>>>>>>  Example:
>>>>>> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
>>>>>> index 54c16eb64713..2c060e015725 100644
>>>>>> --- a/sound/soc/sunxi/sun4i-i2s.c
>>>>>> +++ b/sound/soc/sunxi/sun4i-i2s.c
>>>>>> @@ -942,6 +942,25 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
>>>>>>         .field_rxchansel        = REG_FIELD(SUN8I_I2S_RX_CHAN_SEL_REG, 0, 2),
>>>>>>  };
>>>>>>
>>>>>> +static const struct sun4i_i2s_quirks sun50i_a64_acodec_i2s_quirks = {
>>>>> ditto
>>>>>> +       .has_reset              = true,
>>>>>> +       .reg_offset_txdata      = SUN8I_I2S_FIFO_TX_REG,
>>>>>> +       .sun4i_i2s_regmap       = &sun4i_i2s_regmap_config,
>>>>>> +       .has_slave_select_bit   = true,
>>>>>> +       .fixed_wss              = true,
>>>>>> +       .wss_value              = 3,
>>>>>> +       .field_clkdiv_mclk_en   = REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
>>>>>> +       .field_fmt_wss          = REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
>>>>>> +       .field_fmt_sr           = REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
>>>>>> +       .field_fmt_bclk         = REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
>>>>>> +       .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
>>>>>> +       .field_fmt_mode         = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
>>>>>> +       .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
>>>>>> +       .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
>>>>>> +       .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
>>>>>> +       .field_rxchansel        = REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
>>>>>> +};
>>>>>> +
>>>>>>  static int sun4i_i2s_init_regmap_fields(struct device *dev,
>>>>>>                                         struct sun4i_i2s *i2s)
>>>>>>  {
>>>>>> @@ -1146,6 +1165,10 @@ static const struct of_device_id sun4i_i2s_match[] = {
>>>>>>                 .compatible = "allwinner,sun8i-h3-i2s",
>>>>>>                 .data = &sun8i_h3_i2s_quirks,
>>>>>>         },
>>>>>> +       {
>>>>>> +               .compatible = "allwinner,sun50i-a64-acodec-i2s",
>>>>>> +               .data = &sun50i_a64_acodec_i2s_quirks,
>>>>> ditto
>>>>> BR,
>>>>> CK
>>>>>> +       },
>>>>>>         {}
>>>>>>  };
>>>>>>  MODULE_DEVICE_TABLE(of, sun4i_i2s_match);
>>>>>> --
>>>>>> 2.15.0
>>>>>>
