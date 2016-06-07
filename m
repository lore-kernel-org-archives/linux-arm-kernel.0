From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue,  7 Jun 2016 09:47:40 -0700
Subject: [RESEND/PATCHv4 v4 2/3] firmware: Provide infrastructure to make fw
 caching optional
In-Reply-To: <20160607164741.31849-1-stephen.boyd@linaro.org>
References: <20160607164741.31849-1-stephen.boyd@linaro.org>
Message-ID: <20160607164741.31849-3-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vikram Mulukutla <markivx@codeaurora.org>

Some low memory systems with complex peripherals cannot afford to
have the relatively large firmware images taking up valuable
memory during suspend and resume. Change the internal
implementation of firmware_class to disallow caching based on a
configurable option. In the near future, variants of
request_firmware will take advantage of this feature.

Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
[stephen.boyd at linaro.org: Drop firmware_desc design and use flags]
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/base/firmware_class.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 01d55723d82c..45ed20cefa10 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -112,6 +112,7 @@ static inline long firmware_loading_timeout(void)
 #define FW_OPT_FALLBACK		0
 #endif
 #define FW_OPT_NO_WARN	(1U << 3)
+#define FW_OPT_NOCACHE	(1U << 4)
 
 struct firmware_cache {
 	/* firmware_buf instance will be added into the below list */
@@ -1065,14 +1066,16 @@ static int assign_firmware_buf(struct firmware *fw, struct device *device,
 	 * should be fixed in devres or driver core.
 	 */
 	/* don't cache firmware handled without uevent */
-	if (device && (opt_flags & FW_OPT_UEVENT))
+	if (device && (opt_flags & FW_OPT_UEVENT) &&
+	    !(opt_flags & FW_OPT_NOCACHE))
 		fw_add_devm_name(device, buf->fw_id);
 
 	/*
 	 * After caching firmware image is started, let it piggyback
 	 * on request firmware.
 	 */
-	if (buf->fwc->state == FW_LOADER_START_CACHE) {
+	if (!(opt_flags & FW_OPT_NOCACHE) &&
+	    buf->fwc->state == FW_LOADER_START_CACHE) {
 		if (fw_cache_piggyback_on_request(buf->fw_id))
 			kref_get(&buf->ref);
 	}
-- 
2.9.0-rc1
