From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 15 Aug 2013 09:53:44 -0700
Subject: [PATCH] ARM64: KVM: Fix coherent_icache_guest_page() for host
 with external L3-cache.
In-Reply-To: <5935339137684ecf90dd484cc5739548@www.loen.fr>
References: <1376480832-18705-1-git-send-email-pranavkumar@linaro.org>
 <f8917fe8409b1fae634c7de45e34d4a7@www.loen.fr>
 <CAAhSdy2TctgKk7m48S7jUCMr2dkDoeyT-r=-SMX+_Ce-sUimYA@mail.gmail.com>
 <da83e967f5a266ca28ee54638a4a9be9@www.loen.fr>
 <CAAhSdy3-+tJ34QQgieifo931pfGoYt3RAqr8OkVtkxO6jgGdHQ@mail.gmail.com>
 <3ebe469fcf451cc7396dd2a5d3f01272@www.loen.fr>
 <CAAhSdy3WwZcLW6s05mV=Mn8=w8TcubTdYrgNqAChqiHxXC53eg@mail.gmail.com>
 <747a0675165da4ef147bbda4e140549b@www.loen.fr>
 <CAAhSdy3t1B_94qiYiLeR2-imQU0KCct6+76kjW_FS=QgAtTb3g@mail.gmail.com>
 <5935339137684ecf90dd484cc5739548@www.loen.fr>
