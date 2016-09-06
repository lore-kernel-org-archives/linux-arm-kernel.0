From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Sep 2016 14:02:03 +0100
Subject: [PATCH 05/19] arm64: KVM: Add EL1 async abort handler
In-Reply-To: <1473166937-15271-1-git-send-email-marc.zyngier@arm.com>
References: <1473166937-15271-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1473166937-15271-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we've exited the guest because it has triggered an asynchronous
abort from EL1, a possible course of action is to let it know it
screwed up by giving it a Virtual Abort to chew on.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/handle_exit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index fa96fe2b..08afc69a 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -173,6 +173,9 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	switch (exception_index) {
 	case ARM_EXCEPTION_IRQ:
 		return 1;
+	case ARM_EXCEPTION_EL1_SERROR:
+		kvm_inject_vabt(vcpu);
+		return 1;
 	case ARM_EXCEPTION_TRAP:
 		/*
 		 * See ARM ARM B1.14.1: "Hyp traps on instructions
-- 
2.1.4
