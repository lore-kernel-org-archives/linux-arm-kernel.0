From: jerome.forissier@linaro.org (Jerome Forissier)
Date: Fri, 24 Nov 2017 15:47:18 +0100
Subject: [PATCH 2/2] tee: optee: report OP-TEE revision information
In-Reply-To: <cover.1511533457.git.jerome.forissier@linaro.org>
References: <cover.1511533457.git.jerome.forissier@linaro.org>
Message-ID: <00cdd293320d68f0d315ffc4c1957cfa90fdfb73.1511533457.git.jerome.forissier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the driver initializes, report the following information
about the OP-TEE OS:
- major and minor version,
- build identifier (if available).

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/tee/optee/core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 7952357df9c8..d04f4617aed2 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -302,6 +302,27 @@ static bool optee_msg_api_uid_is_optee_api(optee_invoke_fn *invoke_fn)
 	return false;
 }
 
+static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
+{
+	union {
+		struct arm_smccc_res smccc;
+		struct optee_smc_call_get_os_revision_result result;
+	} res = {
+		.result = {
+			.build_id = 0
+		}
+	};
+
+	invoke_fn(OPTEE_SMC_CALL_GET_OS_REVISION, 0, 0, 0, 0, 0, 0, 0,
+		  &res.smccc);
+
+	if (res.result.build_id)
+		pr_info("revision %lu.%lu (%08lx)", res.result.major,
+			res.result.minor, res.result.build_id);
+	else
+		pr_info("revision %lu.%lu", res.result.major, res.result.minor);
+}
+
 static bool optee_msg_api_revision_is_compatible(optee_invoke_fn *invoke_fn)
 {
 	union {
@@ -465,6 +486,8 @@ static struct optee *optee_probe(struct device_node *np)
 		return ERR_PTR(-EINVAL);
 	}
 
+	optee_msg_get_os_revision(invoke_fn);
+
 	if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
 		pr_warn("api revision mismatch\n");
 		return ERR_PTR(-EINVAL);
-- 
2.7.4
