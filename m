From: net147@gmail.com (Jonathan Liu)
Date: Wed, 21 Jun 2017 19:12:07 +1000
Subject: [PATCH v2] drm/sun4i: hdmi: Implement I2C adapter for A10s DDC bus
In-Reply-To: <20170621084128.6745bs6irwmccbx6@flea.lan>
References: <20170612055235.31019-1-net147@gmail.com>
 <20170613111505.afyh4iotxdz5kceh@flea.lan>
 <CANwerB0eXxAwihwt-xZuUm6DD6JSJt8nQdyxnp5TVYyU1yf9xA@mail.gmail.com>
 <20170621084128.6745bs6irwmccbx6@flea.lan>
Message-ID: <CANwerB1VVx--r9xqJUokhBkL8Z3pvM_LRX7Lqsv01ine-x_VPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 21 June 2017 at 18:41, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Jun 13, 2017 at 09:53:31PM +1000, Jonathan Liu wrote:
>> >> --- /dev/null
>> >> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
>> >> @@ -0,0 +1,163 @@
>> >> +/*
>> >> + * Copyright (C) 2017 Jonathan Liu
>> >> + *
>> >> + * Jonathan Liu <net147@gmail.com>
>> >
>> > Is it?
>>
>> I could add you to the copyright since you did the old one. But the
>> implementation is different.
>> I intend to rework this I2C driver to use the FIFO more to avoid
>> splitting larger transfers > 16 bytes and do the transfer in a single
>> command. Would you like to be added to the copyright?
>
> You took some code that you didn't create, and added some more
> stuff. The copyright on the initial code remains, and it has nothing
> to do with whether the author wants it or not, (s)he should be
> mentionned, along with you of course.
>
I will update the copyright header accordingly.

>> >> +            ? SUN4I_HDMI_DDC_CMD_IMPLICIT_READ
>> >> +            : SUN4I_HDMI_DDC_CMD_IMPLICIT_WRITE,
>> >> +            hdmi->base + SUN4I_HDMI_DDC_CMD_REG);
>> >> +
>> >> +     reg = readl(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> >> +     writel(reg | SUN4I_HDMI_DDC_CTRL_START_CMD,
>> >> +            hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> >> +
>> >> +     if (!(msg->flags & I2C_M_RD)) {
>> >> +             for (i = 0; i < count; i++) {
>> >> +                     writeb(*msg->buf++, hdmi->base
>> >> +                            + SUN4I_HDMI_DDC_FIFO_DATA_REG);
>> >
>> > writesb?
>> I intend to rework the FIFO handling so will need to continue using writeb.
>
> Then you'll change it when you'll rework it. Before then, you can use
> writesb.
>
I have already reworked it in V3.

>> >
>> >> +                     --msg->len;
>> >> +             }
>> >> +     }
>> >> +
>> >> +     if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG,
>> >> +                            reg,
>> >> +                            !(reg & SUN4I_HDMI_DDC_CTRL_START_CMD),
>> >> +                            100, 100000))
>> >> +             return -EIO;
>> >> +
>> >> +     reg = readl(hdmi->base + SUN4I_HDMI_DDC_INTERRUPT_STATUS_REG);
>> >> +     reg &= ~SUN4I_HDMI_DDC_INTERRUPT_STATUS_FIFO_REQUEST;
>> I want to check all the other bits that are set if there are errors.
>
> Same thing here: you'll change it when that happens.
I have already reworked it in V3.

>
>> >
>> > You don't need to use that mask.
>> >
>> >> +     if (reg != SUN4I_HDMI_DDC_INTERRUPT_STATUS_TRANSFER_COMPLETE)
>> >> +             return -EIO;
>> >
>> > !(reg & SUN4I_HDMI_DDC_INTERRUPT_STATUS_TRANSFER_COMPLETE) would be enough.
>> I want to check all the other bits that are set if there are errors.
>
> Same thing here.
I have already reworked it in V3.

>
>> >
>> >> +
>> >> +     if (msg->flags & I2C_M_RD) {
>> >> +             for (i = 0; i < count; i++) {
>> >> +                     *msg->buf++ = readb(hdmi->base
>> >> +                                         + SUN4I_HDMI_DDC_FIFO_DATA_REG);
>> >
>> > readsb ?
>> I am reworking the FIFO handling so I will need to continue to use readb.
>
> Same thing here.
I have already reworked it in V3.

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

Regards,
Jonathan
