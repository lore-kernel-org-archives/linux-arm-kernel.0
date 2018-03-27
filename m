From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 27 Mar 2018 14:02:25 +0100
Subject: [PATCH v2 0/6] arm64: provide pseudo NMI with GICv3
In-Reply-To: <b7ac787c-c3d0-d1f1-6559-dbd3c18a9317@huawei.com>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
 <8315db11-7899-008d-f37a-c311b278a1c4@hisilicon.com>
 <7ec201a4-e2dc-8a1e-e8a1-f2b10bd41cd4@huawei.com>
 <afb46ee0-4f26-fd1a-2fd1-866dc0b25175@arm.com>
 <b7ac787c-c3d0-d1f1-6559-dbd3c18a9317@huawei.com>
Message-ID: <5d41794c-b220-7de7-f945-1fcfda8b56ce@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/03/18 13:48, dongbo (E) wrote:
> Hi, Julien and Marc.
> 
> On 2018/3/22 21:40, Julien Thierry wrote:
>> Hi Bo Dong,
>>
>> [adding Marc to the conversation]
>>
>> On 22/03/18 11:07, dongbo (E) wrote:
>>> Hi, Julien.
>>>
>>> We've test this series of patches on our arm64 platform, but it
>>> didn't work. We checked the dmesg and found these patches require
>>> SCR_EL3.FIQ == 1 when Linux runs.
>>>
>>
>> Yes, if SCR_EL3.FIQ != 1, the GIC driver will disable the NMIs (i.e. changing the IRQ priority).
>>
>> The reason for this is, this bit affects how the GIC CPU interface views priorities (cf. GIC architecture version 3.0 and version 4.0, section 4.8.1 Non-secure accesses to register fields for Secure interrupt priorities and 4.8.6 Software accesses of interrupt priority).
>>
>> When SCR_EL3.FIQ != 1, the priorities the GIC CPU interface will present through ICC_RPR_EL1 will be the value set in the distributor/redistributor shifted and with top bit set for Group 1 interrupts (the group linux uses). This is also how the value that is compared against the content of ICC_PMR_EL1 is affected, effectively meaning the same value of ICC_PMR_EL1 will not filter the same priorities (as programmed in the distributor/redistributor) depending on the value of SCR_EL3.FIQ.
>>
> Oh, understood. :)
> 
>>> Seems that the interrupt priority is not relevant with this bit
>>> after going through `GIC architecture version 3.0 and version 4.0`.
>>> Maybe we miss something. Can you explain to us?
>>>
>>
>> It does not mean that interrupt priority is not relevant when SCR_EL3.FIQ != 1, but that the values in the distributor/redistributor are not equal to the ones in the CPU interface.
>>
>> For now we haven't planned to add the support the case SCR_EL3.FIQ == 0, but maybe this can be discussed on the linux-arm-kernel ML.
>>
>> I am attaching a patch I used to test the series on platforms with SCR_EL3.FIQ == 0. You should be able to test with that patch (hoping it still applies easily. Do note that this patch is not for upstream.
>>
> Thanks for sharing the patch, it works.
> 
> So pesudo NMI can be supported on platform with SCR_EL3.FIQ == 0.
> Why don't you want to upstream this patch? What is your consideration?

It creates an indirection that causes extra work on a very hot path.

I'd rather you address the issue in your secure firmware, configuring it
to handle Group-0 interrupts as it is expected.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
