From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Aug 2014 10:00:35 +0100
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140826082626.GE17263@ulmo>
References: <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <53FB46FF.1010208@redhat.com>
 <20140825145303.GC14763@ulmo.nvidia.com>
 <20140825150705.GB15297@lukather> <20140826082626.GE17263@ulmo>
Message-ID: <20140826090035.GB17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 10:26:27AM +0200, Thierry Reding wrote:
> On Mon, Aug 25, 2014 at 05:07:05PM +0200, Maxime Ripard wrote:

> > Regulators with regulator-boot-on will still be disabled if there's no
> > one to claim it. Just like what happens currently for the clocks.

> I was somewhat surprised by this, but it can indeed easily be verified.
> It seems to me somewhat at odds with the definition of such a property.

That depends what you think it should do - it's there for handover from
the bootloader in cases where we can't read the state.

> that. However the implementation will automatically disable a regulator
> marked boot-on if it hasn't been claimed by any driver after the
> initcall stage completes.

> I find that rather odd since I always assumed that a regulator marked
> boot-on would not be touched by the core at all, assuming that firmware
> set it up properly and that it would be required (even if not explicitly
> claimed).

No, there's a separate always-on property if we don't want to disable.
We can't assume that the "proper" setup is that the supply should be
left on.

> Two categories of drivers have this issue: drivers built as modules (or
> that defer probing) and therefore won't be probed until after initcalls

We really need a later initcall to manage handover to userspace
(probably triggered by a combination of userspace saying it's done doing
initial module enumeration and the deferred probe grinding to a halt).

> have run and generic low-level drivers that take over firmware devices
> (simplefb in this case) that don't know anything about the resource that
> the devices need.

I don't understand this use case, sorry - it sounds like a buggy system
design and/or integration.  If the firmware is managing the resource
then Linux really shouldn't be talking to it at all without coordinating
with firmware.  How can such a system work otherwise?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/f6affe2b/attachment.sig>
