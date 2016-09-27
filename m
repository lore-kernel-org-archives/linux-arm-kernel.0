From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:55 +0200
Subject: [PULL 47/50] arm64: KVM: Remove duplicating init code for setting VMID
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-48-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

By now both VHE and non-VHE initialisation sequences query supported
VMID size. Lets keep only single instance of this code under
init_common_resources().

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 75f130e..85a3f90 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1178,6 +1178,10 @@ static int init_common_resources(void)
 		return -ENOMEM;
 	}
 
+	/* set size of VMID supported by CPU */
+	kvm_vmid_bits = kvm_get_vmid_bits();
+	kvm_info("%d-bit VMID\n", kvm_vmid_bits);
+
 	return 0;
 }
 
@@ -1243,10 +1247,6 @@ static void teardown_hyp_mode(void)
 
 static int init_vhe_mode(void)
 {
-	/* set size of VMID supported by CPU */
-	kvm_vmid_bits = kvm_get_vmid_bits();
-	kvm_info("%d-bit VMID\n", kvm_vmid_bits);
-
 	kvm_info("VHE mode initialized successfully\n");
 	return 0;
 }
@@ -1330,10 +1330,6 @@ static int init_hyp_mode(void)
 		}
 	}
 
-	/* set size of VMID supported by CPU */
-	kvm_vmid_bits = kvm_get_vmid_bits();
-	kvm_info("%d-bit VMID\n", kvm_vmid_bits);
-
 	kvm_info("Hyp mode initialized successfully\n");
 
 	return 0;
-- 
2.9.0
