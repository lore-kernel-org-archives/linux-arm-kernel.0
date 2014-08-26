From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Aug 2014 15:53:41 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140826080432.GD17263@ulmo>
References: <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
Message-ID: <20140826135341.GM15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 10:04:33AM +0200, Thierry Reding wrote:
> > > No. simplefb just wants to write to some memory that hardware has been
> > > set up to scan out. The platform requires that the clocks be on. Other
> > > platforms may not even allow turning off the clocks.
> > 
> > Like what? the rpi? Come on. Just because the videocore is some black
> > box we know nothing about doesn't mean we should use it as an example.
> 
> You make it sound like the Raspberry Pi is somehow less important than
> sunxi.

No. What I mean is that it seems like we are somehow punished, or at
least blamed, for having a better and more complete kernel support.

> > Any decent enough SoC, with a decent support in the kernel will have
> > clocks for this, and I really wonder how simplefb will behave once its
> > clocks will be turned off...
> 
> There are other devices besides ARM SoCs that may want to use this
> driver and that don't have clock support.

And in this case, with this patch, simplefb will not claim any clock,
nor will fail probing.

> But you're missing my point. What I'm saying is that the simplefb driver
> is meant to serve as a way to take over whatever framebuffer a firmware
> set up. Therefore I think it makes the most sense to assume that nothing
> needs to be controlled in any way since already been set up by firmware.
> Eventually there should be a driver that takes over from simplefb that
> knows how to properly handle the device's specifics, but that's not
> simplefb.

I guess such a hand over if it were to happen in the kernel would
involve the second driver claiming the resources before the first one
release them. How is that different in this case?

> The goal of this patch series is to keep clocks from being turned off.
> But that's not what it does. What it does is turn clocks on to prevent
> them from being turned off. In my opinion that's a workaround for a
> deficiency in the kernel (and the firmware/kernel interface) and I think
> it should be fixed at the root. So a much better solution would be to
> establish a way for firmware to communicate to the kernel that a given
> resource has been enabled by firmware and shouldn't be disabled. Such a
> solution can be implement for all types of resources and can be reused
> by all drivers since they don't have to worry about these details.

Mike Turquette repeatedly said that he was against such a DT property:
https://lkml.org/lkml/2014/5/12/693

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/0a274db7/attachment.sig>
