From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 20 Apr 2010 11:50:49 +0300
Subject: [PATCH 3/8] arm: kdump: implement machine_crash_shutdown()
In-Reply-To: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <3f3bf07b54d6e2fd45df8b305584e7987b455cd0.1271752135.git.ext-mika.1.westerberg@nokia.com>
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
