From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 11 Aug 2017 17:06:06 +0100
Subject: [PATCH 0/7] ARM: NOMMU: MPU updates
In-Reply-To: <4f7f6318-dd3f-978c-5138-e9d16379e1c1@st.com>
References: <1497344707-14446-1-git-send-email-vladimir.murzin@arm.com>
 <4f7f6318-dd3f-978c-5138-e9d16379e1c1@st.com>
Message-ID: <ca70151d-b4a1-5517-e3c0-5ccd7a81cc73@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On 28/07/17 16:51, Alexandre Torgue wrote:
> Hi Vlad,
> 
> On 06/13/2017 11:05 AM, Vladimir Murzin wrote:
>> Hi,
>>
>> This is an update of the existent MPU code which consist set of
>> clean-ups and enhancements. The most significant changes are in the way
>> how MPU settings sync-up for secondaries (PATCH 3/7) and more flexible
>> layout for memory (PATCH 7/7). Since there is no in-tree user of MPU,
>> support for M-class has been added (PATCH 6/7).
>>
>> Thanks!
>>
>> Changelog:
>>
>>          RFC v2 -> v1
>>                 - dropped RFC tag
>>            - Tested-by from Andr?s
>>            - rebased on 4.12-rc5
>>
>>             RFC -> RFC v2
>>            - fixed MPU enable for v7m (PATCH 6/7)
>>
>> Vladimir Murzin (7):
>>    ARM: NOMMU: Move out MPU setup in separate module
>>    ARM: NOMMU: Update MPU accessors to use cp15 helpers
>>    ARM: NOMMU: Rework MPU to be mostly done in C
>>    ARM: NOMMU: Disallow MPU for XIP
>>    ARM: Kconfig: Kill CONFIG_VECTORS_BASE
>>    ARM: V7M: Add support for MPU to M-class
>>    ARM: NOMMU: Use more MPU regions to cover memory
>>
>>   arch/arm/Kconfig               |   9 -
>>   arch/arm/Kconfig-nommu         |   4 +-
>>   arch/arm/include/asm/cputype.h |  10 +
>>   arch/arm/include/asm/mpu.h     |  23 ++-
>>   arch/arm/include/asm/smp.h     |   2 +-
>>   arch/arm/include/asm/v7m.h     |  10 +
>>   arch/arm/kernel/asm-offsets.c  |  11 +
>>   arch/arm/kernel/head-nommu.S   | 128 +++++++++---
>>   arch/arm/kernel/smp.c          |   2 +-
>>   arch/arm/mm/Makefile           |   1 +
>>   arch/arm/mm/nommu.c            | 254 +----------------------
>>   arch/arm/mm/pmsa-v7.c          | 445 +++++++++++++++++++++++++++++++++++++++++
>>   12 files changed, 598 insertions(+), 301 deletions(-)
>>   create mode 100644 arch/arm/mm/pmsa-v7.c
>>
> 
> I tested two cases on stm32h743 (based on cortes-M7):
> 
>  - NO XIP: it works fine.
>  - XIP: it is ko Kernel doesn't boot.

I assume you are referring to v2...

> 
> I started investigations but no big success.
> I have a question:
> In arch/arm/kernel/head-nommu.S, I see that background region is set after the XIP region. It seems due to save CPU register value. But doing that you remove the XIP region just created. No ?

No. We have dedicated MPU slots for XIP and background regions, so it doesn't
matter which order they are programmed.

> 
> Other point, why (in arch/arm/kernel/head-nommu.S) we couldn't create:
> 
> 1-backup region strongly-ordered
> 2-create SDRAM region (normal one)
> 3-create XIP region
> 
> By debugging I saw that issue was due to the backup region. If I remove, backup region settings done by Kernel, and I put the sequence above in my bootloader, it works fine in XIP.

It'd be handy if you can say a bit more of that issue, how far Linux was able
to boot?

> 
> Sorry to not have more precise analysis.

Thanks for giving it a try!

Vladimir

> 
> Regards
> Alex
> 
> 
