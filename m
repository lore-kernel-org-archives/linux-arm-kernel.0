From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Jul 2013 15:29:45 +0100
Subject: [PATCH 3/4] arm64: KVM: let other tasks run when hitting WFE
In-Reply-To: <20130719142524.GF18139@mudshark.cambridge.arm.com>
References: <1374242035-13199-1-git-send-email-marc.zyngier@arm.com>
 <1374242035-13199-4-git-send-email-marc.zyngier@arm.com>
 <20130719142524.GF18139@mudshark.cambridge.arm.com>
Message-ID: <51E94D59.9010607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/07/13 15:25, Will Deacon wrote:
> On Fri, Jul 19, 2013 at 02:53:54PM +0100, Marc Zyngier wrote:
>> So far, when a guest executes WFE (like when waiting for a spinlock
>> to become unlocked), we don't do a thing and let it run uninterrupted.
>>
>> Another option is to trap a blocking WFE and offer the opportunity
>> to the scheduler to switch to another task, potentially giving the
>> vcpu holding the spinlock a chance to run sooner.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> [...]
> 
>> +static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>  {
>> -	kvm_vcpu_block(vcpu);
>> +	if (kvm_vcpu_get_hsr(vcpu) & 1)
>> +		cond_resched();
> 
> The hardcoded `1' doesn't make it obvious that we're treating wfi and wfe
> differently. Could you use a #define for that bit in hsr.iss please?

Good point. I'll rework that part.

	M.
-- 
Jazz is not dead. It just smells funny...
