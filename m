From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 3 Jun 2014 17:59:39 +0200
Subject: [PATCH v2 08/11] sched: get CPU's activity statistic
In-Reply-To: <20140603120354.GC29593@e103034-lin>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-9-git-send-email-vincent.guittot@linaro.org>
 <20140528121001.GI19967@e103034-lin>
 <CAKfTPtDxeBfZK1AxCRqEG91pi--Ti1RYFoQPDhvMVnGTCspQ-g@mail.gmail.com>
 <20140528154703.GJ19967@e103034-lin>
 <CAKfTPtCd8Mm+bvO3f1ybRC=gV-vQ=_5SxcUnOiuZ0XTf0JN=mA@mail.gmail.com>
 <20140603120354.GC29593@e103034-lin>
Message-ID: <20140603155939.GA30445@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 01:03:54PM +0100, Morten Rasmussen wrote:
> On Wed, May 28, 2014 at 05:39:10PM +0100, Vincent Guittot wrote:
> > On 28 May 2014 17:47, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> > > On Wed, May 28, 2014 at 02:15:03PM +0100, Vincent Guittot wrote:
> > >> On 28 May 2014 14:10, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> > >> > On Fri, May 23, 2014 at 04:53:02PM +0100, Vincent Guittot wrote:

> > > I agree that the task runnable_avg_sum is always affected by the
> > > circumstances on the cpu where it is running, and that it takes this
> > > history with it. However, I think cfs.runnable_load_avg leads to less
> > > problems than using the rq runnable_avg_sum. It would work nicely for
> > > the two tasks on two cpus example I mentioned earlier. We don't need add
> > 
> > i would say that nr_running is an even better metrics for such
> > situation as the load doesn't give any additional information.
> 
> I fail to understand how nr_running can be used. nr_running doesn't tell
> you anything about the utilization of the cpu, just the number tasks
> that happen to be runnable at a point in time on a specific cpu. It
> might be two small tasks that just happened to be running while you read
> nr_running.

Agreed, I'm not at all seeing how nr_running is useful here.

> An unweighted version of cfs.runnable_load_avg gives you a metric that
> captures cpu utilization to some extend, but not the number of tasks.
> And it reflects task migrations immediately unlike the rq
> runnable_avg_sum.

So runnable_avg would be equal to the utilization as long as
there's idle time, as soon as we're over-loaded the metric shows how
much extra cpu is required.

That is, runnable_avg - running_avg >= 0 and the amount is the
exact amount of extra cpu required to make all tasks run but not have
idle time.

> Agreed, but I think it is quite important to discuss what we understand
> by cpu utilization. It seems to be different depending on what you want
> to use it for.

I understand utilization to be however much cpu is actually used, so I
would, per the existing naming, call running_avg to be the avg
utilization of a task/group/cpu whatever.

> We have done experiments internally with rq runnable_avg_sum for
> load-balancing decisions in the past and found it unsuitable due to its
> slow response to task migrations. That is why I brought it up here.

So I'm not entirely seeing that from the code (I've not traced this),
afaict we actually update the per-cpu values on migration based on the
task values.

old_rq->sum -= p->val;
new_rq->sum += p->val;

like,.. except of course totally obscured.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140603/847f8a37/attachment.sig>
