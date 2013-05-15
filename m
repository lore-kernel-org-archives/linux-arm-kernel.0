From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 May 2013 16:23:58 +0100
Subject: [PATCHv2 2/5] ARM: KVM: arch_timers: zero CNTVOFF upon return to host
In-Reply-To: <1368631441-28434-1-git-send-email-mark.rutland@arm.com>
References: <1368631441-28434-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1368631441-28434-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To use the virtual counters from the host, we need to ensure that
CNTVOFF doesn't change unexpectedly. When we change to a guest, we
replace the host's CNTVOFF, but we don't restore it when returning to
the host.

As the host sets CNTVOFF to zero, and never changes it, we can simply
zero CNTVOFF when returning to the host. This patch adds said zeroing to
the return to host path.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Christoffer Dall <cdall@cs.columbia.edu>
---
 arch/arm/kvm/interrupts_head.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
index 3c8f2f0..d43cfb5 100644
--- a/arch/arm/kvm/interrupts_head.S
+++ b/arch/arm/kvm/interrupts_head.S
@@ -497,6 +497,10 @@ vcpu	.req	r0		@ vcpu pointer always in r0
 	add	r5, vcpu, r4
 	strd	r2, r3, [r5]
 
+	@ Ensure host CNTVCT == CNTPCT
+	mov	r2, #0
+	mcrr	p15, 4, r2, r2, c14	@ CNTVOFF
+
 1:
 #endif
 	@ Allow physical timer/counter access for the host
-- 
1.8.1.1
