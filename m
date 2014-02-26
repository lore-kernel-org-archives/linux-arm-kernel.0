From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 26 Feb 2014 15:00:42 -0800
Subject: [PATCH V2 1/8] PM / Runtime: Fetch runtime PM callbacks using a
 macro
In-Reply-To: <1393237368-15500-1-git-send-email-ulf.hansson@linaro.org> (Ulf
 Hansson's message of "Mon, 24 Feb 2014 11:22:48 +0100")
References: <1393237368-15500-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <7hk3chwkbp.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> While fetching the proper runtime PM callback, we walk the hierarchy of
> device's power domains, subsystems and drivers.
>
> This is common for rpm_suspend(), rpm_idle() and rpm_resume(). Let's
> clean up the code by using a macro that handles this.
>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
> 	Updated the macro to return a callback instead.
> 	Suggested by Josh Cartwright.
>
> ---
>  drivers/base/power/runtime.c |   63 ++++++++++++++++--------------------------
>  1 file changed, 24 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 72e00e6..cc7d1ed 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -13,6 +13,27 @@
>  #include <trace/events/rpm.h>
>  #include "power.h"
>  
> +#define RPM_GET_CALLBACK(dev, cb)				\
> +({								\
> +	int (*__rpm_cb)(struct device *__d);			\
> +								\
> +	if (dev->pm_domain)					\
> +		__rpm_cb = dev->pm_domain->ops.cb;		\
> +	else if (dev->type && dev->type->pm)			\
> +		__rpm_cb = dev->type->pm->cb;			\
> +	else if (dev->class && dev->class->pm)			\
> +		__rpm_cb = dev->class->pm->cb;			\
> +	else if (dev->bus && dev->bus->pm)			\
> +		__rpm_cb = dev->bus->pm->cb;			\
> +	else							\
> +		__rpm_cb = NULL;				\
> +								\
> +	if (!__rpm_cb && dev->driver && dev->driver->pm)	\
> +		__rpm_cb = dev->driver->pm->cb;			\
> +								\
> +	__rpm_cb;						\
> +})

So the main question from v1 remains: why use a macro, and not a function?

Kevin
