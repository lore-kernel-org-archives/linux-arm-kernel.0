From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 12 Mar 2018 14:23:08 +0000
Subject: [PATCH v5 22/23] arm64: KVM: Allow mapping of vectors outside of
 the RAM region
In-Reply-To: <5AA2D984.5030901@arm.com>
References: <20180301155538.26860-1-marc.zyngier@arm.com>
 <20180301155538.26860-23-marc.zyngier@arm.com> <5AA2D984.5030901@arm.com>
Message-ID: <264a1a57-e71a-6319-ffe6-ba43768062bf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/18 18:59, James Morse wrote:
> Hi Marc,
> 
> On 01/03/18 15:55, Marc Zyngier wrote:
>> We're now ready to map our vectors in weird and wonderful locations.
>> On enabling ARM64_HARDEN_EL2_VECTORS, a vector slots gets allocated
>> if this hasn't been already done via ARM64_HARDEN_BRANCH_PREDICTOR
>> and gets mapped outside of the normal RAM region, next to the
>> idmap.
>>
>> That way, being able to obtain VBAR_EL2 doesn't reveal the mapping
>> of the rest of the hypervisor code.
> 
>> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
>> index 3da9e5aea936..433d13d0c271 100644
>> --- a/arch/arm64/include/asm/kvm_mmu.h
>> +++ b/arch/arm64/include/asm/kvm_mmu.h
> 
> [..]
> 
>>  
>> +/*  This is only called on a !VHE system */
>>  static inline int kvm_map_vectors(void)
>>  {
>> -	return create_hyp_mappings(kvm_ksym_ref(__bp_harden_hyp_vecs_start),
>> -				   kvm_ksym_ref(__bp_harden_hyp_vecs_end),
>> -				   PAGE_HYP_EXEC);
>> -}
>> +	phys_addr_t vect_pa = virt_to_phys(__bp_harden_hyp_vecs_start);
> 
> __pa_symbol()?
> 
> A gift from CONFIG_DEBUG_VIRTUAL:
> 
> [    3.479878] kvm [1]: 8-bit VMID
> [    3.500761] ------------[ cut here ]------------
> [    3.505608] virt_to_phys used for non-linear address: 000000006fa7ae39
> (__bp_harden_hyp_vecs_start+0x0/0x2000)
> [    3.515907] WARNING: CPU: 3 PID: 1 at ../arch/arm64/mm/physaddr.c:15
> __virt_to_phys+0x48/0x68
> [    3.524614] Modules linked in:
> [    3.527782] CPU: 3 PID: 1 Comm: swapper/0 Not tainted
> 4.16.0-rc4-00024-gf6f4460e41ba-dirty #9396
> [    3.536751] Hardware name: ARM Juno development board (r1) (DT)
> [    3.542806] pstate: 80400005 (Nzcv daif +PAN -UAO)
> [    3.547716] pc : __virt_to_phys+0x48/0x68
> [    3.551832] lr : __virt_to_phys+0x48/0x68
> 
> [    3.641447] Call trace:
> [    3.643975]  __virt_to_phys+0x48/0x68
> [    3.647739]  kvm_arch_init+0x2fc/0x734
> [    3.651589]  kvm_init+0x28/0x2b0
> [    3.654910]  arm_init+0x1c/0x24
> [    3.658143]  do_one_initcall+0x38/0x11c
> [    3.662083]  kernel_init_freeable+0x1e0/0x27c
> [    3.666552]  kernel_init+0x10/0xfc
> [    3.670049]  ret_from_fork+0x10/0x18
> [    3.673731] ---[ end trace d4ef061e4bf05fc6 ]---
> [    3.678870] kvm [1]: vgic-v2 at 2c04f000
> [    3.683424] kvm [1]: vgic interrupt IRQ1
> [    3.687675] kvm [1]: virtual timer IRQ5
> [    3.692375] kvm [1]: Hyp mode initialized successfully
> [    3.718640] Initialise system trusted keyrings
Nice catch. Fixed locally.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
