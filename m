From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Sat, 16 Apr 2016 21:14:53 -0400
Subject: [PATCH v2 2/2] i2c: exynos5: Fix possible ABBA deadlock by keeping
 I2C clock prepared
In-Reply-To: <1460855693-28225-1-git-send-email-javier@osg.samsung.com>
References: <1460855693-28225-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1460855693-28225-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos5 I2C controller driver always prepares and enables a clock
before using it and then disables unprepares it when the clock is not
used anymore.

But this can cause a possible ABBA deadlock in some scenarios since a
driver that uses regmap to access its I2C registers, will first grab
the regmap lock and then the I2C xfer function will grab the prepare
lock when preparing the I2C clock. But since the clock driver also
uses regmap for I2C accesses, preparing a clock will first grab the
prepare lock and then the regmap lock when using the regmap API.

An example of this happens on the Exynos5422 Odroid XU4 board where a
s2mps11 PMIC is used and both the s2mps11 regulators and clk drivers
share the same I2C regmap.

The possible deadlock is reported by the kernel lockdep:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(sec_core:428:(regmap)->lock);
                                lock(prepare_lock);
                                lock(sec_core:428:(regmap)->lock);
   lock(prepare_lock);

  *** DEADLOCK ***

Fix it by leaving the code prepared on probe and use {en,dis}able in
the I2C transfer function.

This patch is similar to commit 34e81ad5f0b6 ("i2c: s3c2410: fix ABBA
deadlock by keeping clock prepared") that fixes the same bug in other
driver for an I2C controller found in Samsung SoCs.

Reported-by: Anand Moon <linux.amoon@gmail.com>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>

---

Changes in v2:
- Add Anand Moon's Reviewed and Tested by tags.
- Unprepare the clock on suspend. Suggested by Krzysztof Kozlowski.

 drivers/i2c/busses/i2c-exynos5.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index ebbcba3de20a..f54ece8fce78 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -671,7 +671,7 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
 		return -EIO;
 	}
 
-	ret = clk_prepare_enable(i2c->clk);
+	ret = clk_enable(i2c->clk);
 	if (ret)
 		return ret;
 
@@ -697,7 +697,7 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
 	}
 
  out:
-	clk_disable_unprepare(i2c->clk);
+	clk_disable(i2c->clk);
 	return ret;
 }
 
@@ -803,6 +803,10 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2c);
 
+	clk_disable(i2c->clk);
+
+	return 0;
+
  err_clk:
 	clk_disable_unprepare(i2c->clk);
 	return ret;
@@ -814,6 +818,8 @@ static int exynos5_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&i2c->adap);
 
+	clk_unprepare(i2c->clk);
+
 	return 0;
 }
 
@@ -825,6 +831,8 @@ static int exynos5_i2c_suspend_noirq(struct device *dev)
 
 	i2c->suspended = 1;
 
+	clk_unprepare(i2c->clk);
+
 	return 0;
 }
 
@@ -845,7 +853,7 @@ static int exynos5_i2c_resume_noirq(struct device *dev)
 	}
 
 	exynos5_i2c_init(i2c);
-	clk_disable_unprepare(i2c->clk);
+	clk_disable(i2c->clk);
 	i2c->suspended = 0;
 
 	return 0;
-- 
2.5.5
