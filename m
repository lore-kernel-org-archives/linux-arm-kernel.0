From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 27 Mar 2013 09:46:20 +0100
Subject: [RFC PATCH v3 3/6] sched: pack small tasks
In-Reply-To: <5151BEF2.9090100@linux.intel.com>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
 <1364301998.5053.17.camel@laptop> <5151BEF2.9090100@linux.intel.com>
Message-ID: <1364373980.5053.57.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-03-26 at 08:29 -0700, Arjan van de Ven wrote:
> > Isn't this basically related to picking the NO_HZ cpu; if the system
> > isn't fully symmetric with its power gates you want the NO_HZ cpu to be
> > the 'special' cpu. If it is symmetric we really don't care which core
> > is left 'running' and we can even select a new pack cpu from the idle
> > cores once the old one is fully utilized.
> 
> you don't really care much sure, but there's some advantages for sorting "all the way left",
> e.g. to linux cpu 0.
> Some tasks only run there, and interrupts tend to be favored to that cpu as well on x86.

Right, and I suspect all the big-little nonsense will have the little
cores on low numbers as well (is this architected or can a creative
licensee screw us over?)

So find_new_ilb() already does cpumask_first(), so it has a strong
leftmost preference. We just need to make sure it indeed does the right
thing and doesn't have some unintended side effect.
