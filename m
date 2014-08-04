From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon,  4 Aug 2014 10:46:52 +0200
Subject: [GIT PULL 35/51] ARM64: KVM: MMIO support BE host running LE code
In-Reply-To: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
References: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1407142028-31105-36-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Kamensky <victor.kamensky@linaro.org>

In case of guest CPU running in LE mode and host runs in
BE mode we need byteswap data, so read/write is emulated correctly.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_emulate.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index dd8ecfc3..fdc3e21 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -213,6 +213,17 @@ static inline unsigned long vcpu_data_guest_to_host(struct kvm_vcpu *vcpu,
 		default:
 			return be64_to_cpu(data);
 		}
+	} else {
+		switch (len) {
+		case 1:
+			return data & 0xff;
+		case 2:
+			return le16_to_cpu(data & 0xffff);
+		case 4:
+			return le32_to_cpu(data & 0xffffffff);
+		default:
+			return le64_to_cpu(data);
+		}
 	}
 
 	return data;		/* Leave LE untouched */
@@ -233,6 +244,17 @@ static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
 		default:
 			return cpu_to_be64(data);
 		}
+	} else {
+		switch (len) {
+		case 1:
+			return data & 0xff;
+		case 2:
+			return cpu_to_le16(data & 0xffff);
+		case 4:
+			return cpu_to_le32(data & 0xffffffff);
+		default:
+			return cpu_to_le64(data);
+		}
 	}
 
 	return data;		/* Leave LE untouched */
-- 
2.0.0
