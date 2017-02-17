From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 17 Feb 2017 18:44:51 +0800
Subject: [PATCH net-next v2 0/2] net: mvneta: improve rx performance
In-Reply-To: <87shndayse.fsf@free-electrons.com>
References: <20170217100233.2325-1-jszhang@marvell.com>
 <87shndayse.fsf@free-electrons.com>
Message-ID: <20170217184451.55217e0e@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Feb 2017 11:37:21 +0100 Gregory CLEMENT wrote:

> Hi Jisheng,
>  
>  On ven., f?vr. 17 2017, Jisheng Zhang <jszhang@marvell.com> wrote:
> 
> > In hot code path such as mvneta_rx_hwbm() and mvneta_rx_swbm(), we may
> > access fields of rx_desc. The rx_desc is allocated by
> > dma_alloc_coherent, it's uncacheable if the device isn't cache
> > coherent, reading from uncached memory is fairly slow.  
> 
> Did you test it with HWBM support?

No I didn't test it for lacking of such HW, so it's appreciated if someone
can test with HWBM capable HW.

> 
> I am not sure ti will work in this case.

IMHO, if mvneta HW doesn't update rx_desc->buf_phys_addr, it can still work.
I don't have HWBM background, so above may be wrong. If this case doesn't
work for HWBM, I'll submit v3 to modify mvneta_rx_swbm() only.

Thanks,
Jisheng

> 
> Gregory
> 
> >
> > patch1 reuses the read out status to getting status field of rx_desc
> > again.
> >
> > patch2 uses cacheable memory to store the rx buffer DMA address.
> >
> > We get the following performance data on Marvell BG4CT Platforms
> > (tested with iperf):
> >
> > before the patch:
> > recving 1GB in mvneta_rx_swbm() costs 149265960 ns
> >
> > after the patch:
> > recving 1GB in mvneta_rx_swbm() costs 1421565640 ns
> >
> > We saved 4.76% time.
> >
> > RFC: can we do similar modification for tx? If yes, I can prepare a v2.
> >
> >
> > Basically, these two patches do what Arnd mentioned in [1].
> >
> > Hi Arnd,
> >
> > I added "Suggested-by you" tag, I hope you don't mind ;)
> >
> > Thanks
> >
> > [1] https://www.spinics.net/lists/netdev/msg405889.html
> >
> > Since v1:
> >   - correct the performance data typo
> >
> > Jisheng Zhang (2):
> >   net: mvneta: avoid getting status from rx_desc as much as possible
> >   net: mvneta: Use cacheable memory to store the rx buffer DMA address
> >
> >  drivers/net/ethernet/marvell/mvneta.c | 36 ++++++++++++++++++++---------------
> >  1 file changed, 21 insertions(+), 15 deletions(-)
> >
> > -- 
> > 2.11.0
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel  
> 
