From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 26 Feb 2014 18:18:20 +0000
Subject: [PATCH 17/18] KVM: ARM: vgic: add the GICv3 backend
In-Reply-To: <20140225180756.GJ23136@mudshark.cambridge.arm.com>
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
 <1391607050-540-18-git-send-email-marc.zyngier@arm.com>
 <20140225180756.GJ23136@mudshark.cambridge.arm.com>
Message-ID: <530E2FEC.8090205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/02/14 18:07, Will Deacon wrote:
> On Wed, Feb 05, 2014 at 01:30:49PM +0000, Marc Zyngier wrote:
>> Introduce the support code for emulating a GICv2 on top of GICv3
>> hardware.
>>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  include/kvm/arm_vgic.h |  26 ++++++
>>  virt/kvm/arm/vgic-v3.c | 220 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  virt/kvm/arm/vgic.c    |   2 +
>>  3 files changed, 248 insertions(+)
>>  create mode 100644 virt/kvm/arm/vgic-v3.c
>>
>> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
>> index c95039a..caeb8f4 100644
>> --- a/include/kvm/arm_vgic.h
>> +++ b/include/kvm/arm_vgic.h
>> @@ -32,6 +32,7 @@
>>  #define VGIC_NR_SHARED_IRQS	(VGIC_NR_IRQS - VGIC_NR_PRIVATE_IRQS)
>>  #define VGIC_MAX_CPUS		KVM_MAX_VCPUS
>>  #define VGIC_MAX_LRS		(1 << 6)
>> +#define VGIC_V3_MAX_LRS		16
> 
> Since we have fewer list registers, doesn't the code in vgic.c need updating
> to honour the relevant bounds? (e.g. the use of find_first_zero_bit in
> vgic_queue_irq).

I'm confused. We've always used a variable, as even with GICv2, we
usually have far less list registers than the maximum (4 vs 64). Looking
at the code you mention, I see this:

	/* Try to use another LR for this interrupt */
	lr = find_first_zero_bit((unsigned long *)vgic_cpu->lr_used,
			       vgic->nr_lr);

Am I looking at the wrong place?

	M.
-- 
Jazz is not dead. It just smells funny...
