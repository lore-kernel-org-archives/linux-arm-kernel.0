From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 15 Mar 2017 22:05:21 +0800
Subject: [PATCH v2 05/12] Document: dt: binding: imx: update pinctrl doc
 for imx6sll
In-Reply-To: <CACRpkdaLq125bKQcpHeFn312omxw9jp0VHr9DVanj42Y_29+mg@mail.gmail.com>
References: <1482832070-22668-1-git-send-email-ping.bai@nxp.com>
 <1482832070-22668-6-git-send-email-ping.bai@nxp.com>
 <CACRpkdYUME8K+JusA0ORRKqxyBuhDdyei8eg7UZbHidKw9=bQw@mail.gmail.com>
 <CAA+hA=TL=Ys6j7YGOofAqrEGBcR15szvx3mMf-Dm03rnEa_VRA@mail.gmail.com>
 <CACRpkdaLq125bKQcpHeFn312omxw9jp0VHr9DVanj42Y_29+mg@mail.gmail.com>
Message-ID: <CAA+hA=Rtw-4-SCf8svFq3E9TKv3zBD9T=nPhF7=3qEoH9k4wsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Mar 14, 2017 at 9:54 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Feb 16, 2017 at 8:51 AM, Dong Aisheng <dongas86@gmail.com> wrote:
>> On Tue, Dec 27, 2016 at 8:59 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>>> I would consider augmenting the code in the driver to handle the generic
>>> bindings *in addition* to the old legacy bindings, and use those over these
>>> random custom bits.
> (...)
>> Generic binding only supports parsing strings for pins and function
>> from dts right now, that means we need back to the old way of hardcoding
>> all register bits in driver which we actually chose to move out since
>> the commit "e164153 pinctrl: imx: move hard-coding data into device tree".
>
> Aha I see.
>
>> One option is using macro definitions instead of raw data as pinctrl-single
>> users as OMAP.
>> e.g.
>> art2_pins: pinmux_uart2_pins {
>>         pinctrl-single,pins = <
>>                 OMAP4_IOPAD(0x118, PIN_INPUT_PULLUP | MUX_MODE0)
>>  /* uart2_cts.uart2_cts */
>>         ........
>>
>> For this way, no driver changes required, just replace the raw data by macro
>> in device tree. But i wonder this may not be your original intention although
>> it's the easiest way for us.
>> Anyway, if you agree, we probably would prefer this way.
>
> That make it look better than it looks today, but...
>
>> Another option is partially convert to generic binding for only pad
>> configuration
>> part. e.g.
>> pinctrl_usdhc1: usdhc1grp {
>>         fsl,pins = <
>>                 MX7D_PAD_SD1_CMD__SD1_CMD
>>                 MX7D_PAD_SD1_CLK__SD1_CLK
>>                 MX7D_PAD_SD1_DATA0__SD1_DATA0
>>                 ...
>>         >;
>>         bias-pull-up = <47KOHM>;
>>         drive-strength = <130OHM>;
>>         slew-rate = <FAST>;
>>         speed = <50MHZ>;
>>         ....
>> };
>> (Some of the property still not supported or not the same as generic
>> binding right now)
>
> This looks totally awesome, so if you could do this, it would be even
> better.
>
>> This way requires no big drivers changes and only extend the driver
>> to support the generic pinctrl dt configuration properties.
>
> Yep, you should be able to support both the old and the new
> way of configuring the pins this way I guess.
>
>> And it also fix the raw data issues and looks like more applicable than the full
>> migration.
>>
>> So would you be willing to accept it?
>
> Anything that move us closer to the generic bindings will be accepted.
>

It's good to get an alignment with you.
We will start to do that.

Thanks

Regards
Dong Aisheng
