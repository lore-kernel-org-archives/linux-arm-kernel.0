From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Feb 2011 10:21:40 +0000
Subject: [PATCH v3] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <20110223100547.GG29559@n2100.arm.linux.org.uk>
References: <1298283699-14635-1-git-send-email-shawn.guo@freescale.com>
	<1298433701.23371.236.camel@vkoul-udesk3>
	<20110223055709.GC20346@S2100-06.ap.freescale.net>
	<1298440516.23371.258.camel@vkoul-udesk3>
	<20110223100547.GG29559@n2100.arm.linux.org.uk>
Message-ID: <20110223102140.GH29559@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 10:05:47AM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 23, 2011 at 11:25:16AM +0530, Koul, Vinod wrote:
> > Well in that case you are calling the callback from irq handler which is
> > not so good. The tasklet is other extreme (slow).
> 
> tasklets are run on the exit path of interrupts.
> 
> > Given that this is
> > also intended for audio I am not sure if calling period elapsed from
> > tasklet callback will not cause any audio over/underruns, last I tried
> > it used to break quite often in stressed situations.
> 
> Nevertheless, the DMA engine API specifies that callbacks shall be called
> from tasklet context.

Note also that the DMA engine API is supposed to work as follows:

1. You submit DMA jobs to it.
2. The DMA engine starts the first job
3. When the first job is complete, it retires it to a retired list and
   marks the tasklet to run
4. If there is another job waiting, the DMA engine starts the next job
5. Repeat 3 until no further jobs are queued

The tasklet then processes the list of retired jobs, cleaning them
up and calling their callbacks. 

So the way to efficiently handle audio is to initially submit several
'period' sized buffers for the DMA engine.  As each buffer completes,
you call snd_pcm_elapsed() to tell ALSA that a period has finished
and submit the next buffer.  As there's always several buffers submitted,
the DMA engine never waits for the callback to complete.  And ALSA is
capable of handling latency in snd_pcm_elapsed().
