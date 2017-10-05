From: james.morse@arm.com (James Morse)
Date: Thu,  5 Oct 2017 20:18:12 +0100
Subject: [PATCH v3 20/20] KVM: arm64: Take any host SError before entering the
 guest
In-Reply-To: <20171005191812.5678-1-james.morse@arm.com>
References: <20171005191812.5678-1-james.morse@arm.com>
Message-ID: <20171005191812.5678-21-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On VHE systems KVM masks SError before switching the VBAR value. Any
host RAS error that the CPU knew about before world-switch may become
pending as an SError during world-switch, and only be taken once we enter
the guest.

Until KVM can take RAS SErrors during world switch, add an ESB to
force any RAS errors to be synchronised and taken on the host before
we enter world switch.

RAS errors that become pending during world switch are still taken
once we enter the guest.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index b3c53d8b6a60..6a48f9d18c58 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -392,6 +392,7 @@ static inline void __cpu_init_stage2(void)
 
 static inline void kvm_arm_vhe_guest_enter(void)
 {
+	esb();
 	local_mask_daif();
 }
 
-- 
2.13.3
