From: tbaicar@codeaurora.org (Tyler Baicar)
Date: Mon, 16 Jul 2018 13:26:49 -0400
Subject: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
Message-ID: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable per-layer error reporting for ARM systems so that the error
counters are incremented per-DIMM.

On ARM systems that use firmware first error handling it is understood
that card=channel and module=DIMM on that channel. Populate that
information and enable per layer error reporting for ARM systems so that
the EDAC error counters are incremented based on DIMM number as per the
SMBIOS table rather than just incrementing the noinfo counters on the
memory controller.

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 drivers/edac/ghes_edac.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 473aeec..e4c8b6e 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -213,9 +213,18 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	strcpy(e->label, "unknown label");
 	e->msg = pvt->msg;
 	e->other_detail = pvt->other_detail;
-	e->top_layer = -1;
-	e->mid_layer = -1;
-	e->low_layer = -1;
+	if ((IS_ENABLED(CONFIG_ARM) || IS_ENABLED(CONFIG_ARM64))
+	    && (mem_err->validation_bits & CPER_MEM_VALID_CARD)
+	    && (mem_err->validation_bits & CPER_MEM_VALID_MODULE)) {
+		e->top_layer = mem_err->card;
+		e->mid_layer = mem_err->module;
+		e->low_layer = -1;
+		e->enable_per_layer_report = true;
+	} else {
+		e->top_layer = -1;
+		e->mid_layer = -1;
+		e->low_layer = -1;
+	}
 	*pvt->other_detail = '\0';
 	*pvt->msg = '\0';
 
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
