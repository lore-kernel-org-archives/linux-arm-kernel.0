From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Thu, 15 Sep 2016 10:35:33 +0100
Subject: [GIT PULL] Greybus driver subsystem for 4.9-rc1
In-Reply-To: <20160914182952.GA21615@kroah.com>
References: <20160914100949.GA6179@kroah.com>
 <20160914173625.GB15356@leverpostej> <20160914180754.GA16053@kroah.com>
 <20160914182952.GA21615@kroah.com>
Message-ID: <1473932133.10230.25.camel@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-09-14 at 20:29 +0200, Greg KH wrote:
> On Wed, Sep 14, 2016 at 08:07:54PM +0200, Greg KH wrote:
> > 
> > On Wed, Sep 14, 2016 at 06:36:26PM +0100, Mark Rutland wrote:
> > > 
> > > Hi Greg,
> > > 
> > > On Wed, Sep 14, 2016 at 12:09:49PM +0200, Greg KH wrote:
> > > > 
> > > > Given that it's never a good idea to keep subsystems out of the
> > > > mainline
> > > > kernel, I've put together this pull request that adds the
> > > > greybus driver
> > > > layer to drivers/greybus/.??Because this was 2 1/2 years of
> > > > work, with
> > > > many many developers contributing, I didn't want to flatten all
> > > > of their
> > > > effort into a few small patches, as that wouldn't be very
> > > > fair.??So I've
> > > > built a git tree with all of the changes going back to the
> > > > first commit,
> > > > and merged it into the kernel tree, just like btrfs was merged
> > > > into the
> > > > kernel.
> > > > 
> > > > Unless people point out some major problems with this, I'd like
> > > > to get
> > > > it merged into 4.9-rc1.
> > > I'm extremely concerned that these patches have *never* seen
> > > upstream
> > > review, and this pull request gives no real opportunity for
> > > people to
> > > make a judgement regarding the code, as many relevant parties
> > > have not
> > > been Cc'd.
> > As I said, I will send a set of simple patches, I wanted to get
> > this out
> > as soon as possible and other things came up today.??Will do it in
> > the
> > morning, sorry.
> Here's the timesync code pulled out into a simple patch if you want
> to
> see it.
> 
> Bryan, any explanations you want to provide that would help in
> clarifying Mark's issues?

As Douglas Adams would say - "don't panic".

If you look at the final state the code ends up in - we're doing
get_cycles(); as opposed to reading an architectural timer directly.

u64 gb_timesync_platform_get_counter(void)
{
????????return (u64)get_cycles();
}

You have the entire git history - from the early days where we were reading one of the unused ARMv8 timers the MSM8994 has to the later days where we just do get_cycles()...

At the time when we first started writing the code it wasn't 100% clear if get_cycles() would do, so it was safer to allocate an unused architectural timer and read it directly. Later on and with some experimentation it was possible to switch to get_cycles().

---
bod
