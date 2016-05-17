From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 17 May 2016 11:48:08 +0200
Subject: [PATCH 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <1462980974-22091-3-git-send-email-cedric.madianga@gmail.com>
References: <1462980974-22091-1-git-send-email-cedric.madianga@gmail.com>
 <1462980974-22091-3-git-send-email-cedric.madianga@gmail.com>
Message-ID: <CALszF6A-jiCBtSO1RFDdgHKTKmsonRXFVs0x2zHha1LJ3UhwtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cedric,

2016-05-11 17:36 GMT+02:00 M'boumba Cedric Madianga <cedric.madianga@gmail.com>:
> This patch adds support for the STM32F4 I2C controller.
>
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> ---
>  drivers/i2c/busses/Kconfig       |  10 +
>  drivers/i2c/busses/Makefile      |   1 +
>  drivers/i2c/busses/i2c-stm32f4.c | 872 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 883 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-stm32f4.c
>
...
> diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
> new file mode 100644
> index 0000000..4692213
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-stm32f4.c
...
> +enum stm32f4_i2c_speed {
> +       STM32F4_I2C_SPEED_STANDARD, /* 100 kHz */
> +       STM32F4_I2C_SPEED_FAST, /* 400 kHz */
> +       STM32F4_I2C_SPEED_END,
> +};
> +
> +/**
> + * struct stm32f4_i2c_timings - per-Mode tuning parameters
> + * @rate: I2C bus rate
> + * @duty: Fast mode duty cycle
> + */
> +struct stm32f4_i2c_timings {
> +       u32 rate;
> +       u32 duty;
> +};
...
> +/**
> + * struct stm32f4_i2c_dev - private data of the controller
> + * @adap: I2C adapter for this controller
> + * @dev: device for this controller
> + * @base: virtual memory area
> + * @complete: completion of I2C message
> + * @irq_event: interrupt event line for the controller
> + * @irq_error: interrupt error line for the controller
> + * @clk: hw i2c clock
> + * speed: I2C clock frequency of the controller. Standard or Fast only supported
> + * @client: I2C transfer information
> + * @busy: I2C transfer on-going
> + * @rst: I2C reset line
> + */
> +struct stm32f4_i2c_dev {
> +       struct i2c_adapter              adap;
> +       struct device                   *dev;
> +       void __iomem                    *base;
> +       struct completion               complete;
> +       int                             irq_event;
> +       int                             irq_error;
> +       struct clk                      *clk;
> +       int                             speed;
> +       struct stm32f4_i2c_client       client;
> +       bool                            busy;
> +       struct reset_control            *rst;
> +};
> +
> +static struct stm32f4_i2c_timings i2c_timings[] = {
> +       [STM32F4_I2C_SPEED_STANDARD] = {
> +               .rate                   = 100000,
> +               .duty                   = 0,
> +       },
> +       [STM32F4_I2C_SPEED_FAST] = {
> +               .rate                   = 400000,
> +               .duty                   = 0,
> +       },
> +};
Is this table really needed?
As duty value seems to always be 0, couldn't you just store the rate
in the speed field?


> +static void stm32f4_i2c_set_rise_time(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +       u32 trise, freq, cr2;
> +
> +       cr2 = readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
> +       freq = cr2 & STM32F4_I2C_CR2_FREQ_MASK;
> +
> +       trise = readl_relaxed(i2c_dev->base + STM32F4_I2C_TRISE);
> +       trise &= ~STM32F4_I2C_TRISE_TRISE_MASK;
> +
> +       if (i2c_dev->speed == STM32F4_I2C_SPEED_STANDARD)
> +               trise |= STM32F4_I2C_TRISE_TRISE((freq + 1));
> +       else
> +               trise |= STM32F4_I2C_TRISE_TRISE((((freq * 300) / 1000) + 1));
Or if you keep the timings struct, maybe the rise time should be part of it.
Doing, that, you will avoid the if/else

> +
> +       writel_relaxed(trise, i2c_dev->base + STM32F4_I2C_TRISE);
> +}
> +
> +static void stm32f4_i2c_set_speed_mode(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +       struct stm32f4_i2c_timings *t = &i2c_timings[i2c_dev->speed];
> +       u32 ccr, val, clk_rate;
> +
> +       ccr = readl_relaxed(i2c_dev->base + STM32F4_I2C_CCR);
> +       ccr &= ~(STM32F4_I2C_CCR_FS | STM32F4_I2C_CCR_DUTY |
> +                STM32F4_I2C_CCR_CCR_MASK);
> +
> +       clk_rate = clk_get_rate(i2c_dev->clk);
> +
> +       switch (i2c_dev->speed) {
> +       case STM32F4_I2C_SPEED_STANDARD:
> +               val = clk_rate / t->rate * 2;
> +               if (val < STM32F4_I2C_MIN_CCR)
> +                       ccr |= STM32F4_I2C_CCR_CCR(STM32F4_I2C_MIN_CCR);
> +               else
> +                       ccr |= STM32F4_I2C_CCR_CCR(val);
> +               break;
> +       case STM32F4_I2C_SPEED_FAST:
> +               ccr |= STM32F4_I2C_CCR_FS;
> +               if (t->duty) {
> +                       ccr |= STM32F4_I2C_CCR_DUTY;
> +                       ccr |= STM32F4_I2C_CCR_CCR(clk_rate / t->rate * 25);
> +               } else {
> +                       ccr |= STM32F4_I2C_CCR_CCR(clk_rate / t->rate * 3);
> +               }
Is it really useful since duty seems to always be 0?

> +               break;
> +       default:
> +               dev_err(i2c_dev->dev, "I2C speed mode not supported\n");
> +       }
> +
> +       writel_relaxed(ccr, i2c_dev->base + STM32F4_I2C_CCR);
> +}
> +
> +static void stm32f4_i2c_set_filter(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +       u32 filter;
> +
> +       /* Enable analog noise filter and disable digital noise filter */
Maybe a stupid question, but is it always what we want?
Are there some cases we would prefer to use the digital noise filter
instead of the analog one?

> +       filter = readl_relaxed(i2c_dev->base + STM32F4_I2C_FLTR);
> +       filter &= ~(STM32F4_I2C_FLTR_ANOFF | STM32F4_I2C_FLTR_DNF_MASK);
> +       writel_relaxed(filter, i2c_dev->base + STM32F4_I2C_FLTR);
> +}
> +
> +/**
> + * stm32f4_i2c_hw_config() - Prepare I2C block
> + * @i2c_dev: Controller's private data
> + */
> +static void stm32f4_i2c_hw_config(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +       void __iomem *reg = i2c_dev->base + STM32F4_I2C_CR1;
> +
> +       /* Disable I2C */
> +       stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_PE);
> +
> +       stm32f4_i2c_set_periph_clk_freq(i2c_dev);
> +
> +       stm32f4_i2c_set_rise_time(i2c_dev);
> +
> +       stm32f4_i2c_set_speed_mode(i2c_dev);
> +
> +       stm32f4_i2c_set_filter(i2c_dev);
> +
> +       /* Enable I2C */
> +       stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_PE);
> +}
> +
> +static int stm32f4_i2c_wait_free_bus(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +       u32 status;
> +       int ret;
> +
> +       ret = readl_relaxed_poll_timeout(i2c_dev->base + STM32F4_I2C_SR2,
> +                                        status,
> +                                        !(status & STM32F4_I2C_SR2_BUSY),
> +                                        10, 1000);
> +       if (ret) {
> +               dev_err(i2c_dev->dev, "bus not free\n");
> +               ret = -EBUSY;
> +       }
> +
> +       return ret;
> +}
> +
> +/**
> + * stm32f4_i2c_write_ byte() - Write a byte in the data register
> + * @i2c_dev: Controller's private data
> + * @byte: Data to write in the register
> + */
> +static void stm32f4_i2c_write_byte(struct stm32f4_i2c_dev *i2c_dev, u8 byte)
> +{
> +       writel_relaxed(byte, i2c_dev->base + STM32F4_I2C_DR);
> +}
> +
> +/**
> + * stm32f4_i2c_write_msg() - Fill the data register in write mode
> + * @i2c_dev: Controller's private data
> + *
> + * This function fills the data register with I2C transfer buffer
> + */
> +static void stm32f4_i2c_write_msg(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +       struct stm32f4_i2c_client *c = &i2c_dev->client;
> +
> +       stm32f4_i2c_write_byte(i2c_dev, *c->buf++);
> +       c->count--;
> +}
> +
> +static void stm32f4_i2c_read_msg(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +       struct stm32f4_i2c_client *c = &i2c_dev->client;
> +       u32 rbuf;
> +
> +       rbuf = readl_relaxed(i2c_dev->base + STM32F4_I2C_DR);
> +       *c->buf++ = (u8)rbuf & 0xff;
> +       c->count--;
> +}
> +
> +static void stm32f4_i2c_terminate_xfer(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +       struct stm32f4_i2c_client *c = &i2c_dev->client;
> +       void __iomem *reg = i2c_dev->base + STM32F4_I2C_CR2;
> +
> +       /* Disable all interrupts */
> +       stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_IRQ_MASK);
> +
> +       /* Set STOP or REPSTART */
> +       reg = i2c_dev->base + STM32F4_I2C_CR1;
> +       if (c->stop)
> +               stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_STOP);
> +       else
> +               stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_START);
> +
> +       complete(&i2c_dev->complete);
> +}
> +
> +/**
> + * stm32f4_i2c_handle_write() - Handle FIFO empty interrupt in case of write
> + * @i2c_dev: Controller's private data
> + */
> +static void stm32f4_i2c_handle_write(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +       struct stm32f4_i2c_client *c = &i2c_dev->client;
> +       void __iomem *reg = i2c_dev->base + STM32F4_I2C_CR2;
> +
> +       if (c->count) {
> +               stm32f4_i2c_write_msg(i2c_dev);
> +               if (!c->count) {
> +                       /* Disable BUF interrupt */
> +                       stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_ITBUFEN);
> +               }
> +       } else {
> +               stm32f4_i2c_terminate_xfer(i2c_dev);
> +       }
> +}
> +
> +/**
> + * stm32f4_i2c_handle_tx_btf() - Handle byte transfer finished interrupt
> + * in case of write
> + * @i2c_dev: Controller's private data
> + */
> +static void stm32f4_i2c_handle_tx_btf(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +       struct stm32f4_i2c_client *c = &i2c_dev->client;
> +
> +       if (c->count)
> +               stm32f4_i2c_write_msg(i2c_dev);
> +       else
> +               stm32f4_i2c_terminate_xfer(i2c_dev);
> +}
The two functions above look very similar.
Isn't there a way to factorize?

