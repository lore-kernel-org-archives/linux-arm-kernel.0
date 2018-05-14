From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 14 May 2018 08:37:24 -0500
Subject: [PATCH 10/12] platform/early: implement support for early
 platform drivers
In-Reply-To: <20180511162028.20616-11-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
 <20180511162028.20616-11-brgl@bgdev.pl>
Message-ID: <CAL_JsqJw8UXktcLK8ADUfo1P+1un+omJ31sGcq7GFbNwJMsHKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 11:20 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> This introduces the core part of support for early platform drivers
> and devices.
>

It looks like most of your prep patches are to separate the alloc and
init of platform devices because you are essentially making early
devices/drivers a sub-class. Maybe you could avoid doing that and
simplify things a bit. Comments below based on doing that...

> +/**
> + * struct early_platform_driver
> + *
> + * @pdrv: real platform driver associated with this early platform driver
> + * @list: list head for the list of early platform drivers
> + * @early_probe: early probe callback
> + */
> +struct early_platform_driver {
> +       struct platform_driver pdrv;
> +       struct list_head list;

Couldn't you use an existing list in driver_private until you move
over to the normal bus infra.

> +       int (*early_probe)(struct platform_device *);

Just add this to platform_driver.

> +};
> +
> +/**
> + * struct early_platform_device
> + *
> + * @pdev: real platform device associated with this early platform device
> + * @list: list head for the list of early platform devices
> + * @deferred: true if this device's early probe was deferred
> + * @deferred_drv: early platform driver with which this device was matched
> + */
> +struct early_platform_device {
> +       struct platform_device pdev;
> +       struct list_head list;

Use a list in device_private?

> +       bool deferred;
> +       struct early_platform_driver *deferred_drv;

Can't you use the existing deferred probe list?

Rob
