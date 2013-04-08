From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  8 Apr 2013 16:47:18 +0100
Subject: [PATCH 1/2] ARM: KVM: add architecture specific hook for capabilities
In-Reply-To: <1365436039-29564-1-git-send-email-marc.zyngier@arm.com>
References: <1365436039-29564-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1365436039-29564-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the capabilities are common to both arm and arm64, but
we still need to handle the exceptions.

Introduce kvm_arch_dev_ioctl_check_extention, which both architectures
implement (in the 32bit case, it just returns 0).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h | 5 +++++
 arch/arm/kvm/arm.c              | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 78813b8..a81480c 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -207,6 +207,11 @@ static inline void __cpu_init_hyp_mode(unsigned long long pgd_ptr,
 	kvm_call_hyp((void *)pgd_low, pgd_high, hyp_stack_ptr, vector_ptr);
 }
 
+static inline int kvm_arch_dev_ioctl_check_extention(long ext)
+{
+	return 0;
+}
+
 int kvm_perf_init(void);
 int kvm_perf_teardown(void);
 
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 61f7394..ed7b1e3 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -206,7 +206,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 		r = KVM_MAX_VCPUS;
 		break;
 	default:
-		r = 0;
+		r = kvm_arch_dev_ioctl_check_extention(ext);
 		break;
 	}
 	return r;
-- 
1.8.1.4
