From: andreas.fenkart@streamunlimited.com (Andreas Fenkart)
Date: Thu, 1 Oct 2009 12:47:15 +0200
Subject: [PATCH 1/4] Made VMALLOC_END of type unsigned long.
In-Reply-To: <20090619094640.GD22234@n2100.arm.linux.org.uk>
References: <1245155890204-git-send-email-andreas.fenkart@streamunlimited.com>
	<20090619094640.GD22234@n2100.arm.linux.org.uk>
Message-ID: <20091001104715.GA25067@CCCP>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2009 at 10:46:40AM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 16, 2009 at 02:38:07PM +0200, Andreas Fenkart wrote:
> > This makes VMALLOC_END consistent with VMALLOC_START
> > diff --git a/arch/arm/mach-davinci/include/mach/io.h b/arch/arm/mach-davinci/include/mach/io.h
> > index 2479785..81c4269 100644
> > --- a/arch/arm/mach-davinci/include/mach/io.h
> > +++ b/arch/arm/mach-davinci/include/mach/io.h
> > @@ -18,7 +18,7 @@
> >   * I/O mapping
> >   * ----------------------------------------------------------------------------
> >   */
> > -#define IO_PHYS		0x01c00000
> > +#define IO_PHYS		0x01c00000UL
> 
> Why is this change required?

Davinci defines VMALLOC_END this way:

#define VMALLOC_END   (IO_VIRT - (2<<20))   

The simple solution would be to prefix the VMALLOC_END with UL,
the alternative to make IO_VIRT unsinged long.

IO_VIRT and recurses are defined in mach/hardware.h
#define IO_PHYS   0x01c00000UL
#define IO_OFFSET 0xfd000000 /* Virtual IO = 0xfec00000 */
#define IO_SIZE   0x00400000
#define IO_VIRT   (IO_PHYS + IO_OFFSET)

Changing IO_VIRT to unsigned long should be fine. Virtual
addresses are mostly unsigned long,@least VMALLOC_START,
PAGE_OFFSET are. See below for complete list of IO_VIRT usage.

IO_PHYS should not be changed though, since it is assigned to
unsigned int fields.

So I changed the patch, and made only IO_VIRT unsigned long:

 #define IO_PHYS        0x01c00000
 #define IO_OFFSET      0xfd000000 /* Virtual IO = 0xfec00000 */
 #define IO_SIZE        0x00400000
-#define IO_VIRT        (IO_PHYS + IO_OFFSET)
+#define IO_VIRT        UL(IO_PHYS + IO_OFFSET)


Andreas

----

IO_VIRT:
-assigned to struct map_desc / unsigned long virtual;
-used as return value in void __iomem *davinci_ioremap function;
-used in define DA8XX_CP_INTC_VIRT, which recursively is used as:
--assigned to struct map_desc / unsigned long virtual;
--assigned to struct davinci_soc_info / void __iomem *intc_base;
-used in define of VMALLOC_END

IO_PHYS:
-assigned to struct machine_desc / unsigned int phys_io;
-assigned to struct machine_desc / unsigned int io_pg_offst;
-shifted and assigned to struct map_desc / unsigned long pfn;
-used defines for UART base address, which are:
--via plat_serial8250_port / resource_size_t mapbase
---assigned to type phys_addr_t
-used defines for TIMER base address, which recursively are:
--assigned to struct davinci_timer_instance / void __iomem *base;
-used defines for WDOG base address, which are:
--via struct resource / resource_size_t start
---assigned to type phys_addr_t
