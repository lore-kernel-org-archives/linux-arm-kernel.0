From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Thu, 15 Sep 2016 16:40:00 +0100
Subject: [GIT PULL] Greybus driver subsystem for 4.9-rc1
In-Reply-To: <20160915124601.GA9316@leverpostej>
References: <20160914100949.GA6179@kroah.com>
 <20160914173625.GB15356@leverpostej> <20160914180754.GA16053@kroah.com>
 <20160914182952.GA21615@kroah.com>
 <1473932133.10230.25.camel@nexus-software.ie>
 <20160915101330.GB6718@leverpostej>
 <1473935756.10230.42.camel@nexus-software.ie>
 <20160915112029.GC6718@leverpostej>
 <1473940088.10230.65.camel@nexus-software.ie>
 <20160915124601.GA9316@leverpostej>
Message-ID: <1473954000.4035.5.camel@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-09-15 at 13:46 +0100, Mark Rutland wrote:
> On Thu, Sep 15, 2016 at 12:48:08PM +0100, Bryan O'Donoghue wrote:
> > 
> > On Thu, 2016-09-15 at 12:20 +0100, Mark Rutland wrote:
> > > 
> > > For example, you have absolutely no guarantee as to what backs
> > > get_cycles(). Despite this, the code assumes that get_cycles() is
> > > backed by something running at the frequency described in a
> > > "google,greybus-frame-time-counter" node.
> > > 
> > > Even if this *happens* to match what some piece of arch code
> > > provides
> > > today on some platform, it is in no way *guaranteed*.
> > That's the point though, if you declare "google,greybus-frame-time-
> > counter" in your platform code - then you can use 'get_cycles()' in
> > this manner
> To be clear, *some* properties (and perhaps additional nodes) may
> need
> to be in the DT, in order to capture the hardware property or
> relationship that you are reliant upon.

Sure but on the relevant platform we know?

1. get_cycles() is derived from an architectured MMIO timer
2. What is clocking that timer

So any platform that declares that property must be aware of what its
doing.

For clarity this is the alternative to reading another register
directly bypassing get_cycles().


> > 
> > > 
> > > Without a higher-level view of what you're trying to achieve,
> > > it's
> > > not clear to me whether get_cycles() is the right interface.
> > I appreciate that.
> Until that's clarified, we won't make any progress here.

Let's see. We're synchronizing a set of distributed timers via a GPIO
pulse. Each processor on the system has at least one timer block
directly driven by the refclk at 19.2MHz?or a PLL driven by refclk at 19.2MHz

FrameTime is a 64 bit free-running counter running @19.2MHz that is
used as a common source of reference for events. On the MSM side this
implies reading one of the timers driven by that refclk directly.

The choices on MSM8994 to access one of those timer blocks are

1. Read the register directly as is done in earlier patches or
2. Read get_cycles() as is done in later patches.

It's no more complex than that.

---
bod
