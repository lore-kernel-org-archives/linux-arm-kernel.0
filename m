From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Thu, 17 Mar 2016 17:57:07 +0800
Subject: [PATCH v6 08/17] Xen: public/hvm: sync changes of
 HVM_PARAM_CALLBACK_VIA ABI from Xen
In-Reply-To: <1458208636-12960-1-git-send-email-zhaoshenglong@huawei.com>
References: <1458208636-12960-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1458208636-12960-9-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Sync the changes of HVM_PARAM_CALLBACK_VIA ABI introduced by
Xen commit <ca5c54b6ff05> (public/hvm: export the HVM_PARAM_CALLBACK_VIA
ABI in the API).

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 include/xen/interface/hvm/params.h | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/xen/interface/hvm/params.h b/include/xen/interface/hvm/params.h
index a6c7991..70ad208 100644
--- a/include/xen/interface/hvm/params.h
+++ b/include/xen/interface/hvm/params.h
@@ -27,16 +27,31 @@
  * Parameter space for HVMOP_{set,get}_param.
  */
 
+#define HVM_PARAM_CALLBACK_IRQ 0
 /*
  * How should CPU0 event-channel notifications be delivered?
- * val[63:56] == 0: val[55:0] is a delivery GSI (Global System Interrupt).
- * val[63:56] == 1: val[55:0] is a delivery PCI INTx line, as follows:
- *                  Domain = val[47:32], Bus  = val[31:16],
- *                  DevFn  = val[15: 8], IntX = val[ 1: 0]
- * val[63:56] == 2: val[7:0] is a vector number.
+ *
  * If val == 0 then CPU0 event-channel notifications are not delivered.
+ * If val != 0, val[63:56] encodes the type, as follows:
+ */
+
+#define HVM_PARAM_CALLBACK_TYPE_GSI      0
+/*
+ * val[55:0] is a delivery GSI.  GSI 0 cannot be used, as it aliases val == 0,
+ * and disables all notifications.
+ */
+
+#define HVM_PARAM_CALLBACK_TYPE_PCI_INTX 1
+/*
+ * val[55:0] is a delivery PCI INTx line:
+ * Domain = val[47:32], Bus = val[31:16] DevFn = val[15:8], IntX = val[1:0]
+ */
+
+#define HVM_PARAM_CALLBACK_TYPE_VECTOR   2
+/*
+ * val[7:0] is a vector number.  Check for XENFEAT_hvm_callback_vector to know
+ * if this delivery method is available.
  */
-#define HVM_PARAM_CALLBACK_IRQ 0
 
 #define HVM_PARAM_STORE_PFN    1
 #define HVM_PARAM_STORE_EVTCHN 2
-- 
2.0.4
