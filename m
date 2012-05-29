From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 May 2012 08:33:34 +0100
Subject: [alsa-devel] [PATCH 2/4] ASoC: mmp: add audio dma support
In-Reply-To: <1338268734.1580.26.camel@vkoul-udesk3>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
 <1337929863-31885-3-git-send-email-zhangfei.gao@marvell.com>
 <1337932416.1580.2.camel@vkoul-udesk3>
 <20120525080500.GB24149@n2100.arm.linux.org.uk>
 <CAMj5Bkhc46zqY5AbJkc=-h02taP_esxrqpNu--aYtZZcVcPK6A@mail.gmail.com>
 <20120525094231.GC24149@n2100.arm.linux.org.uk>
 <CAMj5BkjhCakuZdUcA+P_nbETi8tnYK5Ok6HMWTG61whZXwCD6g@mail.gmail.com>
 <1338268734.1580.26.camel@vkoul-udesk3>
Message-ID: <20120529073334.GA12217@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 10:48:54AM +0530, Vinod Koul wrote:
> On Tue, 2012-05-29 at 13:14 +0800, zhangfei gao wrote:
> > 
> > When debugging with putting snd_dmaengine_pcm_open to probe or
> > pcm_new, there is issue.
> > snd_dmaengine_pcm_open ->
> > snd_pcm_hw_constraint_integer(substream->runtime,
> > 
> > SNDRV_PCM_HW_PARAM_PERIODS);
> > The runtime is only exist at runtime.
> > So if using soc-dmaengine, I am afraid the snd_dmaengine_pcm_open has
> > to be put in open instead of probe. 
> I think you got it wrong, the snd_dmaengine_pcm_open needs to be called
> from your CPU pcm_open. See other examples how this is used in other
> drivers.

But, as I pointed out earlier, there's the issue of using the wrong
struct device to allocate memory for the DMA engine.  That's something
that my soc-dmaengine.c got _right_, and soc-dmaengine-pcm.c gets _wrong_.
