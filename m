From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Thu, 31 May 2018 20:41:46 +0800
Subject: [PATCH v1 2/2] arm64: handle NOTIFY_SEI notification by the APEI
 driver
In-Reply-To: <1527770506-8076-1-git-send-email-gengdongjiu@huawei.com>
References: <1527770506-8076-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <1527770506-8076-3-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When kernel or KVM gets the NOTIFY_SEI notification, it firstly
calls the APEI driver to handle this notification.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 arch/arm64/kernel/traps.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
---
change since https://www.spinics.net/lists/kvm/msg168919.html

1. Remove the handle_guest_sei() helper


diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 8bbdc17..676e40c 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -50,6 +50,7 @@
 #include <asm/exception.h>
 #include <asm/system_misc.h>
 #include <asm/sysreg.h>
+#include <acpi/ghes.h>
 
 static const char *handler[]= {
 	"Synchronous Abort",
@@ -701,6 +702,20 @@ void __noreturn arm64_serror_panic(struct pt_regs *regs, u32 esr)
 bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
 {
 	u32 aet = arm64_ras_serror_get_severity(esr);
+	int ret = -ENOENT;
+
+	if (IS_ENABLED(CONFIG_ACPI_APEI_SEI)) {
+		if (interrupts_enabled(regs))
+			nmi_enter();
+
+		ret = ghes_notify_sei();
+
+		if (interrupts_enabled(regs))
+			nmi_exit();
+
+		if (!ret)
+			return false;
+	}
 
 	switch (aet) {
 	case ESR_ELx_AET_CE:	/* corrected error */
-- 
1.9.1
