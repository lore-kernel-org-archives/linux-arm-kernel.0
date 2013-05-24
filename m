From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 May 2013 12:36:10 +0100
Subject: [PATCHv3 5/5] ARM: arch_timer: stop virtual timer when booted in HYP
 mode
In-Reply-To: <1369395370-21358-1-git-send-email-mark.rutland@arm.com>
References: <1369395370-21358-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1369395370-21358-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <Marc.Zyngier@arm.com>

When booting the kernel, a bootloader could have left the virtual
timer ticking away, potentially generating interrupts. This could
be troublesome if the user of the virtual timer is not careful
when enabling the interrupt.

In order to avoid any surprise, stop the virtual timer from
interrupting us when booted in HYP mode, as we'll use the physical
timer in this case.

Reported-by: Giridhar Maruthy <giridhar.m@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/kernel/hyp-stub.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index dbe2110..4910232 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -155,6 +155,11 @@ THUMB(	orr	r7, #(1 << 30)	)	@ HSCTLR.TE
 	mcr	p15, 4, r7, c14, c1, 0	@ CNTHCTL
 	mov	r7, #0
 	mcrr	p15, 4, r7, r7, c14	@ CNTVOFF
+
+	@ Disable virtual timer in case it was counting
+	mrc	p15, 0, r7, c14, c3, 1	@ CNTV_CTL
+	bic	r7, #1			@ Clear ENABLE
+	mcr	p15, 0, r7, c14, c3, 1	@ CNTV_CTL
 1:
 #endif
 
-- 
1.8.1.1
