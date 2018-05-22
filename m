From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 22 May 2018 23:21:06 +0300
Subject: [patch v21 2/4] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <AM5PR0501MB244981D83DD33BD29FD64924B1940@AM5PR0501MB2449.eurprd05.prod.outlook.com>
References: <1526394095-5069-1-git-send-email-oleksandrs@mellanox.com>
 <1526394095-5069-3-git-send-email-oleksandrs@mellanox.com>
 <CAHp75Ve7EYiWBiE73i0CmyJhPMOdSKsGzCr0SUvta3Uya=Ov1Q@mail.gmail.com>
 <AM5PR0501MB244981D83DD33BD29FD64924B1940@AM5PR0501MB2449.eurprd05.prod.outlook.com>
Message-ID: <CAHp75Vedcsbet3L0p0t5-=J0PmSe26VFXDbcRmk9943D9_FSqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 6:00 PM, Oleksandr Shamray
<oleksandrs@mellanox.com> wrote:


> Ok. Changed to:
> #define ASPEED_JTAG_IOUT_LEN(len) \
>                                (ASPEED_JTAG_CTL_ENG_EN | \
>                                ASPEED_JTAG_CTL_ENG_OUT_EN | \
>                                ASPEED_JTAG_CTL_INST_LEN(len))
>
> #define ASPEED_JTAG_DOUT_LEN(len) \
>                                (ASPEED_JTAG_CTL_ENG_EN | \
>                                ASPEED_JTAG_CTL_ENG_OUT_EN | \
>                                ASPEED_JTAG_CTL_DATA_LEN(len))

What about

#define _JTAG_OUT_ENABLE \
( _ENG_EN | _ENG_OUT_EN)

#define _IOUT_LEN(len) \
 (_ENABLE | _INST_LEN(len))

#define _DOUT_LEN(len) \
...

?

>> > +       apb_frq = clk_get_rate(aspeed_jtag->pclk);
>>
>> > +       div = (apb_frq % freq == 0) ? (apb_frq / freq) - 1 :
>> > + (apb_frq / freq);
>>
>> Isn't it the same as
>>
>> div = (apb_frq - 1) / freq;
>>
>> ?

> Seems it is same. Thanks.

Though be careful if apb_frq == 0.
In either case the hw will be screwed, but differently.

>> > +       if (xfer->direction == JTAG_READ_XFER)
>> > +               tdi = UINT_MAX;
>> > +       else
>> > +               tdi = data[index];
>>
>> > +                       if (xfer->direction == JTAG_READ_XFER)
>> > +                               tdi = UINT_MAX;
>> > +                       else
>> > +                               tdi = data[index];
>>
>> Take your time to think how the above duplication can be avoided.
>>
>
> In both cases data[] is different, so I should check it twice, but I will
> change it to, macro like:
>
> #define ASPEED_JTAG_GET_TDI(direction, data) \
>                               (direction == JTAG_READ_XFER) ? UNIT_MAX : data

Perhaps choose better name for data, b/c in the above you are using data[index].

>> > +               dev_err(aspeed_jtag->dev, "irq status:%x\n",
>> > +                       status);

>> Huh, really?! SPAM.

> I will review and delete redundant debug messages.

Just to be sure you got a point. This is interrupt context. Imagine
what might go wrong.


>> > +       err = jtag_register(jtag);
>>
>> Perhaps we might have devm_ variant of this. Check how SPI framework
>> deal with a such.
>>
>
> Jtag driver uses miscdevice and related  misc_register and misc_deregister
> calls for creation and destruction. There is no device object prior
> to call to misc_register, which could be used in devm_jtag_register.

Same question as per previous patch.

-- 
With Best Regards,
Andy Shevchenko
