From: brendanhiggins@google.com (Brendan Higgins)
Date: Thu, 12 Jul 2018 01:41:28 -0700
Subject: [PATCH] i2c: aspeed: Adjust spinlock scope in the irq handler
In-Reply-To: <20180702214011.16071-1-jae.hyun.yoo@linux.intel.com>
References: <20180702214011.16071-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <CAFd5g47nBCbF0mcYqEnQkDpz0Dhh0F0S1-wEL_yBHgs1b3yE5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2018 at 2:40 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> This patch adjusts spinlock scope to make it wrap the whole irq
> handler using a single lock/unlock which covers both master and
> slave handlers.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 60e4d0e939a3..9f02aa959a3e 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -234,7 +234,6 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
>         bool irq_handled = true;
>         u8 value;
>
> -       spin_lock(&bus->lock);
>         if (!slave) {
>                 irq_handled = false;
>                 goto out;
> @@ -325,7 +324,6 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
>         writel(status_ack, bus->base + ASPEED_I2C_INTR_STS_REG);
>
>  out:
> -       spin_unlock(&bus->lock);
>         return irq_handled;
>  }
>  #endif /* CONFIG_I2C_SLAVE */
> @@ -389,7 +387,6 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>         u8 recv_byte;
>         int ret;
>
> -       spin_lock(&bus->lock);
>         irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>         /* Ack all interrupt bits. */
>         writel(irq_status, bus->base + ASPEED_I2C_INTR_STS_REG);
> @@ -547,22 +544,29 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 dev_err(bus->dev,
>                         "irq handled != irq. expected 0x%08x, but was 0x%08x\n",
>                         irq_status, status_ack);
> -       spin_unlock(&bus->lock);
>         return !!irq_status;
>  }
>
>  static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  {
>         struct aspeed_i2c_bus *bus = dev_id;
> +       bool ret;
> +
> +       spin_lock(&bus->lock);
>
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
>         if (aspeed_i2c_slave_irq(bus)) {
>                 dev_dbg(bus->dev, "irq handled by slave.\n");
> -               return IRQ_HANDLED;
> +               ret = true;
> +               goto out;
>         }
>  #endif /* CONFIG_I2C_SLAVE */
>
> -       return aspeed_i2c_master_irq(bus) ? IRQ_HANDLED : IRQ_NONE;
> +       ret = aspeed_i2c_master_irq(bus);
> +
> +out:
> +       spin_unlock(&bus->lock);
> +       return ret ? IRQ_HANDLED : IRQ_NONE;
>  }
>
>  static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
> --
> 2.17.1
>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
