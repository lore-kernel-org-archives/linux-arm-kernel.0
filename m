From: etienne.carriere@st.com (Etienne CARRIERE)
Date: Tue, 13 Nov 2012 17:08:16 +0100
Subject: [PATCH 2/2] mach-ux500: L2CC shared mutex with ARM TZ
Message-ID: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1B5A@SAFEX1MAIL3.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Etienne Carriere <etienne.carriere@stericsson.com>

L2 cache mutex is allocated in DDR from TZ/TEE.
Linux retrieves its physical address using from TEE API.
It maps it to the kernel address space.
Mutex needs to be cacheable, as configured in TZ MMU mapping
Once configured from TEE, enable its use by l2cc driver.

This patch assumes no L2 cache maintenance is request to TEE
inside the time frame from linux early boot to this "late_initcall
of "romcode-sm" probing. The SW architecture insures that.

This patch is an example of how ux500 plans to load the TZ shared
mutex into outer cache driver.
This patch cannot hit kernel main track. It targets internal kernel
Trees with enabled TEE driver (API to TZ world).

Signed-off-by: carriere etienne <etienne.carriere@stericsson.com>
---
arch/arm/mach-ux500/romcode-shared_mutex.c | 111 +++++++++++++++++++++++++++++
1 file changed, 111 insertions(+)

diff --git a/arch/arm/mach-ux500/romcode-shared_mutex.c b/arch/arm/mach-ux500/romcode-shared_mutex.c
new file mode 100644
index 0000000..a09df72
--- /dev/null
+++ b/arch/arm/mach-ux500/romcode-shared_mutex.c
@@ -0,0 +1,111 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ * License terms:  GNU General Public License (GPL), version 2
+ * Author:  Etienne Carriere <etienne.carriere@stericsson.com> for ST-Ericsson.
+ *
+ * ROM code Mutex Configuration for A9 exclusive load and store operation
+ * for l2 cache maintenance.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/tee.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include <mach/hardware.h>
+#include <asm/outercache.h>
+
+#define BASS_ROMCODE_SHARED_MUTEX           0
+
+#define UUID_TEE_TA_START_LOW    0xBC765EDE
+#define UUID_TEE_TA_START_MID     0x6724
+#define UUID_TEE_TA_START_HIGH   0x11DF
+#define UUID_TEE_TA_START_CLOCKSEQ  \
+             {0x8E, 0x12, 0xEC, 0xDB, 0xDF, 0xD7, 0x20, 0x85}
+
+static int __devinit shared_mutex_config_probe(struct platform_device *pdev)
+{
+             struct tee_operation op;
+             struct tee_session sess;
+             struct tee_context ctx;
+             uint32_t mutex_type = BASS_ROMCODE_SHARED_MUTEX;
+             unsigned int paddr;
+             void __iomem *vaddr;
+             int err, ori;
+
+             /* Selects trustzone application needed for the job. */
+             struct tee_uuid static_uuid = {
+                             UUID_TEE_TA_START_LOW,
+                             UUID_TEE_TA_START_MID,
+                             UUID_TEE_TA_START_HIGH,
+                             UUID_TEE_TA_START_CLOCKSEQ,
+             };
+
+             err = teec_initialize_context(NULL, &ctx);
+             if (err) {
+                             pr_err("%s: context init failed, 0x%X\n", __func__, err);
+                             err = -EINVAL;
+                             goto out;
+             }
+
+             err = teec_open_session(&ctx, &sess, &static_uuid,
+                                             TEEC_LOGIN_PUBLIC, NULL, NULL, &ori);
+             if (err) {
+                             pr_err("%s: session failed, 0x%X/0x%X\n", __func__, err, ori);
+                             err = -EINVAL;
+                             goto out1;
+             }
+
+             memset(&op, 0, sizeof(op));
+             op.param[0].tmpref.buffer = (void *)&paddr;
+             op.param[0].tmpref.size = sizeof(uint32_t *);
+             op.param[1].tmpref.buffer = (void *)&mutex_type;
+             op.param[1].tmpref.size = sizeof(uint32_t);
+             op.types = TEEC_PARAM_TYPES(TEEC_MEMREF_TEMP_OUTPUT,
+                                             TEEC_MEMREF_TEMP_INPUT, TEEC_NONE, TEEC_NONE);
+
+             err = teec_invoke_command(&sess, TEE_STA_CONF_SHARED_MUTEX, &op, &ori);
+             if (err) {
+                             pr_err("%s: init failed, 0x%X/0x%X", __func__, err, ori);
+                             err = -EINVAL;
+                             goto out2;
+             }
+
+             vaddr = ioremap_cached((unsigned long)paddr, SZ_1K);
+             if (vaddr == NULL) {
+                             pr_err("%s: mutex map failed, 0x%X\n", __func__, paddr);
+                             err = -EIO;
+                             goto out2;
+             }
+
+             if (!outer_tz_mutex((unsigned long)vaddr)) {
+                             pr_err("%s: load mutex 0x%08X failed\n", __func__, (uint)vaddr);
+                             err = -EIO;
+             }
+out2:
+             (void)teec_close_session(&sess);
+out1:
+             (void)teec_finalize_context(&ctx);
+out:
+             return err;
+}
+
+static struct platform_driver romcode_sm_driver = {
+             .driver = {
+                             .name = "romcode-sm",
+                             .owner = THIS_MODULE,
+             },
+             .probe = shared_mutex_config_probe,
+};
+
+static int __init shared_mutex_config_init(void)
+{
+             return platform_driver_register(&romcode_sm_driver);
+}
+
+/* Wait for TEE driver to be initialized. */
+late_initcall(shared_mutex_config_init);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("TZ shared mutex config");



--

1.7.11.3

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/2b6c134d/attachment-0001.html>
