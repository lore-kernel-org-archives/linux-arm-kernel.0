From: khilman@ti.com (Kevin Hilman)
Date: Thu, 03 May 2012 13:26:40 -0700
Subject: [PATCH 18/18][V3] ARM: OMAP3: cpuidle - set global variables
 static
In-Reply-To: <1335276339-11135-19-git-send-email-daniel.lezcano@linaro.org>
 (Daniel Lezcano's message of "Tue, 24 Apr 2012 16:05:39 +0200")
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
 <1335276339-11135-19-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <878vh9ko3j.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> and check the powerdomain lookup is successful.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 0d28596..116a0d8 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -73,7 +73,7 @@ static struct omap3_idle_statedata omap3_idle_data[] = {
>  	},
>  };
>  
> -struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
> +static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
>  
>  static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
>  				struct clockdomain *clkdm)
> @@ -252,6 +252,9 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>  	 *        its own code.
>  	 */
>  
> +	if (!mpu_pd || !core_pd || !per_pd || !cam_pd)
> +		return -ENODEV;
> +

Why check here?  cam_pd is actually used just above this code.

Also, this is in the fast path.  This should just be checked once at
init time instead of every idle path.

For those reasons, I've dropped this part of the patch (updated patch
below.)

If desired, you can send an additional patch that adds this error
checking at init time and then refuses to register the driver if any of
the pwrdms don't exist.

Kevin


>From 7870c78d0343ab39050bec01d88cdb19245fdaa9 Mon Sep 17 00:00:00 2001
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Tue, 24 Apr 2012 16:05:39 +0200
Subject: [PATCH] ARM: OMAP3: cpuidle - set global variables static

struct powerdomain varialbes are all file local, make them static.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>
[khilman at ti.com: update changelog, drop error check in fast path]
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 0d28596..9429c65 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -73,7 +73,7 @@ static struct omap3_idle_statedata omap3_idle_data[] = {
 	},
 };
 
-struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
+static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
 
 static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
 				struct clockdomain *clkdm)
-- 
1.7.9.2
