From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Sep 2012 09:28:44 +0100
Subject: [PATCH v3 02/15] dmaengine: omap: Add support for pause/resume
 in cyclic dma mode
In-Reply-To: <1347851637.1943.125.camel@vkoul-udesk3>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
 <1347624358-25582-3-git-send-email-peter.ujfalusi@ti.com>
 <1347851637.1943.125.camel@vkoul-udesk3>
Message-ID: <20120918082843.GD12445@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 08:43:57AM +0530, Vinod Koul wrote:
> On Fri, 2012-09-14 at 15:05 +0300, Peter Ujfalusi wrote:
> > -       /* FIXME: not supported by platform private API */
> > -       return -EINVAL;
> > +       /* Pause/Resume only allowed with cyclic mode */
> > +       if (!c->cyclic)
> > +               return -EINVAL; 
> This is not a dma restriction right?

This is needed because this is not a real "pause" - it is a stop, which
causes the contents of the DMA engine's FIFOs to be discarded - which
means a subsequent resume will loose data.
