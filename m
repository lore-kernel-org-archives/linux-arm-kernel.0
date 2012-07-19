From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Jul 2012 14:16:32 +0000
Subject: [GIT PULL] io.h clean-up for PCI
In-Reply-To: <50049285.1060100@gmail.com>
References: <50049285.1060100@gmail.com>
Message-ID: <201207191416.33330.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 July 2012, Rob Herring wrote:
> Arnd,
> 
> Please pull io.h PCI clean-up series. As you suggested, lets get it in
> next for test and decide later if to apply it for 3.6 or wait.
> 
> BTW, I'll have sporadic email access over the next 2 weeks.

I've alrady applied this patch on top, which was rather obvious.

	Arnd

commit 960760557356fba9e86698605d1e1c68783d72e3
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Jul 19 16:13:41 2012 +0200

    ARM: pci: mark pci_reserve_io as __init
    
    pci_reserve_io calls the vm_reserve_area_early function that is
    marked __init, so it needs to be __init itself to avoid this
    warning:
    
    WARNING: arch/arm/mm/built-in.o(.text+0x22dc): Section mismatch in
    reference from the function pci_reserve_io() to the function
    .init.text:vm_reserve_area_early()
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 6345a5f..188fd58 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -64,7 +64,7 @@ void pci_common_init(struct hw_pci *);
  */
 #if defined(CONFIG_PCI) && !defined(CONFIG_NEED_MACH_IO_H)
 /* Called from devicemaps_init before .map_io */
-static inline void pci_reserve_io(void)
+static inline void __init pci_reserve_io(void)
 {
 	vm_reserve_area_early(PCI_IO_VIRT_BASE, SZ_2M, pci_reserve_io);
 }
