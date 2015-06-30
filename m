From: pawelo@king.net.pl (Paul Osmialowski)
Date: Tue, 30 Jun 2015 14:27:22 +0200
Subject: [PATCH v2 1/9] arm: allow copying of vector table to internal SRAM
 memory
In-Reply-To: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
Message-ID: <1435667250-28299-2-git-send-email-pawelo@king.net.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on part of the commit published on Emcraft git repo:

https://github.com/EmcraftSystems/linux-emcraft.git

2ce1841b590d014d8738215fb1ffe05f53c8d9f0 "some commit"

by: Dmitry Cherkassov <d_cherkasov@emcraft.com>

The ARM v7M allows setting the vector table either in
the boot memory or in the internal SRAM memory, controlled
by Bit 29 in the Vector Table Base register. This implies
that the OS vector table needs to be copied to the internal RAM.

New option CONFIG_COPY_VECTOR_TABLE_TO_SRAM_ADDR allows specification
of the desired destination for the OS vector table.

Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>
---
 arch/arm/Kconfig-nommu      | 11 +++++++++++
 arch/arm/kernel/entry-v7m.S |  3 +++
 arch/arm/mm/proc-v7m.S      | 11 +++++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
index aed66d5..d081fcb 100644
--- a/arch/arm/Kconfig-nommu
+++ b/arch/arm/Kconfig-nommu
@@ -62,3 +62,14 @@ config ARM_MPU
 
          If your CPU has an MPU then you should choose 'y' here unless you
          know that you do not want to use the MPU.
+
+config COPY_VECTOR_TABLE_TO_SRAM_ADDR
+	hex 'If non-zero, copy Vector Table to this SRAM Address' if CPU_V7M
+	default 0x00000000
+	depends on CPU_V7M
+	help
+	  The ARM v7M allows setting the vector table either in
+	  the boot memory or in the internal SRAM memory, controlled
+	  by Bit 29 in the Vector Table Base register.
+	  This implies that the OS vector table needs to be copied to
+	  the internal RAM.
diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index b6c8bb9..114096e 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -146,3 +146,6 @@ ENTRY(vector_table)
 	.rept	CONFIG_CPU_V7M_NUM_IRQ
 	.long	__irq_entry		@ External Interrupts
 	.endr
+#if CONFIG_COPY_VECTOR_TABLE_TO_SRAM_ADDR > 0x00000000
+ENTRY(vector_table_end)
+#endif
diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 67d9209..ded9504 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -83,7 +83,18 @@ ENDPROC(cpu_v7m_do_resume)
 __v7m_setup:
 	@ Configure the vector table base address
 	ldr	r0, =BASEADDR_V7M_SCB
+#if CONFIG_COPY_VECTOR_TABLE_TO_SRAM_ADDR > 0x00000000
+	ldr	r12, =CONFIG_COPY_VECTOR_TABLE_TO_SRAM_ADDR
+	mov	r5, r12			@ Copy the kernel vector_table to
+	ldr	r6, =vector_table	@ the in-SRAM vector table
+	ldr	r4, =vector_table_end
+1:	ldr	r3, [r6], #4
+	str	r3, [r5], #4
+	cmp	r6, r4
+	bne	1b			@ End of the copy code
+#else
 	ldr	r12, =vector_table
+#endif
 	str	r12, [r0, V7M_SCB_VTOR]
 
 	@ enable UsageFault, BusFault and MemManage fault.
-- 
2.3.6
