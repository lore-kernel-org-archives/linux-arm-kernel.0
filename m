From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 6 Oct 2016 13:48:39 +0200
Subject: [PATCH 8/8] PM / doc: Update device documentation for devices in
 IRQ safe PM domains
In-Reply-To: <1475699519-109623-9-git-send-email-lina.iyer@linaro.org>
References: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org>
 <1475699519-109623-9-git-send-email-lina.iyer@linaro.org>
Message-ID: <CAPDyKFp_phou_aA2N8NUmoi4Ve5+y1GODipR5t5Q7d-5fpcZhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2016 at 22:31, Lina Iyer <lina.iyer@linaro.org> wrote:
> Update documentation to reflect the changes made to support IRQ safe PM
> domains.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  Documentation/power/devices.txt | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
> index 8ba6625..a622136 100644
> --- a/Documentation/power/devices.txt
> +++ b/Documentation/power/devices.txt
> @@ -607,7 +607,17 @@ individually.  Instead, a set of devices sharing a power resource can be put
>  into a low-power state together at the same time by turning off the shared
>  power resource.  Of course, they also need to be put into the full-power state
>  together, by turning the shared power resource on.  A set of devices with this
> -property is often referred to as a power domain.
> +property is often referred to as a power domain. A power domain may also be
> +nested inside another power domain.
> +
> +Devices, by default, operate in process context. If a device can operate in
> +IRQ safe context that has to be explicitly indicated by setting the irq_safe
> +boolean inside struct generic_pm_domain to be true. Power domains by default,

This doesn't make much sense.

First, I think you should mention that this is about which context the
device's corresponding runtime PM callbacks are allowed to execute in.
Second, it's not clear *why* you must set the irq_safe boolean inside
struct generic_pm_domain to true, for IRQ-safe devices. You probably
shouldn't state this at all.

Perhaps a better description is to elaborate on the constraints an
IRQ-safe device holds. Then one could explain a bit about how IRQ safe
(genpd) PM domains can be used for these devices (something like
below).

> +operate in process context but could have devices that are IRQ safe. Such
> +power domains cannot be powered on/off during runtime PM. On the other hand,
> +IRQ safe PM domains that have IRQ safe devices may be powered off when all
> +the devices are in idle. An IRQ safe domain may only be attached as a
> +subdomain to another IRQ safe domain.
>
>  Support for power domains is provided through the pm_domain field of struct
>  device.  This field is a pointer to an object of type struct dev_pm_domain,
> --
> 2.7.4
>

Kind regards
Uffe
