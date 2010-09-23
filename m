From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 23 Sep 2010 17:04:00 -0400 (EDT)
Subject: [PATCH] ARM: do not define VMALLOC_END relative to PAGE_OFFSET
Message-ID: <alpine.LFD.2.00.1009231703010.13233@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


VMALLOC_END is supposed to be an absolute value, while PAGE_OFFSET may
vary depending on the selected user:kernel memory split mode through
CONFIG_VMSPLIT_*.  In fact, the goal of moving PAGE_OFFSET down is to
accommodate more directly addressed RAM by the kernel below the vmalloc
area, and having VMALLOC_END move along PAGE_OFFSET is rather against
the very reason why PAGE_OFFSET can be moved in the first place.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

diff --git a/arch/arm/mach-aaec2000/include/mach/vmalloc.h b/arch/arm/mach-aaec2000/include/mach/vmalloc.h
index 551f68f..cff4e0a 100644
--- a/arch/arm/mach-aaec2000/include/mach/vmalloc.h
+++ b/arch/arm/mach-aaec2000/include/mach/vmalloc.h
@@ -11,6 +11,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END		(PAGE_OFFSET + 0x10000000)
+#define VMALLOC_END		0xd0000000
 
 #endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-bcmring/include/mach/vmalloc.h b/arch/arm/mach-bcmring/include/mach/vmalloc.h
index 35e2ead..3db3a09 100644
--- a/arch/arm/mach-bcmring/include/mach/vmalloc.h
+++ b/arch/arm/mach-bcmring/include/mach/vmalloc.h
@@ -22,4 +22,4 @@
  * 0xe0000000 to 0xefffffff. This gives us 256 MB of vm space and handles
  * larger physical memory designs better.
  */
-#define VMALLOC_END       (PAGE_OFFSET + 0x30000000)
+#define VMALLOC_END       0xf0000000
diff --git a/arch/arm/mach-clps711x/include/mach/vmalloc.h b/arch/arm/mach-clps711x/include/mach/vmalloc.h
index ea6cc7b..30b3a287 100644
--- a/arch/arm/mach-clps711x/include/mach/vmalloc.h
+++ b/arch/arm/mach-clps711x/include/mach/vmalloc.h
@@ -17,4 +17,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define VMALLOC_END       (PAGE_OFFSET + 0x10000000)
+#define VMALLOC_END       0xd0000000
diff --git a/arch/arm/mach-ebsa110/include/mach/vmalloc.h b/arch/arm/mach-ebsa110/include/mach/vmalloc.h
index 9b44c19..60bde56 100644
--- a/arch/arm/mach-ebsa110/include/mach/vmalloc.h
+++ b/arch/arm/mach-ebsa110/include/mach/vmalloc.h
@@ -7,4 +7,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#define VMALLOC_END       (PAGE_OFFSET + 0x1f000000)
+#define VMALLOC_END       0xdf000000
diff --git a/arch/arm/mach-footbridge/include/mach/vmalloc.h b/arch/arm/mach-footbridge/include/mach/vmalloc.h
index d0958d8..0ffbb7c 100644
--- a/arch/arm/mach-footbridge/include/mach/vmalloc.h
+++ b/arch/arm/mach-footbridge/include/mach/vmalloc.h
@@ -7,4 +7,4 @@
  */
 
 
-#define VMALLOC_END       (PAGE_OFFSET + 0x30000000)
+#define VMALLOC_END       0xf0000000
diff --git a/arch/arm/mach-h720x/include/mach/vmalloc.h b/arch/arm/mach-h720x/include/mach/vmalloc.h
index ff1460d..a45915b 100644
--- a/arch/arm/mach-h720x/include/mach/vmalloc.h
+++ b/arch/arm/mach-h720x/include/mach/vmalloc.h
@@ -5,6 +5,6 @@
 #ifndef __ARCH_ARM_VMALLOC_H
 #define __ARCH_ARM_VMALLOC_H
 
-#define VMALLOC_END       (PAGE_OFFSET + 0x10000000)
+#define VMALLOC_END       0xd0000000
 
 #endif
