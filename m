From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Jan 2017 16:51:46 +0000
Subject: [RESEND] spi: davinci: Allow device tree devices to use DMA
In-Reply-To: <dc47ecd2-fb94-ef7c-af15-590b2233e79f@lechnology.com>
References: <1483673177-31516-1-git-send-email-david@lechnology.com>
 <20170109194811.p3if5pzvjjaez2g3@sirena.org.uk>
 <dc47ecd2-fb94-ef7c-af15-590b2233e79f@lechnology.com>
Message-ID: <20170110165146.ineknejdhln5mwkv@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 02:40:50PM -0600, David Lechner wrote:
> On 01/09/2017 01:48 PM, Mark Brown wrote:
> > On Thu, Jan 05, 2017 at 09:26:17PM -0600, David Lechner wrote:

> > > Unfortunately, this excludes the possibility of using one SPI device with
> > > DMA and one without on the same master.

> > Why would you ever want to do that?  What would ever make sense about
> > not using DMA if it's available and the transfer is suitably large, or
> > conversely why would one want to force DMA even if PIO would be more
> > performant?

> I don't particularly want to do that, but that is the way the spi-davinci
> driver currently works. The choice between DMA or PIO is specified in the
> platform data on a per-device basis.

> What I get from your remarks is that this is wrong and it needs to be fixed.
> If that is so, could someone please point out a driver that does it the
> right way and I will try to fix it.

Pretty much any driver doing DMA...  off the top of my head the i.MX and
Samsung drivers ought to be reasonable examples.  If you've got time to
look at fixing the driver the other thing that jumps out with it is the
use of a threaded interrupt handler with no actual handling in the
thread, that looks like some magic timing based hack which seems risky
(or completely unneeded which would be better).

> > > When I originally submitted this patch, there was some discussion as to whether
> > > dspi->dma_rx should be changed to return an error rather than being null.
> > 
> > > However, I prefer it the way it is and don't see a compelling reason to change
> > > it.

> > I don't know what the above comment means, sorry (and don't recall
> > having seen any earlier versions of this).

> FWIW, you can find the previous conversation at
> https://patchwork.kernel.org/patch/9437901/

What Sekhar is saying there is right, it is better style to use an error
pointer rather than NULL as someone could potentially come up with a way
to make NULL a valid pointer in the API.  But it doesn't matter greatly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170110/aac7bf99/attachment.sig>
