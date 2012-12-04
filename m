From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Dec 2012 12:30:01 +0000
Subject: [RFC PATCH 0/2] Add support for a fake, para-virtualised machine
In-Reply-To: <50BD1F81.9080304@gmail.com>
References: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
 <50BD1F81.9080304@gmail.com>
Message-ID: <20121204123001.GL23368@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

[fixing Arnd's address, as I apparently can't spell]

On Mon, Dec 03, 2012 at 09:54:09PM +0000, Rob Herring wrote:
> On 12/03/2012 11:52 AM, Will Deacon wrote:
> > When running Linux on a para-virtualised platform (that is, one where
> > the guest is aware that it is dealing with virtual devices sitting on
> > things like virtio or xenbus) we require very little in the way of
> > platform code and piggy-backing on top of an existing platform can
> > require a lot of device emulation for very little gain.
> > 
> > These two patches introduce mach-virt: a very simple, DT-based machine
> > which can be used with kvmtool in conjunction with virtio-based devices.
> > It's not hard to imagine the same machine being targetted by Xen, which
> > currently emulates a minimal variant of the vexpress platform.
> > 
> > Note that this patch series depends on the timer rework from Mark
> > Rutland, posted on Friday:
> > 
> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/135651.html
> > 
> > All feedback welcome. We suspect that most controversy will be around
> > the name of the thing :)
> 
> We've discussed this before at conferences. I don't know that we
> concluded this wasn't needed, but it certainly leaned that direction.

I too leaned that direction before I started looking at kvm in detail and,
since then, I've changed my mind when it comes to para-virtualisation.

The reason for this is that there is absolutely no reason to emulate some
components of a real platform and then bolt virtual devices onto it once
you've got enough to get it going. It leads to a right royal mess in
userspace, where you have to write a load of non-reusable emulation code and
it leads to churn in the kernel because you're constantly at odds with
people trying to develop the platform code based on the actual hardware
they have.

With a virtualisation-capable ARMv7 system, all you *need* to boot SMP
Debian is:

	- A v7 CPU with virt extensions
	- vGIC
	- architected timers

*everything* else can be described using virtio devices in the device-tree,
essentially allowing you to generate platforms based on the above and boot
the same kernel on them.

> So what has changed? You're not going to save code space because we're
> building multiple platforms together. You'll save some boot time, but a
> stripped down dtb with only the minimal peripherals would probably save
> nearly as much time. 

It's really got nothing to do with code space or boot speed. What it *is*
about is avoiding the tight coupling with a real platform and suffering as a
result. Yes, you can strip down the DT for a real platform but you'll likely
still have to emulate things like the SP804 in order to boot. That's not to
mention any platform-specific system register interfaces which are required
early on.

We can't even re-use the socfpga code (which is incredibly minimal) without
emulating the dw_apb_timer.

> However, I do have concerns with using VExpress as
> the guest. For example, you can't support a non-PAE guest with 4GB of
> RAM on VExpress (maybe if the vexpress code gets all memory map info
> from DT).

Yes, vexpress is even less suitable for this.

> Is this really complete? Will we need reset, poweroff, hotplug, and
> suspend/resume support for example? Unlike most initial platform
> submissions which are minimal, I think seeing full support would be
> useful here. Then we can better gauge how much we are really saving.

The code is complete in the sense that you can boot an SMP guest running
Debian with console, network, block etc. etc. but you're right to point out
the absence of power-management support.

However, power-management in KVM guests is a *much* larger problem and not
one that has been solved adequately as of yet. There are suggestions that it
should be handled entirely in firmware, with the guest making smc calls to
request power-management operations but this is yet to materialise and, as
such, we can't yet use it here.

We could look at building a virtio-based power controller but that's going
to come up too late for SMP booting (although will give us hotplug, reset
etc).

Will
