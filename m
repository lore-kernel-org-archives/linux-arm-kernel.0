From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 31 Jan 2018 23:48:22 +0000
Subject: ARM64 SMMU Setup
In-Reply-To: <2b9c4adb-9645-0c02-ffb6-9357ff421355@linux.intel.com>
References: <fc00c99b-7766-2ac5-83a5-2ed9e13a15e1@linux.intel.com>
 <CAKv+Gu-vwWp_o=XUd17OJ28Brh=Qt_GibpiSMByAXFW07VrxPA@mail.gmail.com>
 <2b9c4adb-9645-0c02-ffb6-9357ff421355@linux.intel.com>
Message-ID: <EAD74C8F-E30A-4E6F-B7AA-0E77F0FEC05C@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 31 Jan 2018, at 23:31, Thor Thayer <thor.thayer@linux.intel.com> wrote:
> 
> Hi Ard,
> 
>> On 01/31/2018 04:21 PM, Ard Biesheuvel wrote:
>>> On 31 January 2018 at 22:09, Thor Thayer <thor.thayer@linux.intel.com> wrote:
>>> Hi,
>>> 
>>> I'm enabling the ARM SMMU-500 on an ARM64 A53. I'm hitting a data abort in
>>> the probe functions because I'm accessing the registers in EL1 mode.
>>> 
>> Why do you think the fact that you are running at EL1 is causing the data abort?
> Yes, I may not be diagnosing this correctly. I narrowed it down to failing on the first read in arm_smmu_device_cfg_probe().
> 
> When I read the same register with a debugger (I'm in EL1), it fails. I just realized the read also fails in EL2.
> 
> If I elevate the read to EL3, I can read the default reset value from the register but I mistakenly thought this was EL2.
> 

This confirms my suspicion. It is up to the secure firmware running in EL3 (or secure EL1) to configure the SMMU itself and the interconnect in a way that allows code running in EL2 or non-secure EL1 to access it (note that EL3 is always secure and EL2 is always non-secure)

I don?t know the details of the MMU-500 or the way it is integrated into your platform, so I can?t be of any more help, unfortunately.


> 
>>> Linux starts in EL2 mode but drops down to EL1 mode by the time it reaches
>>> the arm-smmu probe function.
>>> 
>>> Is there something else I need to add to either move the arm-smmu probe
>>> earlier or remain in EL2 until after the arm-smmu probe?
>>> 
>> No. I am pretty sure EL2 vs EL1 is not causing your issue. Could you
>> elaborate on the nature of the exception you are getting?
> The error I'm getting is:
> 
> Unhandled fault: synchronous external abort (0x96000010) at 0xffff000008e40020
> Internal error: : 96000010 [#1] PREEMPT SMP

> To be honest I got lost trying to decode 0x96000010 and I may have used the wrong ARM document. I ended up interpreting this as Data Abort taken without an Exception level from the ARMv8 ARM.
> 
> Additionally, the SMMU documentation seemed to indicate the Hypervisor would need to run at EL2 so I ran with that.
> 
> Thank you for the reply and I'll go back and examine my assumptions again.
> 
> Thor
> 
>>> A Google search didn't turn up anything so I hoped posting to the list would
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
