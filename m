From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 11 Jan 2017 16:39:40 +0100
Subject: [PATCH v8 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <CAOAejn2eOy2sn1VkE979ne23Sj9L6+kaQDNpL1EUKb2m=6sGXw@mail.gmail.com>
References: <1483607246-14771-1-git-send-email-cedric.madianga@gmail.com>
 <1483607246-14771-3-git-send-email-cedric.madianga@gmail.com>
 <20170111082208.vzu7xgpd4eakyldl@pengutronix.de>
 <CAOAejn2eOy2sn1VkE979ne23Sj9L6+kaQDNpL1EUKb2m=6sGXw@mail.gmail.com>
Message-ID: <20170111153940.dtxzvtdici3r7l54@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 02:58:44PM +0100, M'boumba Cedric Madianga wrote:
> Hi Uwe,
> 
> 2017-01-11 9:22 GMT+01:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hello Cedric,
> >
> > On Thu, Jan 05, 2017 at 10:07:23AM +0100, M'boumba Cedric Madianga wrote:
> >> +/*
> >> + * In standard mode:
> >> + * SCL period = SCL high period = SCL low period = CCR * I2C parent clk period
> >> + *
> >> + * In fast mode:
> >> + * If Duty = 0; SCL high period = 1  * CCR * I2C parent clk period
                                         ^^
> >> + *           SCL low period  = 2  * CCR * I2C parent clk period
                                      ^^
> >> + * If Duty = 1; SCL high period = 9  * CCR * I2C parent clk period
                                         ^^
> >> + *           SCL low period  = 16 * CCR * I2C parent clk period

> > s/  \*/ */ several times
> 
> Sorry but I don't see where is the issue as the style for multi-line
> comments seems ok.
> Could you please clarify that point if possible ? Thanks in advance

There are several places with double spaces before * marked above.

> >> + * In order to reach 400 kHz with lower I2C parent clk frequencies we always set
> >> + * Duty = 1
> >> + *
> >> + * For both modes, we have CCR = SCL period * I2C parent clk frequency
> >> + * with scl_period = 5 microseconds in Standard mode and scl_period = 1
> > s/mode/Mode/
> 
> ok thanks
> 
> >
> >> + * microsecond in Fast Mode in order to satisfy scl_high and scl_low periods
> >> + * constraints defined by i2c bus specification
> >
> > I don't understand scl_period = 1 ?s for Fast Mode. For a bus freqency
> > of 400 kHz we need low + high = 2.5 ?s. Is there a factor 10 missing
> > somewhere?
> 
> As CCR = SCL_period * I2C parent clk frequency with minimal freq =
> 2Mhz and SCL_period = 1 we have:
> CCR = 1 * 2Mhz = 2.
> But to compute, scl_low and scl_high in Fast mode, we have to do the
> following thing as Duty=1:
> scl_high = 9 * CCR * I2C parent clk period
> scl_low = 16 * CCR * I2C parent clk period
> In our example:
> scl_high = 9 * 2 * 0,0000005 = 0,000009 sec = 9 ?s
> scl_low = 16 * 2 * 0.0000005 = 0,000016 sec = 16 ?s
> So low + high = 27 ?s > 2,5 ?s

For me 9 ?s + 16 ?s is 25 ?s, resulting in 40 kHz. That's why I wondered
if there is a factor 10 missing somewhere.

> >> + */
> >> +static struct stm32f4_i2c_timings i2c_timings[] = {
> >> [...]
> >> +
> >> +/**
> >> + * stm32f4_i2c_hw_config() - Prepare I2C block
> >> + * @i2c_dev: Controller's private data
> >> + */
> >> +static int stm32f4_i2c_hw_config(struct stm32f4_i2c_dev *i2c_dev)
> >> +{
> >> +     void __iomem *reg = i2c_dev->base + STM32F4_I2C_CR1;
> >> +     int ret = 0;
> >> +
> >> +     /* Disable I2C */
> >> +     stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_PE);
> >> +
> >> +     ret = stm32f4_i2c_set_periph_clk_freq(i2c_dev);
> >> +     if (ret)
> >> +             return ret;
> >> +
> >> +     stm32f4_i2c_set_rise_time(i2c_dev);
> >> +
> >> +     stm32f4_i2c_set_speed_mode(i2c_dev);
> >> +
> >> +     stm32f4_i2c_set_filter(i2c_dev);
> >> +
> >> +     /* Enable I2C */
> >> +     stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_PE);
> >
> > This function is called after a hw reset, so there should be no need to
> > use clr_bits and set_bits because the value read from hw should be
> > known.
> 
> ok thanks
> 
> >
> >> +     return ret;
> >
> > return 0;
> 
> ok thanks
> 
> >
> >> +}
> >> +
> >> +static int stm32f4_i2c_wait_free_bus(struct stm32f4_i2c_dev *i2c_dev)
> >> +{
> >> +     u32 status;
> >> +     int ret;
> >> +
> >> +     ret = readl_relaxed_poll_timeout(i2c_dev->base + STM32F4_I2C_SR2,
> >> +                                      status,
> >> +                                      !(status & STM32F4_I2C_SR2_BUSY),
> >> +                                      10, 1000);
> >> +     if (ret) {
> >> +             dev_dbg(i2c_dev->dev, "bus not free\n");
> >> +             ret = -EBUSY;
> >> +     }
> >> +
> >> +     return ret;
> >> +}
> >> +
> >> +/**
> >> + * stm32f4_i2c_write_ byte() - Write a byte in the data register
> >> + * @i2c_dev: Controller's private data
> >> + * @byte: Data to write in the register
> >> + */
> >> +static void stm32f4_i2c_write_byte(struct stm32f4_i2c_dev *i2c_dev, u8 byte)
> >> +{
> >> +     writel_relaxed(byte, i2c_dev->base + STM32F4_I2C_DR);
> >> +}
> >> +
> >> +/**
> >> + * stm32f4_i2c_write_msg() - Fill the data register in write mode
> >> + * @i2c_dev: Controller's private data
> >> + *
> >> + * This function fills the data register with I2C transfer buffer
> >> + */
> >> +static void stm32f4_i2c_write_msg(struct stm32f4_i2c_dev *i2c_dev)
> >> +{
> >> +     struct stm32f4_i2c_msg *msg = &i2c_dev->msg;
> >> +
> >> +     stm32f4_i2c_write_byte(i2c_dev, *msg->buf++);
> >> +     msg->count--;
> >> +}
> >> +
> >> +static void stm32f4_i2c_read_msg(struct stm32f4_i2c_dev *i2c_dev)
> >> +{
> >> +     struct stm32f4_i2c_msg *msg = &i2c_dev->msg;
> >> +     u32 rbuf;
> >> +
> >> +     rbuf = readl_relaxed(i2c_dev->base + STM32F4_I2C_DR);
> >> +     *msg->buf++ = rbuf & 0xff;
> >
> > This is unnecessary. buf has an 8 bit wide type so
> >
> >         *msg->buf++ = rbuf;
> >
> > has the same effect. (ISTR this is something I already pointed out
> > earlier?)
> 
> Yes you are right.
> 
> >
> >> +     msg->count--;
> >> +}
> >> +
> >> +static void stm32f4_i2c_terminate_xfer(struct stm32f4_i2c_dev *i2c_dev)
> >> +{
> >> +     struct stm32f4_i2c_msg *msg = &i2c_dev->msg;
> >> +     void __iomem *reg = i2c_dev->base + STM32F4_I2C_CR2;
> >> +
> >> +     stm32f4_i2c_disable_irq(i2c_dev);
> >> +
> >> +     reg = i2c_dev->base + STM32F4_I2C_CR1;
> >> +     if (msg->stop)
> >> +             stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_STOP);
> >> +     else
> >> +             stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_START);
> >> +
> >> +     complete(&i2c_dev->complete);
> >> +}
> >> +
> >> +/**
> >> + * stm32f4_i2c_handle_write() - Handle FIFO empty interrupt in case of write
> >> + * @i2c_dev: Controller's private data
> >> + */
> >> +static void stm32f4_i2c_handle_write(struct stm32f4_i2c_dev *i2c_dev)
> >> +{
> >> +     struct stm32f4_i2c_msg *msg = &i2c_dev->msg;
> >> +     void __iomem *reg = i2c_dev->base + STM32F4_I2C_CR2;
> >> +
> >> +     if (msg->count) {
> >> +             stm32f4_i2c_write_msg(i2c_dev);
> >> +             if (!msg->count) {
> >> +                     /* Disable buffer interrupts for RXNE/TXE events */
> >> +                     stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_ITBUFEN);
> >> +             }
> >> +     } else {
> >> +             stm32f4_i2c_terminate_xfer(i2c_dev);
> >
> > Is stm32f4_i2c_terminate_xfer also called when arbitration is lost? If
> > yes, is it then right to set STM32F4_I2C_CR1_STOP or
> > STM32F4_I2C_CR1_START?
> 
> If arbitration is lost, stm32f4_i2c_terminate_xfer() is not called.
> In that case, we return -EAGAIN and i2c-core will retry by calling
> stm32f4_i2c_xfer()
> 
> >
> >> +     }
> >> +}
> >> +
> >> +/**
> >> + * stm32f4_i2c_handle_read() - Handle FIFO empty interrupt in case of read
> >> + * @i2c_dev: Controller's private data
> >> + */
> >> +static void stm32f4_i2c_handle_read(struct stm32f4_i2c_dev *i2c_dev)
> >> +{
> >> +     struct stm32f4_i2c_msg *msg = &i2c_dev->msg;
> >> +     void __iomem *reg = i2c_dev->base + STM32F4_I2C_CR2;
> >> +
> >> +     switch (msg->count) {
> >> +     case 1:
> >> +             stm32f4_i2c_disable_irq(i2c_dev);
> >> +             stm32f4_i2c_read_msg(i2c_dev);
> >> +             complete(&i2c_dev->complete);
> >> +             break;
> >> +     /*
> >> +      * For 2 or 3-byte reception, we do not have to read the data register
> >> +      * when RXNE occurs as we have to wait for byte transferred finished
> >
> > it's hard to understand because if you don't know the hardware the
> > meaning of RXNE is unknown.
> 
> Ok I will replace RXNE by RX not empty in that comment
> 
> >
> >> +      * event before reading data. So, here we just disable buffer
> >> +      * interrupt in order to avoid another system preemption due to RXNE
> >> +      * event
> >> +      */
> >> +     case 2:
> >> +     case 3:
> >> +             stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_ITBUFEN);
> >> +             break;
> >> +     /* For N byte reception with N > 3 we directly read data register */
> >> +     default:
> >> +             stm32f4_i2c_read_msg(i2c_dev);
> >> +     }
> >> +}
> >> +
> >> +/**
> >> + * stm32f4_i2c_handle_rx_btf() - Handle byte transfer finished interrupt
> >> + * in case of read
> >> + * @i2c_dev: Controller's private data
> >> + */
> >> +static void stm32f4_i2c_handle_rx_btf(struct stm32f4_i2c_dev *i2c_dev)
> >> +{
> >
> > btf is a hw-related name. Maybe better use _done which is easier to
> > understand?
> 
> OK
> 
> >
> >> +     struct stm32f4_i2c_msg *msg = &i2c_dev->msg;
> >> +     void __iomem *reg;
> >> +     u32 mask;
> >> +     int i;
> >> +
> >> +     switch (msg->count) {
> >> +     case 2:
> >> +             /*
> >> +              * In order to correctly send the Stop or Repeated Start
> >> +              * condition on the I2C bus, the STOP/START bit has to be set
> >> +              * before reading the last two bytes.
> >> +              * After that, we could read the last two bytes, disable
> >> +              * remaining interrupts and notify the end of xfer to the
> >> +              * client
> >
> > This is surprising. I didn't recheck the manual, but that looks very
> > uncomfortable.
> 
> I agree but this exactly the hardware way of working described in the
> reference manual.

IMHO that's a hw bug. This makes it for example impossible to implement
SMBus block transfers (I think).

> > How does this work, when I only want to read a single
> > byte? Same problem for ACK below.
> 
> For a single reception, we enable NACK and STOP or Repeatead START
> bits during address match.
> The NACK and STOP/START pulses are sent as soon as the data is
> received in the shift register.
> Please note that in that case, we don't have to wait BTF event to read the data.
> Data is read as soon as RXNE event occurs.
> 
> >
> >> +              */
> >> +             reg = i2c_dev->base + STM32F4_I2C_CR1;
> >> +             if (msg->stop)
> >> +                     stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_STOP);
> >> +             else
> >> +                     stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_START);
> >> +
> >> +             for (i = 2; i > 0; i--)
> >> +                     stm32f4_i2c_read_msg(i2c_dev);
> >> +
> >> +             reg = i2c_dev->base + STM32F4_I2C_CR2;
> >> +             mask = STM32F4_I2C_CR2_ITEVTEN | STM32F4_I2C_CR2_ITERREN;
> >> +             stm32f4_i2c_clr_bits(reg, mask);
> >> +
> >> +             complete(&i2c_dev->complete);
> >> +             break;
> >> +     case 3:
> >> +             /*
> >> +              * In order to correctly send the ACK on the I2C bus for the
> >> +              * last two bytes, we have to set ACK bit before reading the
> >> +              * third last data byte
> >> +              */
> >> +             reg = i2c_dev->base + STM32F4_I2C_CR1;
> >> +             stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
> >> +             stm32f4_i2c_read_msg(i2c_dev);
> >> +             break;
> >> +     default:
> >> +             stm32f4_i2c_read_msg(i2c_dev);
> >> +     }
> >> +}
> >> +
> >> +/**
> >> + * stm32f4_i2c_handle_rx_addr() - Handle address matched interrupt in case of
> >> + * master receiver
> >> + * @i2c_dev: Controller's private data
> >> + */
> >> +static void stm32f4_i2c_handle_rx_addr(struct stm32f4_i2c_dev *i2c_dev)
> >> +{
> >> +     struct stm32f4_i2c_msg *msg = &i2c_dev->msg;
> >> +     void __iomem *reg;
> >> +
> >> +     switch (msg->count) {
> >> +     case 0:
> >> +             stm32f4_i2c_terminate_xfer(i2c_dev);
> >> +             /* Clear ADDR flag */
> >> +             readl_relaxed(i2c_dev->base + STM32F4_I2C_SR2);
> >> +             break;
> >> +     case 1:
> >> +             /*
> >> +              * Single byte reception:
> >
> > This also happens for the last byte of a 5 byte transfer, right?
> 
> For a 5 byte transfer the behavior is different:
> We have to read data from DR (data register)  as soon as the RXNE (RX
> not empty) event occurs for data1, data2 and data3 (until N-2 data for
> a more generic case)
> The ACK is automatically sent as soon as the data is received in the
> shift register as the I2C controller was configured to do that during
> adress match phase.
> 
> For data3 (N-2 data), we wait for BTF (Byte Transfer finished) event
> in order to set NACK before reading DR.
> This event occurs when a new data has been received in shift register
> (in our case data4 or N-1 data) but the prevoius data in DR (in our
> case data3 or N-2 data) has not been read yet.
> In that way, the NACK pulse will be correctly generated after the last
> received data byte.
> 
> For data4 and data5, we wait for BTF event (data4 or N-1 data in DR
> and data5 or N data in shift register), set STOP or repeated Start in
> order to correctly sent the right pulse after the last received data
> byte and run 2 consecutives read of DR.

So "Single byte reception" above is wrong, as this case is also used for
longer transfers and should be updated accordingly.

> >> +              * Enable NACK, clear ADDR flag and generate STOP or RepSTART
> >> +              */
> >> +             reg = i2c_dev->base + STM32F4_I2C_CR1;
> >> +             stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
> >> +             readl_relaxed(i2c_dev->base + STM32F4_I2C_SR2);
> >> +             if (msg->stop)
> >> +                     stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_STOP);
> >> +             else
> >> +                     stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_START);
> >> +             break;
> >> +     case 2:
> >> +             /*
> >> +              * 2-byte reception:
> >> +              * Enable NACK and set POS
> >
> > What is POS?
> POS is used to define the position of the (N)ACK pulse
> 0: ACK is generated when the current is being received in the shift register
> 1: ACK is generated when the next byte which will be received in the
> shift register (used for 2-byte reception)

Can you please put this into the comment. "POS" isn't much helpful
there.

> 
> >
> >> +              */
> >> +             reg = i2c_dev->base + STM32F4_I2C_CR1;
> >> +             stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
> >> +             stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_POS);
> >
> > You could get rid of this, when caching the value of CR1. Would save two
> > register reads here. This doesn't work for all registers, but it should
> > be possible to apply for most of them, maybe enough to get rid of the
> > clr_bits and set_bits function.
> >
> >> +             readl_relaxed(i2c_dev->base + STM32F4_I2C_SR2);
> >> +             break;
> >> +
> >> +     default:
> >> +             /* N-byte reception: Enable ACK */
> >> +             reg = i2c_dev->base + STM32F4_I2C_CR1;
> >> +             stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_ACK);
> >
> > Do you need to set ACK for each byte transferred?
> I need to do that in order to be SMBus compatible and the ACK/NACK
> seems to be used by default in Documentation/i2c/i2c-protocol file.

Yeah, protocol wise you need to ack each byte. I just wondered if you
need to set the hardware bit for each byte or if it is retained in
hardware until unset by a register write.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
