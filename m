From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Feb 2016 16:00:10 +0000
Subject: [PATCH v2 16/28] ARM: KVM: Add the new world switch implementation
In-Reply-To: <20160209184455.GT5171@cbox>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-17-git-send-email-marc.zyngier@arm.com>
 <20160209184455.GT5171@cbox>
Message-ID: <56BB5E8A.5030103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/16 18:44, Christoffer Dall wrote:
> On Thu, Feb 04, 2016 at 11:00:33AM +0000, Marc Zyngier wrote:
>> The new world switch implementation is modeled after the arm64 one,
>> calling the various save/restore functions in turn, and having as
>> little state as possible.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/kvm/hyp/Makefile |   1 +
>>  arch/arm/kvm/hyp/hyp.h    |   7 +++
>>  arch/arm/kvm/hyp/switch.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 144 insertions(+)
>>  create mode 100644 arch/arm/kvm/hyp/switch.c
>>
>> diff --git a/arch/arm/kvm/hyp/Makefile b/arch/arm/kvm/hyp/Makefile
>> index c779690..cfab402 100644
>> --- a/arch/arm/kvm/hyp/Makefile
>> +++ b/arch/arm/kvm/hyp/Makefile
>> @@ -9,3 +9,4 @@ obj-$(CONFIG_KVM_ARM_HOST) += vgic-v2-sr.o
>>  obj-$(CONFIG_KVM_ARM_HOST) += vfp.o
>>  obj-$(CONFIG_KVM_ARM_HOST) += banked-sr.o
>>  obj-$(CONFIG_KVM_ARM_HOST) += entry.o
>> +obj-$(CONFIG_KVM_ARM_HOST) += switch.o
>> diff --git a/arch/arm/kvm/hyp/hyp.h b/arch/arm/kvm/hyp/hyp.h
>> index b3f6ed2..2ca651f 100644
>> --- a/arch/arm/kvm/hyp/hyp.h
>> +++ b/arch/arm/kvm/hyp/hyp.h
>> @@ -60,11 +60,16 @@
>>  #define CNTV_CVAL	__ACCESS_CP15_64(3, c14)
>>  #define CNTVOFF		__ACCESS_CP15_64(4, c14)
>>  
>> +#define MIDR		__ACCESS_CP15(c0, 0, c0, 0)
>>  #define CSSELR		__ACCESS_CP15(c0, 2, c0, 0)
>> +#define VMIDR		__ACCESS_CP15(c0, 4, c0, 0)
> 
> Nit: This is called VPIDR in v7 and VMPIDR_EL2 in v8 IIUC.  Should we
> refer to it by one of those names instead?

Seems to be VPIDR in all cases, actually (I stupidly made it consistent,
silly me!). I'll definitely fix that, thanks for noticing it!

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
