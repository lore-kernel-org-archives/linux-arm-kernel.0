From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 May 2012 09:01:54 +0100
Subject: [alsa-devel] [PATCH 2/4] ASoC: mmp: add audio dma support
In-Reply-To: <CAMj5Bkg-Jy7=JUwhkGVWvGJJ+HQOmNY5f4r75VkevitJPEx6Sg@mail.gmail.com>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
 <1337929863-31885-3-git-send-email-zhangfei.gao@marvell.com>
 <1337932416.1580.2.camel@vkoul-udesk3>
 <20120525080500.GB24149@n2100.arm.linux.org.uk>
 <CAMj5Bkhc46zqY5AbJkc=-h02taP_esxrqpNu--aYtZZcVcPK6A@mail.gmail.com>
 <20120525094231.GC24149@n2100.arm.linux.org.uk>
 <CAMj5BkjhCakuZdUcA+P_nbETi8tnYK5Ok6HMWTG61whZXwCD6g@mail.gmail.com>
 <1338268734.1580.26.camel@vkoul-udesk3>
 <20120529073334.GA12217@n2100.arm.linux.org.uk>
 <CAMj5Bkg-Jy7=JUwhkGVWvGJJ+HQOmNY5f4r75VkevitJPEx6Sg@mail.gmail.com>
Message-ID: <20120529080154.GB12217@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 03:57:18PM +0800, zhangfei gao wrote:
> On Tue, May 29, 2012 at 3:33 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, May 29, 2012 at 10:48:54AM +0530, Vinod Koul wrote:
> >> On Tue, 2012-05-29 at 13:14 +0800, zhangfei gao wrote:
> >> >
> >> > When debugging with putting snd_dmaengine_pcm_open to probe or
> >> > pcm_new, there is issue.
> >> > snd_dmaengine_pcm_open ->
> >> > snd_pcm_hw_constraint_integer(substream->runtime,
> >> >
> >> > SNDRV_PCM_HW_PARAM_PERIODS);
> >> > The runtime is only exist at runtime.
> >> > So if using soc-dmaengine, I am afraid the snd_dmaengine_pcm_open has
> >> > to be put in open instead of probe.
> >> I think you got it wrong, the snd_dmaengine_pcm_open needs to be called
> >> from your CPU pcm_open. See other examples how this is used in other
> >> drivers.
> >
> > But, as I pointed out earlier, there's the issue of using the wrong
> > struct device to allocate memory for the DMA engine. ?That's something
> > that my soc-dmaengine.c got _right_, and soc-dmaengine-pcm.c gets _wrong_.
> 
> Could you help clarify what's the struct device should be used?
> Any example, not find soc-dmaengine.c.
> When debug,
> rtd->card->snd_card->dev is same as substream->pcm->card->dev, which
> we using now.

When your intention is to DMA to/from some memory, that memory _should_
be mapped via the DMA API (or, in the case of dma_alloc_coherent,
allocated) _using_ the device associated with the agent performing the
DMA.

This is so that the DMA API can know whether there's an IOMMU that has
to be programmed for the DMA agent to be able to see the memory, or
whether there's restrictions on the range of RAM which is visible to
the DMA agent.
