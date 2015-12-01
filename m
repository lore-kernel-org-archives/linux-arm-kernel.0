From: agross@codeaurora.org (Andy Gross)
Date: Tue, 1 Dec 2015 11:25:35 -0600
Subject: [PATCH 3/4] dmaengine: qcom_bam_dma: use correct pipe FIFO size
In-Reply-To: <1971752.Auss6gPApO@wuerfel>
References: <1448961299-15161-1-git-send-email-stanimir.varbanov@linaro.org>
 <1448961299-15161-4-git-send-email-stanimir.varbanov@linaro.org>
 <1971752.Auss6gPApO@wuerfel>
Message-ID: <20151201172535.GB26687@Agamemnon.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 11:28:32AM +0100, Arnd Bergmann wrote:
> On Tuesday 01 December 2015 11:14:58 Stanimir Varbanov wrote:
> > 
> > diff --git a/drivers/dma/qcom_bam_dma.c b/drivers/dma/qcom_bam_dma.c
> > index 0f06f3b7a72b..6d290de9ab2b 100644
> > --- a/drivers/dma/qcom_bam_dma.c
> > +++ b/drivers/dma/qcom_bam_dma.c
> > @@ -458,7 +458,7 @@ static void bam_chan_init_hw(struct bam_chan *bchan,
> >          */
> >         writel_relaxed(ALIGN(bchan->fifo_phys, sizeof(struct bam_desc_hw)),
> >                         bam_addr(bdev, bchan->id, BAM_P_DESC_FIFO_ADDR));
> > -       writel_relaxed(BAM_DESC_FIFO_SIZE,
> > +       writel_relaxed(BAM_MAX_DATA_SIZE,
> >                         bam_addr(bdev, bchan->id, BAM_P_FIFO_SIZES));
> >  
> >         /* enable the per pipe interrupts, enable EOT, ERR, and INT irqs */
> 
> I'm looking at that now and fail to see why these have to use writel_relaxed().

At some point I believe I got a comment about using (readl/writel)_relaxed
instead of readl/writel.  So I used these instead.  Has the wind direction
changed?  =)

Using the readl/writel is nice w.r.t. having the implicit barriers, especially
with the funky 1K boundary on reordering of operations that can occur on Kraits.
This can hit you on accesses even within the same IP block.
