From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 3 Dec 2014 11:28:29 +0100
Subject: [PATCH v4 15/19] arm/arm64: KVM: add virtual GICv3 distributor
 emulation
In-Reply-To: <547DE7D5.5020205@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-16-git-send-email-andre.przywara@arm.com>
 <20141123143841.GB3401@cbox> <5473562E.7060303@arm.com>
 <20141125104129.GC31297@cbox> <5478939B.8010103@arm.com>
 <20141130083014.GA82106@macair> <547DE7D5.5020205@arm.com>
Message-ID: <20141203102829.GA17502@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 02, 2014 at 04:24:53PM +0000, Andre Przywara wrote:
> Hej Christoffer,
> 
> On 30/11/14 08:30, Christoffer Dall wrote:
> > On Fri, Nov 28, 2014 at 03:24:11PM +0000, Andre Przywara wrote:
> >> Hej Christoffer,
> >>
> >> On 25/11/14 10:41, Christoffer Dall wrote:
> >>> Hi Andre,
> >>>
> >>> On Mon, Nov 24, 2014 at 04:00:46PM +0000, Andre Przywara wrote:
> >>>
> >>
> 
> [...]
> 
> >>>>>> +
> >>>>>> +     if (!is_in_range(mmio->phys_addr, mmio->len, rdbase,
> >>>>>> +         GIC_V3_REDIST_SIZE * nrcpus))
> >>>>>> +             return false;
> >>>>>
> >>>>> Did you think more about the contiguous allocation issue here or can you
> >>>>> give me a pointer to the requirement in the spec?
> >>>>
> >>>> 5.4.1 Re-Distributor Addressing
> >>>>
> >>>
> >>> Section 5.4.1 talks about the pages within a single re-distributor having
> >>> to be contiguous, not all the re-deistributor regions having to be
> >>> contiguous, right?
> >>
> >> Ah yes, you are right. But I still think it does not matter:
> >> 1) We are "implementing" the GICv3. So as the spec does not forbid this,
> >> we just state that the redistributor register maps for each VCPU are
> >> contiguous. Also we create the FDT accordingly. I will add a comment in
> >> the documentation to state this.
> >>
> >> 2) The kernel's GICv3 DT bindings assume this allocation is the default.
> >> Although Marc added bindings to work around this (stride), it seems much
> >> more logical to me to not use it.
> > 
> > I don't disagree (and never have) with the fact that it is up to us to
> > decide.
> > 
> > My original question, which we haven't talked about yet, is if it is
> > *reasonable* to assume that all re-distributor regions will always be
> > contiguous?
> > 
> > How will you handle VCPU hotplug for example?
> 
> As kvmtool does not support hotplug, I haven't thought about this yet.
> To me it looks like userland should just use maxcpus for the allocation.
> If I get the current QEMU code right, there is room for 127 GICv3 VCPUs
> (2*64K per VCPU + 64K for the distributor in 16M space) at the moment.
> Kvmtool uses a different mapping, which allows to share 1G with virtio,
> so the limit is around 8000ish VCPUs here.
> Are there any issues with changing the QEMU virt mapping later?

Not issues as such, but we try to keep it as stable as possible.  At
least soon, you have to worry about UEFI working with such changes, for
example.

> Migration, maybe?
> If the UART, the RTC and the virtio regions are moved more towards the
> beginning of the 256MB PCI mapping, then there should be space for a bit
> less than 1024 VCPUs, if I get this right.
> 
> > Where in the guest
> > physical memory map of our various virt machines should these regions
> > sit so that we can allocate anough re-distributors for VCPUs etc.?
> 
> Various? Are there other mappings than those described in hw/arm/virt.c?
> 

QEMU's and kvmtool's, for starters.

> > I just want to make sure we're not limiting ourselves by some amount of
> > functionality or ABI (redistributor base addresses) that will be hard to
> > expand in the future.
> 
> If we are flexible with the mapping at VM creation time, QEMU could just
> use a mapping depending on max_cpus:
> < 128 VCPUs: use the current mapping
> 128 <= x < 1020: use a more compressed mapping
> >= 1020: map the redistributor somewhere above 4 GB

