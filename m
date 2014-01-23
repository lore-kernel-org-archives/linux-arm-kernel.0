From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu, 23 Jan 2014 14:32:15 -0500
Subject: [PATCH-next] drivers/clk: make max77686 driver bool for now
Message-ID: <1390505535-30229-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 3966c947f45911e093114371462687134d5e8d40 ("clk: max77686:
Refactor driver data handling") added a call to __clk_get_hw()
but this function is not exported (as __<name> is typically a
private/internal thing).

Hence this driver fails to build modular, and has been causing
allmodconfig build breakage in arch outside of just ARM.  Since
the only defconfig that uses it sets it as =y, lets just make
it non-modular for now.

Mike says that changes are pending to export similar functionality
in the future[1], so at that point in time, it can be returned to
tristate if desired.

[1] https://lkml.org/lkml/2014/1/20/21

Reported-by: SeongJae Park <sj38.park@gmail.com>
Cc: SeongJae Park <sj38.park@gmail.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index efb508a..009fb9b 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -40,7 +40,7 @@ config COMMON_CLK_VERSATILE
 	  - Versatile Express
 
 config COMMON_CLK_MAX77686
-	tristate "Clock driver for Maxim 77686 MFD"
+	bool "Clock driver for Maxim 77686 MFD"
 	depends on MFD_MAX77686
 	---help---
 	  This driver supports Maxim 77686 crystal oscillator clock. 
-- 
1.8.5.2
