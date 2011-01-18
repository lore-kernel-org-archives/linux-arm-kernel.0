From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 18 Jan 2011 12:42:09 +0530
Subject: [PATCH V4 42/62] ST SPEAr13xx: Modified static mappings
In-Reply-To: <cover.1295333957.git.viresh.kumar@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
Message-ID: <25166d8371c3e1d6c94b9625ee8cdac06aecd58c.1295333959.git.viresh.kumar@st.com>
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
 arch/arm/mach-spear13xx/include/mach/hardware.h |    7 ++++++-
 arch/arm/mach-spear13xx/include/mach/vmalloc.h  |    2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

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
diff --git a/arch/arm/mach-spear13xx/include/mach/vmalloc.h b/arch/arm/mach-spear13xx/include/mach/vmalloc.h
index 85ad57e..0f243af 100644
--- a/arch/arm/mach-spear13xx/include/mach/vmalloc.h
+++ b/arch/arm/mach-spear13xx/include/mach/vmalloc.h
@@ -13,6 +13,6 @@
 #ifndef __MACH_VMALLOC_H
 #define __MACH_VMALLOC_H
 
-#include <plat/vmalloc.h>
+#define VMALLOC_END		0xEC800000UL
 
 #endif /* __MACH_VMALLOC_H */
-- 
1.7.2.2
