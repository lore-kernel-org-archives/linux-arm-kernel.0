From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Feb 2015 20:42:36 +0100
Subject: [PATCH 04/11] ARM: davinci: davinci_cfg_reg cannot be init
In-Reply-To: <1423770163-583064-1-git-send-email-arnd@arndb.de>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
Message-ID: <1423770163-583064-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

davinci_cfg_reg gets called from a lot of locations that
might get called after the init section has been discarded,
so the function itself must not be marked __init either.

The kernel build currently warns about this with lots of
messages like:

WARNING: vmlinux.o(.text.unlikely+0x24c): Section mismatch in reference from the function dm365evm_mmc_configure() to the function .init.text:davinci_cfg_reg()
The function dm365evm_mmc_configure() references
the function __init davinci_cfg_reg().
This is often because dm365evm_mmc_configure lacks a __init
annotation or the annotation of davinci_cfg_reg is wrong.

This removes the extraneous __init_or_module annotation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/mux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/mux.c b/arch/arm/mach-davinci/mux.c
index a8eb909a2b6c..6a2ff0a654a5 100644
--- a/arch/arm/mach-davinci/mux.c
+++ b/arch/arm/mach-davinci/mux.c
@@ -30,7 +30,7 @@ static void __iomem *pinmux_base;
 /*
  * Sets the DAVINCI MUX register based on the table
  */
-int __init_or_module davinci_cfg_reg(const unsigned long index)
+int davinci_cfg_reg(const unsigned long index)
 {
 	static DEFINE_SPINLOCK(mux_spin_lock);
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
@@ -101,7 +101,7 @@ int __init_or_module davinci_cfg_reg(const unsigned long index)
 }
 EXPORT_SYMBOL(davinci_cfg_reg);
 
-int __init_or_module davinci_cfg_reg_list(const short pins[])
+int davinci_cfg_reg_list(const short pins[])
 {
 	int i, error = -EINVAL;
 
-- 
2.1.0.rc2
