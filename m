From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Aug 2014 15:16:01 +0100
Subject: [PATCH] arm/arm64: KVM: Support KVM_CAP_READONLY_MEM
In-Reply-To: <20140815091550.GS10550@cbox> (Christoffer Dall's message of
 "Fri, 15 Aug 2014 10:15:50 +0100")
References: <1405003351-12973-1-git-send-email-christoffer.dall@linaro.org>
 <8761hvrs4z.fsf@approximate.cambridge.arm.com>
 <20140815091550.GS10550@cbox>
Message-ID: <87bnrlrg7y.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15 2014 at 10:15:50 am BST, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Thu, Aug 14, 2014 at 04:46:20PM +0100, Marc Zyngier wrote:
>> On Thu, Jul 10 2014 at 3:42:31 pm BST, Christoffer Dall
>> <christoffer.dall@linaro.org> wrote:
>> > When userspace loads code and data in a read-only memory regions, KVM
>> > needs to be able to handle this on arm and arm64.  Specifically this is
>> > used when running code directly from a read-only flash device; the
>> > common scenario is a UEFI blob loaded with the -bios option in QEMU.
>> >
>> > To avoid looking through the memslots twice and to reuse the hva error
>> > checking of gfn_to_hva_prot(), add a new gfn_to_hva_memslot_prot()
>> > function and refactor gfn_to_hva_prot() to use this function.
>> >
>> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>> 
>> This looks good to me, but you may want to split the patch in two
>> (generic stuff, and the ARM code).
>
> sure, I can split it up.
>
>> 
>> One question though...
>> 
>
> [...]
>
>> >  
>> > @@ -882,7 +882,10 @@ int kvm_handle_guest_abort(struct kvm_vcpu
>> > *vcpu, struct kvm_run *run)
>> >  	idx = srcu_read_lock(&vcpu->kvm->srcu);
>> >  
>> >  	gfn = fault_ipa >> PAGE_SHIFT;
>> > -	if (!kvm_is_visible_gfn(vcpu->kvm, gfn)) {
>> > +	memslot = gfn_to_memslot(vcpu->kvm, gfn);
>> > +	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
>> > +	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
>> > +	if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
>> 
>> So the consequence of a write to a ROM region would be to do an IO
>> emulation? That seems a bit weird. Shouldn't we have a separate error
>> path for this (possibly ignoring the write entierely)?
>> 
>
> It's part of the ABI, see Documentation/virtual/kvm/api.txt section
> 4.35:
>
> "The latter [KVM_KVM_READONLY] can be set, if KVM_CAP_READONLY_MEM
> capability allows it, to make a new slot read-only.  In this case,
> writes to this memory will be posted to userspace as KVM_EXIT_MMIO
> exits."

Fair enough. In which case, and assuming you split the patches:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
