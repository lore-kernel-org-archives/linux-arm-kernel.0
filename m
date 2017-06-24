From: net147@gmail.com (Jonathan Liu)
Date: Sat, 24 Jun 2017 15:59:37 +1000
Subject: [PATCH v3] drm/sun4i: hdmi: Implement I2C adapter for A10s DDC bus
In-Reply-To: <20170621212616.uzmxspziaknxs2ju@flea.lan>
References: <20170614152933.19482-1-net147@gmail.com>
 <20170621085159.6atrdspsqgus63an@flea.lan>
 <CANwerB0GY0g5fCg3q4_7s2GJv3Zb1Wyd=xAOsh5qqa7reanvjA@mail.gmail.com>
 <20170621212616.uzmxspziaknxs2ju@flea.lan>
Message-ID: <CANwerB2wvRp+6ej=9nACaWKowUFkfV037jTuxYpBLzxA7M1V3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 22 June 2017 at 07:26, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Jun 21, 2017 at 07:42:47PM +1000, Jonathan Liu wrote:
>> >> +static int wait_fifo_flag_unset(struct sun4i_hdmi *hdmi, u32 flag)
>> >> +{
>> >> +     /* 1 byte takes 9 clock cycles (8 bits + 1 ack) */
>> >> +     unsigned long byte_time = DIV_ROUND_UP(USEC_PER_SEC,
>> >> +                                            clk_get_rate(hdmi->ddc_clk)) * 9;
>> >> +     ktime_t wait_timeout = ktime_add_us(ktime_get(), 100000);
>> >> +     u32 reg;
>> >> +
>> >> +     for (;;) {
>> >> +             /* Check for errors */
>> >> +             reg = readl(hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG);
>> >> +             if (reg & SUN4I_HDMI_DDC_INT_STATUS_ERROR_MASK) {
>> >> +                     writel(reg, hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG);
>> >> +                     return -EIO;
>> >> +             }
>> >> +
>> >> +             /* Check if requested FIFO flag is unset */
>> >> +             reg = readl(hdmi->base + SUN4I_HDMI_DDC_FIFO_STATUS_REG);
>> >> +             if (!(reg & flag))
>> >> +                     return 0;
>> >> +
>> >> +             /* Timeout */
>> >> +             if (ktime_compare(ktime_get(), wait_timeout) > 0)
>> >> +                     return -EIO;
>> >> +
>> >> +             /* Wait for 1-2 bytes to transfer */
>> >> +             usleep_range(byte_time, 2 * byte_time);
>> >> +     }
>> >> +
>> >> +     return -EIO;
>> >> +}
>> >> +
>> >> +static int wait_fifo_read_ready(struct sun4i_hdmi *hdmi)
>> >> +{
>> >> +     return wait_fifo_flag_unset(hdmi, SUN4I_HDMI_DDC_FIFO_STATUS_EMPTY);
>> >> +}
>> >> +
>> >> +static int wait_fifo_write_ready(struct sun4i_hdmi *hdmi)
>> >> +{
>> >> +     return wait_fifo_flag_unset(hdmi, SUN4I_HDMI_DDC_FIFO_STATUS_FULL);
>> >> +}
>> >
>> > Both of these can use readl_poll_timeout, and I'm not sure you need to
>> > be that aggressive in your timings.
>> >
>> I have set my timings to minimize communication delays - e.g. when
>> userspace is reading from I2C one byte at a time (like i2cdump from
>> i2c-tools).
>
> I wouldn't try to optimise that too much. There's already a lot of
> overhead, it's way inefficient, and it's not really a significant use
> case anyway.
>

Ok.

>> readl_poll_timeout can't be used to check 2 registers at
>> once and I couldn't get DDC_FIFO_Request_Interrupt_Status_Bit in
>> DDC_Int_Status register to behave properly.
>
> Can't you just use readl_poll_timeout, and then if it timed out check
> for errors?
>

I think it is more flexible this way as I can adjust the usleep_range min.

