From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 7 Jan 2016 15:47:01 +0100
Subject: [PATCH v11 2/4] PM / Domains: add setter for dev.pm_domain
In-Reply-To: <CAGS+omBMJXOgsd2x9agtt7yi-y+EPgHWSTr7B3JqbN9Hg_2W5A@mail.gmail.com>
References: <1445956731-6304-1-git-send-email-tomeu.vizoso@collabora.com>
 <1445956731-6304-3-git-send-email-tomeu.vizoso@collabora.com>
 <CAGS+omBMJXOgsd2x9agtt7yi-y+EPgHWSTr7B3JqbN9Hg_2W5A@mail.gmail.com>
Message-ID: <CAAObsKC1jTzLWmMtwGWVStuMtzZwvMuA_731dsn4YX7aKMtFKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 November 2015 at 10:33, Daniel Kurtz <djkurtz@chromium.org> wrote:
[snip]
>
> The problem appears to be that:
>   * On boot, platform_drv_probe() calls dev_pm_domain_attach() before
> drv->probe(); thus, it calls dev_pm_domain_attach() while the device
> is unbound.
>
>  * However, for a platform_device, the reboot path calls
> device_shutdown(), but not __device_release_driver():
> device_shutdown()
>   dev->driver->shutdown => platform_drv_shutdown()
>     dev_pm_domain_detach()
>        dev->pm_domain->detach() => genpd_dev_pm_detach()
>          pm_genpd_remove_device()
>             dev_pm_domain_set(dev, NULL);
>
> So, for a platform_device in a genpd power domain with .shutdown
> installed, platform_drv_shutdown() calls dev_pm_domain_detach() while
> the device is still bound, which triggers the WARN().

Hi Rafael, Alan and Ulf,

do you have any suggestion about this? I don't really understand why
the device is detached from the domain on shutdown.

Thanks,

Tomeu

> Thanks,
> -Dan
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
