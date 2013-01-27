From: blauwirbel@gmail.com (Blue Swirl)
Date: Sun, 27 Jan 2013 10:12:20 +0000
Subject: [Qemu-devel] [kvmarm] [RFC] Virtio-desktop: Virtio-based virtual
 desktop
In-Reply-To: <20130127082007.GA31120@redhat.com>
References: <CALrVBktEQM5D-L+60RTzdRgo7jLZ671KxWMUFGnQwQ1bzgjO2A@mail.gmail.com>
 <CAAu8pHve_E-jtQAXidxroWHRVi_QKaYs6YeQhHqEap2bd7RMEQ@mail.gmail.com>
 <C549A8FA-7BD7-4C9C-B2B7-AE960F402645@suse.de>
 <20130127082007.GA31120@redhat.com>
Message-ID: <CAAu8pHuUfEezDEsYWTymFkuCEzdK+kr09MMFmVy-DZV8ztJbGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 8:20 AM, Gleb Natapov <gleb@redhat.com> wrote:
> On Fri, Jan 25, 2013 at 08:31:54PM +0100, Alexander Graf wrote:
>>
>> On 25.01.2013, at 20:04, Blue Swirl wrote:
>>
>> > On Thu, Jan 24, 2013 at 6:10 AM, Anup Patel <anup.patel@linaro.org> wrote:
>> >> Hi All,
>> >>
>> >> How about having a generic Virtio-based machine for emulating a virtual
>> >> desktop ?
>> >
>> > I have also thought about this, current virtio design is not very
>> > clean. On the downside, pure no-legacy approach might not work well if
>> > you want the host to give control of a host device to guest (VFIO like
>> > pass through using IOMMUs).
>> >
>> >> I know folks have already thought about this and probably also tried
>> >> something or other on this front but, it will be good to know the downsides.
>> >>
>> >> Virtio-desktop can be a separate specification describing a virtual desktop.
>> >> Of-course we cannot avoid few architecture dependent virtual devices in but
>> >> the Virtio-desktop specification will try to keep minimum possible
>> >> architecture dependent devices.
>> >>
>> >> As per our thoughts, a Virtio-desktop will have two kinds of devices:
>> >> 1. Architecture dependent devices: This devices will be emulated in-kernel
>> >> by architecture specific code of KVM or Xen or Some other hypervisor.
>> >>   a) Virtualized CPU
>> >>   b) Virtualized PIC (i.e. in-kernel architecture specific emulation of
>> >> irqchip)
>> >>   c) Virtualized Timer (i.e. in-kernel architecture specific emulation of
>> >> timer chip)
>> >
>> > I think reusing PIC and timer design is not the most optimal. What a
>> > PV aware OS really wants is to wake up because of an external event or
>> > at some specific point of time (or after a specific delay) and easy
>> > way to manage the VM clock without timer tick counting. With a
>> > tickless approach, it would need the timer events as rarely as
>> > possible.
>> >
>> > Perhaps a better approach would be to introduce a way for the guest to
>> > subscribe to a list of external events (including time), which would
>> > be fed to it via something like reverse hypercall (or just use legacy
>> > interrupts). Preferably it should be possible to pass any events
>> > through a stack of guests to the end consumer guest and even
>> > applications in a guest.
>>
>> This approach falls apart once hardware vendors implement timer interrupts inside a guest context (which Intel and IIUC ARM are doing). At that point, it's actually more efficient to do real timer calls to real hardware.
>>
> Same with irq chip. Implementing PV irqchip today is going backwards.

I'm not sure this should be the conclusion. Obviously throwing more
hardware at virtualization makes it faster and the x86 host will
probably also benefit from faster interrupt handling as a side
benefit, so emulating the PIC etc. makes sense for now and also in
short term (some years from now).

But long term, if you could direct the hardware design efforts of
major companies and standardization bodies to any direction, is fast
emulation of 30 year old technology what would create the fastest
architecture in the future? For example, maybe the PIC+LAPIC should be
replaced in long term by something that can vector the interrupts to
different VCPUs directly, each at different privilege levels?

>
>> PV is bad. We only do it when we have to. Not doing PV where we don't have to is exactly the reason KVM is superior to Xen.
>>
> Exactly. Implementing PV for something that does not require PV (for
> performance reasons mostly) is trading tested guest code, to untested,
> and unwritten, one.

HW acceleration of Xen would just need faster IPC, but that has
probably reached max performance ages ago.

The legacy driver benefit is a good point, though more so for short term.

>
> --
>                         Gleb.
