From: andreas@kemnade.info (Andreas Kemnade)
Date: Fri, 12 Jan 2018 19:40:35 +0100
Subject: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
In-Reply-To: <20180112144647.GA5992@localhost>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost> <20180109184347.28ba0a6e@aktux>
 <20180112144647.GA5992@localhost>
Message-ID: <20180112194022.7da1e726@kemnade.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Jan 2018 15:46:47 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Tue, Jan 09, 2018 at 06:43:47PM +0100, Andreas Kemnade wrote:
> > On Fri, 22 Dec 2017 13:44:27 +0100
> > Johan Hovold <johan@kernel.org> wrote:
> > 
> > [...]  
> > > I'd suggest reiterating the problem you're trying to solve and
> > > enumerating the previously discussed potential solutions in order to
> > > find a proper abstraction level for this (before getting lost in
> > > implementation details).
> > >   
> > The main point here is in short words: Having a device powered on or off
> > when the uart it is attached to, is used or not used anymore,
> > so the already available userspace applications do not need to be changed.  
> 
> So we'd end up with something in-between a kernel driver and a
> user-space solution. What about devices that need to be (partially)
> powered also when the port isn't open? A pure user-space solution would
> be able to handle all variants.
> 
Well partly powered devices are at many places, And they hide that problem
from userspace, just get the open()/get() and close()/put() from there and power the
device accordingly. 

So the question still remains why should the kernel hide some things and some
it should not.
If it all is in userspace, then there is still something needed in the devicetree
(if I understand correctly, every information about hardware which cannot be
auto-probed belongs into device tree) so that the userspace knows what kind of
device is at that port. So there can be a daemon powering on and off devices.
But that would break existing applications which just expect that they just need
to open/close the device. 

Or you need to have some inotify handler in userspace and attach it there to
react on close() and open() of that device.
But this thing needs to have two kind of information:

1. the type of chip available to do the right powerup sequence. 

2. how the chip is wired up to the cpu. 

So to avoid having hardware information spread all over the table at least
these information would need to be in devicetree. But that also all feels
like a hack and hard to maintain.

Regards,
Andreas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180112/516f978d/attachment.sig>
