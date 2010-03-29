From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Mon, 29 Mar 2010 12:26:29 +0300
Subject: [RFC 03/10] arm: kdump: implement machine_crash_shutdown()
In-Reply-To: <e3c9449c42a735f9acee8e50af33762ffcadf7b4.1269854500.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<7b747cd930c20ae4a625c981d88e2773c706fce9.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<e3c9449c42a735f9acee8e50af33762ffcadf7b4.1269854500.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <0f8c479602b8957c49db7ac56b8f90ac6f4da5dc.1269854500.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement function machine_crash_shutdown() which disables IRQs and saves
machine state to ELF notes structure.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/kernel/machine_kexec.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 598ca61..81e9898 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -43,6 +43,10 @@ void machine_shutdown(void)
 
 void machine_crash_shutdown(struct pt_regs *regs)
 {
+	local_irq_disable();
+	crash_save_cpu(regs, smp_processor_id());
+
+	printk(KERN_INFO "Loading crashdump kernel...\n");
 }
 
 void machine_kexec(struct kimage *image)
-- 
1.5.6.5
