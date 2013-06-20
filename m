From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Jun 2013 09:13:22 +0100
Subject: [PATCH 3/5] ARM: KVM: make sure maintainance operation complete
 before world switch
In-Reply-To: <20130620001820.GJ7870@lvm>
References: <1371648006-8036-1-git-send-email-marc.zyngier@arm.com>
 <1371648006-8036-4-git-send-email-marc.zyngier@arm.com>
 <20130620001820.GJ7870@lvm>
Message-ID: <51C2B9A2.1020401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/13 01:18, Christoffer Dall wrote:
> On Wed, Jun 19, 2013 at 02:20:04PM +0100, Marc Zyngier wrote:
>> We may have preempted the guest while it was performing a maintainance
>> operation (TLB invalidation, for example). Make sure it completes
>> before we do anything else by adding the necessary barriers.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/kvm/interrupts.S | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
>> index afa6c04..3124e0f 100644
>> --- a/arch/arm/kvm/interrupts.S
>> +++ b/arch/arm/kvm/interrupts.S
>> @@ -149,6 +149,15 @@ __kvm_vcpu_return:
>>  	 * r0: vcpu pointer
>>  	 * r1: exception code
>>  	 */
>> +
>> +	/*
>> +	 * We may have preempted the guest while it was performing a
>> +	 * maintainance operation (TLB invalidation, for example). Make
>> +	 * sure it completes before we do anything else.
>> +	 */
> 
> Can you explain what could go wrong here without these two instructions?

There would be no guarantee that the TLB invalidation has effectively
completed, and is visible by other CPUs. Not sure that would be a
massive issue in any decent guest OS, but I thought it was worth plugging.

Another (more serious) thing I had doubts about was that we're about to
switch VMID to restore the host context. The ARM ARM doesn't clearly
specify the interaction between pending TLB maintainance and VMID
switch, and I'm worried that you could end up performing the TLB
maintainance on the *host* TLBs rather than on the guest's.

Having this dsb/isb sequence before switching VMID gives us a strong
guarantee that such a mixup cannot occur.

	M.
-- 
Jazz is not dead. It just smells funny...
