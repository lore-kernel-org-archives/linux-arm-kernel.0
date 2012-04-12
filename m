From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 12 Apr 2012 20:00:26 +0530
Subject: [PATCH 2/2] ARM: mm: Flush only CPU local cache instead of all
 cache levels.
In-Reply-To: <20120412132729.GA27744@e102568-lin.cambridge.arm.com>
References: <1334230187-21553-1-git-send-email-santosh.shilimkar@ti.com>
 <1334230187-21553-3-git-send-email-santosh.shilimkar@ti.com>
 <20120412132729.GA27744@e102568-lin.cambridge.arm.com>
Message-ID: <CAMQu2gzdaGOq-dyJ8dZmyL3e+jg0QJj2BfQBsxh=EYkXrQVTsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 6:57 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Hi Santosh,
>
> just posted a series whose aim is the same, please have a look and
> let's try to merge the two approaches.
>
Sure ...

> On Thu, Apr 12, 2012 at 12:29:47PM +0100, Santosh Shilimkar wrote:
>> The ARMv7 processor setup functions clean and invalidates the
>> cpu cache before enabling MMU. The intention here is to start
>> with clean CPU local cache.
>>
>> But on architectures like Cortex-[A15/A8], this code will end
>> up flushing the L2 cache as well which undesirable and incorrect.
>
> Undesirable agreed, can you define incorrect please ?
>
I was mainly visualizing mainly the hotplug scenario where one CPU
is middle of accessing shared data and other CPU in it's way up path
flush L1 + L2. After thinking bit more, looks like it might work without
issues so incorrect may not be write word.

>> The setup functions are used in CPU hotplug scenario's too and
>> hence flushing all cache levels should be avoided.
>>
>
> Agreed, but this is also true for __cpu_disable() if we consider hotplug into
> the picture. The difference is that __cpu_disable is not v7 specific
> that's what I tried to address with my series, a more generic (and of course
> arguable) approach.
>
>> Fix this code by restricting the cache flush to local cpu
>> cache or L1.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
>> ---
>> ?arch/arm/mm/proc-v7.S | ? ?3 ++-
>> ?1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
>> index f1c8486..96cfc31 100644
>> --- a/arch/arm/mm/proc-v7.S
>> +++ b/arch/arm/mm/proc-v7.S
>> @@ -172,7 +172,8 @@ __v7_ca15mp_setup:
>> ?__v7_setup:
>> ? ? ? adr ? ? r12, __v7_setup_stack ? ? ? ? ? @ the local stack
>> ? ? ? stmia ? r12, {r0-r5, r7, r9, r11, lr}
>> - ? ? bl ? ? ?v7_flush_dcache_all
>> + ? ? mov ? ? r0, #0x1
>> + ? ? bl ? ? ?v7_flush_dcache_by_level
>
> I did not post my patch here that is similar but basically the idea here is
> to clean/invalidate up to Level of Unification Inner Shareable.
>
ok.

> That hardcoded 0x1 must be explained, it might work for most of the v7 systems
> but I think it should be generalized.
>
Agree. I just looked at current V7 processors and thought that #1 should be
fine.
