From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Thu, 2 Nov 2017 03:14:57 +0800
Subject: [PATCH v1 3/3] KVM: arm64: add ESB in exception handler entry and
 exit.
In-Reply-To: <1509563697-6359-1-git-send-email-gengdongjiu@huawei.com>
References: <1509563697-6359-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <1509563697-6359-4-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some hardware platform can support RAS Extension instead
of support IESB, so software need to insert Synchronization
Barrier operations at exception handler entry and exit.

In the __guest_exit(), it added a ESB instruction, but can
not cover the path which is not guest exit. For example, if
EL1 host call HVC instruction enter to hypervisor, it will
not call __guest_exit().

In the kvm_arm_vhe_guest_enter(), it synchronised any host
RAS errors for VHE mode, but it can not handle the non-VHE
mode. For example, if EL1 host is pending a SError, the error
can be propagated to guest without error synchronization
operation.

Only add the ESB in the important exception handler path to
reduce the impact on performance.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 arch/arm64/kvm/hyp/entry.S     | 2 ++
 arch/arm64/kvm/hyp/hyp-entry.S | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 96caa53..fce6806 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -84,6 +84,8 @@ ENTRY(__guest_enter)
 	// Restore guest reg x18
 	ldr	x18,      [x18, #CPU_XREG_OFFSET(18)]
 
+	// synchronize host pending asynchronous error
+	error_synchronize
 	// Do not touch any register after this!
 	eret
 ENDPROC(__guest_enter)
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 5170ce1..ac85029 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -54,6 +54,7 @@ ENTRY(__vhe_hyp_call)
 ENDPROC(__vhe_hyp_call)
 
 el1_sync:				// Guest trapped into EL2
+	error_synchronize
 	stp	x0, x1, [sp, #-16]!
 
 alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
-- 
1.9.1
