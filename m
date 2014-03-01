From: grant.likely@linaro.org (Grant Likely)
Date: Sat, 01 Mar 2014 19:54:19 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <alpine.DEB.2.02.1402271216040.31489@kaball.uk.xensource.com>
References: <20140226183454.GA14639@cbox> <
 CACxGe6tjuytsYAn6Hadf0AK+REzHgRydgbHPafL8+Sdtd_tMUA@mail.gmail.com> <alpine
 .DEB.2.02.1402271216040.31489@kaball.uk.xensource.com>
Message-ID: <20140301195419.0DB5DC40B0D@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Feb 2014 12:27:58 +0000, Stefano Stabellini <stefano.stabellini@eu.citrix.com> wrote:
> On Wed, 26 Feb 2014, Grant Likely wrote:
> > > VM Platform
> > > -----------
> > > The specification does not mandate any specific memory map. ??The guest
> > > OS must be able to enumerate all processing elements, devices, and
> > > memory through HW description data (FDT, ACPI) or a bus-specific
> > > mechanism such as PCI.
> > >
> > > The virtual platform must support at least one of the following ARM
> > > execution states:
> > > ?? (1) aarch32 virtual CPUs on aarch32 physical CPUs
> > > ?? (2) aarch32 virtual CPUs on aarch64 physical CPUs
> > > ?? (3) aarch64 virtual CPUs on aarch64 physical CPUs
> > >
> > > It is recommended to support both (2) and (3) on aarch64 capable
> > > physical systems.
> > >
> > > The virtual hardware platform must provide a number of mandatory
> > > peripherals:
> > >
> > > ?? Serial console: ??The platform should provide a console,
> > > ?? based on an emulated pl011, a virtio-console, or a Xen PV console.
> > 
> > For portable disk image, can Xen PV be dropped from the list? pl011 is part of SBSA, and virtio is getting standardised, but Xen PV is
> > implementation specific.
> 
> Does an interface need OASIS' rubber stamp to be "standard"?  If so, we
> should also drop FDT from this document. The SBSA has not been published
> by any OASIS-like standardization body either, so maybe we should drop
> the SBSA too.
> 
> If it doesn't need OASIS nice logo on the side to be a standard, then
> the Xen PV interfaces are a standard too. Give a look at
> xen/include/public/io, they go as back as 2004, and they have multiple
> different implementations of the frontends and backends in multiple
> operating systems today.
> 
> There is no reason why another hypervisor couldn't implement the same
> interface and in fact I know for a fact that it was considered for KVM.

Allow me to elaborate. I'm not trying to punish Xen here, but I'm
deliberately pushing back against "either/or" options in the spec. In
this case the spec says the VM must implement one of pl011 *or* virtio
*or* xenpv. That gives lots of implementation choice to VM projects.

The downside is that spec-compliant OSes are required to implement
support for *all three*. This is a non-issue for Linux guests because all
those drivers are already there*, but it a real cost for niche guests.

The reason why a cut-dowm pl011 exists in SBSA is to provide a
bare-minimum output device that is always available. I would be far
happier for this spec to not give the VMs an option at all here. Now
that I think about it, it probably isn't appropriate to allow
virtio-console to be an option either. It should flat out require the
cut-down pl011 register interface. Make everything else optional. 'sane'
linux distros will enable virtio-console and xenpv and the kernel should
use whichever it finds in normal operation. Then no matter what crazy
guest the user wants to run there is still a known-safe fallback for
console output when things go wrong.

* aside from the footprint required to enable all of them

I've just had another thought. In the majority of cases the fallback
pl011 won't get used by the guest anyway unless asked to because the
UEFI OS Loader (EFI_STUB for Linux) will use the UEFI console drivers.
I expect the Xen UEFI port will use xenpv, and the kvm UEFI port will
use virtio. After UEFI exit boot services the OS is responsible for it's
own console output. If it has drivers for virtio-console or xenpv, then
fine; it discovers the interface and all is good. But if it doesn't,
then the fallback will at least work.

g.
