From: geoff@infradead.org (Geoff Levand)
Date: Fri, 14 Nov 2014 13:08:47 -0800
Subject: [PATCH v3 7/8] arm64/kexec: Add checks for KVM and EFI
In-Reply-To: <b7b2f48822a563bafe2888d7ac8e863731159796.1415926876.git.geoff@infradead.org>
References: <cover.1415926876.git.geoff@infradead.org>
 <b7b2f48822a563bafe2888d7ac8e863731159796.1415926876.git.geoff@infradead.org>
Message-ID: <1415999327.15847.123.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add runtime checks that fail the arm64 kexec syscall for situations that would
result in system instability do to problems in the KVM and EFI kernel support.
These checks should be removed when the KVM and EFI problems are fixed.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
v2: Typo fixes.
v3: Format fixes.

 arch/arm64/kernel/machine_kexec.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 3d84759..e7f036e 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -16,6 +16,12 @@
 #include <asm/cacheflush.h>
 #include <asm/system_misc.h>
 
+/* TODO: Remove this include when KVM can support a kexec reboot. */
+#include <asm/virt.h>
+
+/* TODO: Remove this include when EFI can support a kexec reboot. */
+#include <linux/efi.h>
+
 /* Global variables for the relocate_kernel routine. */
 extern const unsigned char relocate_new_kernel[];
 extern const unsigned long relocate_new_kernel_size;
@@ -100,6 +106,20 @@ int machine_kexec_prepare(struct kimage *image)
 
 	kexec_image_info(image);
 
+	/* TODO: Remove this message when KVM can support a kexec reboot. */
+	if (IS_ENABLED(CONFIG_KVM) && is_hyp_mode_available()) {
+		pr_err("%s: Your kernel is configured with KVM support (CONFIG_KVM=y) which currently does not allow for kexec re-boot.\n",
+			__func__);
+		return -ENOSYS;
+	}
+
+	/* TODO: Remove this message when EFI can support a kexec reboot. */
+	if (efi_enabled(EFI_BOOT)) {
+		pr_err("%s: Your kernel is using the Extensible Firmware Interface (EFI) which currently does not allow for kexec re-boot.\n",
+			__func__);
+		return -ENOSYS;
+	}
+
 	return 0;
 }
 
-- 
1.9.1
