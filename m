From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 18:30:36 +0200
Subject: [PATCH 04/21] ARM: kvm: define KVM_ARM_MAX_VCPUS unconditionally
In-Reply-To: <1366734653-488286-1-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
Message-ID: <1366734653-488286-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CONFIG_KVM_ARM_MAX_VCPUS symbol is needed in order to build the
kernel/context_tracking.c code, which includes the vgic data structures
implictly through the kvm headers. Definining the symbol to zero
on builds without KVM resolves this build error:

In file included from include/linux/kvm_host.h:33:0,
                 from kernel/context_tracking.c:18:
arch/arm/include/asm/kvm_host.h:28:23: warning: "CONFIG_KVM_ARM_MAX_VCPUS" is not defined [-Wundef]
 #define KVM_MAX_VCPUS CONFIG_KVM_ARM_MAX_VCPUS
                       ^
arch/arm/include/asm/kvm_vgic.h:34:24: note: in expansion of macro 'KVM_MAX_VCPUS'
 #define VGIC_MAX_CPUS  KVM_MAX_VCPUS
                        ^
arch/arm/include/asm/kvm_vgic.h:38:6: note: in expansion of macro 'VGIC_MAX_CPUS'
 #if (VGIC_MAX_CPUS > 8)
      ^
In file included from arch/arm/include/asm/kvm_host.h:41:0,
                 from include/linux/kvm_host.h:33,
                 from kernel/context_tracking.c:18:
arch/arm/include/asm/kvm_vgic.h:59:11: error: 'CONFIG_KVM_ARM_MAX_VCPUS' undeclared here (not in a function)
  } percpu[VGIC_MAX_CPUS];
           ^

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@cs.columbia.edu>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kvm/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 49dd64e..370e1a8 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -41,9 +41,9 @@ config KVM_ARM_HOST
 	  Provides host support for ARM processors.
 
 config KVM_ARM_MAX_VCPUS
-	int "Number maximum supported virtual CPUs per VM"
-	depends on KVM_ARM_HOST
-	default 4
+	int "Number maximum supported virtual CPUs per VM" if KVM_ARM_HOST
+	default 4 if KVM_ARM_HOST
+	default 0
 	help
 	  Static number of max supported virtual CPUs per VM.
 
-- 
1.8.1.2
