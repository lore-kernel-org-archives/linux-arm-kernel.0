From: robherring2@gmail.com (Rob Herring)
Date: Sun, 22 Jul 2012 19:35:00 -0500
Subject: [GIT PULL] io.h clean-up for PCI
In-Reply-To: <50049285.1060100@gmail.com>
References: <50049285.1060100@gmail.com>
Message-ID: <500C9C34.2030404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2012 05:15 PM, Rob Herring wrote:
> Arnd,
> 
> Please pull io.h PCI clean-up series. As you suggested, lets get it in
> next for test and decide later if to apply it for 3.6 or wait.
> 
> BTW, I'll have sporadic email access over the next 2 weeks.
> 

I found a collision with EDAC enum mem_type and ARM struct mem_type definitions.
It's caused from pulling in asm/mach/map.h into asm/mach/pci.h. I've reworked
things which avoids the to avoid that. You want a rebased branch with the fix
and other issues you found or just the following patch?

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 188fd58..78d10a8 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -12,7 +12,6 @@
 #define __ASM_MACH_PCI_H
 
 #include <linux/ioport.h>
-#include <asm/mach/map.h>
 
 struct pci_sys_data;
 struct pci_ops;
@@ -63,6 +62,9 @@ void pci_common_init(struct hw_pci *);
  * Setup fixed I/O mapping.
  */
 #if defined(CONFIG_PCI) && !defined(CONFIG_NEED_MACH_IO_H)
+extern void vm_reserve_area_early(unsigned long addr, unsigned long size,
+				  void *caller);
+
 /* Called from devicemaps_init before .map_io */
 static inline void __init pci_reserve_io(void)
 {
