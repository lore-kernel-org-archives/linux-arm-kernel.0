From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Feb 2013 20:33:58 +0000
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <CACRpkdZihnp3_Df==QRWxQupgi7W_YXZxc-MxkusVH6J+Vx56A@mail.gmail.com>
References: <510C2A47.1090607@mvista.com>
 <20130201205600.GA31762@arwen.pp.htv.fi>
 <20130201213003.GW2637@n2100.arm.linux.org.uk>
 <20130204154153.GA18237@arwen.pp.htv.fi> <510FF1A6.403@mvista.com>
 <20130204164712.GB4269@arwen.pp.htv.fi>
 <510FF5C9.3030600@mvista.com>
 <20130204170216.GC4269@arwen.pp.htv.fi> <51100A72.6030909@ti.com>
 <CACRpkdZihnp3_Df==QRWxQupgi7W_YXZxc-MxkusVH6J+Vx56A@mail.gmail.com>
Message-ID: <20130204203358.GX4720@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 09:29:46PM +0100, Linus Walleij wrote:
> On Mon, Feb 4, 2013 at 8:22 PM, Cyril Chemparathy <cyril@ti.com> wrote:

> > Based on our experience with fitting multiple subsystems on top of this
> > DMA-Engine driver, I must say that the DMA-Engine interface has proven
> > to be a less than ideal fit for the network driver use case.

> > The first problem is that the DMA-Engine interface expects to "push"
> > completed traffic up into the upper layer as a part of its callback.
> > This doesn't fit cleanly with NAPI, which expects to "pull" completed
> > traffic from below in the NAPI poll.  We've somehow kludged together a
> > solution around this, but it isn't very elegant.

> I cannot understand the actual technical problem from the above
> paragraphs though. dmaengine doesn't have a concept of pushing
> nor polling, it basically copies streams of words from A to B, where
> A/B can be a device or a buffer, nothing else.

> The thing you're looking for sounds more like an adapter on top
> of dmaengine, which can surely be constructed, some
> drivers/dma/dmaengine-napi.c or whatever.

Broadly speaking what NAPI wants is to never get any callbacks from the
hardware (or DMAs).  It wants to wake up periodically, take a look at
what packets have been read by the hardware and process them.  The goal
is to have the DMAs sitting and running without disturbing the processor
at all after the first packet has been handled.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/57d28b85/attachment.sig>
