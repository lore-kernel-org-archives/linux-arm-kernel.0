From: gengdongjiu@huawei.com (gengdongjiu)
Date: Tue, 4 Jul 2017 15:04:54 +0800
Subject: [PATCH v4 1/3] arm64: kvm: support user space to detect RAS
 extension feature
In-Reply-To: <20170703082126.GC4066@cbox>
References: <1498481143-23183-1-git-send-email-gengdongjiu@huawei.com>
 <20170703082126.GC4066@cbox>
Message-ID: <dd9cf101-2ca9-f349-292e-f48204abe929@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 2017/7/3 16:21, Christoffer Dall wrote:
> On Mon, Jun 26, 2017 at 08:45:43PM +0800, Dongjiu Geng wrote:
>> Handle userspace's detection for RAS extension, because sometimes
>> the userspace needs to know the CPU's capacity
> 
> Why?  Can you please provide some more rationale.

userspace mainly want to know whether CPU has RAS extension capability to decide whether need to specify the syndrome value.
if have, userspace specify the syndrome value. otherwise, not specify the value.

James ever suggest not want userspace to know the capability, and let KVM to judge the RAS extension capability.

but I consider it again, userspace know the RAS extension capability may be better, which can avoid KVM return error if
CPU does not support RAS extension.

could you give me some suggestion that whether let userspace to know the RAS extension capability?

> 
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>>  arch/arm64/kvm/reset.c   | 11 +++++++++++
>>  include/uapi/linux/kvm.h |  1 +
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index d9e9697..1004039 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -64,6 +64,14 @@ static bool cpu_has_32bit_el1(void)
>>  	return !!(pfr0 & 0x20);
>>  }
>>  
>> +static bool kvm_arm_support_ras_extension(void)
>> +{
>> +	u64 pfr0;
>> +
>> +	pfr0 = read_system_reg(SYS_ID_AA64PFR0_EL1);
>> +	return !!(pfr0 & 0x10000000);
>> +}
> 
> Why is this specific to KVM?  This seems to reveal information about the
> underlying physical CPU, not specific to KVM at all, surely if userspace
> is really supposed to be able to figure this out, it should not be KVM
> specific.
  you are right. it should not be KVM specific, thanks for pointing it out.

> 
> Thanks,
> -Christoffer
> 
>> +
>>  /**
>>   * kvm_arch_dev_ioctl_check_extension
>>   *
>> @@ -87,6 +95,9 @@ int kvm_arch_dev_ioctl_check_extension(struct kvm *kvm, long ext)
>>  	case KVM_CAP_ARM_PMU_V3:
>>  		r = kvm_arm_support_pmu_v3();
>>  		break;
>> +	case KVM_CAP_ARM_RAS_EXTENSION:
>> +		r = kvm_arm_support_ras_extension();
>> +		break;
>>  	case KVM_CAP_SET_GUEST_DEBUG:
>>  	case KVM_CAP_VCPU_ATTRIBUTES:
>>  		r = 1;
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index f51d508..27fe556 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -883,6 +883,7 @@ struct kvm_ppc_resize_hpt {
>>  #define KVM_CAP_PPC_MMU_RADIX 134
>>  #define KVM_CAP_PPC_MMU_HASH_V3 135
>>  #define KVM_CAP_IMMEDIATE_EXIT 136
>> +#define KVM_CAP_ARM_RAS_EXTENSION 137
>>  
>>  #ifdef KVM_CAP_IRQ_ROUTING
>>  
>> -- 
>> 2.10.1
>>
> 
> .
> 
