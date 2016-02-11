From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 10 Feb 2016 16:41:24 -0800
Subject: [PATCH 1/3] clk: Allow clocks to be marked as CRITICAL
In-Reply-To: <1453127331-20616-2-git-send-email-lee.jones@linaro.org>
References: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
 <1453127331-20616-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20160211004124.26445.47437@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lee Jones (2016-01-18 06:28:49)
> Critical clocks are those which must not be gated, else undefined
> or catastrophic failure would occur.  Here we have chosen to
> ensure the prepare/enable counts are correctly incremented, so as
> not to confuse users with enabled clocks with no visible users.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/clk/clk.c            | 7 ++++++-
>  include/linux/clk-provider.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index f13c3f4..835cb85 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2576,8 +2576,13 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>         }
>  
>         ret = __clk_init(dev, hw->clk);
> -       if (!ret)
> +       if (!ret) {
> +               if (core->flags & CLK_IS_CRITICAL) {
> +                       clk_core_prepare(core);
> +                       clk_core_enable(core);
> +               }
>                 return hw->clk;
> +       }

I moved the above code into __clk_init where we do similar sort of clk
init-y type things. Modified patch below.

Best regards,
Mike



>From 83b4f533b581a386341cd0cf9dbce92286e41e75 Mon Sep 17 00:00:00 2001
From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 18 Jan 2016 14:28:49 +0000
Subject: [PATCH 1/6] clk: Allow clocks to be marked as CRITICAL

Critical clocks are those which must not be gated, else undefined
or catastrophic failure would occur.  Here we have chosen to
ensure the prepare/enable counts are correctly incremented, so as
not to confuse users with enabled clocks with no visible users.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
---
 drivers/clk/clk.c            | 5 +++++
 include/linux/clk-provider.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b4db67a..993f775 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2484,6 +2484,11 @@ static int __clk_init(struct device *dev, struct clk *clk_user)
 	if (core->ops->init)
 		core->ops->init(core->hw);
 
+	if (core->flags & CLK_IS_CRITICAL) {
+		clk_core_prepare(core);
+		clk_core_enable(core);
+	}
+
 	kref_init(&core->ref);
 out:
 	clk_prepare_unlock();
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1143e38..1d986ea 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -32,6 +32,7 @@
 #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
 #define CLK_RECALC_NEW_RATES	BIT(9) /* recalc rates after notifications */
 #define CLK_SET_RATE_UNGATE	BIT(10) /* clock needs to run to set rate */
+#define CLK_IS_CRITICAL		BIT(11) /* do not gate, ever */
 
 struct clk;
 struct clk_hw;
-- 
2.1.4
