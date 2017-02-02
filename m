From: andre.przywara@arm.com (Andre Przywara)
Date: Thu,  2 Feb 2017 16:32:23 +0000
Subject: [kvmtool PATCH v9 15/15] arm64: enable GICv3-ITS emulation
In-Reply-To: <20170202163223.15372-1-andre.przywara@arm.com>
References: <20170202163223.15372-1-andre.przywara@arm.com>
Message-ID: <20170202163223.15372-16-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With everything in place for the ITS emulation add a new option to the
--irqchip parameter to allow the user to specify --irqchip=gicv3-its
to enable the ITS emulation.
This will trigger creating the FDT node and an ITS register frame to
tell the kernel we want ITS emulation in the guest.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arm/gic.c                                | 2 ++
 arm/include/arm-common/kvm-config-arch.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arm/gic.c b/arm/gic.c
index 5e5a227..54fd8fc 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -26,6 +26,8 @@ int irqchip_parser(const struct option *opt, const char *arg, int unset)
 		*type = IRQCHIP_GICV2;
 	} else if (!strcmp(arg, "gicv3")) {
 		*type = IRQCHIP_GICV3;
+	} else if (!strcmp(arg, "gicv3-its")) {
+		*type = IRQCHIP_GICV3_ITS;
 	} else {
 		pr_err("irqchip: unknown type \"%s\"\n", arg);
 		return -1;
diff --git a/arm/include/arm-common/kvm-config-arch.h b/arm/include/arm-common/kvm-config-arch.h
index ed626b5..b48e720 100644
--- a/arm/include/arm-common/kvm-config-arch.h
+++ b/arm/include/arm-common/kvm-config-arch.h
@@ -27,7 +27,7 @@ int irqchip_parser(const struct option *opt, const char *arg, int unset);
 		    "Force virtio devices to use PCI as their default "		\
 		    "transport"),						\
         OPT_CALLBACK('\0', "irqchip", &(cfg)->irqchip,				\
-		     "[gicv2|gicv3]",					\
+		     "[gicv2|gicv3|gicv3-its]",					\
 		     "Type of interrupt controller to emulate in the guest",	\
 		     irqchip_parser, NULL),
 
-- 
2.9.0
