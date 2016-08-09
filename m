From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 9 Aug 2016 11:48:38 -0500
Subject: [PATCH] OF: mark released devices as no longer populated
In-Reply-To: <E1bX3Pw-00088i-KU@rmk-PC.armlinux.org.uk>
References: <E1bX3Pw-00088i-KU@rmk-PC.armlinux.org.uk>
Message-ID: <CAL_Jsq+pDeL1_=p06ynrV4CK+h8-Yx_KDbH-W=d-aSdARe3ZHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2016 at 4:33 AM, Russell King <rmk+kernel@armlinux.org.uk> wrote:
> When a Linux device is released and cleaned up, we left the OF device
> node marked as populated.  This causes the Freescale CAAM driver
> (drivers/crypto/caam) problems when the module is removed and re-
> inserted:
>
> JR0 Platform device creation error
> JR0 Platform device creation error
> caam 2100000.caam: no queues configured, terminating
> caam: probe of 2100000.caam failed with error -12
>
> The reason is that CAAM creates platform devices for each job ring:
>
>         for_each_available_child_of_node(nprop, np)
>                 if (of_device_is_compatible(np, "fsl,sec-v4.0-job-ring") ||
>                     of_device_is_compatible(np, "fsl,sec4.0-job-ring")) {
>                         ctrlpriv->jrpdev[ring] =
>                                 of_platform_device_create(np, NULL, dev);
>
> which sets OF_POPULATED on the device node, but then it cleans these
> up:
>
>         /* Remove platform devices for JobRs */
>         for (ring = 0; ring < ctrlpriv->total_jobrs; ring++) {
>                 if (ctrlpriv->jrpdev[ring])
>                         of_device_unregister(ctrlpriv->jrpdev[ring]);

This looks a bit asymmetrical to me with a of_platform_device_* call
and a of_device_* call.

I think you could use of_platform_{de}populate here instead. That
would simplify things in the driver a bit too as you wouldn't need to
store jrpdev. It wouldn't work if there are other child nodes with
compatible strings which you don't want devices created.

>         }
>
> which leaves OF_POPULATED set.
>
> Arrange for platform devices with a device node to clear the
> OF_POPULATED bit when they are released.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> Please check this carefully - it may have issues where an of_node
> pointer is copied from one platform device to another, but IMHO
> doing that is itself buggy behaviour.

Agreed, that is wrong.

>
> Resending due to wrong list address, sorry.
>
>  include/linux/of_device.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index cc7dd687a89d..7a8362d0c6d2 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -43,6 +43,7 @@ extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env
>
>  static inline void of_device_node_put(struct device *dev)
>  {
> +       of_node_clear_flag(dev->of_node, OF_POPULATED);

This would result in clearing the flag twice in the
of_platform_populate/of_platform_depopulate case. It would do the same
for other bus types like i2c as well. That doesn't really hurt
anything that I can think of, but just not the best implementation. I
think adding a of_platform_device_unregister() call that wraps
of_platform_device_destroy would be more balanced.

I looked thru all the callers of of_platform_device_create. The only
other ones affected by this are:

drivers/macintosh/ams/ams-core.c
drivers/macintosh/therm_adt746x.c
drivers/macintosh/therm_windtunnel.c

The others either have no remove path or a buggy remove path.

Rob
