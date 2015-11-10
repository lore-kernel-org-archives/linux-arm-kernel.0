From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 10 Nov 2015 17:33:26 +0800
Subject: [PATCH v11 2/4] PM / Domains: add setter for dev.pm_domain
In-Reply-To: <1445956731-6304-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1445956731-6304-1-git-send-email-tomeu.vizoso@collabora.com>
 <1445956731-6304-3-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAGS+omBMJXOgsd2x9agtt7yi-y+EPgHWSTr7B3JqbN9Hg_2W5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomeu,

On Tue, Oct 27, 2015 at 10:38 PM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> Adds a function that sets the pointer to dev_pm_domain in struct device
> and that warns if the device has already finished probing. The reason
> why we want to enforce that is because in the general case that can
> cause problems and also that we can simplify code quite a bit if we can
> always assume that.
>
> This patch also changes all current code that directly sets the
> dev.pm_domain pointer.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

[snip...]

> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index f32b802b98f4..a70f8a5cdfd7 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -128,3 +128,24 @@ void dev_pm_domain_detach(struct device *dev, bool power_off)
>                 dev->pm_domain->detach(dev, power_off);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
> +
> +/**
> + * dev_pm_domain_set - Set PM domain of a device.
> + * @dev: Device whose PM domain is to be set.
> + * @pd: PM domain to be set, or NULL.
> + *
> + * Sets the PM domain the device belongs to. The PM domain of a device needs
> + * to be set before its probe finishes (it's bound to a driver).
> + *
> + * This function must be called with the device lock held.
> + */
> +void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
> +{
> +       if (dev->pm_domain == pd)
> +               return;
> +
> +       WARN(device_is_bound(dev),
> +            "PM domains can only be changed for unbound devices\n");
> +       dev->pm_domain = pd;
> +}

When testing this patch, I have a platform driver with a device in a
genpd that hits this WARN() during shutdown with a backtrace like:

[  930.476714] ------------[ cut here ]------------
[  930.481323] WARNING: CPU: 3 PID: 10110 at
drivers/base/power/common.c:154 dev_pm_domain_set+0x50/0x60()
[  930.494605] PM domains can only be changed for unbound devices
[  930.541047] Call trace:
[  930.543470] [<ffffffc000208c00>] dump_backtrace+0x0/0x140
[  930.548820] [<ffffffc000208d5c>] show_stack+0x1c/0x28
[  930.553826] [<ffffffc000862f8c>] dump_stack+0x74/0x94
[  930.558831] [<ffffffc000221964>] warn_slowpath_common+0x90/0xb8
[  930.564698] [<ffffffc000221a10>] warn_slowpath_fmt+0x84/0xac
[  930.570305] [<ffffffc000574da8>] dev_pm_domain_set+0x4c/0x60
[  930.575913] [<ffffffc00057f500>] pm_genpd_remove_device+0xc4/0x174
[  930.582038] [<ffffffc00057f62c>] genpd_dev_pm_detach+0x7c/0xd4
[  930.587818] [<ffffffc000574be4>] dev_pm_domain_detach+0x34/0x44
[  930.593685] [<ffffffc00056e0f0>] platform_drv_shutdown+0x30/0x40
[  930.599639] [<ffffffc000569dfc>] device_shutdown+0x12c/0x184
[  930.605247] [<ffffffc000243dbc>] kernel_restart_prepare+0x38/0x44
[  930.611285] [<ffffffc000243eb0>] kernel_restart+0x1c/0x68
[  930.616634] [<ffffffc000244230>] SyS_reboot+0x1b4/0x210
[  930.621810] ---[ end trace 0551d0a7afcd5f6f ]---

The problem appears to be that:
  * On boot, platform_drv_probe() calls dev_pm_domain_attach() before
drv->probe(); thus, it calls dev_pm_domain_attach() while the device
is unbound.

 * However, for a platform_device, the reboot path calls
device_shutdown(), but not __device_release_driver():
device_shutdown()
  dev->driver->shutdown => platform_drv_shutdown()
    dev_pm_domain_detach()
       dev->pm_domain->detach() => genpd_dev_pm_detach()
         pm_genpd_remove_device()
            dev_pm_domain_set(dev, NULL);

So, for a platform_device in a genpd power domain with .shutdown
installed, platform_drv_shutdown() calls dev_pm_domain_detach() while
the device is still bound, which triggers the WARN().

Thanks,
-Dan
