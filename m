From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 17 Sep 2015 15:46:08 +0100
Subject: [PATCH 5/8] arm64: KVM: Disable virtual timer even if the guest is
 not using it
In-Reply-To: <1442501171-24484-1-git-send-email-marc.zyngier@arm.com>
References: <1442501171-24484-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1442501171-24484-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When running a guest with the architected timer disabled (with QEMU and
the kernel_irqchip=off option, for example), it is important to make
sure the timer gets turned off. Otherwise, the guest may try to
enable it anyway, leading to a screaming HW interrupt.

The fix is to unconditionally turn off the virtual timer on guest
exit.

Cc: stable at vger.kernel.org
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 39aa322..60a83e2 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -562,8 +562,6 @@
 	mrs	x3, cntv_ctl_el0
 	and	x3, x3, #3
 	str	w3, [x0, #VCPU_TIMER_CNTV_CTL]
-	bic	x3, x3, #1		// Clear Enable
-	msr	cntv_ctl_el0, x3
 
 	isb
 
@@ -571,6 +569,9 @@
 	str	x3, [x0, #VCPU_TIMER_CNTV_CVAL]
 
 1:
+	// Disable the virtual timer
+	msr	cntv_ctl_el0, xzr
+
 	// Allow physical timer/counter access for the host
 	mrs	x2, cnthctl_el2
 	orr	x2, x2, #3
-- 
2.1.4
