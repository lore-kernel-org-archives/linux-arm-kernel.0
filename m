From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Oct 2014 18:48:30 +0200
Subject: [PATCH v2 2/2] Documentation: dmaengine: Add a documentation for
 the dma controller API
In-Reply-To: <5425AAAE.3020305@infradead.org>
References: <1411746035-15882-1-git-send-email-maxime.ripard@free-electrons.com>
 <1411746035-15882-2-git-send-email-maxime.ripard@free-electrons.com>
 <5425AAAE.3020305@infradead.org>
Message-ID: <20141007164830.GC17925@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy,

Thanks for your review,

On Fri, Sep 26, 2014 at 11:04:30AM -0700, Randy Dunlap wrote:
> On 09/26/14 08:40, Maxime Ripard wrote:
> > The dmaengine is neither trivial nor properly documented at the moment, which
> > means a lot of trial and error development, which is not that good for such a
> > central piece of the system.
> > 
> > Attempt at making such a documentation.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  Documentation/dmaengine/provider.txt | 358 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 358 insertions(+)
> >  create mode 100644 Documentation/dmaengine/provider.txt
> > 
> > diff --git a/Documentation/dmaengine/provider.txt b/Documentation/dmaengine/provider.txt
> > new file mode 100644
> > index 000000000000..ba407e706cde
> > --- /dev/null
> > +++ b/Documentation/dmaengine/provider.txt
> > @@ -0,0 +1,358 @@
> > +DMAengine controller documentation
> > +==================================
> > +
> > +Hardware Introduction
> > ++++++++++++++++++++++
> > +
> > +Most of the Slave DMA controllers have the same general principles of
> > +operations.
> > +
> > +They have a given number of channels to use for the DMA transfers, and
> > +a given number of requests lines.
> > +
> > +Requests and channels are pretty much orthogonal. Channels can be used
> > +to serve several to any requests. To simplify, channels are the
> 
>                     to many ?

Not really, it was meant to say that, depending on the hardware,
channels can be handling only a few requests, or all of the requests
that might be connected to the dma controller.

[...]
 
> > +need to initialize a few fields in there:
> > +
> > +  * chancnt:	should be the number of channels your driver is exposing
> > +		to the system.
> > +		This doesn't have to be the number of physical
> > +		channels: some DMA controllers also expose virtual
> > +		channels to the system to overcome the case where you
> > +		have more consumers than physical channels available.
> > +
> > +  * channels:	should be initialized as a list using the
> > +		INIT_LIST_HEAD macro for example
> 
> 	But what does 'channels' contain?

A list of initialised struct dma_chan. The exact meaning of
"initialised" is kind of blurry, because it's somewhat
driver-specific, because this structure will be the one that will be
passed to your callback, so you need to put in there whatever
information you need to process the future callbacks.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/106031f0/attachment.sig>
