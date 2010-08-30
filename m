From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:09:18 +0530
Subject: [PATCH 55/74] ST SPEAr13xx: Modified static mappings
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <ba740ee450513a415e666299a0dbaee871014cb4.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

The new static io mappings map regions in 0xE...,.... space to
0xF...,.... and those in space 0x6...,.... to 0xE...,.... range.
This is done to accomodate regions of RAS configuration registers to be
used by clock frameowrk and possibly others.

Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/hardware.h  |    7 ++++++-
 arch/arm/mach-spear13xx/include/mach/spear1310.h |    1 +
 arch/arm/mach-spear13xx/include/mach/vmalloc.h   |    2 +-
 arch/arm/mach-spear13xx/spear13xx.c              |    8 ++++++++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/hardware.h b/arch/arm/mach-spear13xx/include/mach/hardware.h
index 4abc2c0..44cd0c2 100644
--- a/arch/arm/mach-spear13xx/include/mach/hardware.h
+++ b/arch/arm/mach-spear13xx/include/mach/hardware.h
@@ -17,7 +17,12 @@
 #include <mach/spear.h>
 
 /* Vitual to physical translation of statically mapped space */
-#define IO_ADDRESS(x)		(x | 0xF0000000)
+/*
+ * if phy_addr is 0x8...,.... and above then map it to  0xF...,....
+ * else map it to 0xE...,....
+ */
+
+#define IO_ADDRESS(x)   ((x) | ((((x) >> 31) << 28) | 0xE0000000))
 
 /* typesafe io address */
 #define __io_address(n)		__io(IO_ADDRESS(n))
diff --git a/arch/arm/mach-spear13xx/include/mach/spear1310.h b/arch/arm/mach-spear13xx/include/mach/spear1310.h
index d1735e8..e3d347c 100644
--- a/arch/arm/mach-spear13xx/include/mach/spear1310.h
+++ b/arch/arm/mach-spear13xx/include/mach/spear1310.h
@@ -18,6 +18,7 @@
 
 #define SPEAR1310_CAN0_BASE		UL(0x6DA00000)
 #define SPEAR1310_CAN1_BASE		UL(0x6DB00000)
+#define SPEAR1310_RAS_BASE		UL(0x6C800000)
 
 #endif /* __MACH_SPEAR1310_H */
 
diff --git a/arch/arm/mach-spear13xx/include/mach/vmalloc.h b/arch/arm/mach-spear13xx/include/mach/vmalloc.h
index 85ad57e..9f329d1 100644
--- a/arch/arm/mach-spear13xx/include/mach/vmalloc.h
+++ b/arch/arm/mach-spear13xx/include/mach/vmalloc.h
@@ -13,6 +13,6 @@
 #ifndef __MACH_VMALLOC_H
 #define __MACH_VMALLOC_H
 
-#include <plat/vmalloc.h>
+#define VMALLOC_END		0xEC800000
 
 #endif /* __MACH_VMALLOC_H */
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 48cdff2..05ae8f5 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -570,6 +570,14 @@ struct map_desc spear13xx_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(SPEAR13XX_SYSRAM1_BASE),
 		.length		= SZ_1M,
 		.type		= MT_MEMORY_NONCACHED
+#ifdef CONFIG_MACH_SPEAR1310
+	}, {
+		.virtual	= IO_ADDRESS(SPEAR1310_RAS_BASE),
+		.pfn		= __phys_to_pfn(SPEAR1310_RAS_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE
+
+#endif
 	},
 };
 
-- 
1.7.2.2
