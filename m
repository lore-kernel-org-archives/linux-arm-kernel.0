From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  3 Apr 2013 10:43:13 +0100
Subject: [PATCH] ARM: KVM: fix KVM_CAP_ARM_SET_DEVICE_ADDR reporting
Message-ID: <1364982193-21867-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 3401d54696f9 (KVM: ARM: Introduce KVM_ARM_SET_DEVICE_ADDR
ioctl) added support for the KVM_CAP_ARM_SET_DEVICE_ADDR capability,
but failed to add a break in the relevant case statement, returning
the number of CPUs instead.

Luckilly enough, the CONFIG_NR_CPUS=0 patch hasn't been merged yet
(https://lkml.org/lkml/diff/2012/3/31/131/1), so the bug wasn't
noticed.

Just give it a break!

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 6cc076e..d568e83 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -198,6 +198,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 		break;
 	case KVM_CAP_ARM_SET_DEVICE_ADDR:
 		r = 1;
+		break;
 	case KVM_CAP_NR_VCPUS:
 		r = num_online_cpus();
 		break;
-- 
1.8.1.4
