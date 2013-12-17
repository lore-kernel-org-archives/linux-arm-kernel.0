From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 17 Dec 2013 18:31:14 +0000
Subject: [PATCH 2/2] kvmtool/arm: Add option to override Generic Timer
 frequency
In-Reply-To: <1387305074-29421-1-git-send-email-robin.murphy@arm.com>
References: <1387305074-29421-1-git-send-email-robin.murphy@arm.com>
Message-ID: <1387305074-29421-3-git-send-email-robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms have secure firmware which does not correctly set the
CNTFRQ register on boot, preventing the use of the Generic Timer.
This patch allows mirroring the necessary host workaround by specifying
the clock-frequency property in the guest DT.

This should only be considered a means of KVM bring-up on such systems,
such that vendors may be convinced to properly implement their firmware
to support the virtualisation capabilities of their hardware.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 tools/kvm/arm/include/arm-common/kvm-config-arch.h |   15 ++++++++++-----
 tools/kvm/arm/timer.c                              |    2 ++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/kvm/arm/include/arm-common/kvm-config-arch.h b/tools/kvm/arm/include/arm-common/kvm-config-arch.h
index 7ac6f6e..f3baf39 100644
--- a/tools/kvm/arm/include/arm-common/kvm-config-arch.h
+++ b/tools/kvm/arm/include/arm-common/kvm-config-arch.h
@@ -5,13 +5,18 @@
 
 struct kvm_config_arch {
 	const char *dump_dtb_filename;
+	unsigned int force_cntfrq;
 	bool aarch32_guest;
 };
 
-#define OPT_ARCH_RUN(pfx, cfg)						\
-	pfx,								\
-	ARM_OPT_ARCH_RUN(cfg)						\
-	OPT_STRING('\0', "dump-dtb", &(cfg)->dump_dtb_filename,		\
-		   ".dtb file", "Dump generated .dtb to specified file"),
+#define OPT_ARCH_RUN(pfx, cfg)							\
+	pfx,									\
+	ARM_OPT_ARCH_RUN(cfg)							\
+	OPT_STRING('\0', "dump-dtb", &(cfg)->dump_dtb_filename,			\
+		   ".dtb file", "Dump generated .dtb to specified file"),	\
+	OPT_UINTEGER('\0', "override-bad-firmware-cntfrq", &(cfg)->force_cntfrq,\
+		     "Specify Generic Timer frequency in guest DT to "		\
+		     "work around buggy secure firmware *Firmware should be "	\
+		     "updated to program CNTFRQ correctly*"),
 
 #endif /* ARM_COMMON__KVM_CONFIG_ARCH_H */
diff --git a/tools/kvm/arm/timer.c b/tools/kvm/arm/timer.c
index bd6a0bb..d757c1d 100644
--- a/tools/kvm/arm/timer.c
+++ b/tools/kvm/arm/timer.c
@@ -33,6 +33,8 @@ void timer__generate_fdt_nodes(void *fdt, struct kvm *kvm, int *irqs)
 	_FDT(fdt_begin_node(fdt, "timer"));
 	_FDT(fdt_property(fdt, "compatible", compatible, sizeof(compatible)));
 	_FDT(fdt_property(fdt, "interrupts", irq_prop, sizeof(irq_prop)));
+	if (kvm->cfg.arch.force_cntfrq > 0)
+		_FDT(fdt_property_cell(fdt, "clock-frequency", kvm->cfg.arch.force_cntfrq));
 	_FDT(fdt_end_node(fdt));
 }
 
-- 
1.7.9.5
