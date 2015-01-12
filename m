From: tyler.baker@linaro.org (Tyler Baker)
Date: Mon, 12 Jan 2015 07:54:46 -0800
Subject: [PATCH RESEND] reset: sunxi: fix spinlock initialization
Message-ID: <1421078086-27946-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call spin_lock_init() before the spinlocks are used, both in early init 
and probe functions preventing a lockdep splat.

I have been observing lockdep complaining [1] during boot on my a80 optimus [2]
when CONFIG_PROVE_LOCKING has been enabled. This patch resolves the splat,
and has been tested on a few other sunxi platforms without issue.

[1] http://storage.kernelci.org/next/next-20150107/arm-multi_v7_defconfig+CONFIG_PROVE_LOCKING=y/lab-tbaker/boot-sun9i-a80-optimus.html
[2] http://kernelci.org/boot/?a80-optimus

Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
Cc: <stable@vger.kernel.org>
---
 drivers/reset/reset-sunxi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
index eebc52c..3d95c87 100644
--- a/drivers/reset/reset-sunxi.c
+++ b/drivers/reset/reset-sunxi.c
@@ -102,6 +102,8 @@ static int sunxi_reset_init(struct device_node *np)
 		goto err_alloc;
 	}
 
+	spin_lock_init(&data->lock);
+
 	data->rcdev.owner = THIS_MODULE;
 	data->rcdev.nr_resets = size * 32;
 	data->rcdev.ops = &sunxi_reset_ops;
@@ -157,6 +159,8 @@ static int sunxi_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(data->membase))
 		return PTR_ERR(data->membase);
 
+	spin_lock_init(&data->lock);
+
 	data->rcdev.owner = THIS_MODULE;
 	data->rcdev.nr_resets = resource_size(res) * 32;
 	data->rcdev.ops = &sunxi_reset_ops;
-- 
2.1.3
