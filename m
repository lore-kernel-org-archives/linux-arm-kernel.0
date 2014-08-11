From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Mon, 11 Aug 2014 15:44:13 -0700
Subject: [PATCH] ARM: Explain workaround for faulty ISAR0 register on B15
Message-ID: <1407797053-12544-1-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Brahma-B15 CPU design, like Krait, incorrectly indicates that it
only supports UDIV and SDIV instructions in Thumb mode when it
actually supports them in ARM and Thumb mode.  This is apparently
because it follows the DDI0406B ARM ARM which has two values for the
divide instruction field, instead of the DDI0406C ARM ARM which has
three values.

Work around this problem by forcing the hwcaps to indicate support for
UDIV and SDIV in both ARM and Thumb modes.

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---

Will and Mark had both asked whether Brahma-B15 has a wrong value for ISAR0:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/225895.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/227916.html

This should clear up the matter, sorry it took so long!

 arch/arm/mm/proc-v7.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index b5d67db..7706986 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -570,6 +570,11 @@ __v7_ca15mp_proc_info:
 __v7_b15mp_proc_info:
 	.long	0x420f00f0
 	.long	0xff0ffff0
+	/*
+	 * Brahma-B15 processors don't indicate support for SDIV and UDIV
+	 * instructions in the ARM instruction set, even though they actually
+	 * do support them.
+	 */
 	__v7_proc __v7_b15mp_setup, hwcaps = HWCAP_IDIV
 	.size	__v7_b15mp_proc_info, . - __v7_b15mp_proc_info
 
-- 
1.8.3.2
