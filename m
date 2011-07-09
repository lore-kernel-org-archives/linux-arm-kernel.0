From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:10 +0100
Subject: [PATCH 23/51] ARM: kprobes: Add bx_write_pc()
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-24-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

This writes a value to PC, with interworking. I.e. switches to Thumb or
ARM mode depending on the state of the least significant bit.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes.h b/arch/arm/kernel/kprobes.h
index 36e0768..12627a3 100644
--- a/arch/arm/kernel/kprobes.h
+++ b/arch/arm/kernel/kprobes.h
@@ -95,6 +95,20 @@ static inline unsigned long it_advance(unsigned long cpsr)
 	return cpsr;
 }
 
+static inline void __kprobes bx_write_pc(long pcv, struct pt_regs *regs)
+{
+	long cpsr = regs->ARM_cpsr;
+	if (pcv & 0x1) {
+		cpsr |= PSR_T_BIT;
+		pcv &= ~0x1;
+	} else {
+		cpsr &= ~PSR_T_BIT;
+		pcv &= ~0x2;	/* Avoid UNPREDICTABLE address allignment */
+	}
+	regs->ARM_cpsr = cpsr;
+	regs->ARM_pc = pcv;
+}
+
 void __kprobes kprobe_simulate_nop(struct kprobe *p, struct pt_regs *regs);
 void __kprobes kprobe_emulate_none(struct kprobe *p, struct pt_regs *regs);
 
-- 
1.7.2.5
