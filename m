From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 30 Apr 2013 07:49:31 -0700
Subject: [PATCH 10/15] ARM: KVM: add architecture specific hook for
 capabilities
In-Reply-To: <1367333376-30983-1-git-send-email-cdall@cs.columbia.edu>
References: <1367333376-30983-1-git-send-email-cdall@cs.columbia.edu>
Message-ID: <1367333376-30983-11-git-send-email-cdall@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Most of the capabilities are common to both arm and arm64, but
we still need to handle the exceptions.

Introduce kvm_arch_dev_ioctl_check_extension, which both architectures
implement (in the 32bit case, it just returns 0).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@cs.columbia.edu>
---
 arch/arm/include/asm/kvm_host.h |    5 +++++
 arch/arm/kvm/arm.c              |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 6c2a35d..dcfcbf5 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -214,6 +214,11 @@ static inline void __cpu_init_hyp_mode(unsigned long long boot_pgd_ptr,
 	kvm_call_hyp((void*)hyp_stack_ptr, vector_ptr, pgd_ptr);
 }
 
+static inline int kvm_arch_dev_ioctl_check_extension(long ext)
+{
+	return 0;
+}
+
 int kvm_perf_init(void);
 int kvm_perf_teardown(void);
 
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 6ea2aed..cc67caf 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -206,7 +206,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 		r = KVM_MAX_VCPUS;
 		break;
 	default:
-		r = 0;
+		r = kvm_arch_dev_ioctl_check_extension(ext);
 		break;
 	}
 	return r;
-- 
1.7.9.5
