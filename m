From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jul 2010 17:49:04 +0200
Subject: [RFC] dove: fix __io() definition to use bus based offset
In-Reply-To: <AANLkTikeoQf=WC8M9daA=O+tgPdMbDeQdMTWoT8U=CpK@mail.gmail.com>
References: <AANLkTinuXRH0XeD=3b0Wmq32SEEBxdevfj58EmSybcWu@mail.gmail.com>
	<201007291726.39145.arnd@arndb.de>
	<AANLkTikeoQf=WC8M9daA=O+tgPdMbDeQdMTWoT8U=CpK@mail.gmail.com>
Message-ID: <201007291749.04181.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 July 2010, Eric Miao wrote:
> On Thu, Jul 29, 2010 at 11:26 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >>  #include "dove.h"
> >>
> >> -#define IO_SPACE_LIMIT         0xffffffff
> >> -
> >> -#define __io(a)  ((void __iomem *)(((a) - DOVE_PCIE0_IO_PHYS_BASE) +\
> >> -                                  DOVE_PCIE0_IO_VIRT_BASE))
> >> -#define __mem_pci(a)           (a)
> >> +#define IO_SPACE_LIMIT 0xffffffff
> >> +#define __io(a)                __typesafe_io((a) - DOVE_PCIE0_IO_BUS_BASE + \
> >> +                                           DOVE_PCIE0_IO_VIRT_BASE)
> >> +#define __mem_pci(a)   (a)
> >>
> >>  #endif
> >>
> >
> > The IO_SPACE_LIMIT still looks wrong, AFAICT it should be
> >
> > #define IO_SPACE_LIMIT (DOVE_PCIE0_IO_SIZE + DOVE_PCIE1_IO_SIZE - 1)
> >
> 
> And it looks like PCIE1_IO space is not used as indicated in its __io() macro.

DOVE_PCIE1_IO_VIRT_BASE directly follows (DOVE_PCIE0_IO_VIRT_BASE +
DOVE_PCIE0_IO_SIZE), so the macro is the same, isn't it?

However, I believe you also need the patch below to make thinks like
PCI-ISA bridges and VGA adapters as well as /dev/port access work.

Not-at-all-tested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
 
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -59,10 +59,10 @@ static int __init dove_pcie_setup(int nr, struct pci_sys_data *sys)
 	pp->io_space_name[sizeof(pp->io_space_name) - 1] = 0;
 	pp->res[0].name = pp->io_space_name;
 	if (pp->index == 0) {
-		pp->res[0].start = DOVE_PCIE0_IO_PHYS_BASE;
+		pp->res[0].start = DOVE_PCIE0_IO_BUS_BASE;
 		pp->res[0].end = pp->res[0].start + DOVE_PCIE0_IO_SIZE - 1;
 	} else {
-		pp->res[0].start = DOVE_PCIE1_IO_PHYS_BASE;
+		pp->res[0].start = DOVE_PCIE1_IO_BUS_BASE;
 		pp->res[0].end = pp->res[0].start + DOVE_PCIE1_IO_SIZE - 1;
 	}
 	pp->res[0].flags = IORESOURCE_IO;
