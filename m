From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 25 May 2018 11:41:51 +0100
Subject: [PATCH v4 02/26] arm64: cpufeature: Add cpufeature for IRQ
 priority masking
In-Reply-To: <54ff6127-928d-99a3-a6e9-59799628ca87@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
 <1527241772-48007-3-git-send-email-julien.thierry@arm.com>
 <e44df12f-9868-ae94-4623-ec221d72d783@arm.com>
 <b0673d7e-9a1e-7dcb-5322-c05fe0821349@arm.com>
 <c4e5f8ff-ecde-7b88-8a37-39e47ef22917@arm.com>
 <54ff6127-928d-99a3-a6e9-59799628ca87@arm.com>
Message-ID: <3f0afa54-8e98-798e-68dc-bbbc74bd9e19@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/05/18 11:39, Julien Thierry wrote:
> 
> 
> On 25/05/18 11:36, Suzuki K Poulose wrote:
>> On 25/05/18 11:17, Julien Thierry wrote:
>>>
>>>
>>> On 25/05/18 11:04, Suzuki K Poulose wrote:
>>>> On 25/05/18 10:49, Julien Thierry wrote:
>>>>> Add a cpufeature indicating whether a cpu supports masking interrupts
>>>>> by priority.
>>>>
>>>> How is this different from the SYSREG_GIC_CPUIF cap ? Is it just
>>>> the description ?
>>>
>>> More or less.
>>>
>>> It is just to have an easier condition in the rest of the series. Basically the PRIO masking feature is enabled if we have a GICv3 CPUIF working *and* the option was selected at build time. Before this meant that I was checking for the GIC_CPUIF cap inside #ifdefs (and putting alternatives depending on that inside #ifdefs as well).
>>>
>>> Having this as a separate feature feels easier to manage in the code. It also makes it clearer at boot time that the kernel will be using irq priorities (although I admit it was not the initial intention):
>>>
>>> [??? 0.000000] CPU features: detected: IRQ priority masking
>>>
>>>
>>> But yes that new feature will be detected only if SYSREG_GIC_CPUIF gets detected as well.
>>
>> Well, you could always wrap the check like :
>>
>> static inline bool system_has_irq_priority_masking(void)
>> {
>> ?????return (IS_ENABLED(CONFIG_YOUR_CONFIG) && cpus_have_const_cap(HWCAP_SYSREG_GIC_CPUIF));
>> }
>>
>> and use it everywhere.
>>
> 
> Yes, but I can't use that in the asm parts that use alternatives and would need to surround them in #ifdef... :\

I thought there is _ALTERNATIVE_CFG() to base the alternative depend on a CONFIG_xxx ?
Doesn't that solve the problem ?

Suzuki