diff --git a/arch/arm/mach-integrator/include/mach/vmalloc.h b/arch/arm/mach-integrator/include/mach/vmalloc.h
index e87ab0b..e056e7c 100644
--- a/arch/arm/mach-integrator/include/mach/vmalloc.h
+++ b/arch/arm/mach-integrator/include/mach/vmalloc.h
@@ -17,4 +17,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define VMALLOC_END       (PAGE_OFFSET + 0x10000000)
+#define VMALLOC_END       0xd0000000
diff --git a/arch/arm/mach-msm/include/mach/vmalloc.h b/arch/arm/mach-msm/include/mach/vmalloc.h
index 05f81fd..31a32ad 100644
--- a/arch/arm/mach-msm/include/mach/vmalloc.h
+++ b/arch/arm/mach-msm/include/mach/vmalloc.h
@@ -16,7 +16,7 @@
 #ifndef __ASM_ARCH_MSM_VMALLOC_H
 #define __ASM_ARCH_MSM_VMALLOC_H
 
-#define VMALLOC_END	  (PAGE_OFFSET + 0x10000000)
+#define VMALLOC_END	  0xd0000000
 
 #endif
 
diff --git a/arch/arm/mach-netx/include/mach/vmalloc.h b/arch/arm/mach-netx/include/mach/vmalloc.h
index 25d5cc6..7cca357 100644
--- a/arch/arm/mach-netx/include/mach/vmalloc.h
+++ b/arch/arm/mach-netx/include/mach/vmalloc.h
@@ -16,4 +16,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define VMALLOC_END       (PAGE_OFFSET + 0x10000000)
+#define VMALLOC_END       0xd0000000
diff --git a/arch/arm/mach-omap1/include/mach/vmalloc.h b/arch/arm/mach-omap1/include/mach/vmalloc.h
index 1b2af14..b001f67 100644
--- a/arch/arm/mach-omap1/include/mach/vmalloc.h
+++ b/arch/arm/mach-omap1/include/mach/vmalloc.h
@@ -17,4 +17,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
-#define VMALLOC_END	(PAGE_OFFSET + 0x18000000)
+#define VMALLOC_END	0xd8000000
diff --git a/arch/arm/mach-omap2/include/mach/vmalloc.h b/arch/arm/mach-omap2/include/mach/vmalloc.h
index 9ce9b6e..4da31e9 100644
--- a/arch/arm/mach-omap2/include/mach/vmalloc.h
+++ b/arch/arm/mach-omap2/include/mach/vmalloc.h
@@ -17,4 +17,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
-#define VMALLOC_END	  (PAGE_OFFSET + 0x38000000)
+#define VMALLOC_END	  0xf8000000
diff --git a/arch/arm/mach-pnx4008/include/mach/vmalloc.h b/arch/arm/mach-pnx4008/include/mach/vmalloc.h
index 2ad3983..31b65ee 100644
--- a/arch/arm/mach-pnx4008/include/mach/vmalloc.h
+++ b/arch/arm/mach-pnx4008/include/mach/vmalloc.h
@@ -17,4 +17,4 @@
  * The vmalloc() routines leaves a hole of 4kB between each vmalloced
  * area for the same reason. ;)
  */
-#define VMALLOC_END       (PAGE_OFFSET + 0x10000000)
+#define VMALLOC_END       0xd0000000
diff --git a/arch/arm/mach-rpc/include/mach/vmalloc.h b/arch/arm/mach-rpc/include/mach/vmalloc.h
index 9a96fd6..3bcd86f 100644
--- a/arch/arm/mach-rpc/include/mach/vmalloc.h
+++ b/arch/arm/mach-rpc/include/mach/vmalloc.h
@@ -7,4 +7,4 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#define VMALLOC_END       (PAGE_OFFSET + 0x1c000000)
+#define VMALLOC_END       0xdc000000
diff --git a/arch/arm/mach-shark/include/mach/vmalloc.h b/arch/arm/mach-shark/include/mach/vmalloc.h
index f6c6837..8e845b6 100644
--- a/arch/arm/mach-shark/include/mach/vmalloc.h
+++ b/arch/arm/mach-shark/include/mach/vmalloc.h
@@ -1,4 +1,4 @@
 /*
  * arch/arm/mach-shark/include/mach/vmalloc.h
  */
-#define VMALLOC_END       (PAGE_OFFSET + 0x10000000)
+#define VMALLOC_END       0xd0000000
diff --git a/arch/arm/mach-versatile/include/mach/vmalloc.h b/arch/arm/mach-versatile/include/mach/vmalloc.h
index 427e361..ebd8a25 100644
--- a/arch/arm/mach-versatile/include/mach/vmalloc.h
+++ b/arch/arm/mach-versatile/include/mach/vmalloc.h
@@ -18,4 +18,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#define VMALLOC_END		(PAGE_OFFSET + 0x18000000)
+#define VMALLOC_END		0xd8000000
