From: dongas86@gmail.com (Dong Aisheng)
Date: Thu, 16 Feb 2017 15:51:40 +0800
Subject: [PATCH v2 05/12] Document: dt: binding: imx: update pinctrl doc
 for imx6sll
In-Reply-To: <CACRpkdYUME8K+JusA0ORRKqxyBuhDdyei8eg7UZbHidKw9=bQw@mail.gmail.com>
References: <1482832070-22668-1-git-send-email-ping.bai@nxp.com>
 <1482832070-22668-6-git-send-email-ping.bai@nxp.com>
 <CACRpkdYUME8K+JusA0ORRKqxyBuhDdyei8eg7UZbHidKw9=bQw@mail.gmail.com>
Message-ID: <CAA+hA=TL=Ys6j7YGOofAqrEGBcR15szvx3mMf-Dm03rnEa_VRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Dec 27, 2016 at 8:59 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Dec 27, 2016 at 10:47 AM, Bai Ping <ping.bai@nxp.com> wrote:
>
>> Add pinctrl binding doc update for imx6sll.
>>
>> Signed-off-by: Bai Ping <ping.bai@nxp.com>
>
> I have to push back on this a bit.
>
>> +Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
>> +and usage.
>
> I understand that it is building on top of the old i.MX bindings and that
> it has some kind of "tradition" coming with it.
>
> At the same time, the i.MX bindings came about before we had the
> generic pin control bindings defined.
>
>> +CONFIG bits definition:
>> +PAD_CTL_LVE                    (1 << 22)
>> +PAD_CTL_HYS                     (1 << 16)
>> +PAD_CTL_PUS_100K_DOWN           (0 << 14)
>> +PAD_CTL_PUS_47K_UP              (1 << 14)
>> +PAD_CTL_PUS_100K_UP             (2 << 14)
>> +PAD_CTL_PUS_22K_UP              (3 << 14)
>> +PAD_CTL_PUE                     (1 << 13)
>> +PAD_CTL_PKE                     (1 << 12)
>> +PAD_CTL_ODE                     (1 << 11)
>> +PAD_CTL_SPEED_LOW               (0 << 6)
>> +PAD_CTL_SPEED_MED               (1 << 6)
>> +PAD_CTL_SPEED_HIGH              (3 << 6)
>> +PAD_CTL_DSE_DISABLE             (0 << 3)
>> +PAD_CTL_DSE_260ohm              (1 << 3)
>> +PAD_CTL_DSE_130ohm              (2 << 3)
>> +PAD_CTL_DSE_87ohm               (3 << 3)
>> +PAD_CTL_DSE_65ohm               (4 << 3)
>> +PAD_CTL_DSE_52ohm               (5 << 3)
>> +PAD_CTL_DSE_43ohm               (6 << 3)
>> +PAD_CTL_DSE_37ohm               (7 << 3)
>> +PAD_CTL_SRE_FAST                (1 << 0)
>> +PAD_CTL_SRE_SLOW                (0 << 0)
>
> A whole slew of these if not all correspond to the generic bindings.
>
> I would consider augmenting the code in the driver to handle the generic
> bindings *in addition* to the old legacy bindings, and use those over these
> random custom bits.
>
> Read drivers using CONFIG_GENERIC_PINCONF as an inspiration.
>
> For example see commit
> cefbf1a1b29531a970bc2908a50a75d6474fcc38
> "pinctrl: sunxi: Support generic binding"
> from Maxime Ripard, where he does a similar thing for sunxi.
>

First thanks for your good suggestion!

All we realized that the raw data of IMX pad config in dts is not good.
e.g.
pinctrl_ecspi3: ecspi3grp {
        fsl,pins = <
                MX7D_PAD_SAI2_TX_SYNC__ECSPI3_MISO      0x17059
        .........

I did a deep feasibility analysis these days on the migrating to generic
pinctrl binding you referred. It is regrettably that it may not be so suitable
for IMX to fully migrate right now.

Generic binding only supports parsing strings for pins and function
from dts right now, that means we need back to the old way of hardcoding
all register bits in driver which we actually chose to move out since
the commit "e164153 pinctrl: imx: move hard-coding data into device tree".

And IMX doesn't have PAD GROUP in HW, each pad theoretically can be muxed
as 8 single functions.
e.g.
For IOMUXC_SW_MUX_CTL_PAD_CSI_DATA07
MUX_MODE MUX Mode Select Field.
Select 1 of 8 iomux modes to be used for pad: CSI_DATA07.
000 ALT0 ? Select signal CSI1_DATA09.
001 ALT1 ? Select signal ESAI_TX3_RX2.
010 ALT2 ? Select signal I2C4_SDA.
011 ALT3 ? Select signal KPP_ROW7.
100 ALT4 ? Select signal UART6_CTS_B.
101 ALT5 ? Select signal GPIO1_IO21.
110 ALT6 ? Select signal EIM_DATA16.
111 ALT7 ? Select signal DCIC1_OUT.
By converting to generic binding, we need construct a huge function/group map
in driver for hundreds of pads for each SoC. That is a bit fear to us.

Current IMX method only generates the used function/groups dynamically
by parsing board dts which is much a lighter way.

But of course, we want to fix the raw config value issue as well which is
un-maintainable and un-readable as you pointed out.

I think there might be two options for us to go:
One option is using macro definitions instead of raw data as pinctrl-single
users as OMAP.
e.g.
art2_pins: pinmux_uart2_pins {
        pinctrl-single,pins = <
                OMAP4_IOPAD(0x118, PIN_INPUT_PULLUP | MUX_MODE0)
 /* uart2_cts.uart2_cts */
        ........

For this way, no driver changes required, just replace the raw data by macro
in device tree. But i wonder this may not be your original intention although
it's the easiest way for us.
Anyway, if you agree, we probably would prefer this way.

Another option is partially convert to generic binding for only pad
configuration
part. e.g.
pinctrl_usdhc1: usdhc1grp {
        fsl,pins = <
                MX7D_PAD_SD1_CMD__SD1_CMD
                MX7D_PAD_SD1_CLK__SD1_CLK
                MX7D_PAD_SD1_DATA0__SD1_DATA0
                ...
        >;
        bias-pull-up = <47KOHM>;
        drive-strength = <130OHM>;
        slew-rate = <FAST>;
        speed = <50MHZ>;
        ....
};
(Some of the property still not supported or not the same as generic
binding right now)

This way requires no big drivers changes and only extend the driver
to support the generic pinctrl dt configuration properties.

And it also fix the raw data issues and looks like more applicable than the full
migration.

So would you be willing to accept it?

Another potential benefits for this way is that we may can use PCONFDUMP
to dump a more readable data from pinctrl debug system.

> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards
Dong Aisheng
