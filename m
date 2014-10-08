From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Wed, 8 Oct 2014 12:13:26 +0100
Subject: [PATCH 4/7] sched: Track group sched_entity usage contributions
In-Reply-To: <xm26oatnk55g.fsf@sword-of-the-dawn.mtv.corp.google.com>
References: <1412684017-16595-1-git-send-email-vincent.guittot@linaro.org>
 <1412684017-16595-5-git-send-email-vincent.guittot@linaro.org>
 <xm26oatnk55g.fsf@sword-of-the-dawn.mtv.corp.google.com>
Message-ID: <20141008111326.GB1788@e105550-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 09:15:39PM +0100, bsegall at google.com wrote:
> Vincent Guittot <vincent.guittot@linaro.org> writes:
> 
> > From: Morten Rasmussen <morten.rasmussen@arm.com>
> >
> > Adds usage contribution tracking for group entities. Unlike
> > se->avg.load_avg_contrib, se->avg.utilization_avg_contrib for group
> > entities is the sum of se->avg.utilization_avg_contrib for all entities on the
> > group runqueue. It is _not_ influenced in any way by the task group
> > h_load. Hence it is representing the actual cpu usage of the group, not
> > its intended load contribution which may differ significantly from the
> > utilization on lightly utilized systems.
> 
> 
> Just noting that this version also has usage disappear immediately when
> a task blocks, although it does what you probably want on migration.

Yes, as it was discussed at Ksummit, we should include blocked
usage. It gives a much more stable metric.

> Also, group-ses don't ever use their running_avg_sum so it's kinda a
> waste, but I'm not sure it's worth doing anything about.

Yeah, but since we still have to maintain runnable_avg_sum for group-ses
it isn't much that can be saved I think. Maybe avoid calling
update_entity_load_avg() from set_next_entity() for group-ses, but I'm
not sure how much it helps.