Message-ID: <20130815165344.GA3853@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 04:37:27PM +0100, Marc Zyngier wrote:
> On 2013-08-15 16:13, Anup Patel wrote:
> > Hi Marc,
> >
> > On Thu, Aug 15, 2013 at 8:17 PM, Marc Zyngier <marc.zyngier@arm.com> 
> > wrote:
> >> On 2013-08-15 14:31, Anup Patel wrote:
> >>>
> >>> On Thu, Aug 15, 2013 at 2:01 PM, Marc Zyngier 
> >>> <marc.zyngier@arm.com>
> >>> wrote:
> >>>>
> >>>> On 2013-08-15 07:26, Anup Patel wrote:
> >>>>>
> >>>>>
> >>>>> Hi Marc,
> >>>>>
> >>>>> On Thu, Aug 15, 2013 at 10:22 AM, Marc Zyngier 
> >>>>> <marc.zyngier@arm.com>
> >>>>> wrote:
> >>>>>>
> >>>>>>
> >>>>>> Hi Anup,
> >>>>>>
> >>>>>>
> >>>>>> On 2013-08-14 15:22, Anup Patel wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On Wed, Aug 14, 2013 at 5:34 PM, Marc Zyngier 
> >>>>>>> <marc.zyngier@arm.com>
> >>>>>>> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Hi Pranav,
> >>>>>>>>
> >>>>>>>> On 2013-08-14 12:47, Pranavkumar Sawargaonkar wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Systems with large external L3-cache (few MBs), might have 
> >>>>>>>>> dirty
> >>>>>>>>> content belonging to the guest page in L3-cache. To tackle 
> >>>>>>>>> this,
> >>>>>>>>> we need to flush such dirty content from d-cache so that 
> >>>>>>>>> guest
> >>>>>>>>> will see correct contents of guest page when guest MMU is 
> >>>>>>>>> disabled.
> >>>>>>>>>
> >>>>>>>>> The patch fixes coherent_icache_guest_page() for external 
> >>>>>>>>> L3-cache.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Pranavkumar Sawargaonkar 
> >>>>>>>>> <pranavkumar@linaro.org>
> >>>>>>>>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> >>>>>>>>> ---
> >>>>>>>>>  arch/arm64/include/asm/kvm_mmu.h |    2 ++
> >>>>>>>>>  1 file changed, 2 insertions(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/arch/arm64/include/asm/kvm_mmu.h
> >>>>>>>>> b/arch/arm64/include/asm/kvm_mmu.h
> >>>>>>>>> index efe609c..5129038 100644
> >>>>>>>>> --- a/arch/arm64/include/asm/kvm_mmu.h
> >>>>>>>>> +++ b/arch/arm64/include/asm/kvm_mmu.h
> >>>>>>>>> @@ -123,6 +123,8 @@ static inline void
> >>>>>>>>> coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
> >>>>>>>>>       if (!icache_is_aliasing()) {            /* PIPT */
> >>>>>>>>>               unsigned long hva = gfn_to_hva(kvm, gfn);
> >>>>>>>>>               flush_icache_range(hva, hva + PAGE_SIZE);
> >>>>>>>>> +             /* Flush d-cache for systems with external 
> >>>>>>>>> caches. */
> >>>>>>>>> +             __flush_dcache_area((void *) hva, PAGE_SIZE);
> >>>>>>>>>       } else if (!icache_is_aivivt()) {       /* non 
> >>>>>>>>> ASID-tagged
> >>>>>>>>> VIVT
> >>>>>>>>> */
> >>>>>>>>>               /* any kind of VIPT cache */
> >>>>>>>>>               __flush_icache_all();
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> [adding Will to the discussion as we talked about this in the 
> >>>>>>>> past]
> >>>>>>>>
> >>>>>>>> That's definitely an issue, but I'm not sure the fix is to hit 
> >>>>>>>> the
> >>>>>>>> data
> >>>>>>>> cache on each page mapping. It looks overkill.
> >>>>>>>>
> >>>>>>>> Wouldn't it be enough to let userspace do the cache cleaning?
> >>>>>>>> kvmtools
> >>>>>>>> knows which bits of the guest memory have been touched, and 
> >>>>>>>> can do a
> >>>>>>>> "DC
> >>>>>>>> DVAC" on this region.
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> It seems a bit unnatural to have cache cleaning is user-space. 
> >>>>>>> I am
> >>>>>>> sure
> >>>>>>> other architectures don't have such cache cleaning in 
> >>>>>>> user-space for
> >>>>>>> KVM.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> The alternative is do it in the kernel before running any vcpu 
> >>>>>>>> - but
> >>>>>>>> that's not very nice either (have to clean the whole of the 
> >>>>>>>> guest
> >>>>>>>> memory, which makes a full dcache clean more appealing).
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> Actually, cleaning full d-cache by set/way upon first run of 
> >>>>>>> VCPU was
> >>>>>>> our second option but current approach seemed very simple hence
> >>>>>>> we went for this.
> >>>>>>>
> >>>>>>> If more people vote for full d-cache clean upon first run of 
> >>>>>>> VCPU then
> >>>>>>> we should revise this patch.
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> Can you please give the attached patch a spin on your HW? I've
> >>>>>> boot-tested
> >>>>>> it on a model, but of course I can't really verify that it fixes 
> >>>>>> your
> >>>>>> issue.
> >>>>>>
> >>>>>> As far as I can see, it should fix it without any additional 
> >>>>>> flushing.
> >>>>>>
> >>>>>> Please let me know how it goes.
> >>>>>
> >>>>>
> >>>>>
> >>>>> HCR_EL2.DC=1 means all memory access for Stage1 MMU off are
> >>>>> treated as "Normal Non-shareable, Inner Write-Back 
> >>>>> Write-Allocate,
> >>>>> Outer Write-Back Write-Allocate memory"
> >>>>>
> >>>>> HCR_EL2.DC=0 means all memory access for Stage1 MMU off are
> >>>>> treated as "Strongly-ordered device memory"
> >>>>>
> >>>>> Now if Guest/VM access hardware MMIO devices directly (such as
> >>>>> VGIC CPU interface) with MMU off then MMIO devices will be
> >>>>> accessed as normal memory when HCR_EL2.DC=1.
> >>>>
> >>>>
> >>>>
> >>>> I don't think so. Stage-2 still applies, and should force MMIO to 
> >>>> be
> >>>> accessed as device memory.
> >>>>
> >>>>
> >>>>> The HCR_EL2.DC=1 makes sense only if we have all software
> >>>>> emulated devices for Guest/VM which is not true for KVM ARM or
> >>>>> KVM ARM64 because we use VGIC.
> >>>>>
> >>>>> IMHO, this patch enforces incorrect memory attribute for Guest/VM
> >>>>> when Stage1 MMU is off.
> >>>>
> >>>>
> >>>>
> >>>> See above. My understanding is that HCR.DC controls the default 
> >>>> output of
> >>>> Stage-1, and Stage-2 overrides still apply.
> >>>
> >>>
> >>> You had mentioned that PAGE_S2_DEVICE attribute was redundant
> >>> and wanted guest to decide the memory attribute. In other words, 
> >>> you
> >>> did not want to enforce any memory attribute in Stage2.
> >>>
> >>> Please refer to this patch 
> >>> https://patchwork.kernel.org/patch/2543201/
> >>
> >>
> >> This patch has never been merged. If you carry on following the 
> >> discussion,
> >> you will certainly notice it was dropped for a very good reason:
> >> https://lists.cs.columbia.edu/pipermail/kvmarm/2013-May/005827.html
> >>
> >> So Stage-2 memory attributes are used, they are not going away, and 
> >> they are
> >> essential to the patch I sent this morning.
> >>
> >>
> >>         M.
> >> --
> >> Fast, cheap, reliable. Pick two.
> >
> > HCR_EL2.DC=1 will break Guest/VM bootloader/firmware if the Guest/VM 
> > is
> > provided a DMA-capable device in pass-through mode. The reason being
> > bootloader/firmware typically don't enable MMU and such 
> > bootloader/firmware
> > will programme a pass-through DMA-capable device without any flushes 
> > to
> > guest RAM (because it has not enabled MMU).
> >
> > A good example of such a device would be SATA AHCI controller given 
> > to a
> > Guest/VM as direct access (using SystemMMU) and Guest 
> > bootloader/firmware
> > accessing this SATA AHCI controller to load kernel images from SATA 
> > disk.
> > In this situation, we will have to hack Guest bootloader/firmware
> > AHCI driver to
> > explicitly flushes to Guest RAM (because have HCR_EL2.DC=1).
> 
> OK. So *that* looks like a valid argument against HCR_EL2.DC==1. Out of 
> curiosity: is that a made up example or something you actually have?
> 
> Back to square one:
> Can you please benchmark the various cache cleaning options (global at 
> startup time, per-page on S2 translation fault, and user-space)?
> 
Eh, why is this a more valid argument than the vgic?  The device
passthrough Stage-2 mappings would still have the Stage-2 memory
attributes to configure that memory region as device memory.  Why is it
relevant if the device is DMA-capable in this context?

-Christoffer
