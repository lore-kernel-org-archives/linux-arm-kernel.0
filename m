From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 12 Apr 2016 16:49:11 +0200
Subject: [PATCH v6] drivers: amba: properly handle devices with power
 domains
In-Reply-To: <1460470193-24928-1-git-send-email-m.szyprowski@samsung.com>
References: <570D017E.7060105@samsung.com>
 <1460470193-24928-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAPDyKFqhaLUzzVtSosRQgd1p=QquwHpXEkV9BdgHrBs1nLiLMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>
> +static int __init amba_deferred_device_init(void)
> +{
> +       struct deferred_device *ddev, *tmp;
> +
> +       list_for_each_entry_safe(ddev, tmp, &deferred_devices, node) {
> +               int ret = amba_device_try_add(ddev->dev, ddev->parent);
> +
> +               if (ret == -EPROBE_DEFER)
> +                       continue;

What happens with devices that still fails to be added here? Should we
schedule a periodic work to re-try?

> +
> +               list_del_init(&ddev->node);
> +               kfree(ddev);
> +       }
> +
> +       return 0;
> +}
> +late_initcall(amba_deferred_device_init);
> +
>  static struct amba_device *
>  amba_aphb_device_add(struct device *parent, const char *name,
>                      resource_size_t base, size_t size, int irq1, int irq2,
> --
> 1.9.2
>

I assume there are other similar buses like AMBA that needs
enumeration before it can bind an appropriate driver for its device.

Perhaps that's a good reason to make this new "device add re-try"
mechanism a generic thing supported by the driver core?

Kind regards
Uffe
