From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 May 2012 16:14:23 +0100
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <4FA3F08D.7030603@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FA30604.1030401@wwwdotorg.org> <4FA3F08D.7030603@ti.com>
Message-ID: <20120504151423.GA26585@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 10:06:53AM -0500, Jon Hunter wrote:
> The thought here was that some DMAs may distinguish between devices by a
> request ID or a channel ID or both. In the case of say an OMAP4, we have
> 32 channels and 127 request IDs. From a h/w perspective we need to know
> both. Each of the 32 channels can be programmed to use any one of the
> 127 h/w request signals.
> 
> Other DMAs may only need to specify requests or channels. However, the
> thought was you could specific either or both depending on your needs.
> Again these should have been optional parameters.

As being the one who is converting you over to DMA engine, I can't agree
with what you've just said.  I don't see that there's anything specific
to any particular DMA channel.  I don't see that a driver would need to
obtain a reference to any particular channel.

This seems to be supported by the current OMAP DMA API which merely
returns any one of the 32 channels that it can find whenever
omap_request_dma() is called.

At the moment, the DMA engine support I'm working on totally hides the
physical DMA channels behind a set of virtual DMA channels, one for each
DMA request signal.  This appears to work well, and is compatible with
how existing drivers use the current OMAP DMA API.
