From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 3 Jun 2014 17:50:07 +0200
Subject: [PATCH v2 08/11] sched: get CPU's activity statistic
In-Reply-To: <20140528154703.GJ19967@e103034-lin>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-9-git-send-email-vincent.guittot@linaro.org>
 <20140528121001.GI19967@e103034-lin>
 <CAKfTPtDxeBfZK1AxCRqEG91pi--Ti1RYFoQPDhvMVnGTCspQ-g@mail.gmail.com>
 <20140528154703.GJ19967@e103034-lin>
Message-ID: <20140603155007.GZ30445@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 04:47:03PM +0100, Morten Rasmussen wrote:
> Since we may do periodic load-balance every 10 ms or so, we will perform
> a number of load-balances where runnable_avg_sum will mostly be
> reflecting the state of the world before a change (new task queued or
> moved a task to a different cpu). If you had have two tasks continuously
> on one cpu and your other cpu is idle, and you move one of the tasks to
> the other cpu, runnable_avg_sum will remain unchanged, 47742, on the
> first cpu while it starts from 0 on the other one. 10 ms later it will
> have increased a bit, 32 ms later it will be 47742/2, and 345 ms later
> it reaches 47742. In the mean time the cpu doesn't appear fully utilized
> and we might decide to put more tasks on it because we don't know if
> runnable_avg_sum represents a partially utilized cpu (for example a 50%
> task) or if it will continue to rise and eventually get to 47742.

Ah, no, since we track per task, and update the per-cpu ones when we
migrate tasks, the per-cpu values should be instantly updated.

If we were to increase per task storage, we might as well also track
running_avg not only runnable_avg.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140603/5592e64c/attachment.sig>
