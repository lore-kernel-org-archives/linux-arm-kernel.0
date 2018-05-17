From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 17 May 2018 17:03:53 +0100
Subject: [PATCH] soc: qcom: apr: fix invalid msg_type check
Message-ID: <20180517160353.27561-1-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed invalid msg_type check.
This also fixes below static checker warning:
apr.c:95:35: warning: comparison is always true due to limited range of
 data type [-Wtype-limits]
warn: always true condition '(msg_type != 69864) => (0-u16max != 69864)'

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soc/qcom/apr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 97f3622da535..57af8a537332 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -92,7 +92,7 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
 	}
 
 	msg_type = APR_HDR_FIELD_MT(hdr->hdr_field);
-	if (msg_type >= APR_MSG_TYPE_MAX && msg_type != APR_BASIC_RSP_RESULT) {
+	if (msg_type >= APR_MSG_TYPE_MAX) {
 		dev_err(apr->dev, "APR: Wrong message type: %d\n", msg_type);
 		return -EINVAL;
 	}
-- 
2.16.2
