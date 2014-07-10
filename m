From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 10 Jul 2014 23:36:21 +0200
Subject: [PATCH v2 01/12] ARM: Kirkwood: Remove mach-kirkwood
In-Reply-To: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
Message-ID: <1405028192-9623-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all boards have been converted to DT and all the support code
lives in mach-mvebu, we can remove mach-kirkwood.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/Kconfig                                  |  18 -
 arch/arm/Kconfig.debug                            |   6 +-
 arch/arm/Makefile                                 |   1 -
 arch/arm/boot/dts/Makefile                        |   5 +-
 arch/arm/mach-kirkwood/Kconfig                    | 111 ----
 arch/arm/mach-kirkwood/Makefile                   |  14 -
 arch/arm/mach-kirkwood/Makefile.boot              |   3 -
 arch/arm/mach-kirkwood/board-dt.c                 | 223 -------
 arch/arm/mach-kirkwood/common.c                   | 746 ----------------------
 arch/arm/mach-kirkwood/common.h                   |  74 ---
 arch/arm/mach-kirkwood/d2net_v2-setup.c           | 231 -------
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  86 ---
 arch/arm/mach-kirkwood/include/mach/entry-macro.S |  34 -
 arch/arm/mach-kirkwood/include/mach/hardware.h    |  14 -
 arch/arm/mach-kirkwood/include/mach/irqs.h        |  65 --
 arch/arm/mach-kirkwood/include/mach/kirkwood.h    | 142 ----
 arch/arm/mach-kirkwood/include/mach/uncompress.h  |  46 --
 arch/arm/mach-kirkwood/irq.c                      |  82 ---
 arch/arm/mach-kirkwood/lacie_v2-common.c          | 114 ----
 arch/arm/mach-kirkwood/lacie_v2-common.h          |  16 -
 arch/arm/mach-kirkwood/mpp.c                      |  43 --
 arch/arm/mach-kirkwood/mpp.h                      | 348 ----------
 arch/arm/mach-kirkwood/netxbig_v2-setup.c         | 422 ------------
 arch/arm/mach-kirkwood/openrd-setup.c             | 255 --------
 arch/arm/mach-kirkwood/pcie.c                     | 296 ---------
 arch/arm/mach-kirkwood/pm.c                       |  76 ---
 arch/arm/mach-kirkwood/pm.h                       |  26 -
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c      |  89 ---
 arch/arm/mach-kirkwood/rd88f6281-setup.c          | 128 ----
 arch/arm/mach-kirkwood/t5325-setup.c              | 216 -------
 arch/arm/mach-kirkwood/ts219-setup.c              | 142 ----
 arch/arm/mach-kirkwood/ts41x-setup.c              | 186 ------
 arch/arm/mach-kirkwood/tsx1x-common.c             | 113 ----
 arch/arm/mach-kirkwood/tsx1x-common.h             |   7 -
 arch/arm/mm/Kconfig                               |   2 +-
 35 files changed, 4 insertions(+), 4376 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/Kconfig
 delete mode 100644 arch/arm/mach-kirkwood/Makefile
 delete mode 100644 arch/arm/mach-kirkwood/Makefile.boot
 delete mode 100644 arch/arm/mach-kirkwood/board-dt.c
 delete mode 100644 arch/arm/mach-kirkwood/common.c
 delete mode 100644 arch/arm/mach-kirkwood/common.h
 delete mode 100644 arch/arm/mach-kirkwood/d2net_v2-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/bridge-regs.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/kirkwood.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-kirkwood/irq.c
 delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.c
 delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.h
 delete mode 100644 arch/arm/mach-kirkwood/mpp.c
 delete mode 100644 arch/arm/mach-kirkwood/mpp.h
 delete mode 100644 arch/arm/mach-kirkwood/netxbig_v2-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/openrd-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/pcie.c
 delete mode 100644 arch/arm/mach-kirkwood/pm.c
 delete mode 100644 arch/arm/mach-kirkwood/pm.h
 delete mode 100644 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/rd88f6281-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/t5325-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/ts219-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/ts41x-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/tsx1x-common.c
 delete mode 100644 arch/arm/mach-kirkwood/tsx1x-common.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87b63fde06d7..b20251ad7aa5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -536,22 +536,6 @@ config ARCH_DOVE
 	help
 	  Support for the Marvell Dove SoC 88AP510
 
-config ARCH_KIRKWOOD
-	bool "Marvell Kirkwood"
-	select ARCH_HAS_CPUFREQ
-	select ARCH_REQUIRE_GPIOLIB
-	select CPU_FEROCEON
-	select GENERIC_CLOCKEVENTS
-	select MVEBU_MBUS
-	select PCI
-	select PCI_QUIRKS
-	select PINCTRL
-	select PINCTRL_KIRKWOOD
-	select PLAT_ORION_LEGACY
-	help
-	  Support for the following Marvell Kirkwood series SoCs:
-	  88F6180, 88F6192 and 88F6281.
-
 config ARCH_MV78XX0
 	bool "Marvell MV78xx0"
 	select ARCH_REQUIRE_GPIOLIB
