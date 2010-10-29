From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 29 Oct 2010 16:06:31 -0700
Subject: [PATCH -v3] msm: fix debug-macro.S build failure
In-Reply-To: <20101029221437.GA31224@n2100.arm.linux.org.uk>
References: <20101029221437.GA31224@n2100.arm.linux.org.uk>
Message-ID: <1288393591-26566-1-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was planning to send this directly to Linus assuming everyone
agrees.

---

Originally there was an ifdef case to handle when no debug uart
was selected. In commit 0ea1293009826da45e1019f45dfde1e557bb30df
that case was removed which causes the following build failure,

linux-2.6/arch/arm/kernel/debug.S: Assembler messages:
linux-2.6/arch/arm/kernel/debug.S:174: Error: bad instruction `addruart r1,r2'
linux-2.6/arch/arm/kernel/debug.S:176: Error: bad instruction `waituart r2,r3'
linux-2.6/arch/arm/kernel/debug.S:177: Error: bad instruction `senduart r1,r3'
linux-2.6/arch/arm/kernel/debug.S:178: Error: bad instruction `busyuart r2,r3'
linux-2.6/arch/arm/kernel/debug.S:190: Error: bad instruction `addruart r1,r2'

This is a partial revert to add back the case which was removed with
two caveats. First the API for the addruart macro was updated, and
the new addruart case now return 0xfff00000 so that a know IO mapping
is created instead of a random one.

Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jason Wang <jason77.wang@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/debug-macro.S |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/debug-macro.S b/arch/arm/mach-msm/include/mach/debug-macro.S
index fbd5d90..f792e01 100644
--- a/arch/arm/mach-msm/include/mach/debug-macro.S
+++ b/arch/arm/mach-msm/include/mach/debug-macro.S
@@ -36,7 +36,18 @@
 	tst	\rd, #0x04
 	beq	1001b
 	.endm
+#else
+	.macro  addruart, rp, rv
+	mov	\rv, #0xff000000
+	orr	\rv, \rv, #0x00f00000
+	.endm
 
-	.macro	busyuart,rd,rx
+	.macro	senduart,rd,rx
+	.endm
+
+	.macro	waituart,rd,rx
 	.endm
 #endif
+
+	.macro	busyuart,rd,rx
+	.endm
-- 
1.7.1

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
