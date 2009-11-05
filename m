From: eltshanli@gmail.com (Li Jie)
Date: Thu, 5 Nov 2009 23:29:54 +0800
Subject: [PATCH] kirkwood: fix section mismatch
Message-ID: <8fb2581d0911050729o1631bbf8rdab225eaee593187@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kirkwood_timer_init() and kirkwood_pcie_setup() lack of __init which
causes following warnings:

WARNING: vmlinux.o(.text+0x9568): Section mismatch in reference from
the function kirkwood_timer_init() to the function
.init.text:kirkwood_find_tclk()
The function kirkwood_timer_init() references
the function __init kirkwood_find_tclk().
This is often because kirkwood_timer_init lacks a __init
annotation or the annotation of kirkwood_find_tclk is wrong.

WARNING: vmlinux.o(.text+0x979c): Section mismatch in reference from
the function kirkwood_pcie_setup() to the function
.init.text:orion_pcie_setup()
The function kirkwood_pcie_setup() references
the function __init orion_pcie_setup().
This is often because kirkwood_pcie_setup lacks a __init
annotation or the annotation of orion_pcie_setup is wrong.

Signed-off-by: lijie <eltshanli@gmail.com>
---
 arch/arm/mach-kirkwood/common.c |    2 +-
 arch/arm/mach-kirkwood/pcie.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 0acb61f..7177c4a 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -845,7 +845,7 @@ int __init kirkwood_find_tclk(void)
 	return 166666667;
 }

-static void kirkwood_timer_init(void)
+static void __init kirkwood_timer_init(void)
 {
 	kirkwood_tclk = kirkwood_find_tclk();
 	orion_time_init(IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
index d90b9aa..5538820 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-kirkwood/pcie.c
@@ -93,7 +93,7 @@ static struct pci_ops pcie_ops = {
 };


-static int kirkwood_pcie_setup(int nr, struct pci_sys_data *sys)
+static int __init kirkwood_pcie_setup(int nr, struct pci_sys_data *sys)
 {
 	struct resource *res;
 	extern unsigned int kirkwood_clk_ctrl;
-- 
1.6.5.2
