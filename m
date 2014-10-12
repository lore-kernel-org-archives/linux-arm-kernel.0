From: stefan@agner.ch (Stefan Agner)
Date: Sun, 12 Oct 2014 20:14:00 +0200
Subject: [RFC 6/7] ARM: vf610m4: HACK: get dtb pointer from SRC_GPR3
In-Reply-To: <cover.1413136383.git.stefan@agner.ch>
References: <cover.1413136383.git.stefan@agner.ch>
Message-ID: <2bdc44912522eb02db2e4612738fe9f0545b36d9.1413136383.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get DTB pointer (located in r2) from SRC_GPR3 (argument register
for secondary core)

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
This is clearly a hack but it works around the need of a boot loader
on the Cortex-M4. I guess there is no way neither its acceptable to
do this on machine level..? But then, this can also be done with a
minimal boot loader loaded just in front of the kernel by the m4boot
utility.

 arch/arm/kernel/head-nommu.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index cc176b6..0468683 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -37,6 +37,10 @@
  *
  */
 
+#define	SRC_BASE	0x4006e000
+#define SRC_GPR2	0x28
+#define SRC_GPR3	0x2c
+
 	__HEAD
 
 #ifdef CONFIG_CPU_THUMBONLY
@@ -57,6 +61,10 @@ ENTRY(stext)
 #if defined(CONFIG_CPU_CP15)
 	mrc	p15, 0, r9, c0, c0		@ get processor id
 #elif defined(CONFIG_CPU_V7M)
+
+	ldr	r0, =SRC_BASE
+	ldr	r1, =0xffffffff		@ Machine ID
+	ldr	r2, [r0, #SRC_GPR3 ] 	@ DT pointer from argument register
 	ldr	r9, =BASEADDR_V7M_SCB
 	ldr	r9, [r9, V7M_SCB_CPUID]
 #else
-- 
2.1.2
