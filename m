From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 9 Mar 2012 13:00:59 +0800
Subject: [PATCH v3 10/11] ASoC: fsl: let fsl_ssi work with imx pcm and
 machine drivers
In-Reply-To: <4F5980DE.9050002@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-11-git-send-email-shawn.guo@linaro.org>
 <4F591A69.9060401@freescale.com>
 <20120309031909.GJ2499@S2101-09.ap.freescale.net>
 <4F5980DE.9050002@freescale.com>
Message-ID: <20120309050057.GL2499@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 04:02:40AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> 
> > Ok, got you.  We used to set fifo_depth on imx-ssi not the value given
> > by hardware manual, but the one already tuned.
> 
> What do you mean by "already tuned".  Tuned by whom?
> 
For example, we have SSI fifo depth 15 on i.MX51 design.  Instead of
having fifo_depth as 15 and then writing 15 - 2 into burstsize and
watermark, we used to have fifo_depth as 13, and then burstsize and
watermark can just be fifo_depth.

I agree that fsl_ssi does the right thing, having fifo_depth be the
hardware value.

> >>> +		 */
> >>> +		ssi_private->dma_params_tx.burstsize =
> >>> +			ssi_private->fifo_depth - 2;
> >>> +		ssi_private->dma_params_rx.burstsize =
> >>> +			ssi_private->fifo_depth - 2;
> >>> +		ssi_private->dma_params_tx.dma_addr =
> >>> +			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, stx0);
> >>> +		ssi_private->dma_params_rx.dma_addr =
> >>> +			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, srx0);
> >>
> >> So I'm a little confused by this new binding.  I went through a lot of
> >> work to remove DMA-specific data from the SSI driver, and here you are
> >> adding a bunch of it back.  What you're doing here -- I'm doing it in the
> >> DMA driver where it belongs.
> >
> > I'm not sure these all belong to DMA driver.  These are all
> > configurations/parameters of SSI, which are related to DMA though.
> > I see fsl_dma are handling these, but I do not fully agree with that,
> > because we end up with fsl_dma driver accessing SSI node and
> > "struct ccsr_ssi" which should be SSI private data.
> 
> Well, the SSI needs to tell the DMA driver how to program itself.  On 
> PowerPC, the DMA's burst size is based on the SSI's FIFO depth.  You're 
> effectively doing what I already do, except you do more work in the SSI 
> driver.
> 
> I understand that we need to support old and new bindings, but I already 
> created an infrastructure that supports passing SSI information to the DMA 
> driver.

I do not see an infrastructure, but that fsl_dma driver accesses SSI
private data structure.  Instead, snd_soc_dai_set[get]_dma_data looks
more like an infrastructure to me.

> It seems that the above code is different only for the sake of 
> being different, not because it's better.
> 
> This is not really an i.MX vs. PowerPC issue, which is why I'm not sure 
> this change belong in this patchset.
> 
Without this change, fsl_ssi can not work with imx-pcm-dma.  I do not
understand how it can possibly not belong in this patchset?

> > Secondly, this is the way that how imx-ssi and imx-pcm-dma works and
> > interacts.  If we want to move these stuff into imx-pcm-dma, we need
> > a good story to convince imx-ssi users that why it's better than what
> > they currently do.
> 
> I don't understand that.  You're already rewriting these drivers.  Who 
> else needs to be convinced?
> 
As I told before, even now we have fsl_ssi working for DT based IMX
platforms, imx5 and imx6, imx-ssi will still exist for those non-DT
IMX, like imx21, imx25, imx27, imx31, imx35.  That said, imx-pcm-dma
will need to work with both fsl_ssi and imx-ssi.  Moving those stuff
into imx-pcm-dma will require significant changes on imx-ssi too.

-- 
Regards,
Shawn
