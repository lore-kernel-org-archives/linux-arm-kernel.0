From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  2 Feb 2018 16:07:35 +0100
Subject: [PATCH 2/2] ARM: xscale: fix gcc-8 build
In-Reply-To: <20180202150756.420422-1-arnd@arndb.de>
References: <20180202150756.420422-1-arnd@arndb.de>
Message-ID: <20180202150756.420422-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We use a hack in xscale-cp0.c to allow building it for ARMv4 while
also using ARMv5TE and iWMMXt specific inline assembly, by
adding a top-level asm statement.

Unfortunately that hack no longer works with gcc-8, since it will
revert back to the normal architecture. The recommended way of
handling this is to use __attribute__((target("armv5te"))) on the
functions that need it, or #pragma GCC target("arch=armv5te").
Either of those work with gcc-8, but not earlier versions, and
it seems worse to combine that with the old hack.

Instead, this adds the .arch statement to each inline assembler
statement that needs it individually. That is also slightly uglier
than the previous hack, but it works with all compiler versions
and documents better why we need the override in the first place.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84129
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/xscale-cp0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/xscale-cp0.c b/arch/arm/kernel/xscale-cp0.c
index 77a2eef72115..e06a2f6dac4f 100644
--- a/arch/arm/kernel/xscale-cp0.c
+++ b/arch/arm/kernel/xscale-cp0.c
@@ -17,11 +17,10 @@
 #include <asm/thread_notify.h>
 #include <asm/cputype.h>
 
-asm("	.arch armv5te\n");
-
 static inline void dsp_save_state(u32 *state)
 {
 	__asm__ __volatile__ (
+		".arch	armv5te\n\t"
 		"mrrc	p0, 0, %0, %1, c0\n"
 		: "=r" (state[0]), "=r" (state[1]));
 }
@@ -29,6 +28,7 @@ static inline void dsp_save_state(u32 *state)
 static inline void dsp_load_state(u32 *state)
 {
 	__asm__ __volatile__ (
+		".arch	armv5te\n\t"
 		"mcrr	p0, 0, %0, %1, c0\n"
 		: : "r" (state[0]), "r" (state[1]));
 }
@@ -134,7 +134,8 @@ static int __init cpu_has_iwmmxt(void)
 	 *	tmrrc	%0, %1, wR0
 	 */
 	__asm__ __volatile__ (
-		"mcrr	p0, 0, %2, %3, c0\n"
+		".arch	armv5te\n\t"
+		"mcrr	p0, 0, %2, %3, c0\n\t"
 		"mrrc	p0, 0, %0, %1, c0\n"
 		: "=r" (lo), "=r" (hi)
 		: "r" (0), "r" (0x100));
-- 
2.9.0
