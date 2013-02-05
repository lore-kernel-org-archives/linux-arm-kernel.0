From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Feb 2013 17:06:28 +0000
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <20130205164705.GG4720@opensource.wolfsonmicro.com>
References: <20130204154153.GA18237@arwen.pp.htv.fi> <510FF1A6.403@mvista.com>
 <20130204164712.GB4269@arwen.pp.htv.fi> <510FF5C9.3030600@mvista.com>
 <20130204170216.GC4269@arwen.pp.htv.fi> <51100A72.6030909@ti.com>
 <CACRpkdZihnp3_Df==QRWxQupgi7W_YXZxc-MxkusVH6J+Vx56A@mail.gmail.com>
 <5110369B.9060901@ti.com>
 <CACRpkda8xBB35CwuBH76xXcC341TeRs1ZuwzDD0LtuXc4ifQTw@mail.gmail.com>
 <20130205164705.GG4720@opensource.wolfsonmicro.com>
Message-ID: <20130205170628.GD17852@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 04:47:05PM +0000, Mark Brown wrote:
> On Tue, Feb 05, 2013 at 05:21:48PM +0100, Linus Walleij wrote:
> 
> > For IRQ mode, use the completion callback to push each cookie
> > to NAPI, and thus let the IRQ drive the traffic.
> 
> The whole purpose of NAPI is to avoid taking interrupts for completion
> of transfers.  Anything that generates interrupts when NAPI is in
> polling mode is defeating the point.

Yes, but you're missing one very important point.  If your DMA engine
is decoupled from the network device, and the DMA engine relies upon
interrupts to queue further transfers to move data into RAM, then you
have two options:

1. Receive these interrupts so you can update the DMA engine for
   further data transfer.
2. Don't receive these interrupts, and cause the network device to
   error out with a FIFO overrun because its DMA requests have not
   been serviced. (which may raise an interrupt.)
