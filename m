From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 28 Feb 2018 13:57:44 +0900
Subject: [PATCH v2 3/3] arm64: irq: add get_handle_irq()
In-Reply-To: <20180228045744.12914-1-takahiro.akashi@linaro.org>
References: <20180228045744.12914-1-takahiro.akashi@linaro.org>
Message-ID: <20180228045744.12914-4-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is needed for utilizing lkdtm to make a probe hook on
architecture-specific irq handler entry.
In arm64 case, arm64 doesn't have "do_IRQ" function, instead
handle_arch_irq, which is initialized by irq chip driver(gic), is
called from exception entry code.
So just add it.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/irq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 60e5fc661f74..ddd0759dc859 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -52,6 +52,13 @@ void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 	handle_arch_irq = handle_irq;
 }
 
+#ifdef CONFIG_LKDTM
+unsigned long get_handle_irq(void)
+{
+	return (unsigned long)handle_arch_irq;
+}
+#endif
+
 #ifdef CONFIG_VMAP_STACK
 static void init_irq_stacks(void)
 {
-- 
2.16.2
