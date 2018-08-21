From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Aug 2018 16:08:56 +0100
Subject: [PATCH v3 7/9] KVM: arm/arm64: Only clean the dcache on
 translation fault
In-Reply-To: <2686ddfc-935a-18e0-46bd-0cb608ae44e1@suse.de>
References: <20171023161122.15291-1-marc.zyngier@arm.com>
 <20171023161122.15291-8-marc.zyngier@arm.com>
 <bfeee11e-f8bf-78f2-ab61-27e43781e2e3@suse.de>
 <9fa7efdf-1c21-7b07-edb9-0c7d0d91eaed@arm.com>
 <2686ddfc-935a-18e0-46bd-0cb608ae44e1@suse.de>
Message-ID: <4d1c7d3b-4abe-fa8d-31ac-7a98ec349db1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/08/18 15:08, Alexander Graf wrote:
> On 08/21/2018 03:57 PM, Marc Zyngier wrote:
>> On 21/08/18 14:35, Alexander Graf wrote:
>>> On 10/23/2017 06:11 PM, Marc Zyngier wrote:
>>>> The only case where we actually need to perform a dcache maintenance
>>>> is when we map the page for the first time, and subsequent permission
>>>> faults do not require cache maintenance. Let's make it conditional
>>>> on not being a permission fault (and thus a translation fault).
>>>>
>>>> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> This patch unfortunately breaks something on Hi1616 SoCs when running
>>> 32bit guests. With this patch applied (and thus with 4.18) I get random
>>> illegal instruction warnings from 32bit code inside VMs. I do not know
>>> at this point whether this affects other CPUs as well.
>> Can you please give a few more details?
>>
>> - what are the CPUs on this Hi1616? At least a /proc/cpuinfo would help
> 
> These are A72s:
> 
> processor??? : 0
> BogoMIPS??? : 100.00
> Features??? : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
> CPU implementer??? : 0x41
> CPU architecture: 8
> CPU variant??? : 0x0
> CPU part??? : 0xd08
> CPU revision??? : 2
> 
>>
>> - an example of the crash? Is it within the decompressor? After? This
>> things do matter, given the number of crazy things the 32bit kernel does
> 
> They are always in user space. My current reproducer is this:
> 
>  ? $ while rpm -qa > /dev/null; do :; done
> 
> If I run this in parallel with something that just populates RAM (dd 
> if=/dev/nvme0n1 of=/dev/null bs=10G) I get an illegal instruction fault 
> within seconds:
> 
> sh-4.4# while rpm -qa > /dev/null; do true; done
> Illegal instruction (core dumped)
> 
> 
>> - a host kernel configuration?
> 
> Host kernel configuration is just the normal openSUSE one:
> 
> https://kernel.opensuse.org/cgit/kernel-source/plain/config/arm64/default?h=stable
> 
>>> If anyone is interested in a reproducer, I have something handy. But for
>>> now I believe we should just revert this patch.
>> Before we revert anything, I'd like to understand what is happening.
> 
> Yeah, I didn't realize the commit is already in since 4.16, so I agree. 
> I'll bisect a bit, but it may take a while.

Do you mind giving this a try?

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 1d90d79706bd..df8f3d5eaa22 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1531,7 +1536,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			kvm_set_pfn_dirty(pfn);
 		}
 
-		if (fault_status != FSC_PERM)
+		if (fault_status != FSC_PERM || write_fault)
 			clean_dcache_guest_page(pfn, PMD_SIZE);
 
 		if (exec_fault) {
@@ -1553,7 +1558,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			mark_page_dirty(kvm, gfn);
 		}
 
-		if (fault_status != FSC_PERM)
+		if (fault_status != FSC_PERM || write_fault)
 			clean_dcache_guest_page(pfn, PAGE_SIZE);
 
 		if (exec_fault) {


The missing logic is that a write from the guest could have triggered
a CoW, meaning we definitely need to flush it in that case too. It
fixes a kvm-unit-test regression here.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
