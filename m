From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jul 2012 15:52:27 +0000
Subject: [GIT PULL] io.h clean-up for PCI
In-Reply-To: <50100587.9080809@gmail.com>
References: <50049285.1060100@gmail.com> <201207241243.55640.arnd@arndb.de>
 <50100587.9080809@gmail.com>
Message-ID: <201207251552.28215.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 July 2012, Rob Herring wrote:
> On 07/24/2012 07:43 AM, Arnd Bergmann wrote:
> > On Tuesday 24 July 2012, Rob Herring wrote:
> >>> --- a/arch/arm/mach-iop13xx/include/mach/iop13xx.h
> >>> +++ b/arch/arm/mach-iop13xx/include/mach/iop13xx.h
> >>> @@ -95,7 +95,6 @@ extern unsigned long get_iop_tick_rate(void);
> >>>  /* PCI-E ranges */
> >>>  #define IOP13XX_PCIE_LOWER_IO_PA              0xfffd0000UL
> >>>  #define IOP13XX_PCIE_LOWER_IO_BA              0x0UL  /* OIOTVR */
> >>> -#define IOP13XX_PCIE_LOWER_IO_BA              0x10000UL
> >>
> >> This means we have PCIE and PCIX buses both using i/o bus addresses
> >> starting at 0x0. We can't have that, right?
> >>
> >> The requested resource won't match either as the resource start address
> >> is bus_nr * 64K.
> > 
> > Well, this is the number that gets written into the outbound
> > translation window register, which has to be zero AFAICT.
> > 
> > The PCI device you plug into the bus will always see its io
> > ports as being between zero and 65536 -- the part that
> > stays at 0x10000UL is the offset address that we use in Linux
> > to give it a unique address in the virtual address space
> > window we use to cover all the io port ranges.
> > 
> > The io_offset still gets set to 0x10000, so this number always
> > gets added and subtracted when converting between Linux port
> > numbers and bus-specific port numbers.
> 
> I don't think this is going to work right with the orion family. They
> set the 2nd+ buses to some non-zero bus value.
> 
>         { 0, KIRKWOOD_PCIE_IO_PHYS_BASE, KIRKWOOD_PCIE_IO_SIZE,
>           TARGET_PCIE, ATTR_PCIE_IO, KIRKWOOD_PCIE_IO_BUS_BASE
> 
> This is 0.
> 
>         },
>         { 1, KIRKWOOD_PCIE_MEM_PHYS_BASE, KIRKWOOD_PCIE_MEM_SIZE,
>           TARGET_PCIE, ATTR_PCIE_MEM, KIRKWOOD_PCIE_MEM_BUS_BASE
>         },
>         { 2, KIRKWOOD_PCIE1_IO_PHYS_BASE, KIRKWOOD_PCIE1_IO_SIZE,
>           TARGET_PCIE, ATTR_PCIE1_IO, KIRKWOOD_PCIE1_IO_BUS_BASE
> 
> This was 0x100000 and is now 0x10000.
> 
>         },
>         { 3, KIRKWOOD_PCIE1_MEM_PHYS_BASE, KIRKWOOD_PCIE1_MEM_SIZE,
>           TARGET_PCIE, ATTR_PCIE1_MEM, KIRKWOOD_PCIE1_MEM_BUS_BASE
>         },
> 
> If we change all these to 0, then I need to go back thru all the platforms.

You are right, this is different from what I thought. Do you think
this is for a similar setup register to the one used on IOP13xx?

For all I know, the code in iop13xx has always used a zero here,
while kirkwood/dove/mv78xx0/orion did not. I believe it can work
either way, as long as that register matches what we set up in
the sys->io_offset variable.

With my patch for iop13xx, it does not, since set both the
sys->io_offset variable and the OIOTVR register to zero, but
let the resource start at 64K. I'm pretty sure now that my
patch was broken because of this. If so, I would prefer to leave
io_offset at zero and change the register again.

How is this for a change?

	Arnd

8<----
>From 2012ce83ebbfdee38d2cfc42ab7a8352fe1b95f6 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Jul 2012 14:12:00 +0000
Subject: [PATCH] ARM: iop13xx: remove duplicate IOP13XX_PCIE_LOWER_IO_BA

iop13xx ended up with two conflicting definitions for
IOP13XX_PCIE_LOWER_IO_BA, where one of them is used to set up
the hardware window and was traditionally zero, while the other
one is used to set the location of the second mapping into the
virtual address space.

This kills the extraneous definition and uses the 64KB offset
that is already hardcoded in the bios32.c file now for
storing in the register as well.

Let's hope this works. If it does not, the alternative would
be to revert the value we write into OIOTVR to zero and
set sys->io_offset to 64K.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-iop13xx/include/mach/iop13xx.h b/arch/arm/mach-iop13xx/include/mach/iop13xx.h
index 9278b8c..e10e101 100644
--- a/arch/arm/mach-iop13xx/include/mach/iop13xx.h
+++ b/arch/arm/mach-iop13xx/include/mach/iop13xx.h
@@ -94,8 +94,7 @@ extern unsigned long get_iop_tick_rate(void);
 
 /* PCI-E ranges */
 #define IOP13XX_PCIE_LOWER_IO_PA      	 0xfffd0000UL
-#define IOP13XX_PCIE_LOWER_IO_BA      	 0x0UL  /* OIOTVR */
-#define IOP13XX_PCIE_LOWER_IO_BA      	 0x10000UL
+#define IOP13XX_PCIE_LOWER_IO_BA	 0x10000UL  /* OIOTVR */
 
 #define IOP13XX_PCIE_MEM_PHYS_OFFSET  	 0x200000000ULL
 #define IOP13XX_PCIE_MEM_WINDOW_SIZE  	 0x3a000000UL
diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index f3826bb..91f731a 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -1058,7 +1058,7 @@ int iop13xx_pci_setup(int nr, struct pci_sys_data *sys)
 
 		__raw_writel(pcsr, IOP13XX_ATUE_PCSR);
 
-		pci_ioremap_io(IOP13XX_PCIE_LOWER_IO_BA, IOP13XX_PCIE_LOWER_IO_PA);
+		pci_ioremap_io(SZ_64K, IOP13XX_PCIE_LOWER_IO_PA);
 
 		res->start = IOP13XX_PCIE_LOWER_MEM_RA;
 		res->end   = IOP13XX_PCIE_UPPER_MEM_RA;
