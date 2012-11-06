From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Tue, 6 Nov 2012 17:24:34 +0100
Subject: [PATCH] i2c: omap: Move the remove constraint
In-Reply-To: <1352195673-31559-1-git-send-email-shubhrajyoti@ti.com>
References: <1352195673-31559-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <CAORVsuW_VAiemnauUs-yW+GcQpv+qpESP4kzyQm=Unmofa4k_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shubhrajyoti,

On Tue, Nov 6, 2012 at 10:54 AM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> Currently we just queue the transfer and release the
> qos constraints, however we donot wait for the transfer
> to complete to release the constraint. Move the remove
> constraint after the bus busy as we are sure that the
> transfers are completed by then.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Good catch, the change definitely makes sense. Feel free to add:

Acked-by: Jean Pihet <j-pihet@ti.com>

Thanks,
Jean.

> ---
>  drivers/i2c/busses/i2c-omap.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 94ff685..8b079d7 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -655,13 +655,13 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>                         break;
>         }
>
> -       if (dev->latency)
> -               pm_qos_remove_request(&dev->pm_qos_request);
> -
>         if (r == 0)
>                 r = num;
>
>         omap_i2c_wait_for_bb(dev);
> +
> +       if (dev->latency)
> +               pm_qos_remove_request(&dev->pm_qos_request);
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
