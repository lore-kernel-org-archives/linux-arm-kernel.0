From: jerome.forissier@linaro.org (Jerome Forissier)
Date: Fri, 24 Nov 2017 15:47:17 +0100
Subject: [PATCH 1/2] tee: optee: GET_OS_REVISION: document a2 as a build
 identifier
In-Reply-To: <cover.1511533457.git.jerome.forissier@linaro.org>
References: <cover.1511533457.git.jerome.forissier@linaro.org>
Message-ID: <23a6eaf6eeeb7111649280ecd6fd6be3d7900a07.1511533457.git.jerome.forissier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the OPTEE_SMC_CALL_GET_OS_REVISION request, the previously reserved
parameter a2 is now documented as being an optional build identifier
(such as an SCM revision or commit ID, for instance).

A new structure optee_smc_call_get_os_revision_result is introduced to
be used when querying the secure OS version, instead of re-using the
struct defined for OPTEE_SMC_CALLS_REVISION.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/tee/optee/optee_smc.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 069c8e1429de..d0b67c65ea8f 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -112,12 +112,20 @@ struct optee_smc_calls_revision_result {
  * Trusted OS, not of the API.
  *
  * Returns revision in a0-1 in the same way as OPTEE_SMC_CALLS_REVISION
- * described above.
+ * described above. May optionally return a 32-bit build identifier in a2,
+ * with zero meaning unspecified.
  */
 #define OPTEE_SMC_FUNCID_GET_OS_REVISION OPTEE_MSG_FUNCID_GET_OS_REVISION
 #define OPTEE_SMC_CALL_GET_OS_REVISION \
 	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_OS_REVISION)
 
+struct optee_smc_call_get_os_revision_result {
+	unsigned long major;
+	unsigned long minor;
+	unsigned long build_id;
+	unsigned long reserved1;
+};
+
 /*
  * Call with struct optee_msg_arg as argument
  *
-- 
2.7.4
