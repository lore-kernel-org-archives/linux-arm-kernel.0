From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Aug 2014 11:18:54 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140826090035.GB17528@sirena.org.uk>
References: <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <53FB46FF.1010208@redhat.com>
 <20140825145303.GC14763@ulmo.nvidia.com>
 <20140825150705.GB15297@lukather> <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk>
Message-ID: <20140826091853.GI17263@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 10:00:35AM +0100, Mark Brown wrote:
> On Tue, Aug 26, 2014 at 10:26:27AM +0200, Thierry Reding wrote:
> > On Mon, Aug 25, 2014 at 05:07:05PM +0200, Maxime Ripard wrote:
> 
> > > Regulators with regulator-boot-on will still be disabled if there's no
> > > one to claim it. Just like what happens currently for the clocks.
> 
> > I was somewhat surprised by this, but it can indeed easily be verified.
> > It seems to me somewhat at odds with the definition of such a property.
> 
> That depends what you think it should do - it's there for handover from
> the bootloader in cases where we can't read the state.

True. The description leaves a lot of room for interpretation, though.

	- regulator-boot-on: bootloader/firmware enabled regulator

> > that. However the implementation will automatically disable a regulator
> > marked boot-on if it hasn't been claimed by any driver after the
> > initcall stage completes.
> 
> > I find that rather odd since I always assumed that a regulator marked
> > boot-on would not be touched by the core at all, assuming that firmware
> > set it up properly and that it would be required (even if not explicitly
> > claimed).
> 
> No, there's a separate always-on property if we don't want to disable.

But always-on means that it can't ever be disabled. In this case what
we'd need is a "don't disable automatically because it's needed, but we
may want to switch it off at a later point to save power."

> We can't assume that the "proper" setup is that the supply should be
> left on.

Right, we can't assume it, but if we're given appropriate hints I think
it's fair to keep resources set up by firmware untouched.

> > Two categories of drivers have this issue: drivers built as modules (or
> > that defer probing) and therefore won't be probed until after initcalls
> 
> We really need a later initcall to manage handover to userspace
> (probably triggered by a combination of userspace saying it's done doing
> initial module enumeration and the deferred probe grinding to a halt).

Yes, perhaps that would be another option.

> > have run and generic low-level drivers that take over firmware devices
> > (simplefb in this case) that don't know anything about the resource that
> > the devices need.
> 
> I don't understand this use case, sorry - it sounds like a buggy system
> design and/or integration.  If the firmware is managing the resource
> then Linux really shouldn't be talking to it at all without coordinating
> with firmware.  How can such a system work otherwise?

The firmware isn't really managing resources. It's setting up state that
the kernel shouldn't be modifying. Currently the kernel assumes that no
firmware exists and just disables everything that's not being used. That
is a reasonable default, but it also limits what we can do. I think if
we provided a good interface to communicate state between firmware and
kernel then we could easily do this kind of hand-off.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/0dfb00f3/attachment-0001.sig>
