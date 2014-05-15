From: robherring2@gmail.com (Rob Herring)
Date: Thu, 15 May 2014 13:57:04 -0500
Subject: [PATCH] amba: Put the device's of_node on its release
In-Reply-To: <1400173652-30583-1-git-send-email-pawel.moll@arm.com>
References: <1400173652-30583-1-git-send-email-pawel.moll@arm.com>
Message-ID: <CAL_JsqJotigd1vtj+iOecVMkF79xUxT2i8YxcUgta35RRqDMrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 12:07 PM, Pawel Moll <pawel.moll@arm.com> wrote:
> An amba device created from Device Tree, when released, does not
> decrease of_node's reference counter.
>
> Fixed by adding a call to of_device_node_put() on the release
> path, in a similar way to what platform_device_release() is doing.
>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Acked-by: Rob Herring <robh@kernel.org>

Does this go with the rest of your series? Who needs to pick this up?

Rob

> ---
>  drivers/amba/bus.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 3cf61a1..0f489fb 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -17,6 +17,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/amba/bus.h>
>  #include <linux/sizes.h>
> +#include <linux/of_device.h>
>
>  #include <asm/irq.h>
>
> @@ -268,6 +269,7 @@ static void amba_device_release(struct device *dev)
>  {
>         struct amba_device *d = to_amba_device(dev);
>
> +       of_device_node_put(dev);
>         if (d->res.parent)
>                 release_resource(&d->res);
>         kfree(d);
> --
> 1.9.1
>
