From: peter.ujfalusi@ti.com (=?ISO-8859-1?Q?P=E9ter?= Ujfalusi)
Date: Tue, 29 Nov 2011 15:01:57 +0200
Subject: [PATCH v2 1/2] OMAP2+: DMA: Workaround for invalid source
 position
In-Reply-To: <4EBBCB4C.9030202@bitmer.com>
References: <1320658387-21067-1-git-send-email-peter.ujfalusi@ti.com>
 <4EBBC79E.30701@bitmer.com> <4EBBCB4C.9030202@bitmer.com>
Message-ID: <1857964.6c1BL8cmCX@barack>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 November 2011 15:02:04 Jarkko Nikula wrote:
> On 11/10/2011 02:46 PM, Jarkko Nikula wrote:
> > On 11/07/2011 11:33 AM, Peter Ujfalusi wrote:
> >> If the DMA source position has been asked before the
> >> first actual data transfer has been done, the CSAC
> >> register does not contain valid information.
> >> We can identify this situation by checking the CDAC
> >> register:
> >> CDAC != 0 indicates that the DMA transfer on the channel has
> >> been started already.
> >> When CDAC == 0 we can not trust the CSAC value since it has
> >> not been updated, and can contain random number.
> >> Return the start address in case the DMA has not jet started.
> >> 
> >> Note: The CDAC register has been initialized to 0 at dma_start
> >> time.
> >> 
> >> Signed-off-by: Peter Ujfalusi<peter.ujfalusi@ti.com>
> >> ---
> >> arch/arm/plat-omap/dma.c | 12 ++++++++++++
> >> 1 files changed, 12 insertions(+), 0 deletions(-)
> >> 
> >> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> >> index c22217c..a9983b6 100644
> >> --- a/arch/arm/plat-omap/dma.c
> >> +++ b/arch/arm/plat-omap/dma.c
> >> @@ -1034,6 +1034,18 @@ dma_addr_t omap_get_dma_src_pos(int lch)
> >> if (IS_DMA_ERRATA(DMA_ERRATA_3_3)&& offset == 0)
> >> offset = p->dma_read(CSAC, lch);
> >> 
> >> + if (!cpu_is_omap15xx()) {
> >> + /*
> >> + * CDAC == 0 indicates that the DMA transfer on the channel has
> >> + * not been started (no data has been transferred so far).
> >> + * Return the programmed source start address in this case.
> >> + */
> >> + if (likely(p->dma_read(CDAC, lch)))
> >> + offset = p->dma_read(CSAC, lch);
> >> + else
> >> + offset = p->dma_read(CSSA, lch);
> >> + }
> >> +
> > 
> > I think this is enough:
> > 
> > if (unlikely(p->dma_read(CDAC, lch) == 0))
> > offset = p->dma_read(CSSA, lch);
> > 
> > I suppose offset is ok for normal case as it is already read (twise)
> > above.
> Or actually my proposal could have a race if CDAC changes between CSAC
> read and CDAC read. In that case it's better to re-read CSAC as your
> patch does after CDAC test and give to both:
> 
> Reviewed-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

Tony, have you taken this patch? I failed to find it in the l-o tree...

--
P?ter
