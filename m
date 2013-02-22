From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 22 Feb 2013 15:46:18 -0800
Subject: [PATCH] ARM: vfp: fix fpsid register subarchitecture field mask
 width
In-Reply-To: <20130222182705.GC19527@mudshark.cambridge.arm.com>
References: <1361520485-30269-1-git-send-email-sboyd@codeaurora.org>
 <20130222182705.GC19527@mudshark.cambridge.arm.com>
Message-ID: <5128034A.4000008@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/22/2013 10:27 AM, Will Deacon wrote:
> Hi guys,
>
> On Fri, Feb 22, 2013 at 08:08:05AM +0000, Stephen Boyd wrote:
>> From: Steve Muckle <smuckle@codeaurora.org>
>>
>> The subarchitecture field in the fpsid register is 7 bits wide.
>> The topmost bit is used to designate that the subarchitecture
>> designer is not ARM. We use this field to determine which VFP
>> version is supported by the CPU. Since the topmost bit is masked
>> off we detect non-ARM subarchitectures as supporting only
>> HWCAP_VFP and not HWCAP_VFPv3 as it should be for Qualcomm's
>> processors.
> I'm struggling to see why this has anything to do with the hwcaps being set
> incorrectly. What value do you have in fpsid? As far as I can tell, the
> subarchitecture bits 6:0 should start at 0x40 for you, right?

Yes it does.

>
> I can see cases for changing this code, I just don't see why it would go
> wrong in the case you're describing.

VFP_arch = (vfpsid & FPSID_ARCH_MASK) >> FPSID_ARCH_BIT;

causes VFP_arch to be equal to 0 because 0x40 & 0xf == 0.

and then a little bit later we have

               if (VFP_arch >= 2) {
                        elf_hwcap |= HWCAP_VFPv3;


The branch is not taken so we never set VFPv3.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
