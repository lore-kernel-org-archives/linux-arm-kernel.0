From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 27 Jan 2014 16:13:56 +0100 (CET)
Subject: [Q] block / zynq: DMA bouncing
Message-ID: <Pine.LNX.4.64.1401271549280.23931@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm working on an MMC driver with a DMA capability. All has been working 
well, until at some point I've got a bus error, when the mmc driver had 
been handed in a buffer at 0x3000 physical RAM address. The reason is, 
that on Zynq arch bus masters cannot access RAM below 0x80000. Therefore 
my question: how shall I configure this in software?

The way I found was to use ARM-specific struct dmabounce_device_info and 
implement its .needs_bounce() method to return true for those addresses. 
Is this the right way or is there a better / more straight-forward one?

To do the above I have to enable CONFIG_DMABOUNCE, which then selects 
CONFIG_ZONE_DMA. Having done just that I suddenly discover, that 0x3000 
buffers aren't used any more, so, I cannot actually verify my 
implementation :) Looking at ZONE_DMA it looks like it is still covering 
the whole RAM range (/proc/zoneinfo shows start_pfn=0 in zone DMA), so, I 
don't see why 0x3000 should be excluded now.

So, is using the .needs_bounce() method the correct way to support DMA on 
this arch or is there a better one?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
