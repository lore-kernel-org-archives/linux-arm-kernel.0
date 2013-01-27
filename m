From: anthony@codemonkey.ws (Anthony Liguori)
Date: Sun, 27 Jan 2013 08:07:41 -0600
Subject: [Qemu-devel] [RFC] Virtio-desktop: Virtio-based virtual desktop
In-Reply-To: <CALrVBktEQM5D-L+60RTzdRgo7jLZ671KxWMUFGnQwQ1bzgjO2A@mail.gmail.com>
References: <CALrVBktEQM5D-L+60RTzdRgo7jLZ671KxWMUFGnQwQ1bzgjO2A@mail.gmail.com>
Message-ID: <87wquysor6.fsf@codemonkey.ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Anup Patel <anup.patel@linaro.org> writes:

> Hi All,
>
> How about having a generic Virtio-based machine for emulating a virtual
> desktop ?
>
> I know folks have already thought about this and probably also tried
> something or other on this front but, it will be good to know the downsides.
>
> Virtio-desktop can be a separate specification describing a virtual
> desktop.
> Of-course we cannot avoid few architecture dependent virtual devices in but
> the Virtio-desktop specification will try to keep minimum possible
> architecture dependent devices.

There's a lot of reasons why a pure PV machine type is a bad idea.  Lots
of people have enumerated them in this thread.

But let me mention some things that I think we don't have covered today
with PV:

 - Graphics.  Yes, I know QXL exists but it's (a) dependent on PCI (b)
   lacks the ability to gracefully degrade making it hopelessly tied to
   spice.

 - Input.  PS/2 mouse provides relative input which sucks in guests.
   For absolute input, we have VMMouse which is x86-specific, USB
   tablets (which are expensive to emulate) or the spice mouse which is
   intimately tied to the full Spice stack.

 - Guest interaction.  Copy/paste, drag and drop, etc.  In theory this
   is covered in spice agents but it's all again hopelessly tied to
   Spice which makes it non-portable.

So there's good work todo but it's almost certainly in working with the
Spice community to try to make what they already have more accessible to
non-x86 architectures.

Regards,

Anthony Liguori

>
> As per our thoughts, a Virtio-desktop will have two kinds of devices:
> 1. Architecture dependent devices: This devices will be emulated in-kernel
> by architecture specific code of KVM or Xen or Some other hypervisor.
>    a) Virtualized CPU
>    b) Virtualized PIC (i.e. in-kernel architecture specific emulation of
> irqchip)
>    c) Virtualized Timer (i.e. in-kernel architecture specific emulation of
> timer chip)
> 2. Architecture independent devices: This are Virtio-based devices which
> are usually required by a desktop virtual machine.
>    a) Virtio-blk (storage)
>       - Already available
>    b) Virtio-net (network)
>      - Already available
>    c) Virtio-fb (display)
>      - It seems some work has been already done for Virtio frame buffer but
> I did not find drivers/fb/virtio-fb.c in latest kernel
>        (http://thread.gmane.org/gmane.comp.emulators.kvm.devel/42720)
>      - Is Virtio-fb work still in-progress ??
>    d) Virtio-input (keyboard/mouse/multi-touch)
>      - Currently not available
>      - It will provide keyboard input events
>      - It will provide mouse input events
>      - It will provide multi-touch input events
>    e) Virtio-power (reset/shutdown/enumeration)
>      - It can provides info about the entire virtual machine including CPU,
> PIC, Timer, available Virtio devices, etc.
>      - It can also provide CPU and Virtio-device hot-plugging
>      - Its primary purpose would be to provide reset and shutdown of CPU
> and Virtio devices.
>      - There will be only one instance of this device and its location will
> be fixed for each architecture.
>
> The Virtio-desktop specification may also describe a recommended memory map
> of for each architecture.
>
> Right now, only missing devices seems to be Virtio-fb, Virtio-input, and
> Virtio-power, which some of us are willing to take-up.
>
> IMHO, If we have something like Virtio-desktop specification then all
> possible guest OSes can have support for it and different hypervisor can
> emulate it without worrying about guest support.
>
> Best Regards,
> Anup
