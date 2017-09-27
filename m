From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 27 Sep 2017 09:31:41 +0100
Subject: [PATCH] arm64: fix documentation on kernel pages mappings to HYP
 VA
In-Reply-To: <20170926184542.t56zpdx2s5et77gy@yury-thinkpad> (Yury Norov's
 message of "Tue, 26 Sep 2017 21:45:42 +0300")
References: <20170913180830.8608-1-ynorov@caviumnetworks.com>
 <20170926184542.t56zpdx2s5et77gy@yury-thinkpad>
Message-ID: <86bmlwo842.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26 2017 at  9:45:42 pm BST, Yury Norov <ynorov@caviumnetworks.com> wrote:
> Ping?
>
> On Wed, Sep 13, 2017 at 09:08:30PM +0300, Yury Norov wrote:
>> The Documentation/arm64/memory.txt says:
>> When using KVM, the hypervisor maps kernel pages in EL2, at a fixed
>> offset from the kernel VA (top 24bits of the kernel VA set to zero):
>> 
>> In fact, kernel addresses are transleted to HYP with kern_hyp_va macro,
>> which has more options, and none of them assumes clearing of top 24bits
>> of the kernel VA.
>> 
>> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
>> ---
>>  Documentation/arm64/memory.txt | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>> 
>> diff --git a/Documentation/arm64/memory.txt b/Documentation/arm64/memory.txt
>> index d7273a5f6456..c39895d7e3a2 100644
>> --- a/Documentation/arm64/memory.txt
>> +++ b/Documentation/arm64/memory.txt
>> @@ -86,9 +86,12 @@ Translation table lookup with 64KB pages:
>>   +-------------------------------------------------> [63] TTBR0/1
>>  
>>  
>> -When using KVM, the hypervisor maps kernel pages in EL2, at a fixed
>> -offset from the kernel VA (top 24bits of the kernel VA set to zero):
>> -
>> -Start			End			Size		Use
>> ------------------------------------------------------------------------
>> -0000004000000000	0000007fffffffff	 256GB		kernel objects mapped in HYP
>> +When using KVM without Virtualization Host Extensions, the hypervisor maps
>> +kernel pages in EL2, at a fixed offset from the kernel VA. Namely, top 16
>> +or 25 bits of the kernel VA set to zero depending on ARM64_VA_BITS_48 or
>> +ARM64_VA_BITS_39 config option selected; or top 17 or 26 bits of the kernel
>> +VA set to zero if CPU has Reduced HYP mapping offset capability. See
>> +kern_hyp_va macro.

What is this "Reduced HYP mapping offset capability"?

You're missing the point that the location of the EL2 mapping is
conditioned by the location of the identity mapping that is used to
bring up / tear down KVM. You have to express the VA transformation in
terms of both VA_BITS (and there is more cases than just 39 or 48 bits)
*and* the idmap address, not to mention the case where KVM's VA_BITS is
larger than the rest of the kernel. See the extensive blurb in
kvm_mmu.h.

>> +
>> +When using KVM with Virtualization Host Extensions, no additional mappings
>> +created as host kernel already operates in EL2.

This bit is fine.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
