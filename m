From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  6 Jan 2016 17:12:47 -0800
Subject: [PATCH 1/3] driver-core: platform: Add platform_irq_count()
In-Reply-To: <1452129169-2014-1-git-send-email-sboyd@codeaurora.org>
References: <1452129169-2014-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1452129169-2014-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent patch added calls to of_irq_count() in the qcom pinctrl
drivers and that caused module build failures because
of_irq_count() is not an exported symbol. We shouldn't export
of_irq_count() to modules because it's an internal OF API that
shouldn't be used by drivers. Platform drivers should use
platform device APIs instead. Therefore, add a platform_irq_count()
API that mirrors the of_irq_count() API so that platform drivers
can stay DT agnostic.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/platform.c         | 20 ++++++++++++++++++++
 include/linux/platform_device.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index d77ed0c946dd..8dcbb266643b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -118,6 +118,26 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 EXPORT_SYMBOL_GPL(platform_get_irq);
 
 /**
+ * platform_irq_count - Count the number of IRQs a platform device uses
+ * @dev: platform device
+ *
+ * Return: Number of IRQs a platform device uses or EPROBE_DEFER
+ */
+int platform_irq_count(struct platform_device *dev)
+{
+	int ret, nr = 0;
+
+	while ((ret = platform_get_irq(dev, nr)) >= 0)
+		nr++;
+
+	if (ret == -EPROBE_DEFER)
+		return ret;
+
+	return nr;
+}
+EXPORT_SYMBOL_GPL(platform_irq_count);
+
+/**
  * platform_get_resource_byname - get a resource for a device by name
  * @dev: platform device
  * @type: resource type
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index dba40b1c41dc..03b755521fd9 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -52,6 +52,7 @@ extern void arch_setup_pdev_archdata(struct platform_device *);
 extern struct resource *platform_get_resource(struct platform_device *,
 					      unsigned int, unsigned int);
 extern int platform_get_irq(struct platform_device *, unsigned int);
+extern int platform_irq_count(struct platform_device *);
 extern struct resource *platform_get_resource_byname(struct platform_device *,
 						     unsigned int,
 						     const char *);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
