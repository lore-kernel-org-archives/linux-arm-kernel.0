From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 23 May 2014 10:48:29 +0800
Subject: [PATCH v2] mm, compaction: properly signal and act upon lock and
 need_sched() contention
In-Reply-To: <CAGa+x87-NRyK6kUiXNL_bRNEGm+DR6M3HPSLYEoq4t6Nrtnd_g@mail.gmail.com>
References: <1399904111-23520-1-git-send-email-vbabka@suse.cz>
 <1400233673-11477-1-git-send-email-vbabka@suse.cz>
 <CAGa+x87-NRyK6kUiXNL_bRNEGm+DR6M3HPSLYEoq4t6Nrtnd_g@mail.gmail.com>
Message-ID: <CAAQ0ZWQDVxAzZVm86ATXd1JGUVoLXj_Y5Ske7htxH_6a4GPKRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 May 2014 07:49, Kevin Hilman <khilman@linaro.org> wrote:
> On Fri, May 16, 2014 at 2:47 AM, Vlastimil Babka <vbabka@suse.cz> wrote:
>> Compaction uses compact_checklock_irqsave() function to periodically check for
>> lock contention and need_resched() to either abort async compaction, or to
>> free the lock, schedule and retake the lock. When aborting, cc->contended is
>> set to signal the contended state to the caller. Two problems have been
>> identified in this mechanism.
>
> This patch (or later version) has hit next-20140522 (in the form
> commit 645ceea9331bfd851bc21eea456dda27862a10f4) and according to my
> bisect, appears to be the culprit of several boot failures on ARM
> platforms.

On i.MX6 where CMA is enabled, the commit causes the drivers calling
dma_alloc_coherent() fail to probe.  Tracing it a little bit, it seems
dma_alloc_from_contiguous() always return page as NULL after this
commit.

Shawn
