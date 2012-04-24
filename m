From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Apr 2012 23:05:30 +0100
Subject: [PATCH 06/12] mmc: omap_hsmmc: remove private DMA API
 implementation
In-Reply-To: <CANOLnOM29Mn2BTydX=C5FEu6evkS5W8eL87RwNmppJWuVLGjAQ@mail.gmail.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
 <E1SMLmF-0002WO-Ch@rmk-PC.arm.linux.org.uk>
 <CANOLnOM29Mn2BTydX=C5FEu6evkS5W8eL87RwNmppJWuVLGjAQ@mail.gmail.com>
Message-ID: <20120424220530.GA6290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 12:51:09AM +0300, Grazvydas Ignotas wrote:
> On Mon, Apr 23, 2012 at 7:06 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > Remove the private DMA API implementation from omap_hsmmc, making it
> > use entirely the DMA engine API.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Since the driver becomes useless without DMA_ENGINE, we probably want
> a 'depends on'?

I think it's possible to use tweak this to use PIO should DMA_ENGINE
not be available - though first we need to sort out all the filter
functions and how we select the DMA channels.  That's pretty much an
open question (which was brought up in my original set of patches)
and remains to these ones.

How we did this with the AMBA Primecell drivers was to pass in the
filter function and filter argument from platform code, allowing the
primecell drivers to be used with any DMA engine.  That doesn't work
with DT though...

At the moment, I don't have an answer for this, because of the DT
implications here.  So, the issue is rather stuck, and as a result
I'm just sticking the "extern" declarations for the filter function
into drivers that have been converted.
