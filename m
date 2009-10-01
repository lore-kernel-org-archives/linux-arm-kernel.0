From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Oct 2009 14:03:38 +0100
Subject: [PATCH 1/4] Made VMALLOC_END of type unsigned long.
In-Reply-To: <20091001104715.GA25067@CCCP>
References: <1245155890204-git-send-email-andreas.fenkart@streamunlimited.com>
	<20090619094640.GD22234@n2100.arm.linux.org.uk>
	<20091001104715.GA25067@CCCP>
Message-ID: <20091001130338.GB26910@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2009 at 12:47:15PM +0200, Andreas Fenkart wrote:
> Davinci defines VMALLOC_END this way:
> 
> #define VMALLOC_END   (IO_VIRT - (2<<20))   
> 
> The simple solution would be to prefix the VMALLOC_END with UL,
> the alternative to make IO_VIRT unsinged long.

Is:

	(IO_VIRT - (2<<20))UL

valid C?  I don't think it is, and neither does my compiler.

> IO_PHYS should not be changed though, since it is assigned to
> unsigned int fields.

I'd actually argue that it's more correct for physical addresses to be
unsigned long rather than unsigned int.

> So I changed the patch, and made only IO_VIRT unsigned long:
> 
>  #define IO_PHYS        0x01c00000
>  #define IO_OFFSET      0xfd000000 /* Virtual IO = 0xfec00000 */
>  #define IO_SIZE        0x00400000
> -#define IO_VIRT        (IO_PHYS + IO_OFFSET)
> +#define IO_VIRT        UL(IO_PHYS + IO_OFFSET)

This doesn't work, for the same reason I point out above.  An expression
suffixed with 'UL' is not valid.  However, a pure number may be suffixed
with 'UL' to make it an unsigned long constant.

> IO_PHYS:
> -assigned to struct machine_desc / unsigned int phys_io;
> -assigned to struct machine_desc / unsigned int io_pg_offst;

These both can become unsigned long without any harm.

> -shifted and assigned to struct map_desc / unsigned long pfn;
> -used defines for UART base address, which are:
> --via plat_serial8250_port / resource_size_t mapbase
> ---assigned to type phys_addr_t
> -used defines for TIMER base address, which recursively are:
> --assigned to struct davinci_timer_instance / void __iomem *base;
> -used defines for WDOG base address, which are:
> --via struct resource / resource_size_t start
> ---assigned to type phys_addr_t

The rest are fine.
