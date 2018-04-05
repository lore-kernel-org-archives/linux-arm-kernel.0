From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu,  5 Apr 2018 20:17:56 +0300
Subject: [PATCH 1/5] arm64: entry: isb in el1_irq
In-Reply-To: <20180405171800.5648-1-ynorov@caviumnetworks.com>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
Message-ID: <20180405171800.5648-2-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel text patching framework relies on IPI to ensure that other
SMP cores observe the change. Target core calls isb() in IPI handler
path, but not at the beginning of el1_irq entry. There's a chance
that modified instruction will appear prior isb(), and so will not be
observed.

This patch inserts isb early at el1_irq entry to avoid that chance.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/entry.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ec2ee720e33e..9c06b4b80060 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -593,6 +593,7 @@ ENDPROC(el1_sync)
 
 	.align	6
 el1_irq:
+	isb					// pairs with aarch64_insn_patch_text
 	kernel_entry 1
 	enable_da_f
 #ifdef CONFIG_TRACE_IRQFLAGS
-- 
2.14.1
