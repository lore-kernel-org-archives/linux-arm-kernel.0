From: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 03 May 2016 11:21:28 +0100
Subject: [PATCH kexec-tools 05/32] arm: fix kdump to work on LPAE systems
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
Message-ID: <E1axXSK-0004hN-V7@e0050434b2927.dyn.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to use 64-bit file IO when mapping system memory and the core
dump file as we may be running on a LPAE system, otherwise we risk
mapping memory we shouldn't, and causing a kernel oops:

Unhandled fault: asynchronous external abort (0x211) at 0x00000000
pgd = edd2c740
[00000000] *pgd=82ec98003, *pmd=82dcd2003, *pte=00000000

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
