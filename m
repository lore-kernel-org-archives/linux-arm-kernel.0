From: ohaugan@codeaurora.org (Olav Haugan)
Date: Tue, 24 Jun 2014 14:35:54 -0700
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140624181150.GB4067@arm.com>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
 <CAL_JsqKumG1PSFoVfeGpLLG+MjXFeF4aUjun=vv1BJpaxk0Byg@mail.gmail.com>
 <4545972.cM7IP1qTXQ@wuerfel> <53A4C0C9.2050908@codeaurora.org>
 <20140624091808.GC26013@arm.com> <53A9BC18.2090106@codeaurora.org>
 <20140624181150.GB4067@arm.com>
Message-ID: <53A9EF3A.2070704@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/24/2014 11:11 AM, Will Deacon wrote:
> On Tue, Jun 24, 2014 at 06:57:44PM +0100, Olav Haugan wrote:
>> On 6/24/2014 2:18 AM, Will Deacon wrote:
>>> On Sat, Jun 21, 2014 at 12:16:25AM +0100, Olav Haugan wrote:
>>>> We have multiple-master SMMUs and each master emits a variable number of
>>>> StreamIDs. However, we have to apply a mask (the ARM SMMU spec allows
>>>> for this) to the StreamIDs due to limited number of StreamID 2 Context
>>>> Bank entries in the SMMU. If my understanding is correct we would
>>>> represent this in the DT like this:
>>>>
>>>> 	iommu {
>>>> 		#address-cells = <2>;
>>>> 		#size-cells = <0>;
>>>> 	};
>>>>
>>>> 	master at a {
>>>> 		...
>>>> 		iommus = <&iommu StreamID0 MASK0>,
>>>> 			 <&iommu StreamID1 MASK1>,
>>>> 			 <&iommu StreamID2 MASK2>;
>>>> 	};
>>>
>>> Stupid question, but why not simply describe the masked IDs? What use does
>>> the `raw' ID have to Linux?
>>
>> We do describe the masked StreamID (SID) but we need to specify the mask
>> that the SMMU should apply to the incoming SIDs, right?
>>
>> We have a bus master that emits 43 unique SIDs. However, we have only 40
>> SMMU_SMRn registers in the SMMU. So we need to mask out some of the
>> incoming SID bits so that the 43 SIDs can match one of 40 entries in the
>> SMR.
> 
> Hmm, so you're talking about stream matching, right? That doesn't belong in
> the device-tree. I appreciate that the current driver does a terrible job at
> allocating the SMRs (it's bloody difficult!), but we should try to improve
> the dynamic behaviour instead of moving configuration of the SMMU out into
> device-tree, where it's inflexible at best.

I am talking about SMMU_SMRn[MASK] register bits. This is not something
that can be dynamically detected at run-time. It is configuration at the
same level as the actual StreamIDs.

Thanks,


Olav Haugan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
