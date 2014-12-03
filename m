From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 3 Dec 2014 12:06:56 +0100
Subject: [PATCH v4 15/19] arm/arm64: KVM: add virtual GICv3 distributor
 emulation
In-Reply-To: <547EEA46.9000607@arm.com>
References: <20141123143841.GB3401@cbox> <5473562E.7060303@arm.com>
 <20141125104129.GC31297@cbox> <5478939B.8010103@arm.com>
 <20141130083014.GA82106@macair> <547DE7D5.5020205@arm.com>
 <547DF181.8060402@arm.com> <547DF7BD.1000503@arm.com>
 <20141203103056.GC17502@cbox> <547EEA46.9000607@arm.com>
Message-ID: <20141203110656.GH17502@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 10:47:34AM +0000, Andre Przywara wrote:
> 
> 
> On 03/12/14 10:30, Christoffer Dall wrote:
> > On Tue, Dec 02, 2014 at 05:32:45PM +0000, Andre Przywara wrote:
> >> On 02/12/14 17:06, Marc Zyngier wrote:
> >>> On 02/12/14 16:24, Andre Przywara wrote:
> >>>> Hej Christoffer,
> >>>>
> >>>> On 30/11/14 08:30, Christoffer Dall wrote:
> >>>>> On Fri, Nov 28, 2014 at 03:24:11PM +0000, Andre Przywara wrote:
> >>>>>> Hej Christoffer,
> >>>>>>
> >>>>>> On 25/11/14 10:41, Christoffer Dall wrote:
> >>>>>>> Hi Andre,
> >>>>>>>
> >>>>>>> On Mon, Nov 24, 2014 at 04:00:46PM +0000, Andre Przywara wrote:
> >>>>>>>
> >>>>>>
> >>>>
> >>>> [...]
> >>>>
> >>>>>>>>>> +
> >>>>>>>>>> +     if (!is_in_range(mmio->phys_addr, mmio->len, rdbase,
> >>>>>>>>>> +         GIC_V3_REDIST_SIZE * nrcpus))
> >>>>>>>>>> +             return false;
> >>>>>>>>>
> >>>>>>>>> Did you think more about the contiguous allocation issue here or can you
> >>>>>>>>> give me a pointer to the requirement in the spec?
> >>>>>>>>
> >>>>>>>> 5.4.1 Re-Distributor Addressing
> >>>>>>>>
> >>>>>>>
> >>>>>>> Section 5.4.1 talks about the pages within a single re-distributor having
> >>>>>>> to be contiguous, not all the re-deistributor regions having to be
> >>>>>>> contiguous, right?
> >>>>>>
> >>>>>> Ah yes, you are right. But I still think it does not matter:
> >>>>>> 1) We are "implementing" the GICv3. So as the spec does not forbid this,
> >>>>>> we just state that the redistributor register maps for each VCPU are
> >>>>>> contiguous. Also we create the FDT accordingly. I will add a comment in
> >>>>>> the documentation to state this.
> >>>>>>
> >>>>>> 2) The kernel's GICv3 DT bindings assume this allocation is the default.
> >>>>>> Although Marc added bindings to work around this (stride), it seems much
> >>>>>> more logical to me to not use it.
> >>>>>
> >>>>> I don't disagree (and never have) with the fact that it is up to us to
> >>>>> decide.
> >>>>>
> >>>>> My original question, which we haven't talked about yet, is if it is
> >>>>> *reasonable* to assume that all re-distributor regions will always be
> >>>>> contiguous?
> >>>>>
> >>>>> How will you handle VCPU hotplug for example?
> >>>>
> >>>> As kvmtool does not support hotplug, I haven't thought about this yet.
> >>>> To me it looks like userland should just use maxcpus for the allocation.
> >>>> If I get the current QEMU code right, there is room for 127 GICv3 VCPUs
> >>>> (2*64K per VCPU + 64K for the distributor in 16M space) at the moment.
> >>>> Kvmtool uses a different mapping, which allows to share 1G with virtio,
> >>>> so the limit is around 8000ish VCPUs here.
> >>>> Are there any issues with changing the QEMU virt mapping later?
> >>>> Migration, maybe?
> >>>> If the UART, the RTC and the virtio regions are moved more towards the
> >>>> beginning of the 256MB PCI mapping, then there should be space for a bit
> >>>> less than 1024 VCPUs, if I get this right.
> >>>>
> >>>>> Where in the guest
> >>>>> physical memory map of our various virt machines should these regions
> >>>>> sit so that we can allocate anough re-distributors for VCPUs etc.?
> >>>>
> >>>> Various? Are there other mappings than those described in hw/arm/virt.c?
> >>>>
> >>>>> I just want to make sure we're not limiting ourselves by some amount of
> >>>>> functionality or ABI (redistributor base addresses) that will be hard to
> >>>>> expand in the future.
> >>>>
> >>>> If we are flexible with the mapping at VM creation time, QEMU could just
> >>>> use a mapping depending on max_cpus:
> >>>> < 128 VCPUs: use the current mapping
> >>>> 128 <= x < 1020: use a more compressed mapping
> >>>>> = 1020: map the redistributor somewhere above 4 GB
> >>>>
> >>>> As the device tree binding for GICv3 just supports a stride value, we
> >>>> don't have any other real options beside this, right? So how I see this,
> >>>> a contiguous mapping (with possible holes) is the only way.
> >>>
> >>> Not really. The GICv3 binding definitely supports having several regions
> >>> for the redistributors (see the binding documentation). This allows for
> >>> the pathological case where you have N regions for N CPUs. Not that we
> >>> ever want to go there, really.
> >>
> >> Ah yes, thanks for pointing that out. I was mixing this up with the
> >> stride parameter, which is independent of this. Sorry for that.
> >>
> >> So from a userland point of view we probably would like to have the
> >> first n VCPU's redistributors mapped at their current places and allow
> >> for more VCPUs to use memory above 4 GB.
> >> Which would require quite some changes to the code to support this in a
> >> very flexible way. I think this could be much easier if we confine
> >> ourselves to two regions (one contiguous lower (< 4 GB) and one
> >> contiguous upper region (>4 GB)), so we don't need to support arbitrary
> >> per VCPU addresses, but could just use the 1st or 2nd map depending on
> >> the VCPU number.
> >> Is this too hackish?
> >> If not, I would add another vgic_addr type (like
> >> KVM_VGIC_V3_ADDR_TYPE_REDIST_UPPER or so) to be used from userland and
> >> use that in the handle_mmio region detection.
> >> Let me know if that sounds reasonable.
> >>
> > The point that I've been trying to make sure we think about is if we'll
> > regret not being able to fragment the redistributor regions a bit.  Even
> > if it's technically possible, we may regret requiring a huge contigous
> > allocation in the guest physical address space.  But maybe we don't care
> > when we have 40 bits to play with?
> 
> 40 bits are more than enough. But are we OK with using only memory above
> 4GB? Is there some code before the Linux kernel that is limited to 4GB?
> I am thinking about 32bit guests in particular, which may have some
> firmware blob executed before which may not use the MMU.
> 
> If this is not an issue, I'd rather stay with one contiguous region - at
> least for the itme being. The current GICv3 code has a limit of 255
> VCPUs anyway, so this requires at most 32MB, which should be easily
> fitted anywhere.
> 
> Should we later need to extend the number of VCPUs, we can in the worst
> case adjust the code to support split regions if the 4GB limit issue
> persists. This would be done via a new KVM capability and some new
> register groups in the KVM device ioctl to set a second (or following)
> region, so in a backwards compatible way.
> 
ok, sounds reasonable.  I'll shut up then.

Thanks,
-Christoffer
