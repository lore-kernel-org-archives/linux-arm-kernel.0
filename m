From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 8 May 2017 13:21:53 +0200
Subject: [PATCH v7 01/24] KVM: arm/arm64: Add ITS save/restore API
 documentation
In-Reply-To: <6ca05e9e-2a40-fc30-36d0-359d9a4ff172@arm.com>
References: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
 <1494084283-12723-2-git-send-email-eric.auger@redhat.com>
 <87inlclw4t.fsf@on-the-bus.cambridge.arm.com>
 <c2e1492b-bfb3-d8de-ca7a-0f925093f713@redhat.com>
 <6ca05e9e-2a40-fc30-36d0-359d9a4ff172@arm.com>
Message-ID: <20170508112153.GA28342@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 08, 2017 at 10:14:21AM +0100, Marc Zyngier wrote:
> On 07/05/17 18:05, Auger Eric wrote:
> > Hi Marc,
> > 
> > On 07/05/2017 13:54, Marc Zyngier wrote:
> >> On Sat, May 06 2017 at  4:24:20 pm BST, Eric Auger <eric.auger@redhat.com> wrote:
> >>> Add description for how to access ITS registers and how to save/restore
> >>> ITS tables into/from memory.
> >>>
> >>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>
> >>> ---
> >>> v6 -> v7:
> >>> - rephrase ordering sequence + few cosmetic changes
> >>>
> >>> v5 -> v6:
> >>> - add restoration ordering
> >>> - 256B -> 256 Byte aligned
> >>> - DTE Size is number of bits for the EVENTID
> >>> - s/GITS_READR/GITS_CREADR
> >>>
> >>> v4 -> v5:
> >>> - take into account Christoffer's comments
> >>> - pending table save on GICV3 side now
> >>>
> >>> v3 -> v4:
> >>> - take into account Peter's comments:
> >>>   - typos
> >>>   - KVM_DEV_ARM_VGIC_GRP_ITS_TABLES kvm_device_attr = 0
> >>>   - add a validity bit in DTE
> >>>   - document all fields in CTE and ITE
> >>>   - document ABI revision
> >>> - take into account Andre's comments:
> >>>   - document restrictions about GITS_CREADR writing and GITS_IIDR
> >>>   - document -EBUSY error if one or more VCPUS are runnning
> >>>   - document 64b registers only can be accessed with 64b access
> >>> - itt_addr field matches bits [51:8] of the itt_addr
> >>>
> >>> v1 -> v2:
> >>> - DTE and ITE now are 8 bytes
> >>> - DTE and ITE now indexed by deviceid/eventid
> >>> - use ITE name instead of ITTE
> >>> - mentions ITT_addr matches bits [51:8] of the actual address
> >>> - mentions LE layout
> >>> ---
> >>>  Documentation/virtual/kvm/devices/arm-vgic-its.txt | 120 +++++++++++++++++++++
> >>>  1 file changed, 120 insertions(+)
> >>>
> >>> diff --git a/Documentation/virtual/kvm/devices/arm-vgic-its.txt b/Documentation/virtual/kvm/devices/arm-vgic-its.txt
> >>> index 6081a5b..ba132e9 100644
> >>> --- a/Documentation/virtual/kvm/devices/arm-vgic-its.txt
> >>> +++ b/Documentation/virtual/kvm/devices/arm-vgic-its.txt
> >> [...]
> >>
> >>> + ITS Table ABI REV0:
> >>> + -------------------
> >>> +
> >>> + Revision 0 of the ABI only supports physical LPIs.
> >>
> >> Nit: these are no more physical than any other interrupt that KVM deals
> >> with. If you're hinting at the lack of GICv4 support, it wouldn't
> >> necessarily invalidate this ABI. It is actually even likely that the ABI
> >> could stay the same (until we start supporting GICv4 in a nested
> >> configuration).
> > I understood vLPI are associated to vPE and not to collections. As such
> > ITE would need to be updated, wouldn't it?
> 
> Even in a GICv4 setup (and ignoring nesting), a guest would only see a
> normal GICv3, as all the GICv4 state is the hypervisor's business, and
> not something meaningful to the guest. Also, it is very desirable to be
> able to migrate a GICv4 setup to a GICv3 setup without breaking everything.
> 
> To precisely answer your question, the VPE setup is done by finding out
> which collection is mapped to which vcpu, and using that to map VLPIs to
> VPEs. None of that is observable by the guest.
> 

Doesn't GICv4 hardware has state to configure the virtual interrupt
injection, which we must model if the guest hypervisor should think it
runs on a GICv4 system and uses direct interrupt injection?

For example, the vPE table entries could be cached by the ITS and would
therefore need to be flushed if presenting a GICv4 to the guest.

To clarify:  I understand this comment to be about what we present to
the guest, a GICv3 or a GICv4, and doesn't affect whether or not we run
on a physical GICv3 or GICv4, so when Eric says 'physical LPIs' here, he
really means 'physical from the point of view of the VM', which are of
course virtual, but are physical in the virtual emulated GICv3.

I tried to clarify this in a fix I will send shortly.

> >>
> >>> +
> >>> + The device table and ITT are indexed by the deviceid and eventid,
> >>> + respectively. The collection table is not indexed by collectionid:
> >>> + CTEs are written in the table in the order of collection creation. All
> >>
> >> Is this order really relevant? Can we relax it? Would something break if
> >> collections were in a random order?
> > Christoffer asked me to mention the exact storage order or at least I
> > understood his comment that way. Nothing would break if we change the order.
> 
> OK. If that's not a requirement, then we should probably drop it.
> 
> Christoffer, what do you think?
> 
Yes, we should drop it.  I have a fix for this in my queue.

Thanks,
-Christoffer
