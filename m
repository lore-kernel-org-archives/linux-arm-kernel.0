From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jun 2011 09:19:34 +0100
Subject: [PATCH v3 04/10] ARM: hwcaps: add new HWCAP defines for ARMv7-A
In-Reply-To: <1308298780-28000-1-git-send-email-will.deacon@arm.com>
References: <1308298780-28000-1-git-send-email-will.deacon@arm.com>
Message-ID: <1308298780-28000-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern ARMv7-A cores can optionally implement these new hardware
features:

- VFPv4:
    The latest version of the ARMv7 vector floating-point extensions,
    including hardware support for fused multiple accumulate. D16 or D32
    variants may be implemented.

- Integer divide:
    The SDIV and UDIV instructions provide signed and unsigned integer
    division in hardware. When implemented, these instructions may be
    available in either both Thumb and ARM, or Thumb only.

This patch adds new HWCAP defines to describe these new features. The
integer divide capabilities are split into two bits for ARM and Thumb
respectively. Whilst HWCAP_IDIVA should never be set if HWCAP_IDIVT is
clear, separating the bits makes it easier to interpret from userspace.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/hwcap.h |    4 ++++
 arch/arm/kernel/setup.c      |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/hwcap.h b/arch/arm/include/asm/hwcap.h
index 81512db..c93a22a 100644
--- a/arch/arm/include/asm/hwcap.h
+++ b/arch/arm/include/asm/hwcap.h
@@ -20,6 +20,10 @@
 #define HWCAP_VFPv3	(1 << 13)
 #define HWCAP_VFPv3D16	(1 << 14)
 #define HWCAP_TLS	(1 << 15)
+#define HWCAP_VFPv4	(1 << 16)
+#define HWCAP_IDIVA	(1 << 17)
+#define HWCAP_IDIVT	(1 << 18)
+#define HWCAP_IDIV	(HWCAP_IDIVA | HWCAP_IDIVT)
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 /*
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index ed11fb0..699df68 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -977,6 +977,10 @@ static const char *hwcap_str[] = {
 	"neon",
 	"vfpv3",
 	"vfpv3d16",
+	"tls",
+	"vfpv4",
+	"idiva",
+	"idivt",
 	NULL
 };
 
-- 
1.7.0.4
