From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Wed,  5 May 2010 09:54:15 +0300
Subject: [PATCH v2 3/8] arm: kdump: implement machine_crash_shutdown()
In-Reply-To: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <25d1f9b22c9842e8f379e6cf6a526ccd99e301bc.1273041358.git.ext-mika.1.westerberg@nokia.com>
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
