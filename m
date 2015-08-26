From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Wed, 26 Aug 2015 19:15:05 +0300
Subject: [PATCH 2/4] efi/runtime-wrappers,
 kasan: don't sanitize runtime wrappers.
In-Reply-To: <1440605707-8325-1-git-send-email-ryabinin.a.a@gmail.com>
References: <1440605707-8325-1-git-send-email-ryabinin.a.a@gmail.com>
Message-ID: <1440605707-8325-3-git-send-email-ryabinin.a.a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 maps efi runtime services in userspace addresses
which don't have KASAN shadow. So dereferencing these addresses
in efi_call_virt() will cause crash if this code instrumented.

Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
---
 drivers/firmware/efi/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 6fd3da9..413fcf2 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -1,6 +1,14 @@
 #
 # Makefile for linux kernel
 #
+
+#
+# ARM64 maps efi runtime services in userspace addresses
+# which don't have KASAN shadow. So dereference of these addresses
+# in efi_call_virt() will cause crash if this code instrumented.
+#
+KASAN_SANITIZE_runtime-wrappers.o	:= n
+
 obj-$(CONFIG_EFI)			+= efi.o vars.o reboot.o
 obj-$(CONFIG_EFI_VARS)			+= efivars.o
 obj-$(CONFIG_EFI_ESRT)			+= esrt.o
-- 
2.4.6
