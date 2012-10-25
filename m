From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Thu, 25 Oct 2012 14:46:56 +0530
Subject: [PATCH] i2c: omap: ensure writes to dev->buf_len are ordered
In-Reply-To: <1351155648-20429-1-git-send-email-balbi@ti.com>
References: <1351155648-20429-1-git-send-email-balbi@ti.com>
Message-ID: <CAM=Q2ctdAMH8F94JgJW6Zrx9jpQ3Xs=7gQtZpUcNiyi8sfxP=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 2:30 PM, Felipe Balbi <balbi@ti.com> wrote:
> if we allow compiler reorder our writes, we could
> fall into a situation where dev->buf_len is reset
> for no apparent reason.
>
> This bug was found with a simple script which would
> transfer data to an i2c client from 1 to 1024 bytes
> (a simple for loop), when we got to transfer sizes
> bigger than the fifo size, dev->buf_len was reset
> to zero before we had an oportunity to handle XDR
> Interrupt. Because dev->buf_len was zero, we entered
> omap_i2c_transmit_data() to transfer zero bytes,
> which would mean we would just silently exit
> omap_i2c_transmit_data() without actually writing
> anything to DATA register. That would cause XDR
> IRQ to trigger forever and we would never transfer
> the remaining bytes.
>
> After adding the memory barrier, we also drop resetting
> dev->buf_len to zero in omap_i2c_xfer_msg() because
> both omap_i2c_transmit_data() and omap_i2c_receive_data()
> will act until dev->buf_len reaches zero, rendering the
> other write in omap_i2c_xfer_msg() redundant.
>
> This patch has been tested with pandaboard for a few
> iterations of the script mentioned above.

looks good to me
Acked-by: Shubhrajyoti D <shubhrajyoti@ti.com>

>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>
> This bug has been there forever, but it's quite annoying.
> I think it deserves being pushed upstream during this -rc
> cycle, but if Wolfram decides to wait until v3.8, I don't
> mind.
>
>  drivers/i2c/busses/i2c-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index db31eae..1ec4e6e 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -521,6 +521,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>         /* REVISIT: Could the STB bit of I2C_CON be used with probing? */
>         dev->buf = msg->buf;
>         dev->buf_len = msg->len;
> +       wmb();
>
>         omap_i2c_write_reg(dev, OMAP_I2C_CNT_REG, dev->buf_len);
>
> @@ -579,7 +580,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>          */
>         timeout = wait_for_completion_timeout(&dev->cmd_complete,
>                                                 OMAP_I2C_TIMEOUT);
> -       dev->buf_len = 0;
>         if (timeout == 0) {
>                 dev_err(dev->dev, "controller timed out\n");
>                 omap_i2c_init(dev);
> --
> 1.8.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
