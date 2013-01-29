From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jan 2013 16:21:59 +0000
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <CAKohpoms+WC_XJnH2b6uoycRKkF-yxZUg2J+8NrYJP8fnDNLtg@mail.gmail.com>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <201301291331.48427.arnd@arndb.de>
 <CAKohpoms+WC_XJnH2b6uoycRKkF-yxZUg2J+8NrYJP8fnDNLtg@mail.gmail.com>
Message-ID: <201301291621.59425.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013, Viresh Kumar wrote:
> On 29 January 2013 19:01, Arnd Bergmann <arnd@arndb.de> wrote:
> > Ah, good. So I guess the "dma-requests" property should actually
> > be "16" then.
> 
> yes, even i was checking on that separately :)

Actually, I just discovered something odd in the
arch/arm/mach-spear/spear13xx-dma.h file that gets removed
in the last patch: there, we define request numbers up to
32, e.g.

-       SPEAR1310_DMA_REQ_UART2_RX = 14,
-       SPEAR1310_DMA_REQ_UART2_TX = 15,
-       SPEAR1310_DMA_REQ_UART5_RX = 16,
-       SPEAR1310_DMA_REQ_UART5_TX = 17,

What is the meaning of this, if the maximum request number is 15?
 
> > Could we have device-to-device DMAs with this controller, and if
> > we can, should we have both 'src' and 'dst' fields? Are the
> > two number ranges sharing the same address space, i.e. is
> > request '7' as the destination guaranteed to be the same device
> > as request '7' in the source?
> 
> Request lines are per master... So, for a master single request line
> is independent of direction. Many DMA controllers have capability of
> doing dev-to-dev transfers but DMAENGINE doesn't have any support
> for it, even we don't have a usecase too :)
> 
> > If we need two lines, we could interleave them with the bus
> > master numbers:
> 
> not required.

Ok. Would it be enough to have only one master and one request
field in the DT dma descriptor then, and have the code figure
whether to use it as source or destination, based on the
configuration? Which one should come first? Since you have
multiple masters per controller, and multiple requests per
master, it sounds like the cleanest descriptor form would
be 

	<controller master request>;

Or possibly

	<controller master request direction>;

if the direction needs to be known at the time the channel
is requested.

	Arnd
