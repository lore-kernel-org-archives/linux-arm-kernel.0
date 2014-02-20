From: joshc@codeaurora.org (Josh Cartwright)
Date: Thu, 20 Feb 2014 10:28:21 -0600
Subject: [PATCH 1/8] PM / Runtime: Fetch runtime PM callbacks using a macro
In-Reply-To: <1392910280-12891-2-git-send-email-ulf.hansson@linaro.org>
References: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org>
 <1392910280-12891-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140220162821.GD31820@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 04:31:13PM +0100, Ulf Hansson wrote:
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
>  drivers/base/power/runtime.c |   59 ++++++++++++++----------------------------
>  1 file changed, 20 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 72e00e6..dedbd64 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -13,6 +13,23 @@
>  #include <trace/events/rpm.h>
>  #include "power.h"
>  
> +#define RPM_GET_CALLBACK(dev, cb)				\
> +({								\
> +	if (dev->pm_domain)					\
> +		callback = dev->pm_domain->ops.cb;		\
> +	else if (dev->type && dev->type->pm)			\
> +		callback = dev->type->pm->cb;			\
> +	else if (dev->class && dev->class->pm)			\
> +		callback = dev->class->pm->cb;			\
> +	else if (dev->bus && dev->bus->pm)			\
> +		callback = dev->bus->pm->cb;			\
> +	else							\
> +		callback = NULL;				\
> +								\
> +	if (!callback && dev->driver && dev->driver->pm)	\
> +		callback = dev->driver->pm->cb;			\

Just a matter of style, but toying with the caller's 'callback' variable
is a bit ugly, I'm wondering if it would be cleaner to rework the
statement expression to "return" the callback, which would be used like:

	callback = rpm_get_callback(dev, runtime_idle);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
