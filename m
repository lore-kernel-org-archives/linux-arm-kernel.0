From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 31 Mar 2015 10:59:39 +0200
Subject: [RFC PATCH v3 1/2] clk: samsung: Add a clock lookup function
In-Reply-To: <20150331014013.25195.26862@quantum>
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>
 <1427730803-28635-2-git-send-email-javier.martinez@collabora.co.uk>
 <CA+Ln22Fn+TRGcFXH7m=LkOCpAtbdKq98jNNNDM0shYWvfHEBiA@mail.gmail.com>
 <55197508.5030501@collabora.co.uk> <20150331014013.25195.26862@quantum>
Message-ID: <551A61FB.1040401@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Tomeu who I forgot to add to the cc list.

Hello Mike,

Thanks a lot for your feedback.

On 03/31/2015 03:40 AM, Michael Turquette wrote:
>> 
>> I don't performance is a big issue here. I just thought that since the
>> lookup table is already filled by the driver and the lookup function
>> is one line, we could use that instead to get the performance benefit.
>> 
>> But I don't mind to drop this patch and use the generic lookup function
>> from the CCF API if that is preferred.
> 
> Hello,
> 
> I am not a fan of __clk_lookup and I don't like to see it used more and
> more outside of drivers/clk/clk.c. You mentioned that performance wasn't
> really the problem here.  The real method for a driver to get a clock is
> with clk_get(). Any reason to not use that?
>

I can certainly use clk_get() but I thought that the clk consumer API was
not supposed to be used from within clock drivers. That's why I mentioned
__clk_lookup() as a possibility since that is part of the provider API.

Below is a RFC patch that uses clk_get() [0]. That needs another patch
which was part of a previous RFC and adds an alias for the mdma0 clock:

https://lkml.org/lkml/2015/3/27/769

If you think that is the correct approach then I can post it as a patch.

It would be great if you can also provide some feedback about the other
patch in the first RFC that instead of enabling and disabling the mdma0
clock in driver, does it in the exynos5420 platform PM callbacks:

https://lkml.org/lkml/2015/3/27/770

I was asked to do it in the exynos5420 clk driver instead but maybe you
have a different opinion on that.

Best regards,
Javier

[0]:
>From c118df83da8cac65cc218ae9443622592222f5d0 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Date: Mon, 30 Mar 2015 17:11:40 +0200
Subject: [RFC] clk: exynos5420: Make sure MDMA0 clock is enabled during
 suspend

Commit ae43b3289186 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power
Management support v12") added pm support for the pl330 dma driver but
it makes the clock for the Exynos5420 MDMA0 DMA controller to be gated
during suspend and this clock needs to remain enabled in order to make
the system resume from a system suspend state.

To make sure that the clock is enabled during suspend, enable it prior
to entering a suspend state and disable it once the system has resumed.

Thanks to Abhilash Kesavan for figuring out that this was the issue.

Fixes: ae43b32 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power Management support v12")
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/clk/samsung/clk-exynos5420.c | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 8b49e8b3b548..02029cf9fcb8 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -155,6 +155,7 @@ static enum exynos5x_soc exynos5x_soc;
 #ifdef CONFIG_PM_SLEEP
 static struct samsung_clk_reg_dump *exynos5x_save;
 static struct samsung_clk_reg_dump *exynos5800_save;
+static struct clk **exynos5x_clks;
 
 /*
  * list of controller registers to be saved and restored during a
@@ -275,8 +276,17 @@ static const struct samsung_clk_reg_dump exynos5420_set_clksrc[] = {
 	{ .offset = GATE_IP_PERIC,		.value = 0xffffffff, },
 };
 
+/*
+ * list of clocks that have to be kept enabled during suspend/resume cycle.
+ */
+static const char *exynos5x_clk_pm[] __initdata = {
+	"mdma0",
+};
+
 static int exynos5420_clk_suspend(void)
 {
+	int i;
+
 	samsung_clk_save(reg_base, exynos5x_save,
 				ARRAY_SIZE(exynos5x_clk_regs));
 
@@ -287,11 +297,19 @@ static int exynos5420_clk_suspend(void)
 	samsung_clk_restore(reg_base, exynos5420_set_clksrc,
 				ARRAY_SIZE(exynos5420_set_clksrc));
 
+	for (i = 0; i < ARRAY_SIZE(exynos5x_clk_pm); i++)
+		clk_prepare_enable(exynos5x_clks[i]);
+
 	return 0;
 }
 
 static void exynos5420_clk_resume(void)
 {
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(exynos5x_clk_pm); i++)
+		clk_disable_unprepare(exynos5x_clks[i]);
+
 	samsung_clk_restore(reg_base, exynos5x_save,
 				ARRAY_SIZE(exynos5x_clk_regs));
 
@@ -307,6 +325,9 @@ static struct syscore_ops exynos5420_clk_syscore_ops = {
 
 static void exynos5420_clk_sleep_init(void)
 {
+	int i;
+	int clk_len = ARRAY_SIZE(exynos5x_clk_pm);
+
 	exynos5x_save = samsung_clk_alloc_reg_dump(exynos5x_clk_regs,
 					ARRAY_SIZE(exynos5x_clk_regs));
 	if (!exynos5x_save) {
@@ -323,8 +344,31 @@ static void exynos5420_clk_sleep_init(void)
 			goto err_soc;
 	}
 
+	exynos5x_clks = kzalloc(sizeof(struct clk *) * clk_len, GFP_KERNEL);
+	if (!exynos5x_clks)
+		goto err_clks;
+
+	for (i = 0; i < clk_len; i++) {
+		exynos5x_clks[i] = clk_get(NULL, exynos5x_clk_pm[i]);
+		if (IS_ERR(exynos5x_clks[i])) {
+			pr_warn("Failed to get %s clk (%ld)\n",
+				exynos5x_clk_pm[i], PTR_ERR(exynos5x_clks[i]));
+
+			while (i--)
+				clk_put(exynos5x_clks[i]);
+
+			goto err_clkget;
+		}
+	}
+
 	register_syscore_ops(&exynos5420_clk_syscore_ops);
 	return;
+err_clkget:
+	kfree(exynos5x_clks);
+err_clks:
+	kfree(exynos5800_save);
+	pr_warn("%s: failed to allocate suspend clocks, no sleep support!\n",
+		__func__);
 err_soc:
 	kfree(exynos5x_save);
 	pr_warn("%s: failed to allocate sleep save data, no sleep support!\n",
-- 
2.1.4
