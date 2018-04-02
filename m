From: liuwenliang@huawei.com (Abbott Liu)
Date: Mon, 2 Apr 2018 20:04:36 +0800
Subject: [PATCH v3 2/6] Disable instrumentation for some code
In-Reply-To: <20180402120440.31900-1-liuwenliang@huawei.com>
References: <20180402120440.31900-1-liuwenliang@huawei.com>
Message-ID: <20180402120440.31900-3-liuwenliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrey Ryabinin <a.ryabinin@samsung.com>

Disable instrumentation for arch/arm/boot/compressed/*
,arch/arm/kvm/hyp/* and arch/arm/vdso/* because those
code won't linkd with kernel image.

Disable kasan check in the function unwind_pop_register
because it doesn't matter that kasan checks failed when
unwind_pop_register read stack memory of task.

Reviewed-by: Russell King - ARM Linux <linux@armlinux.org.uk>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Abbott Liu <liuwenliang@huawei.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 arch/arm/boot/compressed/Makefile | 1 +
 arch/arm/kernel/unwind.c          | 3 ++-
 arch/arm/kvm/hyp/Makefile         | 4 ++++
 arch/arm/vdso/Makefile            | 2 ++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 45a6b9b..966103e 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -24,6 +24,7 @@ OBJS		+= hyp-stub.o
 endif
 
 GCOV_PROFILE		:= n
+KASAN_SANITIZE		:= n
 
 #
 # Architecture dependencies
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 0bee233..2e55c7d 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -249,7 +249,8 @@ static int unwind_pop_register(struct unwind_ctrl_block *ctrl,
 		if (*vsp >= (unsigned long *)ctrl->sp_high)
 			return -URC_FAILURE;
 
-	ctrl->vrs[reg] = *(*vsp)++;
+	ctrl->vrs[reg] = READ_ONCE_NOCHECK(*(*vsp));
+	(*vsp)++;
 	return URC_OK;
 }
 
diff --git a/arch/arm/kvm/hyp/Makefile b/arch/arm/kvm/hyp/Makefile
index 63d6b40..0a8b500 100644
--- a/arch/arm/kvm/hyp/Makefile
+++ b/arch/arm/kvm/hyp/Makefile
@@ -24,3 +24,7 @@ obj-$(CONFIG_KVM_ARM_HOST) += hyp-entry.o
 obj-$(CONFIG_KVM_ARM_HOST) += switch.o
 CFLAGS_switch.o		   += $(CFLAGS_ARMV7VE)
 obj-$(CONFIG_KVM_ARM_HOST) += s2-setup.o
+
+GCOV_PROFILE	:= n
+KASAN_SANITIZE	:= n
+UBSAN_SANITIZE	:= n
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index bb411821..87abbb7 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -30,6 +30,8 @@ CFLAGS_vgettimeofday.o = -O2
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
+KASAN_SANITIZE := n
+
 # Force dependency
 $(obj)/vdso.o : $(obj)/vdso.so
 
-- 
2.9.0
