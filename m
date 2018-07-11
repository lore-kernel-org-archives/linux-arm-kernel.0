From: brendanhiggins@google.com (Brendan Higgins)
Date: Tue, 10 Jul 2018 22:42:52 -0700
Subject: [PATCH] i2c: aspeed: Add newline characters into message
 printings.
In-Reply-To: <20180702211359.30585-1-jae.hyun.yoo@linux.intel.com>
References: <20180702211359.30585-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <CAFd5g443wTQJ+0hrprOV949Sr_nRnBGpNo3Wd01xFN4GW4K2Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2018 at 2:14 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> There are some log printing without a newline character. This
> patch adds the missing newline characters.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 60e4d0e939a3..e3007c1c4ac5 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -407,7 +407,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>          */
>         ret = aspeed_i2c_is_irq_error(irq_status);
>         if (ret < 0) {
> -               dev_dbg(bus->dev, "received error interrupt: 0x%08x",
> +               dev_dbg(bus->dev, "received error interrupt: 0x%08x\n",
>                         irq_status);
>                 bus->cmd_err = ret;
>                 bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> @@ -416,7 +416,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>
>         /* We are in an invalid state; reset bus to a known state. */
>         if (!bus->msgs) {
> -               dev_err(bus->dev, "bus in unknown state");
> +               dev_err(bus->dev, "bus in unknown state\n");
>                 bus->cmd_err = -EIO;
>                 if (bus->master_state != ASPEED_I2C_MASTER_STOP)
>                         aspeed_i2c_do_stop(bus);
> @@ -431,7 +431,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>          */
>         if (bus->master_state == ASPEED_I2C_MASTER_START) {
>                 if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
> -                       pr_devel("no slave present at %02x", msg->addr);
> +                       pr_devel("no slave present at %02x\n", msg->addr);

Unless something changed in the last couple versions of the kernel, this is the
only line that actually changes anything. dev_* inserts a newline for every
call.

Admittedly, the rest of the file is pretty inconsistent, so if you really want
to make all these changes, I don't feel super strongly about it.

>                         status_ack |= ASPEED_I2CD_INTR_TX_NAK;
>                         bus->cmd_err = -ENXIO;
>                         aspeed_i2c_do_stop(bus);
> @@ -451,11 +451,11 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>         switch (bus->master_state) {
>         case ASPEED_I2C_MASTER_TX:
>                 if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_NAK)) {
> -                       dev_dbg(bus->dev, "slave NACKed TX");
> +                       dev_dbg(bus->dev, "slave NACKed TX\n");
>                         status_ack |= ASPEED_I2CD_INTR_TX_NAK;
>                         goto error_and_stop;
>                 } else if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
> -                       dev_err(bus->dev, "slave failed to ACK TX");
> +                       dev_err(bus->dev, "slave failed to ACK TX\n");
>                         goto error_and_stop;
>                 }
>                 status_ack |= ASPEED_I2CD_INTR_TX_ACK;
> @@ -478,7 +478,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 /* fallthrough intended */
>         case ASPEED_I2C_MASTER_RX:
>                 if (unlikely(!(irq_status & ASPEED_I2CD_INTR_RX_DONE))) {
> -                       dev_err(bus->dev, "master failed to RX");
> +                       dev_err(bus->dev, "master failed to RX\n");
>                         goto error_and_stop;
>                 }
>                 status_ack |= ASPEED_I2CD_INTR_RX_DONE;
> @@ -509,7 +509,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 goto out_no_complete;
>         case ASPEED_I2C_MASTER_STOP:
>                 if (unlikely(!(irq_status & ASPEED_I2CD_INTR_NORMAL_STOP))) {
> -                       dev_err(bus->dev, "master failed to STOP");
> +                       dev_err(bus->dev, "master failed to STOP\n");
>                         bus->cmd_err = -EIO;
>                         /* Do not STOP as we have already tried. */
>                 } else {
> @@ -520,7 +520,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 goto out_complete;
>         case ASPEED_I2C_MASTER_INACTIVE:
>                 dev_err(bus->dev,
> -                       "master received interrupt 0x%08x, but is inactive",
> +                       "master received interrupt 0x%08x, but is inactive\n",
>                         irq_status);
>                 bus->cmd_err = -EIO;
>                 /* Do not STOP as we should be inactive. */
> @@ -851,7 +851,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>         bus->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
>         if (IS_ERR(bus->rst)) {
>                 dev_err(&pdev->dev,
> -                       "missing or invalid reset controller device tree entry");
> +                       "missing or invalid reset controller device tree entry\n");
>                 return PTR_ERR(bus->rst);
>         }
>         reset_control_deassert(bus->rst);
> --
> 2.17.1
>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
