From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 26 Oct 2015 10:56:09 +0000
Subject: [PATCH 3/3] reset: sti: Provide ops .status() call-back
In-Reply-To: <1445856969-19424-1-git-send-email-lee.jones@linaro.org>
References: <1445856969-19424-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1445856969-19424-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/reset/sti/reset-syscfg.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/reset/sti/reset-syscfg.c b/drivers/reset/sti/reset-syscfg.c
index a145cc0..4453412 100644
--- a/drivers/reset/sti/reset-syscfg.c
+++ b/drivers/reset/sti/reset-syscfg.c
@@ -110,10 +110,33 @@ static int syscfg_reset_dev(struct reset_controller_dev *rcdev,
 	return syscfg_reset_deassert(rcdev, idx);
 }
 
+static int syscfg_reset_status(struct reset_controller_dev *rcdev,
+			      unsigned long idx)
+{
+       struct syscfg_reset_controller *rst = to_syscfg_reset_controller(rcdev);
+       const struct syscfg_reset_channel *ch;
+       u32 ret_val = 0;
+       int err;
+
+       if (idx >= rcdev->nr_resets)
+	       return -EINVAL;
+
+       ch = &rst->channels[idx];
+       if (ch->ack)
+	       err = regmap_field_read(ch->ack, &ret_val);
+       else
+	       err = regmap_field_read(ch->reset, &ret_val);
+       if (err)
+	       return err;
+
+       return rst->active_low ? !ret_val : !!ret_val;
+}
+
 static struct reset_control_ops syscfg_reset_ops = {
 	.reset    = syscfg_reset_dev,
 	.assert   = syscfg_reset_assert,
 	.deassert = syscfg_reset_deassert,
+	.status   = syscfg_reset_status,
 };
 
 static int syscfg_reset_controller_register(struct device *dev,
-- 
1.9.1
