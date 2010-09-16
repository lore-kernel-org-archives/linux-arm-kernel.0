From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Sep 2010 19:12:12 +0200
Subject: [PATCH 0/3] [ARM] tegra: PCI Express support
In-Reply-To: <cover.1284655723.git.mike@compulab.co.il>
References: <cover.1284655723.git.mike@compulab.co.il>
Message-ID: <201009161912.12330.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 September 2010 18:53:33 Mike Rapoport wrote:
> These patches enable PCI Express support on Tegra2.
> The implementation is based on original NVidia code from (1), but it
> is heavily reworked to avoid custom PCI enumeration and make the code
> more Linux friendly.
> 
> This implementation assumes that the PCIe subsystem is fully powered
> and ungated by the bootloader.

The patches look good to me, but it seems that I/O space accesses are
still broken and need to be redirected to the PCI I/O range, like
the (totally untested) patch below.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-tegra/include/mach/io.h b/arch/arm/mach-tegra/include/mach/io.h
index 35edfc3..d54e384 100644
--- a/arch/arm/mach-tegra/include/mach/io.h
+++ b/arch/arm/mach-tegra/include/mach/io.h
@@ -21,7 +21,8 @@
 #ifndef __MACH_TEGRA_IO_H
 #define __MACH_TEGRA_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
+/* Two 1MB windows */
+#define IO_SPACE_LIMIT (SZ_1M + SZ_1M - 1)
 
 /* On TEGRA, many peripherals are very closely packed in
  * two 256MB io windows (that actually only use about 64KB
@@ -69,7 +70,7 @@ void tegra_iounmap(volatile void __iomem *addr);
 
 static inline void __iomem *__io(unsigned long addr)
 {
-	return (void __iomem *)addr;
+	return addr + tegra_pcie.regs + SZ_4M;
 }
 #define __io(a)         __io(a)
 #define __mem_pci(a)    (a)
