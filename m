From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  3 Apr 2017 19:37:58 +0100
Subject: [PATCH v5 25/34] ARM: KVM: Gracefully handle hyp-stubs being restored
 from under our feet
In-Reply-To: <20170403183807.1620-1-marc.zyngier@arm.com>
References: <20170403183807.1620-1-marc.zyngier@arm.com>
Message-ID: <20170403183807.1620-26-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Should kvm_reboot() be invoked while guest is running, an IPI
wil be issued, forcing the guest to exit and HYP being reset to
the stubs. We will then try to reenter the guest, only to get
an error (HVC_STUB_ERR).

This patch allows this case to be gracefully handled by exiting
the run loop.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_asm.h | 2 +-
 arch/arm/kvm/handle_exit.c     | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 7ccb6f1aac5b..df113302e637 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -33,7 +33,7 @@
 #define ARM_EXCEPTION_IRQ	  5
 #define ARM_EXCEPTION_FIQ	  6
 #define ARM_EXCEPTION_HVC	  7
-
+#define ARM_EXCEPTION_HYP_GONE	  HVC_STUB_ERR
 /*
  * The rr_lo_hi macro swaps a pair of registers depending on
  * current endianness. It is used in conjunction with ldrd and strd
diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
index 96af65a30d78..5fd7968cdae9 100644
--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -160,6 +160,14 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	case ARM_EXCEPTION_DATA_ABORT:
 		kvm_inject_vabt(vcpu);
 		return 1;
+	case ARM_EXCEPTION_HYP_GONE:
+		/*
+		 * HYP has been reset to the hyp-stub. This happens
+		 * when a guest is pre-empted by kvm_reboot()'s
+		 * shutdown call.
+		 */
+		run->exit_reason = KVM_EXIT_FAIL_ENTRY;
+		return 0;
 	default:
 		kvm_pr_unimpl("Unsupported exception type: %d",
 			      exception_index);
-- 
2.11.0
