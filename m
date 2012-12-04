From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Dec 2012 13:40:10 +0000
Subject: [RFC PATCH 2/2] ARM: SMP support for mach-virt
In-Reply-To: <20121204133326.GE14363@n2100.arm.linux.org.uk>
References: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
 <1354557160-20144-3-git-send-email-will.deacon@arm.com>
 <50BD1FD7.9040000@gmail.com>
 <20121204124047.GM23368@mudshark.cambridge.arm.com>
 <20121204133326.GE14363@n2100.arm.linux.org.uk>
Message-ID: <20121204134010.GP23368@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 01:33:26PM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 04, 2012 at 12:40:47PM +0000, Will Deacon wrote:
> > On Mon, Dec 03, 2012 at 09:55:35PM +0000, Rob Herring wrote:
> > > Why is the pen is needed? It should only be needed for hotplug on
> > > systems that can't reset their cores. I'd hope you could design good
> > > virtual h/w.
> > 
> > It's not so much about designing good virtual h/w as it is avoiding tying
> > the platform to it. What we don't want is to mandate that in order to boot
> > this machine, you *must* implement an emulation of some virtual
> > power-controller or SMP booting device. If we go down that route, there's
> > less advantage from having the virtual platform in the first place.
> 
> There is actually a bigger problem here.  Let's say that you have a
> quad SMP platform.  You've arranged for your kernel to boot and only
> bring one of those cores online.
> 
> You then kexec() or reboot.  As far as the kernel is concerned, those
> other two CPUs are not online and are not running any kernel code;
> however in reality they could be sitting in this 'pen'.
> 
> The memory that these 'offline' CPUs is executing then gets overwritten,
> and that's game over for those CPUs.

That's not strictly true. The device-tree passed to the kernel should have a
/memreserve/ entry for the SMP pen to avoid exactly this scenario. In real
hardware, this still sucks because you have spinning CPUs burning up power
but that's not such a problem with a virtual platform.

> So, the 'pen' approach in the kernel is fragile, I'd much rather not
> have it.  It was fine in the beginning for the initial ARM Ltd SMP
> platforms but in this modern age it has no place in real platforms where
> there is proper control of the secondary CPUs.

We could have an (optional) virtual device for booting secondary CPUs but I
think the pen should still be there as a default method. Otherwise, we're
forcing a component of the platform to be emulated unnecessarily (the CPU,
vGIC and timers all have hardware-assisted virtualisation and require no
emulation).

Will
