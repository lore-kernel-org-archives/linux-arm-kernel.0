From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 06 Jun 2016 17:59:08 +0100
Subject: [PATCH kexec-tools v2 05/32] arm: fix kdump to work on LPAE systems
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
Message-ID: <E1b9xro-0003rt-BQ@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to use 64-bit file IO when mapping system memory and the core
dump file as we may be running on a LPAE system, otherwise we risk
mapping memory we shouldn't, and causing a kernel oops:

Unhandled fault: asynchronous external abort (0x211) at 0x00000000
pgd = edd2c740
[00000000] *pgd=82ec98003, *pmd=82dcd2003, *pte=00000000

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
index 38137d7..60e433a 100644
--- a/kexec/arch/arm/Makefile
+++ b/kexec/arch/arm/Makefile
@@ -18,6 +18,9 @@ libfdt_SRCS += $(LIBFDT_SRCS:%=kexec/libfdt/%)
 
 arm_CPPFLAGS = -I$(srcdir)/kexec/libfdt
 
+# We want 64-bit file IO for kdump to work correctly on LPAE systems
+arm_CPPFLAGS += -D_FILE_OFFSET_BITS=64
+
 arm_KEXEC_SRCS += $(libfdt_SRCS)
 
 arm_UIMAGE = kexec/kexec-uImage.c
-- 
1.9.1