I don't understand what the compressed mapping is.  Is the current code
easy to expand such that you can add a secondary separate redistributor
region above the 4GB map?

> 
> As the device tree binding for GICv3 just supports a stride value, we
> don't have any other real options beside this, right? So how I see this,
> a contiguous mapping (with possible holes) is the only way.
> 
> >>>>>> +
> >>>>>> +static int vgic_v3_init(struct kvm *kvm, const struct vgic_params *params)
> >>>>>> +{
> >>>>>> +     struct vgic_dist *dist = &kvm->arch.vgic;
> >>>>>> +     int ret, i;
> >>>>>> +     u32 mpidr;
> >>>>>> +
> >>>>>> +     if (IS_VGIC_ADDR_UNDEF(dist->vgic_dist_base) ||
> >>>>>> +         IS_VGIC_ADDR_UNDEF(dist->vgic_redist_base)) {
> >>>>>> +             kvm_err("Need to set vgic distributor addresses first\n");
> >>>>>> +             return -ENXIO;
> >>>>>> +     }
> >>>>>> +
> >>>>>> +     /*
> >>>>>> +      * FIXME: this should be moved to init_maps time, and may bite
> >>>>>> +      * us when adding save/restore. Add a per-emulation hook?
> >>>>>> +      */
> >>>>>
> >>>>> progress on this fixme?
> >>>>
> >>>> Progress supplies the ISS, but not this piece of code (read: none) ;-)
> >>>> I am more in favour of a follow-up patch on this one ...
> >>>
> >>> hmmm, I'm not a fan of merging code with this kind of a comment in it,
> >>> because it looks scary, and I dont' really understand the problem from
> >>> just reading the comment, so something needs to be done here.
> >>
> >> I see. What about we are moving this unconditionally into vgic_init_maps
> >> and allocate it for both v2 and v3 guests and get rid of the whole
> >> function? It allocates only memory for the irq_spi_mpidr, which is 4
> >> bytes per configured SPI (so at most less than 4 KB, but usually just
> >> 128 Bytes per guest). This would be a pretty quick solution. Does that
> >> sound too hackish?
> >>
> >> After your comments about the per-VM ops function pointers I am a bit
> >> reluctant to introduce another one (which would be the obvious way
> >> following the comment) for just this simple kalloc().
> >> On the other hand the ITS emulation may later make better use of a GICv3
> >> specific allocation function.
> > 
> > What I really disliked was the configuration of a function pointer,
> > which, when invoked, configured other function pointers.  That just made
> > my head spin.  So adding another per-gic-model init_maps method is not
> > that bad, but on the other hand, the only problem with keeping this here
> > is that when we restore the vgic state, then user space wants to be able
> > to populate all the date before running any VCPUs, and we don't create
> > the data structures before the first VCPU is run.
> > 
> > However, Eric has a problem with this "init-when-we-run-the-first-VCPU"
> > approach as well, so one argument is that we need to add a method to
> > both the gicv2 and gicv3 device API to say "VGIC_INIT" which userspace
> > can call after having created all the VCPUs.  And, in fact, we may want
> > to enforce this for the gicv3 right now and only maintain the existing
> > behavior for gicv2.
> > 
> > (Eric's use case is configuring IRQFD, which must logically be done
> > before running the machine, but also needs to be done after the vgic is
> > fully ready.).
> > 
> > Does this make sense?
> 
> So if we would avoid that spooky "detect-if-a-VCPU-has-run" code and
> rely on an explicit ioctl, I am in favor for this. We would need to keep
> the current approach for compatibility, though, right?

not for gicv3, only for gicv2, which is exactly why I'm bringing it up
here.

> 
> So what about we either keep the current GICv3 allocation as it stands
> in my patches right now (or move the GICv3 specific part into the
> general vgic_init_maps()) and adapt that to the VGIC_INIT call once that
> has appeared (or even handle this in that series then).
> 
> Does that make sense? What is the time frame for that VGIC_INIT call?
> 

Eric posted some patches in private yesterday, I think he's planning on
sending them out any day now.

-Christoffer
