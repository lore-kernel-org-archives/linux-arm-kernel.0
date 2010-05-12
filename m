From: wolfgang.mues@auerswald.de (Wolfgang =?iso-8859-1?q?M=FCes?=)
Date: Wed, 12 May 2010 08:48:51 +0200
Subject: arm926_dma_flush_range undefined!
In-Reply-To: <4BE95C54.5070008@atmel.com>
References: <4BE95C54.5070008@atmel.com>
Message-ID: <201005120848.52046.wolfgang.mues@auerswald.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Dienstag, 11. Mai 2010 schrieb Nicolas Ferre:
> Le 11/05/2010 11:44, Russell King - ARM Linux :
> > On Tue, May 11, 2010 at 11:43:17AM +0200, Nicolas Ferre wrote:
> >> Le 06/05/2010 19:59, Russell King - ARM Linux :
> >>> On Thu, May 06, 2010 at 03:07:11PM +0100, Catalin Marinas wrote:
> >>>> On Thu, 2010-05-06 at 15:11 +0200, Nicolas Ferre wrote:
> >>>>> I am trying to compile a recent kernel
> >>>>> (v2.6.34-rc6-201-g722154e) and I am
> >>>>> having this kind of error:
> >>>>> 
> >>>>> ERROR: "arm926_dma_flush_range" [drivers/mmc/host/at91_mci.ko]
> >>>>> undefined!
> >>>> 
> >>>> The driver seems to use dmac_flush_range() directly. That's not part
> >>>> of the DMA API. Could you not use one of the supported DMA API
> >>>> functions?
> >> 
> >> The difficult part for me is to choose the proper one ;-)
> >> 
> >> And also, I am wondering if this call is needed as we do a
> >> kunmap_atomic() on the same scatterlist pointer just before. Does not
> >> kunmap_atomic() embed a cache flushing directive already?
> > 
> > No it doesn't.  What are you trying to do here?
> 
> After a read with DMA from sd/mmc interface, a DMA buffer allocated by
> dma_alloc_coherent() is filled.
> This buffer is then copied to the scatterlist provided by the mmc
> request (from drivers/mmc/card/block.c it seems that sg buffers are
> alocacted via kmalloc()).
> 
> For each buffer of the scatterlist, I do this dmac_flush_rage()...
Yepp!
 
> As copy is done between a coherent and a kernel memory buffers, I guess
> that the flushing routine is not needed?
Where do you get this wisdom?

The coherent buffer does not need a cache flush, never.
But the target buffer does need a flush(). If the loaded data from SD card is 
an executable or library, the target buffer may be mapped into the text 
segment of a process and be executed. And this will fail if parts of the
data are only inside the data cache (especially on ARM architectures where
data and instruction cache are separate).

The basic assumption is that the scatterlist buffer is filled directly with a 
DMA controller: data is in memory, not in the cache.
If you fill the scatterlist buffer with the help of the CPU, you need a data 
cache flush afterwards to fullfill this assumption.
It's a shame that the function to do so is not available on all platforms. 
IMHO it should.

best regards
 
i. A. Wolfgang M?es
-- 
Auerswald Gesellschaft f?r Datensysteme mbH
Hardware Development
Telefon: +49 (0)5306 9219 562
Telefax: +49 (0)5306 9219 94 
E-Mail: Wolfgang.Mues at Auerswald.de
Web: http://www.auerswald.de
 
--------------------------------------------------------------
Auerswald Gesellschaft f?r Datensysteme mbH
Vor den Grash?fen 1, 38162 Cremlingen
Registriert beim AG Braunschweig HRB 7499
Gesch?ftsf?hrer: Dipl-Ing. Gerhard Auerswald
