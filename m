From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Fri,  2 Mar 2018 14:55:29 +0000
Subject: [PATCH 1/3] rpmsg: core: export rpmsg bus type
In-Reply-To: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
References: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180302145531.20463-2-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Export rpmsg bus type so that iommu drivers iommu ops to
rpmsg bus type.

On Qualcomm SoCs ADSP exposes functions like audio and
other which need iommu access, as these drivers are part
of rpmsg bus, able to allocate memory from iommus is basic
requirement. So expose this bus so that iommu drivers can
add ops to this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/rpmsg/rpmsg_core.c | 3 ++-
 include/linux/rpmsg.h      | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 5a081762afcc..e84c71f8d6ab 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -465,7 +465,7 @@ static int rpmsg_dev_remove(struct device *dev)
 	return err;
 }
 
-static struct bus_type rpmsg_bus = {
+struct bus_type rpmsg_bus = {
 	.name		= "rpmsg",
 	.match		= rpmsg_dev_match,
 	.dev_groups	= rpmsg_dev_groups,
@@ -473,6 +473,7 @@ static struct bus_type rpmsg_bus = {
 	.probe		= rpmsg_dev_probe,
 	.remove		= rpmsg_dev_remove,
 };
+EXPORT_SYMBOL(rpmsg_bus);
 
 int rpmsg_register_device(struct rpmsg_device *rpdev)
 {
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index ca07366c4c33..869e5946b7df 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -49,7 +49,7 @@ struct rpmsg_device;
 struct rpmsg_endpoint;
 struct rpmsg_device_ops;
 struct rpmsg_endpoint_ops;
-
+extern struct bus_type rpmsg_bus;
 /**
  * struct rpmsg_channel_info - channel info representation
  * @name: name of service
-- 
2.15.1
