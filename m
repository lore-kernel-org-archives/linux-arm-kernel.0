From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Sep 2012 19:29:39 +0000
Subject: [PATCH v4] Add basic address decoding support for Marvell 370/XP
In-Reply-To: <20120911174501.2ddec831@skate>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201209111310.00347.arnd@arndb.de> <20120911174501.2ddec831@skate>
Message-ID: <201209111929.39549.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 September 2012, Thomas Petazzoni wrote:
> Le Tue, 11 Sep 2012 13:10:00 +0000,
> Arnd Bergmann <arnd@arndb.de> a ?crit :
> 
> > Excellent!
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Related to this patch set, I have a question: wouldn't it make sense to
> make the .virtual field of struct map_desc anvoid __iomem pointer as
> well instead of an unsigned long? This would avoid all the (unsigned
> long) casts in map_descs array definitions, and would be a bit more
> consistent, no?
> 

I've actually tried this before, and got stuck at the point where we set
up mappings that are not __iomem in mm/mmu.c: We have a bunch of calls
to create_mapping that are not at all related to MMIO access, and as Russell
pointed out back then, those should not take an __iomem pointer.

We can probably solve this by changing the prototype for create_mapping to 

static void __init create_mapping(unsigned long virtual, unsigned long pfn,
			        unsigned long length, unsigned int type);

and leave a single type cast in the iotable_init() function. There are
a few callers that we'd have to change manually then:

arch/arm/mm/dma-mapping.c:dma_contiguous_remap()
arch/arm/kernel/tcm.c:tcm_init()
arch/arm/mach-davinci/d*.c:SRAM_VIRT
arch/arm/mach-omap2/io.c:MT_MEMORY_SO
arch/arm/mach-omap2/omap4-common.c:OMAP4_DRAM_BARRIER_VA

My feeling is that we can special-case dma_contiguous_remap by introducing
a different helper like

extern void __init create_dma_ready_mapping(unsigned long virtual, size_t length);

and add casts to __iomem for the other four.

	Arnd
