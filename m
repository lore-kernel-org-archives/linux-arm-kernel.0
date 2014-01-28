From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 28 Jan 2014 11:34:24 -0700
Subject: [Q] block / zynq: DMA bouncing
In-Reply-To: <20140128134827.GK15937@n2100.arm.linux.org.uk>
References: <Pine.LNX.4.64.1401271549280.23931@axis700.grange>
 <20140127170230.GQ15937@n2100.arm.linux.org.uk>
 <52E69B4E.5010604@monstr.eu>
 <20140127175231.GU15937@n2100.arm.linux.org.uk>
 <52E69E1E.3020202@monstr.eu>
 <Pine.LNX.4.64.1401281420580.2714@axis700.grange>
 <20140128134827.GK15937@n2100.arm.linux.org.uk>
Message-ID: <20140128183424.GB1427@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 01:48:27PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 28, 2014 at 02:28:28PM +0100, Guennadi Liakhovetski wrote:
> > +static void __init zynq_memory_init(void)
> > +{
> > +	/*
> > +	 * Reserve the 0-0x4000 addresses (before page tables and kernel)
> > +	 * which can't be used for DMA
> > +	 */
> > +	if (!__pa(PAGE_OFFSET))
> > +		memblock_reserve(0, 0x4000);
> 
> Or maybe this:
> 
> 	memblock_reserve(__pa(PAGE_OFFSET), __pa(swapper_pg_dir));
> 
> since that's actually what you mean here.

Can you have a non-zero PAGE_OFFSET and swapper_pg_dir != 0x4000?
Crash dump kernel maybe?

Perhaps:
	if (__pa(PAGE_OFFSET) < 0x8000)
 	   memblock_reserve(__pa(PAGE_OFFSET),
	                    min(__pa(swapper_pg_dir), 0x8000));
?

The Zynq TRM, UG585 pg 115, describes this issue. Physical addresses
below 0x8000 are not accessible to DMA from the AXI interconnect.

Though, how does a crash dump kernel know it needs to bounce buffer
the swapper if it dumps it via DMA?

Regards,
Jason
