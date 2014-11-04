From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Tue,  4 Nov 2014 20:01:40 +0800
Subject: [Patch Part2 v4 06/31] x86, irq: Save destination CPU ID in irq_cfg
In-Reply-To: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
References: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1415102525-9898-7-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cache destination CPU APIC ID into struct irq_cfg when assigning vector
for interrupt. Upper layer just needs to read the cached APIC ID instead
of calling apic->cpu_mask_to_apicid_and(), it helps to hide APIC driver
details from IOAPIC/HPET/MSI drivers..

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/include/asm/hw_irq.h |    1 +
 arch/x86/kernel/apic/vector.c |    6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 7624fffc2822..3d51d74d6c01 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -116,6 +116,7 @@ struct irq_data;
 struct irq_cfg {
 	cpumask_var_t		domain;
 	cpumask_var_t		old_domain;
+	unsigned int		dest_apicid;
 	u8			vector;
 	u8			move_in_progress : 1;
 #ifdef CONFIG_IRQ_REMAP
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 5ac840a4cc53..02cb5d386985 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -188,6 +188,12 @@ next:
 	}
 	free_cpumask_var(tmp_mask);
 
+	if (!err) {
+		/* cache destination APIC IDs into cfg->dest_apicid */
+		err = apic->cpu_mask_to_apicid_and(mask, cfg->domain,
+						   &cfg->dest_apicid);
+	}
+
 	return err;
 }
 
-- 
1.7.10.4
