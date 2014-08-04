From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon,  4 Aug 2014 10:46:49 +0200
Subject: [GIT PULL 32/51] ARM: KVM: MMIO support BE host running LE code
In-Reply-To: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
References: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1407142028-31105-33-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Kamensky <victor.kamensky@linaro.org>

In case of status register E bit is not set (LE mode) and host runs in
BE mode we need byteswap data, so read/write is emulated correctly.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 0fa90c9..69b7469 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -185,9 +185,16 @@ static inline unsigned long vcpu_data_guest_to_host(struct kvm_vcpu *vcpu,
 		default:
 			return be32_to_cpu(data);
 		}
+	} else {
+		switch (len) {
+		case 1:
+			return data & 0xff;
+		case 2:
+			return le16_to_cpu(data & 0xffff);
+		default:
+			return le32_to_cpu(data);
+		}
 	}
-
-	return data;		/* Leave LE untouched */
 }
 
 static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
@@ -203,9 +210,16 @@ static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
 		default:
 			return cpu_to_be32(data);
 		}
+	} else {
+		switch (len) {
+		case 1:
+			return data & 0xff;
+		case 2:
+			return cpu_to_le16(data & 0xffff);
+		default:
+			return cpu_to_le32(data);
+		}
 	}
-
-	return data;		/* Leave LE untouched */
 }
 
 #endif /* __ARM_KVM_EMULATE_H__ */
-- 
2.0.0
