From: blauwirbel@gmail.com (Blue Swirl)
Date: Fri, 25 Jan 2013 19:04:11 +0000
Subject: [Qemu-devel] [RFC] Virtio-desktop: Virtio-based virtual desktop
In-Reply-To: <CALrVBktEQM5D-L+60RTzdRgo7jLZ671KxWMUFGnQwQ1bzgjO2A@mail.gmail.com>
References: <CALrVBktEQM5D-L+60RTzdRgo7jLZ671KxWMUFGnQwQ1bzgjO2A@mail.gmail.com>
Message-ID: <CAAu8pHve_E-jtQAXidxroWHRVi_QKaYs6YeQhHqEap2bd7RMEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 6:10 AM, Anup Patel <anup.patel@linaro.org> wrote:
> Hi All,
>
> How about having a generic Virtio-based machine for emulating a virtual
> desktop ?

I have also thought about this, current virtio design is not very
clean. On the downside, pure no-legacy approach might not work well if
you want the host to give control of a host device to guest (VFIO like
pass through using IOMMUs).

> I know folks have already thought about this and probably also tried
> something or other on this front but, it will be good to know the downsides.
>
> Virtio-desktop can be a separate specification describing a virtual desktop.
> Of-course we cannot avoid few architecture dependent virtual devices in but
> the Virtio-desktop specification will try to keep minimum possible
> architecture dependent devices.
>
> As per our thoughts, a Virtio-desktop will have two kinds of devices:
> 1. Architecture dependent devices: This devices will be emulated in-kernel
> by architecture specific code of KVM or Xen or Some other hypervisor.
>    a) Virtualized CPU
>    b) Virtualized PIC (i.e. in-kernel architecture specific emulation of
> irqchip)
>    c) Virtualized Timer (i.e. in-kernel architecture specific emulation of
> timer chip)

I think reusing PIC and timer design is not the most optimal. What a
PV aware OS really wants is to wake up because of an external event or
at some specific point of time (or after a specific delay) and easy
way to manage the VM clock without timer tick counting. With a
tickless approach, it would need the timer events as rarely as
possible.

Perhaps a better approach would be to introduce a way for the guest to
subscribe to a list of external events (including time), which would
be fed to it via something like reverse hypercall (or just use legacy
interrupts). Preferably it should be possible to pass any events
through a stack of guests to the end consumer guest and even
applications in a guest.

> 2. Architecture independent devices: This are Virtio-based devices which are
> usually required by a desktop virtual machine.
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
>      - Its primary purpose would be to provide reset and shutdown of CPU and
> Virtio devices.
>      - There will be only one instance of this device and its location will
> be fixed for each architecture.

d) and e) would be also covered by the PV event device. Perhaps also a) and b).

I'm not sure how c) would be different from X11 (the original network
protocol using version, not Wayland).

>
> The Virtio-desktop specification may also describe a recommended memory map
> of for each architecture.

Memory management (ballooning and page faults) could also use the
event device. The use of events could also avoid memory to memory
copies (zero copy) by letting the host manage the buffer memory.

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
