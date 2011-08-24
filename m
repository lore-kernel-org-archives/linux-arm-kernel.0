From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 24 Aug 2011 13:00:49 +0900
Subject: [PATCH 1/3] DMA: PL330: Infer transfer direction from transfer
	request instead of platform data
In-Reply-To: <CAJuYYwQ0cKw_069V9Ci0rdfM+vESkbcGXnLj+xV68kf85VngKA@mail.gmail.com>
References: <1314050385-9617-1-git-send-email-thomas.abraham@linaro.org>
	<1314050385-9617-2-git-send-email-thomas.abraham@linaro.org>
	<000601cc61fc$201ac560$60505020$%kim@samsung.com>
	<CAJuYYwQ0cKw_069V9Ci0rdfM+vESkbcGXnLj+xV68kf85VngKA@mail.gmail.com>
Message-ID: <000b01cc6212$694c8e60$3be5ab20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> Sent: Wednesday, August 24, 2011 12:23 PM
> To: Boojin Kim
> Cc: linux-arm-kernel at lists.infradead.org; linux-samsung-
> soc at vger.kernel.org; kgene.kim at samsung.com; vinod.koul at intel.com;
> Jassi Brar
> Subject: Re: [PATCH 1/3] DMA: PL330: Infer transfer direction from
> transfer request instead of platform data
>
> Hi Boojin,
>
> On 24 August 2011 06:51, Boojin Kim <boojin.kim@samsung.com> wrote:
> > Thomas Abraham wrote:
> >> Sent: Tuesday, August 23, 2011 7:00 AM
> >> To: linux-arm-kernel at lists.infradead.org
> >> Cc: linux-samsung-soc at vger.kernel.org; kgene.kim at samsung.com;
> >> vinod.koul at intel.com; Jassi Brar; Boojin Kim
> >> Subject: [PATCH 1/3] DMA: PL330: Infer transfer direction from
> >> transfer request instead of platform data
> >>
> >> The transfer direction for a channel can be inferred from the
> transfer
> >> request and the need for specifying transfer direction in platfrom
> >> data
> >> can be eliminated. So the structure definition 'struct
> dma_pl330_peri'
> >> is no longer required.
> >>
> >> With the 'struct dma_pl330_peri' removed, the dma controller
> transfer
> >> capabilities cannot be inferred any longer. Hence, the dma
> controller
> >> capabilities is specified using platforme data.
> >>
> >> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> >> Cc: Boojin Kim <boojin.kim@samsung.com>
> >> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> >> ---
> >> ?drivers/dma/pl330.c ? ? ? ?| ? 56 ++++++++--------------------------
> ----
> >> ------
> >> ?include/linux/amba/pl330.h | ? 14 +++--------
> >> ?2 files changed, 14 insertions(+), 56 deletions(-)
> >>
>
> [...]
>
> >> ? ? ? for (i = 0; i < num_chan; i++) {
> >> ? ? ? ? ? ? ? pch = &pdmac->peripherals[i];
> >> - ? ? ? ? ? ? if (pdat) {
> >> - ? ? ? ? ? ? ? ? ? ? struct dma_pl330_peri *peri = &pdat->peri[i];
> >> -
> >> - ? ? ? ? ? ? ? ? ? ? switch (peri->rqtype) {
> >> - ? ? ? ? ? ? ? ? ? ? case MEMTOMEM:
> >> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? dma_cap_set(DMA_MEMCPY, pd->cap_mask);
> >> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? break;
> >> - ? ? ? ? ? ? ? ? ? ? case MEMTODEV:
> >> - ? ? ? ? ? ? ? ? ? ? case DEVTOMEM:
> >> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? dma_cap_set(DMA_SLAVE, pd->cap_mask);
> >> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? dma_cap_set(DMA_CYCLIC, pd->cap_mask);
> >> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? break;
> > If remove capabilities setting, dmaengine() doesn't search the
> channel that
> > client requests with specific capability.
> > So, I think dma_request_channel() would fail.
>
> The capabilities is now supplied using platform data. There is a new
> member 'cap_mask' added to the pl330 driver platform data structure.
> The capabilities for a pl330 controller can be specified using
> cap_mask. For exynos4, the capabilities is set up in the
> exynos4_dma_init function. These changes are part of the third patch
> in this patchset.
>
> Thanks for your review.
>
> Regards,
> Thomas.
Okay, It's good to me.
Thanks,
Boojin

>
> [...]
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
