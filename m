From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Jun 2012 11:52:28 +0100
Subject: [RFC 23/34] dmaengine: PL08x: re-jig the starting of txds
In-Reply-To: <CACRpkdb15mx2jPZ3zqD01htvvLsQ27snsQQ+o=aSM8F6y=WKcw@mail.gmail.com>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIxA-00070E-Dc@rmk-PC.arm.linux.org.uk>
 <CACRpkdb15mx2jPZ3zqD01htvvLsQ27snsQQ+o=aSM8F6y=WKcw@mail.gmail.com>
Message-ID: <20120601105228.GE21245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 09:14:15AM +0800, Linus Walleij wrote:
> On Tue, May 29, 2012 at 5:43 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > Rather than code the de-queue of the txd several times, move that into
> > the start_txd function. ?Rename this to better illustrate what it's
> > now doing, and call this function when starting a delayed memcpy().
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? /*
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?* Eww. ?We know this isn't going to deadlock
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?* but lockdep probably doens't.
> 
> Speling...
> 
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?*/
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? spin_lock(&waiting->lock);
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? pl08x_start_next_txd(waiting);
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? spin_unlock(&waiting->lock);
> 
> I've seen this construct in the past and have no better suggestions...

I have no way to test whether my statement is true as I can't get enough
DMA engine usage through the PL011 transmit support to check what happens.
So the statement is purely theoretical.

> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij
> 
