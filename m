From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 4 Jun 2014 12:55:59 +0200
Subject: [PATCH v2 08/11] sched: get CPU's activity statistic
In-Reply-To: <20140604103619.GL29593@e103034-lin>
References: <1400860385-14555-9-git-send-email-vincent.guittot@linaro.org>
 <20140528121001.GI19967@e103034-lin>
 <CAKfTPtDxeBfZK1AxCRqEG91pi--Ti1RYFoQPDhvMVnGTCspQ-g@mail.gmail.com>
 <20140528154703.GJ19967@e103034-lin>
 <20140603155007.GZ30445@twins.programming.kicks-ass.net>
 <CAKfTPtDUvH--WxFATTW6YRAvLuohzyNHDUq6DRdfxc7gRKCX6Q@mail.gmail.com>
 <20140604080809.GK30445@twins.programming.kicks-ass.net>
 <CAKfTPtBCG1Jq2b+fyoGuA=7yG_yUbsmaD+j-ZXXsPNGp5giKpg@mail.gmail.com>
 <20140604101724.GD11096@twins.programming.kicks-ass.net>
 <20140604103619.GL29593@e103034-lin>
Message-ID: <20140604105559.GM30445@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 11:36:19AM +0100, Morten Rasmussen wrote:
> On Wed, Jun 04, 2014 at 11:17:24AM +0100, Peter Zijlstra wrote:
> > Let me explain the 75%, take any one of the above scenarios. Lets call
> > the two tasks A and B, and let for a moment assume A always wins and
> > runs first, and then B.
> > 
> > So A will be runnable for 25%, B otoh will be runnable the entire time A
> > is actually running plus its own running time, giving 50%. Together that
> > makes 75%.
> > 
> > If you release the assumption that A runs first, but instead assume they
> > equally win the first execution, you get them averaging at 37.5% each,
> > which combined will still give 75%.
> 
> But that is assuming that the first task gets to run to completion of it
> busy period. If it uses up its sched_slice and we switch to the other
> tasks, they both get to wait.
> 
> For example, if the sched_slice is 5 ms and the busy period is 10 ms,
> the execution pattern would be: A, B, A, B, idle, ... In that case A is
> runnable for 15 ms and B is for 20 ms. Assuming that the overall period
> is 40 ms, the A runnable is 37.5% and B is 50%.

Indeed, with preemption added you can pull this out further. You can
then indeed get infinitesimally close to 100% with this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/78fdbe49/attachment.sig>
