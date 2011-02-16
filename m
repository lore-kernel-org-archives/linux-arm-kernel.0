From: tony@atomide.com (Tony Lindgren)
Date: Wed, 16 Feb 2011 09:20:02 -0800
Subject: [PATCH] omap: Move omap2_check_revision and omap_sram_init out
	of map_io
In-Reply-To: <20110215015320.GX20795@atomide.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
	<20110123174814.GI30094@n2100.arm.linux.org.uk>
	<20110124201731.GC13589@atomide.com>
	<20110214234520.GT20795@atomide.com>
	<20110214235238.GU20795@atomide.com>
	<20110215015320.GX20795@atomide.com>
Message-ID: <20110216172002.GF20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110214 17:52]:
> * Tony Lindgren <tony@atomide.com> [110214 15:51]:
> > With the early init changes we just want to map IO in map_io.
> > Both omap2_check_revision and omap_sram_init can be moved to
> > happen later in omap2_init_common_infrastructure.
> > 
> > Note that now we can now remove _omap2_map_common_io and remove
> > the extra flushes too as devicemaps_init will take care of it.
> 
> Hmm this one seems to need a bit more work, won't work on 2420.

That's because calling iotable_init after bootmem_init will skip
calling arm_bootmem_init and the new memblock_region we never
call reserve_bootmem on the new entry. So let's skip this for now.

If we want to do SoC detection and SRAM init later during the
boot, we'd have to allocate SRAM the same way as dma-mapping
and ioremap code does.

Regards,

Tony