>> I also wanted to minimize the chance of FIFO underrun/overrun.
>>
>> >> +
>> >> +static int xfer_msg(struct sun4i_hdmi *hdmi, struct i2c_msg *msg)
>> >> +{
>> >> +     u32 reg;
>> >> +     int i;
>> >> +
>> >> +     reg = readl(hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG);
>> >> +     reg &= ~SUN4I_HDMI_DDC_INT_STATUS_ERROR_MASK;
>> >> +     writel(reg, hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG);
>> >> +
>> >> +     reg = readl(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> >> +     reg &= ~SUN4I_HDMI_DDC_CTRL_FIFO_DIR_MASK;
>> >> +     reg |= (msg->flags & I2C_M_RD) ?
>> >> +            SUN4I_HDMI_DDC_CTRL_FIFO_DIR_READ :
>> >> +            SUN4I_HDMI_DDC_CTRL_FIFO_DIR_WRITE;
>> >> +     writel(reg, hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> >> +
>> >> +     writel(SUN4I_HDMI_DDC_ADDR_SLAVE(msg->addr),
>> >> +            hdmi->base + SUN4I_HDMI_DDC_ADDR_REG);
>> >> +
>> >> +     reg = readl(hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG);
>> >> +     writel(reg | SUN4I_HDMI_DDC_FIFO_CTRL_CLEAR,
>> >> +            hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG);
>> >> +
>> >> +     if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG,
>> >> +                            reg,
>> >> +                            !(reg & SUN4I_HDMI_DDC_FIFO_CTRL_CLEAR),
>> >> +                            100, 100000))
>> >> +             return -EIO;
>> >> +
>> >> +     writel(msg->len, hdmi->base + SUN4I_HDMI_DDC_BYTE_COUNT_REG);
>> >> +     writel(msg->flags & I2C_M_RD ?
>> >> +            SUN4I_HDMI_DDC_CMD_IMPLICIT_READ :
>> >> +            SUN4I_HDMI_DDC_CMD_IMPLICIT_WRITE,
>> >> +            hdmi->base + SUN4I_HDMI_DDC_CMD_REG);
>> >> +
>> >> +     reg = readl(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> >> +     writel(reg | SUN4I_HDMI_DDC_CTRL_START_CMD,
>> >> +            hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> >> +
>> >> +     if (msg->flags & I2C_M_RD) {
>> >> +             for (i = 0; i < msg->len; i++) {
>> >> +                     if (wait_fifo_read_ready(hdmi))
>> >> +                             return -EIO;
>> >
>> > it seems weird that a function called read_ready would return 1 if
>> > there's an error.
>>
>> I will change this so wait_fifo_flag_unset returns false on error
>> and true on success. Then the wait_fifo_read_ready and
>> wait_fifo_write_ready conditions will be inverted.
>
> Or just invert the return value, whatever makes sense
>

This will actually be different as I will rework it to use FIFO_LEVEL.

>> >
>> >> +
>> >> +                     *msg->buf++ = readb(hdmi->base +
>> >> +                                         SUN4I_HDMI_DDC_FIFO_DATA_REG);
>> >
>> > Don't you have an hardware FIFO you can rely on intead of reading
>> > everything byte per byte?
>> >
>> Hardware FIFO by nature is transferring one byte at a time. This is my
>> first kernel driver so I still have a lot to learn. In the future it
>> can be improved by using DMA and interrupts.
>
> Yes, you can read one byte at a time, but you don't need to check
> whether you're ready each byte you're reading. Can't you use
> FIFO_LEVEL or the byte counter to read the number of bytes you need to
> read in a single shot ?
>

Ok. I will check FIFO_LEVEL and change readb/writeb to readsb/writesb.

>> >> +             }
>> >> +     } else {
>> >> +             for (i = 0; i < msg->len; i++) {
>> >> +                     if (wait_fifo_write_ready(hdmi))
>> >> +                             return -EIO;
>> >> +
>> >> +                     writeb(*msg->buf++, hdmi->base +
>> >> +                            SUN4I_HDMI_DDC_FIFO_DATA_REG);
>> >> +             }
>> >> +     }
>> >> +
>> >> +     if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG,
>> >> +                            reg,
>> >> +                            !(reg & SUN4I_HDMI_DDC_CTRL_START_CMD),
>> >> +                            100, 100000))
>> >> +             return -EIO;
>> >> +
>> >> +     reg = readl(hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG);
>> >> +
>> >> +     /* Check for errors */
>> >> +     if ((reg & SUN4I_HDMI_DDC_INT_STATUS_ERROR_MASK) ||
>> >> +         !(reg & SUN4I_HDMI_DDC_INT_STATUS_TRANSFER_COMPLETE)) {
>> >> +             writel(reg, hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG);
>> >> +             return -EIO;
>> >> +     }
>> >> +
>> >> +     return 0;
>> >> +}
>> >> +
>> >> +static int sun4i_hdmi_i2c_xfer(struct i2c_adapter *adap,
>> >> +                            struct i2c_msg *msgs, int num)
>> >> +{
>> >> +     struct sun4i_hdmi *hdmi = i2c_get_adapdata(adap);
>> >> +     u32 reg;
>> >> +     int err, i, ret = num;
>> >> +
>> >> +     for (i = 0; i < num; i++) {
>> >> +             if (!msgs[i].len)
>> >> +                     return -EINVAL;
>> >> +             if (msgs[i].len > SUN4I_HDMI_DDC_MAX_TRANSFER_SIZE)
>> >> +                     return -EINVAL;
>> >> +     }
>> >> +
>> >> +     /* Reset I2C controller */
>> >> +     writel(SUN4I_HDMI_DDC_CTRL_ENABLE | SUN4I_HDMI_DDC_CTRL_RESET,
>> >> +            hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> >> +     if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG, reg,
>> >> +                            !(reg & SUN4I_HDMI_DDC_CTRL_RESET),
>> >> +                            100, 2000))
>> >> +             return -EIO;
>> >> +
>> >> +     writel(SUN4I_HDMI_DDC_LINE_CTRL_SDA_ENABLE |
>> >> +            SUN4I_HDMI_DDC_LINE_CTRL_SCL_ENABLE,
>> >> +            hdmi->base + SUN4I_HDMI_DDC_LINE_CTRL_REG);
>> >> +
>> >> +     clk_prepare_enable(hdmi->ddc_clk);
>> >> +     clk_set_rate(hdmi->ddc_clk, 100000);
>> >> +
>> >> +     for (i = 0; i < num; i++) {
>> >> +             err = xfer_msg(hdmi, &msgs[i]);
>> >> +             if (err) {
>> >> +                     ret = err;
>> >> +                     break;
>> >> +             }
>> >> +     }
>> >> +
>> >> +     clk_disable_unprepare(hdmi->ddc_clk);
>> >> +     return ret;
>> >> +}
>> >> +
>> >> +static u32 sun4i_hdmi_i2c_func(struct i2c_adapter *adap)
>> >> +{
>> >> +     return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>> >> +}
>> >> +
>> >> +static const struct i2c_algorithm sun4i_hdmi_i2c_algorithm = {
>> >> +     .master_xfer    = sun4i_hdmi_i2c_xfer,
>> >> +     .functionality  = sun4i_hdmi_i2c_func,
>> >> +};
>> >> +
>> >> +static struct i2c_adapter sun4i_hdmi_i2c_adapter = {
>> >> +     .owner  = THIS_MODULE,
>> >> +     .class  = I2C_CLASS_DDC,
>> >> +     .algo   = &sun4i_hdmi_i2c_algorithm,
>> >> +     .name   = "sun4i_hdmi_i2c adapter",
>> >> +};
>> >
>> > const?
>>
>> i2c_add_adapter and i2c_del_adapter take "struct i2c_adapter *adapter"
>> argument so I can't make it const.
>
> Ah, right, they modify it. You can't allocate it statically then,
> otherwise if you get two instances, they'll both step on each other's
> toe.
>

I will make it const and use devm_kmemdup.

> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

Regards,
Jonathan
