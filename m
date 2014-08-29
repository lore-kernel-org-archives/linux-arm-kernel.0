From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Aug 2014 16:31:49 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140829135708.GG15297@lukather>
References: <20140826143550.GB3027@ulmo> <20140826210248.GO15297@lukather>
 <20140827065440.GG15640@ulmo> <20140827084526.GR15297@lukather>
 <20140827095241.GC23186@ulmo> <20140827154221.GX15297@lukather>
 <20140828101140.GB14388@ulmo> <20140828204603.GB15297@lukather>
 <20140829062932.GB13106@ulmo> <20140829135708.GG15297@lukather>
Message-ID: <20140829143148.GB31264@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 03:57:08PM +0200, Maxime Ripard wrote:
> On Fri, Aug 29, 2014 at 08:29:33AM +0200, Thierry Reding wrote:
> > On Thu, Aug 28, 2014 at 10:46:03PM +0200, Maxime Ripard wrote:
> > > On Thu, Aug 28, 2014 at 12:11:41PM +0200, Thierry Reding wrote:
> > [...]
> > > > Then since firmware already knows what it set up it can tell the
> > > > kernel to not touch those.
> > > 
> > > Somehow, I've been raised kernel-wise into thinking that you can never
> > > fully trust your firmware. Or at least that you should have a way to
> > > recover from any bug/bad behaviour from it.
> > 
> > If you don't trust your firmware then you shouldn't be taking over a
> > device that it's set up for you. Rather you should write a proper driver
> > that sets things up from the start.
> > 
> > This whole "we don't trust firmware" isn't going to work if we want to
> > have hand-off from firmware to kernel. And it's already been decided in
> > other threads that moving more code out of the kernel and into firmware
> > is a requirement (c.f. ARM64).
> 
> Except that in ARM64 case, it has been asked before having any
> SoC/boards out. We're definitely not in this situation there.

You're still in the situation where you need to trust your firmware, so
my point remains valid.

> > Also in this case you wrote the firmware, so why wouldn't you trust it?
> 
> We partly wrote the firmware, on some of the available SoCs. Some
> other just have allwinner's own. But yeah, in this case they wouldn't
> even set up the framebuffer in the first place.

Even if you didn't write it, you could still trust it provided that you
had the source code for it. The whole argument of "never trust firmware"
is based on the assumption that you can't fix it. And even if that's the
case, it's still perfectly acceptable to not trust firmware. But if you
don't trust firmware then you really shouldn't be using simplefb in the
first place and do everything in the kernel.

> > > Moreover, the way I see it, there's a major flaw in having an
> > > attribute in the clock node: you don't even know if the clock is ever
> > > going to be used.
> > > 
> > > If simplefb is not compiled in, you won't claim the clocks, and they
> > > will be disabled, which is imho a good thing. This case wouldn't be
> > > covered with an attribute at the clock node, because you don't have a
> > > link to what device/feature actually uses it in the system, and so you
> > > have to make the assumption that it will be used. And you will end up
> > > with clocks with a rather high rate running for nothing.
> > 
> > That's completely hypothetical. If simplefb isn't enabled and the clock
> > isn't claimed there's probably still going to be some other driver
> > taking over eventually. If there isn't, what's the point of firmware
> > setting up display in the first case?
> 
> And now, here is a new requirement for the firmware: that in addition
> to being reliable, that it must not be dumb, or take shortcuts, like
> setting up the framebuffer in every case, no matter wether there's a
> screen or not.

Firmware should never do that anyway. The whole point of firmware is to
be device-specific and therefore it already knows when there's a need to
activate a framebuffer or not.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/7e24e17e/attachment-0001.sig>
