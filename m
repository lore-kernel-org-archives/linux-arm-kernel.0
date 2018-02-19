From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 19 Feb 2018 12:30:46 -0600
Subject: [PATCH] arm64: Add support for new control bits CTR_EL0.IDC and
 CTR_EL0.IDC
In-Reply-To: <20180219171852.jsbzawbsyv7v5yi7@armageddon.cambridge.arm.com>
References: <1518829066-3558-1-git-send-email-shankerd@codeaurora.org>
 <20180219143820.5oxc2kendvq4bbtt@armageddon.cambridge.arm.com>
 <92836754-2ab3-d5db-f0be-7ee3e10f368f@codeaurora.org>
 <20180219171852.jsbzawbsyv7v5yi7@armageddon.cambridge.arm.com>
Message-ID: <da2b54da-cb05-b478-ce61-eeb3308de672@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Catalin for your comments.

On 02/19/2018 11:18 AM, Catalin Marinas wrote:
> On Mon, Feb 19, 2018 at 10:35:30AM -0600, Shanker Donthineni wrote:
>> On 02/19/2018 08:38 AM, Catalin Marinas wrote:
>>> On the patch, I'd rather have an alternative framework entry for no VAU
>>> cache maint required and some ret instruction at the beginning of the
>>> cache maint function rather than jumping out of the loop somewhere
>>> inside the cache maintenance code, penalising the CPUs that do require
>>> it.
>>
>> Alternative framework might break things in case of CPU hotplug. I need one
>> more confirmation from you on incorporating alternative framework.     
> 
> CPU hotplug can be an issue but it should be handled like other similar
> cases: if a CPU comes online late and its features are incompatible, it
> should not be brought online. The cpufeature code handles this.
> 
> With Will's patch for CTR_EL0, we handle different CPU features during
> boot, defaulting to the lowest value for the IDC/DIC bits.
> 
> I suggest you add new ARM64_HAS_* feature bits and enable them based on
> CTR_EL0.IDC and DIC. You could check for both being 1 with a single
> feature bit but I guess an implementation is allowed to have these
> different (e.g. DIC == 0 and IDC == 1).
> 

I'll add two new features ARM64_HAS_DIC and ARM64_HAS_IDC to support
all implementations. Unfortunately QCOM server chips supports IDC not DIC.
 

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
