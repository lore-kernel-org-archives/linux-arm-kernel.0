From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Dec 2012 17:30:45 +0000
Subject: [RFC PATCH 2/2] ARM: SMP support for mach-virt
In-Reply-To: <50BE31E9.3040404@arm.com>
References: <1354557160-20144-3-git-send-email-will.deacon@arm.com>
 <50BD1FD7.9040000@gmail.com>
 <20121204124047.GM23368@mudshark.cambridge.arm.com>
 <20121204133326.GE14363@n2100.arm.linux.org.uk>
 <20121204134010.GP23368@mudshark.cambridge.arm.com>
 <20121204143724.GF14363@n2100.arm.linux.org.uk>
 <20121204161113.GT23368@mudshark.cambridge.arm.com>
 <50BE28C6.2010403@gmail.com>
 <20121204171628.GF5314@mudshark.cambridge.arm.com>
 <50BE31E9.3040404@arm.com>
Message-ID: <20121204173045.GI5314@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 05:24:57PM +0000, Marc Zyngier wrote:
> On 04/12/12 17:16, Will Deacon wrote:
> > On Tue, Dec 04, 2012 at 04:45:58PM +0000, Rob Herring wrote:
> >> Aren't we mixing 2 pens here? You must have some simple bootloader
> >> containing vector table and a pen that the dtb points to, right? The pen
> >> you have in the kernel is only needed when hotplug only does a wfi. As
> >> you don't yet support hotplug, then you can drop all the kernel pen code.
> > 
> > Yes, both qemu and kvmtool have bootloader pens outside of the kernel but
> > since wfi is not trapped by kvm, the secondaries can be released early due
> > to a spurious wakeup so we need the second pen.
> 
> Actually, KVM traps WFI and puts the vcpu thread on a wait queue (we are
> actually giving more guaranties than the architecture offers here).

Ok, if we can rely on this behaviour in the future this sounds promising.
Can somebody comment from the Xen side of things please?

> We should be able to remove the loop and rely on WFI.

Yes, we should be able to remove the kernel-side loop. We still won't have
hotplug and friends, but that can come later because there's a discussion
around PSCI vs virtual power controller to be had there.

Will
