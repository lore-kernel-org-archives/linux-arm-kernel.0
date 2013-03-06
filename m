From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  6 Mar 2013 17:59:56 +0100
Subject: [PATCH 01/10] arm: plat-orion: only build addr-map.c when needed
In-Reply-To: <1362589205-4726-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362589205-4726-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1362589205-4726-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For now, addr-map.c is needed by all 5 Marvell EBU
sub-architectures. However, we are going to introduce the orion-mbus
driver, which will replace the address decoding code from
addr-map.c. In order to ease the migration process, we will do that
one sub-architecture at a time, which will require us to remove the
compilation of addr-map.c one sub-architecture at a time.

Therefore, we split the unconditional obj-y inclusion of addr-map.c
into 5 conditionals obj-$(CONFIG_...) lines, one per sub-architecture.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/Makefile |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
index a82cecb..ad97400 100644
--- a/arch/arm/plat-orion/Makefile
+++ b/arch/arm/plat-orion/Makefile
@@ -3,7 +3,11 @@
 #
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
-obj-y                             += addr-map.o
+obj-$(CONFIG_ARCH_MVEBU)          += addr-map.o
+obj-$(CONFIG_ARCH_KIRKWOOD)       += addr-map.o
+obj-$(CONFIG_ARCH_DOVE)           += addr-map.o
+obj-$(CONFIG_ARCH_ORION5X)        += addr-map.o
+obj-$(CONFIG_ARCH_MV78XX0)        += addr-map.o
 
 orion-gpio-$(CONFIG_GENERIC_GPIO) += gpio.o
 obj-$(CONFIG_PLAT_ORION_LEGACY)   += irq.o pcie.o time.o common.o mpp.o
-- 
1.7.9.5
