From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 26 Mar 2013 13:46:38 +0100
Subject: [RFC PATCH v3 3/6] sched: pack small tasks
In-Reply-To: <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1364301998.5053.17.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-03-22 at 13:25 +0100, Vincent Guittot wrote:
> During the creation of sched_domain, we define a pack buddy CPU for
> each CPU
> when one is available. We want to pack at all levels where a group of
> CPU can
> be power gated independently from others.
> On a system that can't power gate a group of CPUs independently, the
> flag is
> set at all sched_domain level and the buddy is set to -1. This is the
> default
> behavior.
> On a dual clusters / dual cores system which can power gate each core
> and
> cluster independently, the buddy configuration will be :
> 
>       | Cluster 0   | Cluster 1   |
>       | CPU0 | CPU1 | CPU2 | CPU3 |
> -----------------------------------
> buddy | CPU0 | CPU0 | CPU0 | CPU2 |

I suppose this is adequate for the 'small' systems you currently have;
but given that Samsung is already bragging with its 'octo'-core Exynos
5 (4+4 big-little thing) does this solution scale?

Isn't this basically related to picking the NO_HZ cpu; if the system
isn't fully symmetric with its power gates you want the NO_HZ cpu to be
the 'special' cpu. If it is symmetric we really don't care which core
is left 'running' and we can even select a new pack cpu from the idle
cores once the old one is fully utilized.

Re-using (or integrating) with NO_HZ has the dual advantage that you'll
make NO_HZ do the right thing for big-little (you typically want a
little core to be the one staying 'awake' and once someone makes NO_HZ
scale this all gets to scale along with it.
