From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 26 Mar 2015 17:25:25 +0900
Subject: [RFC v2 4/5] arm64: kvm: add cpu reset at module exit
In-Reply-To: <1427358326-3708-1-git-send-email-takahiro.akashi@linaro.org>
References: <1427358326-3708-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1427358326-3708-5-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch doesn't enable kvm to be built as a module, but is
a prerequisite when kvm is transformed to be module-capable.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm/kvm/arm.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 4892974..85c142b 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1178,6 +1178,12 @@ void kvm_arch_hardware_disable(void)
 void kvm_arch_exit(void)
 {
 	kvm_perf_teardown();
+
+	unregister_reboot_notifier(&kvm_reboot_nb);
+	/*
+	 * Reset each CPU in EL2 to initial state.
+	 */
+	on_each_cpu(kvm_cpu_reset, NULL, 1);
 }
 
 static int arm_init(void)
-- 
1.7.9.5
