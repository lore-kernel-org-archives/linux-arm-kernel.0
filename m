From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 May 2013 15:02:53 +0100
Subject: [RFC PATCH 2/2] ARM: KVM: standalone Makefile for vgic and timers
In-Reply-To: <1367589773-5609-1-git-send-email-marc.zyngier@arm.com>
References: <1367589773-5609-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1367589773-5609-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the road to turn KVM/arm64 into something more sensible, change
the way we compile the VGIC and arch_timer code by using local
Makefiles instead of the very backward method we used before.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Makefile              | 2 +-
 arch/arm/kvm/Makefile | 2 --
 virt/Makefile         | 1 +
 virt/kvm/Makefile     | 1 +
 virt/kvm/arm/Makefile | 2 ++
 5 files changed, 5 insertions(+), 3 deletions(-)
 create mode 100644 virt/Makefile
 create mode 100644 virt/kvm/Makefile
 create mode 100644 virt/kvm/arm/Makefile

diff --git a/Makefile b/Makefile
index 6db672b..19d51df 100644
--- a/Makefile
+++ b/Makefile
@@ -732,7 +732,7 @@ export mod_sign_cmd
 
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/ virt/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index 110d6da..e0540fd 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -20,5 +20,3 @@ kvm-arm-y = $(addprefix $(KVM)/, kvm_main.o coalesced_mmio.o)
 obj-y += kvm-arm.o init.o interrupts.o
 obj-y += arm.o handle_exit.o guest.o mmu.o emulate.o reset.o
 obj-y += coproc.o coproc_a15.o mmio.o psci.o perf.o
-obj-$(CONFIG_KVM_ARM_VGIC) += $(addprefix $(KVM)/arm/, vgic.o)
-obj-$(CONFIG_KVM_ARM_TIMER) += $(addprefix $(KVM)/arm/, arch_timer.o)
diff --git a/virt/Makefile b/virt/Makefile
new file mode 100644
index 0000000..c3b9ad0
--- /dev/null
+++ b/virt/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_KVM)	+= kvm/
diff --git a/virt/kvm/Makefile b/virt/kvm/Makefile
new file mode 100644
index 0000000..dc87943
--- /dev/null
+++ b/virt/kvm/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_KVM_ARM_HOST)	+= arm/
diff --git a/virt/kvm/arm/Makefile b/virt/kvm/arm/Makefile
new file mode 100644
index 0000000..4df943b
--- /dev/null
+++ b/virt/kvm/arm/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_KVM_ARM_VGIC) += vgic.o
+obj-$(CONFIG_KVM_ARM_TIMER) += arch_timer.o
-- 
1.8.2.1
