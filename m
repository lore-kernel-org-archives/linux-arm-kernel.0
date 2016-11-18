From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 18 Nov 2016 10:30:47 +0000
Subject: spin_lock behavior with ARM64 big.Little/HMP
In-Reply-To: <400ab4b8b2354c5b9283f6ed657363a0@codeaurora.org>
References: <400ab4b8b2354c5b9283f6ed657363a0@codeaurora.org>
Message-ID: <8d9d6333-0ebe-65c4-c6f1-3e3475e3e535@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vikram,

On 18/11/16 02:22, Vikram Mulukutla wrote:
> Hello,
>
> This isn't really a bug report, but just a description of a frequency/IPC
> dependent behavior that I'm curious if we should worry about. The behavior
> is exposed by questionable design so I'm leaning towards don't-care.
>
> Consider these threads running in parallel on two ARM64 CPUs running
> mainline
> Linux:
>

Are you seeing this behavior with the mainline kernel on any platforms
as we have a sort of workaround for this ?

> (Ordering of lines between the two columns does not indicate a sequence of
> execution. Assume flag=0 initially.)
>
> LittleARM64_CPU @ 300MHz (e.g.A53)   |  BigARM64_CPU @ 1.5GHz (e.g. A57)
> -------------------------------------+----------------------------------
> spin_lock_irqsave(s)                 |  local_irq_save()
> /* critical section */
> flag = 1                             |  spin_lock(s)
> spin_unlock_irqrestore(s)            |  while (!flag) {
>                                      |      spin_unlock(s)
>                                      |      cpu_relax();
>                                      |      spin_lock(s)
>                                      |  }
>                                      |  spin_unlock(s)
>                                      |  local_irq_restore()
>
> I see a livelock occurring where the LittleCPU is never able to acquire the
> lock, and the BigCPU is stuck forever waiting on 'flag' to be set.
>

Yes we saw this issue 3 years back on TC2 which has A7(with lowest
frequency of 300MHz IIRC) and A15(with 1.2 GHz). We were observing that
inter-cluster events are missed since the two clusters are operating at
different frequencies (details below).

The hardware recommendation is that there should be glue logic between
the two clusters which captures events from one cluster and replays then
on the other if its operating at a different frequency.

Generally EVENTO from cluster 1 is connected to the EVENTI of the
cluster 2 and vice versa. The only extra logic required is the double
synchronizer in the receiving clock domain.

This issue arise in reality if the synchronizer is missing and different
CPUs hold EVENTO for different clock cycles.

However there was a different requirement to implement timer event
stream in Linux for some user-space locking and that indirectly help to
resolve the issue on TC2. That event stream feature is enabled by
default in Linux and should fix the issue and hence I asked you if you
still see that issue.

-- 
Regards,
Sudeep
