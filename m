From: peter.ujfalusi@ti.com (=?ISO-8859-1?Q?P=E9ter_Ujfalusi?=)
Date: Fri, 19 Oct 2012 14:45:55 +0200
Subject: [RFC] dmaengine: omap-dma: Allow DMA controller to prefetch data
In-Reply-To: <20121018233335.GC28061@n2100.arm.linux.org.uk>
References: <20121018222046.GA28541@animalcreek.com>
 <20121018225540.GB28061@n2100.arm.linux.org.uk>
 <20121018232405.GA29064@animalcreek.com>
 <20121018233335.GC28061@n2100.arm.linux.org.uk>
Message-ID: <50814B83.7090203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/19/2012 01:33 AM, Russell King - ARM Linux wrote:
> I would suggest getting some feedback from the ASoC people first, before
> trying to invent new APIs to work around this stuff.  If they can live
> with having prefetch enabled on OMAP then there isn't an issue here.  If
> not, we need a solution to this.
> 
> I do not believe that precisely stopping and starting playback across a
> suspend/resume event is really necessary (it's desirable but the world
> doesn't collapse if you miss a few samples.)  It could be more of an
> issue for pause/resume though, but as I say, that's for ASoC people to
> comment on.

There is another issue with the prefetch in audio:
we tend to like to know the position of the DMA and also to know how much data
we have stored in buffers, FIFOs. This information is used by userspace to do
echo cancellation and also used by PA for example to do runtime mixing
directly in the audio buffer. We have means to extract this information from
McBSP for example (and from tlv320dac33 codec) but AFAIK this information can
not be retrieved from sDMA.
We could assume that the sDMA FIFO is kept full and report that as a 'delay'
or do not account this information.

For now I think the cyclic mode should not set the prefetch. If I recall right
the cyclic mode is only used by audio at the moment.

> I'm merely pointing out here that we need their feedback here before
> deciding if there's anything further that needs to happen.

Thanks Russell, I'll take a look at the implication of the prefetch for audio.

-- 
P?ter