> +
> +/**
> + * stm32f4_i2c_handle_read() - Handle FIFO enmpty interrupt in case of read
s/enmpty/empty/


...
> +
> +/**
> + * stm32f4_i2c_xfer() - Transfer combined I2C message
> + * @i2c_adap: Adapter pointer to the controller
> + * @msgs: Pointer to data to be written.
> + * @num: Number of messages to be executed
> + */
> +static int stm32f4_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[],
> +                           int num)
> +{
> +       struct stm32f4_i2c_dev *i2c_dev = i2c_get_adapdata(i2c_adap);
> +       int ret, i;
> +
> +       i2c_dev->busy = true;
> +
> +       ret = clk_prepare_enable(i2c_dev->clk);
> +       if (ret) {
> +               dev_err(i2c_dev->dev, "Failed to prepare_enable clock\n");
> +               return ret;
> +       }
> +
> +       stm32f4_i2c_hw_config(i2c_dev);
Maybe you could call this only at probe and resume time?
You would save some register accesses.

> +
> +       for (i = 0; i < num && !ret; i++)
> +               ret = stm32f4_i2c_xfer_msg(i2c_dev, &msgs[i], i == 0,
> +                                          i == num - 1);
> +
> +       clk_disable_unprepare(i2c_dev->clk);
> +
> +       i2c_dev->busy = false;
> +
> +       return (ret < 0) ? ret : i;
> +}
> +

Thanks!
Maxime
