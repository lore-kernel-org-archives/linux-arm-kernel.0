From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 17 Nov 2014 13:58:05 +0000
Subject: [PATCH v4 15/19] arm/arm64: KVM: add virtual GICv3 distributor
 emulation
In-Reply-To: <20141114110720.GP19598@cbox>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-16-git-send-email-andre.przywara@arm.com>
 <20141114110720.GP19598@cbox>
Message-ID: <5469FEED.5010706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hej Christoffer,

maybe I just don't see the wood for the trees, so I will explain my view
on the things below. Please correct me / explain your view!

On 14/11/14 11:07, Christoffer Dall wrote:
> On Fri, Nov 14, 2014 at 10:07:59AM +0000, Andre Przywara wrote:
>> With everything separated and prepared, we implement a model of a
>> GICv3 distributor and redistributors by using the existing framework
>> to provide handler functions for each register group.
>>
>> Currently we limit the emulation to a model enforcing a single
>> security state, with SRE==1 (forcing system register access) and
>> ARE==1 (allowing more than 8 VCPUs).
>>
>> We share some of the functions provided for GICv2 emulation, but take
>> the different ways of addressing (v)CPUs into account.
>> Save and restore is currently not implemented.
>>
>> Similar to the split-off of the GICv2 specific code, the new emulation
>> code goes into a new file (vgic-v3-emul.c).
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> ??...??
>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>> index 335ffe0..b7de0f8 100644
>> --- a/virt/kvm/arm/vgic.c
>> +++ b/virt/kvm/arm/vgic.c
>> @@ -1249,7 +1249,7 @@ static bool vgic_update_irq_pending(struct kvm *kvm, int cpuid,
>>  	struct kvm_vcpu *vcpu;
>>  	int edge_triggered, level_triggered;
>>  	int enabled;
>> -	bool ret = true;
>> +	bool ret = true, can_inject = true;
>>  
>>  	spin_lock(&dist->lock);
>>  
>> @@ -1264,6 +1264,11 @@ static bool vgic_update_irq_pending(struct kvm *kvm, int cpuid,
>>  
>>  	if (irq_num >= VGIC_NR_PRIVATE_IRQS) {
>>  		cpuid = dist->irq_spi_cpu[irq_num - VGIC_NR_PRIVATE_IRQS];
>> +		if (cpuid == VCPU_NOT_ALLOCATED) {
>> +			/* Pretend we use CPU0, and prevent injection */
>> +			cpuid = 0;
>> +			can_inject = false;
>> +		}
>>  		vcpu = kvm_get_vcpu(kvm, cpuid);
>>  	}
>>  
>> @@ -1285,7 +1290,7 @@ static bool vgic_update_irq_pending(struct kvm *kvm, int cpuid,
>>  
>>  	enabled = vgic_irq_is_enabled(vcpu, irq_num);
>>  
>> -	if (!enabled) {
>> +	if (!enabled || !can_inject) {
>>  		ret = false;
>>  		goto out;
>>  	}
> 
> As I wrote, I think this is wrong.  What happened here?

can_inject is just a way for stopping "non-targeted" SPIs to be
_injected_. The spec says in "5.3.4. GICD_IROUTERn":

"If this register is programmed to forward the corresponding interrupt
to a specific processor (i.e. IRM is zero) and the affinity path does
not correspond to an implemented processor, then if the corresponding
interrupt becomes pending it will not be forwarded to any processor and
will remain pending."

So we can happily make these SPIs pending, but an illegal irq_spi_cpu[]
entry will just avoid it to be injected, right?

What am I missing?

Do you want a comment here explaining this?

Cheers,
Andre.
