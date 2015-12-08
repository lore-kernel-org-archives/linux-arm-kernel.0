From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 08 Dec 2015 14:10:40 +0000
Subject: [PATCH v6 02/21] KVM: ARM64: Define PMU data structure for each
 vcpu
In-Reply-To: <20151208135335.GK19612@arm.com>
References: <1449578860-15808-1-git-send-email-zhaoshenglong@huawei.com>
 <1449578860-15808-3-git-send-email-zhaoshenglong@huawei.com>
 <5666DD0A.5060004@arm.com> <20151208135335.GK19612@arm.com>
Message-ID: <5666E4E0.8050504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/15 13:53, Will Deacon wrote:
> On Tue, Dec 08, 2015 at 01:37:14PM +0000, Marc Zyngier wrote:
>> On 08/12/15 12:47, Shannon Zhao wrote:
>>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>>
>>> Here we plan to support virtual PMU for guest by full software
>>> emulation, so define some basic structs and functions preparing for
>>> futher steps. Define struct kvm_pmc for performance monitor counter and
>>> struct kvm_pmu for performance monitor unit for each vcpu. According to
>>> ARMv8 spec, the PMU contains at most 32(ARMV8_MAX_COUNTERS) counters.
>>>
>>> Since this only supports ARM64 (or PMUv3), add a separate config symbol
>>> for it.
>>>
>>> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>>> ---
>>>  arch/arm64/include/asm/kvm_host.h |  2 ++
>>>  arch/arm64/kvm/Kconfig            |  8 ++++++++
>>>  include/kvm/arm_pmu.h             | 40 +++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 50 insertions(+)
>>>  create mode 100644 include/kvm/arm_pmu.h
> 
> [...]
> 
>>> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
>>> index a5272c0..66da9a2 100644
>>> --- a/arch/arm64/kvm/Kconfig
>>> +++ b/arch/arm64/kvm/Kconfig
>>> @@ -36,6 +36,7 @@ config KVM
>>>  	select HAVE_KVM_EVENTFD
>>>  	select HAVE_KVM_IRQFD
>>>  	select KVM_ARM_VGIC_V3
>>> +	select KVM_ARM_PMU
>>
>> What if HW_PERF_EVENTS is not selected? Also, selecting HW_PERF_EVENTS
>> is not enough, and you probably need PERF_EVENTS as well, So this should
>> probably read:
>>
>> 	select KVM_ARM_PMU if (HW_PERF_EVENTS && PERF_EVENTS)
> 
> HW_PERF_EVENTS depends on ARM_PMU which in turn depends on PERF_EVENTS.

in which case, let's make it:

	select KVM_ARM_PMU if HW_PERF_EVENTS

which should give us the minimal chain. I hate the kernel config
language! ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
