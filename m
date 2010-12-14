From: john.stultz@linaro.org (John Stultz)
Date: Mon, 13 Dec 2010 20:57:38 -0800
Subject: [PATCH 3/4] process: Add display of memory around registers when
	displaying regs.
In-Reply-To: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
References: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
Message-ID: <1292302659-1863-4-git-send-email-john.stultz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: San Mehat <san@google.com>

This is extremely useful in diagnosing remote crashes, and is based heavily
on original work by <md@google.com>.

Signed-off-by: San Mehat <san@google.com>
Cc: Michael Davidson <md@google.com>

[ARM] process: Use uber-safe probe_kernel_address() to read mem when dumping.

This prevents the dump from taking pagefaults / external aborts.

CC: Nicolas Pitre <nicolas.pitre@linaro.org>
CC: Russell King <linux@arm.linux.org.uk>
Signed-off-by: San Mehat <san@google.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm/kernel/process.c |   73 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index e76fcaa..82c37fe 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -251,6 +251,77 @@ void machine_restart(char *cmd)
 	arm_pm_restart(reboot_mode, cmd);
 }
 
+/*
+ * dump a block of kernel memory from around the given address
+ */
+static void show_data(unsigned long addr, int nbytes, const char *name)
+{
+	int	i, j;
+	int	nlines;
+	u32	*p;
+
+	/*
+	 * don't attempt to dump non-kernel addresses or
+	 * values that are probably just small negative numbers
+	 */
+	if (addr < PAGE_OFFSET || addr > -256UL)
+		return;
+
+	printk("\n%s: %#lx:\n", name, addr);
+
+	/*
+	 * round address down to a 32 bit boundary
+	 * and always dump a multiple of 32 bytes
+	 */
+	p = (u32 *)(addr & ~(sizeof(u32) - 1));
+	nbytes += (addr & (sizeof(u32) - 1));
+	nlines = (nbytes + 31) / 32;
+
+
+	for (i = 0; i < nlines; i++) {
+		/*
+		 * just display low 16 bits of address to keep
+		 * each line of the dump < 80 characters
+		 */
+		printk("%04lx ", (unsigned long)p & 0xffff);
+		for (j = 0; j < 8; j++) {
+			u32	data;
+			if (probe_kernel_address(p, data)) {
+				printk(" ********");
+			} else {
+				printk(" %08x", data);
+			}
+			++p;
+		}
+		printk("\n");
+	}
+}
+
+static void show_extra_register_data(struct pt_regs *regs, int nbytes)
+{
+	mm_segment_t fs;
+
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+	show_data(regs->ARM_pc - nbytes, nbytes * 2, "PC");
+	show_data(regs->ARM_lr - nbytes, nbytes * 2, "LR");
+	show_data(regs->ARM_sp - nbytes, nbytes * 2, "SP");
+	show_data(regs->ARM_ip - nbytes, nbytes * 2, "IP");
+	show_data(regs->ARM_fp - nbytes, nbytes * 2, "FP");
+	show_data(regs->ARM_r0 - nbytes, nbytes * 2, "R0");
+	show_data(regs->ARM_r1 - nbytes, nbytes * 2, "R1");
+	show_data(regs->ARM_r2 - nbytes, nbytes * 2, "R2");
+	show_data(regs->ARM_r3 - nbytes, nbytes * 2, "R3");
+	show_data(regs->ARM_r4 - nbytes, nbytes * 2, "R4");
+	show_data(regs->ARM_r5 - nbytes, nbytes * 2, "R5");
+	show_data(regs->ARM_r6 - nbytes, nbytes * 2, "R6");
+	show_data(regs->ARM_r7 - nbytes, nbytes * 2, "R7");
+	show_data(regs->ARM_r8 - nbytes, nbytes * 2, "R8");
+	show_data(regs->ARM_r9 - nbytes, nbytes * 2, "R9");
+	show_data(regs->ARM_r10 - nbytes, nbytes * 2, "R10");
+	set_fs(fs);
+}
+
 void __show_regs(struct pt_regs *regs)
 {
 	unsigned long flags;
@@ -310,6 +381,8 @@ void __show_regs(struct pt_regs *regs)
 		printk("Control: %08x%s\n", ctrl, buf);
 	}
 #endif
+
+	show_extra_register_data(regs, 128);
 }
 
 void show_regs(struct pt_regs * regs)
-- 
1.7.3.2.146.gca209
