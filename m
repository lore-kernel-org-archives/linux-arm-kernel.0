From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 15 Nov 2012 09:16:43 +0100
Subject: [PATCHv2] i2c: omap: Move the remove constraint
In-Reply-To: <1352964883-9846-1-git-send-email-shubhrajyoti@ti.com>
References: <1352964883-9846-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <CAORVsuVuOLKpcx085VWiPRaD4syS-5F4+s+eKXGN8PPRRiTg2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shubhrajyoti,

On Thu, Nov 15, 2012 at 8:34 AM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> Currently we just queue the transfer and release the
> qos constraints, however we donot wait for the transfer
Typo: donot

> to complete to release the constraint. Move the remove
> constraint after the bus busy as we are sure that the
> transfers are completed by then.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Looks good!
Acked-by: Jean Pihet <j-pihet@ti.com>

Regards,
Jean

> ---
> v2: rebase to the for-next branch
>
>  drivers/i2c/busses/i2c-omap.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 482c63d..fabcbe1 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -654,13 +654,14 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>                         break;
>         }
>
> -       if (dev->set_mpu_wkup_lat != NULL)
> -               dev->set_mpu_wkup_lat(dev->dev, -1);
> -
>         if (r == 0)
>                 r = num;
>
>         omap_i2c_wait_for_bb(dev);
> +
> +       if (dev->set_mpu_wkup_lat != NULL)
> +               dev->set_mpu_wkup_lat(dev->dev, -1);
> +
>  out:
>         pm_runtime_mark_last_busy(dev->dev);
>         pm_runtime_put_autosuspend(dev->dev);
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
