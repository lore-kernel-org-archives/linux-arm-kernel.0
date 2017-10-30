From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 30 Oct 2017 03:55:58 +0100
Subject: [PULL 3/8] arm/arm64: kvm: Move initialization completion message
In-Reply-To: <20171030025603.23550-1-christoffer.dall@linaro.org>
References: <20171030025603.23550-1-christoffer.dall@linaro.org>
Message-ID: <20171030025603.23550-4-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Thierry <julien.thierry@arm.com>

KVM is being a bit too optimistic, Hyp mode is said to be initialized
when Hyp segments have only been mapped.

Notify KVM's successful initialization only once it is really fully
initialized.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/arm.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index b9f68e4add71..95cba0799828 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1326,21 +1326,12 @@ static void teardown_hyp_mode(void)
 {
 	int cpu;
 
-	if (is_kernel_in_hyp_mode())
-		return;
-
 	free_hyp_pgds();
 	for_each_possible_cpu(cpu)
 		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
 	hyp_cpu_pm_exit();
 }
 
-static int init_vhe_mode(void)
-{
-	kvm_info("VHE mode initialized successfully\n");
-	return 0;
-}
-
 /**
  * Inits Hyp-mode on all online CPUs
  */
@@ -1421,8 +1412,6 @@ static int init_hyp_mode(void)
 		}
 	}
 
-	kvm_info("Hyp mode initialized successfully\n");
-
 	return 0;
 
 out_err:
@@ -1456,6 +1445,7 @@ int kvm_arch_init(void *opaque)
 {
 	int err;
 	int ret, cpu;
+	bool in_hyp_mode;
 
 	if (!is_hyp_mode_available()) {
 		kvm_err("HYP mode not available\n");
@@ -1474,21 +1464,28 @@ int kvm_arch_init(void *opaque)
 	if (err)
 		return err;
 
-	if (is_kernel_in_hyp_mode())
-		err = init_vhe_mode();
-	else
+	in_hyp_mode = is_kernel_in_hyp_mode();
+
+	if (!in_hyp_mode) {
 		err = init_hyp_mode();
-	if (err)
-		goto out_err;
+		if (err)
+			goto out_err;
+	}
 
 	err = init_subsystems();
 	if (err)
 		goto out_hyp;
 
+	if (in_hyp_mode)
+		kvm_info("VHE mode initialized successfully\n");
+	else
+		kvm_info("Hyp mode initialized successfully\n");
+
 	return 0;
 
 out_hyp:
-	teardown_hyp_mode();
+	if (!in_hyp_mode)
+		teardown_hyp_mode();
 out_err:
 	teardown_common_resources();
 	return err;
-- 
2.14.2
