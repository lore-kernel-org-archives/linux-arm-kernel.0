From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 30 May 2014 10:59:03 -0600
Subject: [PATCH v2] mm, compaction: properly signal and act upon lock
 and need_sched() contention
In-Reply-To: <537F082F.50501@suse.cz>
References: <1399904111-23520-1-git-send-email-vbabka@suse.cz>	<1400233673-11477-1-git-send-email-vbabka@suse.cz>	<CAGa+x87-NRyK6kUiXNL_bRNEGm+DR6M3HPSLYEoq4t6Nrtnd_g@mail.gmail.com>
 <CAAQ0ZWQDVxAzZVm86ATXd1JGUVoLXj_Y5Ske7htxH_6a4GPKRg@mail.gmail.com>
 <537F082F.50501@suse.cz>
Message-ID: <5388B8D7.1020907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2014 02:34 AM, Vlastimil Babka wrote:
> On 05/23/2014 04:48 AM, Shawn Guo wrote:
>> On 23 May 2014 07:49, Kevin Hilman <khilman@linaro.org> wrote:
>>> On Fri, May 16, 2014 at 2:47 AM, Vlastimil Babka <vbabka@suse.cz> wrote:
>>>> Compaction uses compact_checklock_irqsave() function to periodically check for
>>>> lock contention and need_resched() to either abort async compaction, or to
>>>> free the lock, schedule and retake the lock. When aborting, cc->contended is
>>>> set to signal the contended state to the caller. Two problems have been
>>>> identified in this mechanism.
>>>
>>> This patch (or later version) has hit next-20140522 (in the form
>>> commit 645ceea9331bfd851bc21eea456dda27862a10f4) and according to my
>>> bisect, appears to be the culprit of several boot failures on ARM
>>> platforms.
>>
>> On i.MX6 where CMA is enabled, the commit causes the drivers calling
>> dma_alloc_coherent() fail to probe.  Tracing it a little bit, it seems
>> dma_alloc_from_contiguous() always return page as NULL after this
>> commit.
>>
>> Shawn
>>
> 
> Really sorry, guys :/
> 
> -----8<-----
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Fri, 23 May 2014 10:18:56 +0200
> Subject: mm-compaction-properly-signal-and-act-upon-lock-and-need_sched-contention-fix2
> 
> Step 1: Change function name and comment between v1 and v2 so that the return
>         value signals the opposite thing.
> Step 2: Change the call sites to reflect the opposite return value.
> Step 3: ???
> Step 4: Make a complete fool of yourself.

Tested-by: Stephen Warren <swarren@nvidia.com>

This fix doesn't seem to be in linux-next yet:-(
