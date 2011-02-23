From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Feb 2011 12:12:22 +0000
Subject: [PATCH v3] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <1298459206.23371.267.camel@vkoul-udesk3>
References: <1298283699-14635-1-git-send-email-shawn.guo@freescale.com>
	<1298433701.23371.236.camel@vkoul-udesk3>
	<20110223055709.GC20346@S2100-06.ap.freescale.net>
	<1298440516.23371.258.camel@vkoul-udesk3>
	<20110223100547.GG29559@n2100.arm.linux.org.uk>
	<20110223102140.GH29559@n2100.arm.linux.org.uk>
	<1298459206.23371.267.camel@vkoul-udesk3>
Message-ID: <20110223121222.GI29559@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 04:36:46PM +0530, Koul, Vinod wrote:
> On Wed, 2011-02-23 at 15:51 +0530, Russell King - ARM Linux wrote:
> > So the way to efficiently handle audio is to initially submit several
> > 'period' sized buffers for the DMA engine.  As each buffer completes,
> > you call snd_pcm_elapsed() to tell ALSA that a period has finished
> > and submit the next buffer.  As there's always several buffers submitted,
> > the DMA engine never waits for the callback to complete.  And ALSA is
> > capable of handling latency in snd_pcm_elapsed().
>
> Russel,
> agree with you on this. But in case you have few periods say 2 and small
> period sizes (10ms), or similar scenarios where client is waiting to do
> something (process data) on callback notification, faster the callback
> better it is.

The API is the API.  If you want to change it then all slave DMA engine
drivers need changing otherwise things will go wrong when we mix DMA
engines with slave devices.

We have APIs to ensure that individual chunks of code can be kept modular
and interact correctly with each other.  If implementations start doing
different things then they should stop using the API and create a new API,
or propose a change to the API.

> I know DMA engine species callback to be called from tasklet context,
> but do we need this for slave-dma or not? If this is posing some
> limitation then I am okay to discuss on ways to improve :) 

That depends whether you want to get into a recursive loop of submitting
a request to a DMA engine, only to have it call your completion callback,
you submit a new request, it calls your completion callback, etc.

Anyway, I believe that the issue you're referring to is imaginary -
there are people who have used the DMA engine API with ALSA with
callbacks happening in interrupt context and it works for them, so
there's no theorectical reason why it can't work for you.

10ms is not a small period size.  Remember that you'll get an interrupt
from the DMA engine, which will flag the tasklet to be run.  On exiting
from that interrupt, the softirq state will be checked, and it'll find
that the tasklet is waiting to run.  It will run it at that point.  No
waiting around for the next timer interrupt or anything silly like that.
