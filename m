From: gengdongjiu@huawei.com (gengdongjiu)
Date: Tue, 5 Sep 2017 15:18:19 +0800
Subject: [PATCH v6 4/7] arm64: kvm: support user space to query RAS
 extension feature
In-Reply-To: <59A84F9D.8030309@arm.com>
References: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
 <1503916701-13516-5-git-send-email-gengdongjiu@huawei.com>
 <59A84F9D.8030309@arm.com>
Message-ID: <29951852-8d91-7c33-c68b-ad8b4bbdea54@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

James,

On 2017/9/1 2:04, James Morse wrote:
> Hi Dongjiu Geng,
> 
> On 28/08/17 11:38, Dongjiu Geng wrote:
>> In ARMV8.2 RAS extension, a virtual SError exception syndrome
>> register(VSESR_EL2) is added.  This value may be specified from
>> userspace.
> 
> I agree that the CPU support for injecting SErrors with a specified ESR should
> be exposed to KVM's user space...
Ok, thanks.

> 
> 
>> Userspace will want to check if the CPU has the RAS
>> extension. 
> 
> ... but user-space wants to know if it can inject SErrors with a specified ESR.
> 
> What if we gain another way of doing this that isn't via the RAS-extensions, now
> user-space has to check for two capabilities.
> 
> 
>> If it has, it wil specify the virtual SError syndrome
>> value, otherwise it will not be set. This patch adds support for
>> querying the availability of this extension.
> 
> I'm against telling user-space what features the CPU has unless it can use them
> directly. In this case we are talking about a KVM API, so we should describe the
> API not the CPU.

shenglong (zhaoshenglong at huawei.com) who is Qemu maintainer suggested checking the CPU RAS-extensions
to decide whether generate the APEI table and record CPER for the guest OS in the user space.
he means if the host does not support RAS, user space may also not support RAS.

> 
> 
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index 3256b9228e75..b7313ee028e9 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -77,6 +77,9 @@ int kvm_arch_dev_ioctl_check_extension(struct kvm *kvm, long ext)
>>  	case KVM_CAP_ARM_PMU_V3:
>>  		r = kvm_arm_support_pmu_v3();
>>  		break;
>> +	case KVM_CAP_ARM_RAS_EXTENSION:
> 
> This should be called something more like 'KVM_CAP_ARM_INJECT_SERROR_ESR'
I understand your suggestion.

> 
> 
>> +		r = cpus_have_const_cap(ARM64_HAS_RAS_EXTN);
>> +		break;
>>  	case KVM_CAP_SET_GUEST_DEBUG:
>>  	case KVM_CAP_VCPU_ATTRIBUTES:
>>  		r = 1;
> 
> 
> We can inject SError on systems without the RAS extensions using just the
> HCR_EL2.VSE bit. We may want to make the 'ESR' part of the API optional, or
> expose '1' for the without-ESR version and '2 for with-ESR, (however we choose
> to implement that).
> 
> The risk is if we want to add a without-ESR version later, and the name we make
> ABI now turned out to be a mistake. Marc or Christoffer probably have the best
> view of this. (no-one has needed it so far...)
> 
> 
> Thanks,
> 
> James
> 
> 
> .
> 
