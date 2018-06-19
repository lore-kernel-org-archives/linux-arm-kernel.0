From: mhkelley58@gmail.com (Michael Kelley)
Date: Tue, 19 Jun 2018 14:23:14 -0700
Subject: [PATCH 4/5] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
In-Reply-To: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
References: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
Message-ID: <1529443395-20874-5-git-send-email-mikelley@microsoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add hooks to enable/disable a per-CPU IRQ for VMbus. These hooks
are in the architecture independent setup and shutdown paths for
Hyper-V, and are needed by Linux guests on Hyper-V on ARM64.  The
x86/x64 implementation is null because VMbus interrupts on x86/x64
don't use an IRQ.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: James Morris <james.morris@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 4 ++++
 drivers/hv/hv.c                 | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 3cd1431..27d0e83 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -101,6 +101,10 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 void hv_setup_vmbus_irq(void (*handler)(void));
 void hv_remove_vmbus_irq(void);
 
+/* On x86/x64, there isn't a real IRQ to be enabled/disable */
+static inline void hv_enable_vmbus_irq(void) {}
+static inline void hv_disable_vmbus_irq(void) {}
+
 void hv_setup_kexec_handler(void (*handler)(void));
 void hv_remove_kexec_handler(void);
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 658dc76..15f835a 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -298,6 +298,7 @@ int hv_synic_init(unsigned int cpu)
 	hv_set_siefp(siefp.as_uint64);
 
 	/* Setup the shared SINT. */
+	hv_enable_vmbus_irq();
 	hv_get_synint_state(HV_X64_MSR_SINT0 + VMBUS_MESSAGE_SINT,
 			    shared_sint.as_uint64);
 
@@ -431,6 +432,7 @@ int hv_synic_cleanup(unsigned int cpu)
 	hv_get_synic_state(sctrl.as_uint64);
 	sctrl.enable = 0;
 	hv_set_synic_state(sctrl.as_uint64);
+	hv_disable_vmbus_irq();
 
 	return 0;
 }
-- 
1.8.3.1
