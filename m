From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 1 Feb 2018 12:00:09 +0000
Subject: ARM64 SMMU Setup
In-Reply-To: <2b9c4adb-9645-0c02-ffb6-9357ff421355@linux.intel.com>
References: <fc00c99b-7766-2ac5-83a5-2ed9e13a15e1@linux.intel.com>
 <CAKv+Gu-vwWp_o=XUd17OJ28Brh=Qt_GibpiSMByAXFW07VrxPA@mail.gmail.com>
 <2b9c4adb-9645-0c02-ffb6-9357ff421355@linux.intel.com>
Message-ID: <bfa1d06a-01d2-e97d-2aca-dfa06083305b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/01/18 23:31, Thor Thayer wrote:
> Hi Ard,
> 
> On 01/31/2018 04:21 PM, Ard Biesheuvel wrote:
>> On 31 January 2018 at 22:09, Thor Thayer <thor.thayer@linux.intel.com> 
>> wrote:
>>> Hi,
>>>
>>> I'm enabling the ARM SMMU-500 on an ARM64 A53. I'm hitting a data 
>>> abort in
>>> the probe functions because I'm accessing the registers in EL1 mode.
>>>
>>
>> Why do you think the fact that you are running at EL1 is causing the 
>> data abort?
>>
> Yes, I may not be diagnosing this correctly. I narrowed it down to 
> failing on the first read in arm_smmu_device_cfg_probe().
> 
> When I read the same register with a debugger (I'm in EL1), it fails. I 
> just realized the read also fails in EL2.
> 
> If I elevate the read to EL3, I can read the default reset value from 
> the register but I mistakenly thought this was EL2.

Yes, this sounds like a TrustZone controller preventing non-secure 
access to the SMMU altogether. Even if you try to access MMU-500's 
secure-only registers from non-secure, "successful" accesses to those 
should behave as RAZ/WI rather than aborting.

>>> Linux starts in EL2 mode but drops down to EL1 mode by the time it 
>>> reaches
>>> the arm-smmu probe function.
>>>
>>> Is there something else I need to add to either move the arm-smmu probe
>>> earlier or remain in EL2 until after the arm-smmu probe?
>>>
>>
>> No. I am pretty sure EL2 vs EL1 is not causing your issue. Could you
>> elaborate on the nature of the exception you are getting?
>>
> The error I'm getting is:
> 
> Unhandled fault: synchronous external abort (0x96000010) at 
> 0xffff000008e40020
> Internal error: : 96000010 [#1] PREEMPT SMP
> 
> To be honest I got lost trying to decode 0x96000010 and I may have used 
> the wrong ARM document. I ended up interpreting this as Data Abort taken 
> without an Exception level from the ARMv8 ARM.
> 
> Additionally, the SMMU documentation seemed to indicate the Hypervisor 
> would need to run at EL2 so I ran with that.

Beware that much of the SMMU documentation is based on some theoretical 
idea of how software might work, and bears little or no relation to what 
real software actually does ;)

Robin.

> Thank you for the reply and I'll go back and examine my assumptions again.
> 
> Thor
> 
>>> A Google search didn't turn up anything so I hoped posting to the 
>>> list would
>>> help.
>>>
>>> Thanks in advance,
>>>
>>> Thor
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> iommu mailing list
> iommu at lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
