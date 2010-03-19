From: jamie@shareable.org (Jamie Lokier)
Date: Fri, 19 Mar 2010 01:55:23 +0000
Subject: Highmem issues with MMC filesystem
In-Reply-To: <alpine.LFD.2.00.1003181205020.31128@xanadu.home>
References: <alpine.LFD.2.00.1003170946250.31128@xanadu.home>
	<043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003171050160.31128@xanadu.home>
	<20100318092352.GD8267@n2100.arm.linux.org.uk>
	<c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
	<20100318112453.GA19544@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003180904440.31128@xanadu.home>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com>
	<20100318141930.GF19544@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003181205020.31128@xanadu.home>
Message-ID: <20100319015523.GD14108@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:
> Data read from a DMA based block device is corrupted in memory and 
> causing all sorts of misbehavior such as segmentation faults in user 
> space, or EXT2 complaining about broken filesystem metadata.

I doubt it is related, but just in case: I've seen similar on a
no-doubt completely unrelated ARM9 system on now-ancient kernels:
occasional ext3 metadata corruption.

In my case it was due to a bug in the chip's IDE driver, which did:

   1. Setup DMA address register.
   2. Appropriate cache flushes.
   3. Write to remaining DMA registers to start DMA.

It turned out step 1 causes the DMA controller to begin reading from
that address into an internal 128-byte FIFO, before officially
starting DMA.  Moving step 2 before step 1 fixed that.

-- Jamie