@@ -966,8 +950,6 @@ source "arch/arm/mach-ixp4xx/Kconfig"
 
 source "arch/arm/mach-keystone/Kconfig"
 
-source "arch/arm/mach-kirkwood/Kconfig"
-
 source "arch/arm/mach-ks8695/Kconfig"
 
 source "arch/arm/mach-msm/Kconfig"
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 8f90595069a1..2dfaf8f20c21 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1033,7 +1033,7 @@ config DEBUG_UART_8250
 	def_bool ARCH_DOVE || ARCH_EBSA110 || \
 		(FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
 		ARCH_GEMINI || ARCH_IOP13XX || ARCH_IOP32X || \
-		ARCH_IOP33X || ARCH_IXP4XX || ARCH_KIRKWOOD || \
+		ARCH_IOP33X || ARCH_IXP4XX || \
 		ARCH_LPC32XX || ARCH_MV78XX0 || ARCH_ORION5X || ARCH_RPC
 
 config DEBUG_UART_PHYS
@@ -1089,8 +1089,7 @@ config DEBUG_UART_PHYS
 	default 0xe0000000 if ARCH_SPEAR13XX
 	default 0xf0000be0 if ARCH_EBSA110
 	default 0xf1012000 if DEBUG_MVEBU_UART_ALTERNATE
-	default 0xf1012000 if ARCH_DOVE || ARCH_KIRKWOOD || ARCH_MV78XX0 || \
-				ARCH_ORION5X
+	default 0xf1012000 if ARCH_DOVE || ARCH_MV78XX0 || ARCH_ORION5X
 	default 0xf7fc9000 if DEBUG_BERLIN_UART
 	default 0xf8b00000 if DEBUG_HI3716_UART
 	default 0xf991e000 if DEBUG_QCOM_UARTDM
@@ -1154,7 +1153,6 @@ config DEBUG_UART_VIRT
 	default 0xfec20000 if DEBUG_DAVINCI_DMx_UART0
 	default 0xfed0c000 if DEBUG_DAVINCI_DA8XX_UART1
 	default 0xfed0d000 if DEBUG_DAVINCI_DA8XX_UART2
-	default 0xfed12000 if ARCH_KIRKWOOD
 	default 0xfed60000 if DEBUG_RK29_UART0
 	default 0xfed64000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
 	default 0xfed68000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 6721fab13734..433a6f1b218f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -163,7 +163,6 @@ machine-$(CONFIG_ARCH_IOP32X)		+= iop32x
 machine-$(CONFIG_ARCH_IOP33X)		+= iop33x
 machine-$(CONFIG_ARCH_IXP4XX)		+= ixp4xx
 machine-$(CONFIG_ARCH_KEYSTONE)		+= keystone
-machine-$(CONFIG_ARCH_KIRKWOOD)		+= kirkwood
 machine-$(CONFIG_ARCH_KS8695)		+= ks8695
 machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
 machine-$(CONFIG_ARCH_MMP)		+= mmp
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5986ff63b901..025350ca96aa 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -90,8 +90,7 @@ dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
 dtb-$(CONFIG_ARCH_KEYSTONE) += k2hk-evm.dtb \
 	k2l-evm.dtb \
 	k2e-evm.dtb
-kirkwood := \
-	kirkwood-b3.dtb \
+dtb-$(CONFIG_MACH_KIRKWOOD) += kirkwood-b3.dtb \
 	kirkwood-cloudbox.dtb \
 	kirkwood-db-88f6281.dtb \
 	kirkwood-db-88f6282.dtb \
@@ -150,8 +149,6 @@ kirkwood := \
 	kirkwood-ts219-6282.dtb \
 	kirkwood-ts419-6281.dtb \
 	kirkwood-ts419-6282.dtb
-dtb-$(CONFIG_ARCH_KIRKWOOD) += $(kirkwood)
-dtb-$(CONFIG_MACH_KIRKWOOD) += $(kirkwood)
 dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
 dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
 dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
deleted file mode 100644
index df4b26340ae4..000000000000
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
deleted file mode 100644
index 3a72c5c6e747..000000000000
diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
deleted file mode 100644
index 760a0efe7580..000000000000
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
deleted file mode 100644
index ff18ff20f71f..000000000000
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
deleted file mode 100644
index 255f33a3903c..000000000000
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
deleted file mode 100644
index 832a4e2ab8d7..000000000000
diff --git a/arch/arm/mach-kirkwood/d2net_v2-setup.c b/arch/arm/mach-kirkwood/d2net_v2-setup.c
deleted file mode 100644
index 453418063c1e..000000000000
diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
deleted file mode 100644
index 1c37082c8b39..000000000000
diff --git a/arch/arm/mach-kirkwood/include/mach/entry-macro.S b/arch/arm/mach-kirkwood/include/mach/entry-macro.S
deleted file mode 100644
index 82db29f7af8f..000000000000
diff --git a/arch/arm/mach-kirkwood/include/mach/hardware.h b/arch/arm/mach-kirkwood/include/mach/hardware.h
deleted file mode 100644
index 742b74f43e41..000000000000
diff --git a/arch/arm/mach-kirkwood/include/mach/irqs.h b/arch/arm/mach-kirkwood/include/mach/irqs.h
deleted file mode 100644
index 2bf8161e3b51..000000000000
diff --git a/arch/arm/mach-kirkwood/include/mach/kirkwood.h b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
deleted file mode 100644
index 92976cef3910..000000000000
diff --git a/arch/arm/mach-kirkwood/include/mach/uncompress.h b/arch/arm/mach-kirkwood/include/mach/uncompress.h
deleted file mode 100644
index 5bca5534021f..000000000000
diff --git a/arch/arm/mach-kirkwood/irq.c b/arch/arm/mach-kirkwood/irq.c
deleted file mode 100644
index 2c47a8ad0e27..000000000000
diff --git a/arch/arm/mach-kirkwood/lacie_v2-common.c b/arch/arm/mach-kirkwood/lacie_v2-common.c
deleted file mode 100644
index 8e3e4331c380..000000000000
diff --git a/arch/arm/mach-kirkwood/lacie_v2-common.h b/arch/arm/mach-kirkwood/lacie_v2-common.h
deleted file mode 100644
index fc64f578536e..000000000000
diff --git a/arch/arm/mach-kirkwood/mpp.c b/arch/arm/mach-kirkwood/mpp.c
deleted file mode 100644
index e96fd71abd76..000000000000
diff --git a/arch/arm/mach-kirkwood/mpp.h b/arch/arm/mach-kirkwood/mpp.h
deleted file mode 100644
index d5a0d1da2e0e..000000000000
diff --git a/arch/arm/mach-kirkwood/netxbig_v2-setup.c b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
deleted file mode 100644
index 913d032cdb19..000000000000
diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
deleted file mode 100644
index e5cf84103583..000000000000
diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
deleted file mode 100644
index 12d86f39f380..000000000000
diff --git a/arch/arm/mach-kirkwood/pm.c b/arch/arm/mach-kirkwood/pm.c
deleted file mode 100644
index 8e5e0329d04c..000000000000
diff --git a/arch/arm/mach-kirkwood/pm.h b/arch/arm/mach-kirkwood/pm.h
deleted file mode 100644
index 21e7530f368b..000000000000
diff --git a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
deleted file mode 100644
index e4fd3129d36f..000000000000
diff --git a/arch/arm/mach-kirkwood/rd88f6281-setup.c b/arch/arm/mach-kirkwood/rd88f6281-setup.c
deleted file mode 100644
index 5154bd2a3ad3..000000000000
diff --git a/arch/arm/mach-kirkwood/t5325-setup.c b/arch/arm/mach-kirkwood/t5325-setup.c
deleted file mode 100644
index 8736f8c97518..000000000000
diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-kirkwood/ts219-setup.c
deleted file mode 100644
index e1267d6b468f..000000000000
diff --git a/arch/arm/mach-kirkwood/ts41x-setup.c b/arch/arm/mach-kirkwood/ts41x-setup.c
deleted file mode 100644
index 81d585806b2f..000000000000
diff --git a/arch/arm/mach-kirkwood/tsx1x-common.c b/arch/arm/mach-kirkwood/tsx1x-common.c
deleted file mode 100644
index cec87cef76ca..000000000000
diff --git a/arch/arm/mach-kirkwood/tsx1x-common.h b/arch/arm/mach-kirkwood/tsx1x-common.h
deleted file mode 100644
index 7fa037361b55..000000000000
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index eda0dd0ab97b..f06c6aad75e8 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -854,7 +854,7 @@ config OUTER_CACHE_SYNC
 
 config CACHE_FEROCEON_L2
 	bool "Enable the Feroceon L2 cache controller"
-	depends on ARCH_KIRKWOOD || ARCH_MV78XX0 || ARCH_MVEBU
+	depends on ARCH_MV78XX0 || ARCH_MVEBU
 	default y
 	select OUTER_CACHE
 	help
-- 
2.0.1
