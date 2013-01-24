From: agraf@suse.de (Alexander Graf)
Date: Thu, 24 Jan 2013 15:38:41 +0100
Subject: [kvmarm] [Qemu-devel] [RFC] Virtio-desktop: Virtio-based virtual
 desktop
In-Reply-To: <20130124092531.GD18072@stefanha-thinkpad.redhat.com>
References: <CALrVBktEQM5D-L+60RTzdRgo7jLZ671KxWMUFGnQwQ1bzgjO2A@mail.gmail.com>
 <20130124092531.GD18072@stefanha-thinkpad.redhat.com>
Message-ID: <EC4021BD-DDB7-4D28-BD79-4B7A809200AE@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 24.01.2013, at 10:25, Stefan Hajnoczi wrote:

> On Thu, Jan 24, 2013 at 11:40:24AM +0530, Anup Patel wrote:
>> IMHO, If we have something like Virtio-desktop specification then all
>> possible guest OSes can have support for it and different hypervisor can
>> emulate it without worrying about guest support.
> 
> At this point x86 virtualization is mature and working with a mix of
> emulated x86 architecture pieces and virtio devices for
> performance-critical or open-ended functionality that we want to be able
> to extend.
> 
> ARM is getting KVM and virtio-mmio support.  It will be in a similar
> position soon.
> 
> Virtio guest drivers have not been implemented widely.  The Linux and
> Windows efforts are driven by the folks who were behind virtio from the
> start, but Solaris, FreeBSD, and others didn't really jump on the virtio
> bandwagon.
> 
> Given this landscape, what is the advantage of doing a virtio-desktop?
> It will still need to fall back on ARM or x86 which is already being
> virtualized and emulated.
> 
> Depending on how you see it we either have virtio-desktop already or,
> if not, I think the experience with virtio adoption suggests other
> hypervisors and guest OSes will not trip over themselves to implement
> virtio-desktop.
> 
> What's the advantage over virtualizating an existing ARM or x86 platform
> and using virtio devices where appropriate?

You don't get changing hardware for changing CPUs. I don't think it makes sense to do a cross-arch virtio-desktop machine type. Different architectures simply have different needs.

But check out the QEMU e500 machine. We have a fully device tree based machine type in the kernel. QEMU drives it by generating a device tree for devices it actually exposes on the fly.

The big advantage we have here is that

  1) We don't have to emulate all hardware real hardware emulates
  2) We're not restricted to emulate what real hardware emulates. PCI on ARM anyone?
  3) Different CPU types can live on the same machine. This is something that x86 is doing already. When you get a SoC, guests are usually guaranteed a core <-> device correlation though.

So overall, having a PV machine makes sense. Having the same common PV machine standardized across different architectures does not make sense.


Alex
