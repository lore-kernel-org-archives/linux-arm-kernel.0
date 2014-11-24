From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Mon, 24 Nov 2014 17:16:35 +0000
Subject: [PATCH v9 08/10] sched: replace capacity_factor by usage
In-Reply-To: <CAKfTPtBtdnHUYjbrUiqED7Mr2d4HGB1YcyARED6Zx+rskZRsBw@mail.gmail.com>
References: <1415033687-23294-1-git-send-email-vincent.guittot@linaro.org>
 <1415033687-23294-9-git-send-email-vincent.guittot@linaro.org>
 <20141121123719.GH23177@e105550-lin.cambridge.arm.com>
 <CAKfTPtBtdnHUYjbrUiqED7Mr2d4HGB1YcyARED6Zx+rskZRsBw@mail.gmail.com>
Message-ID: <20141124171635.GL23177@e105550-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 02:41:28PM +0000, Vincent Guittot wrote:
> On 21 November 2014 at 13:37, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> > On Mon, Nov 03, 2014 at 04:54:45PM +0000, Vincent Guittot wrote:
> 
> [snip]
> 
> >>                  */
> >>                 if (prefer_sibling && sds->local &&
> >> -                   sds->local_stat.group_has_free_capacity)
> >> -                       sgs->group_capacity_factor = min(sgs->group_capacity_factor, 1U);
> >> +                   group_has_capacity(env, &sds->local_stat) &&
> >> +                   (sgs->sum_nr_running > 1)) {
> >> +                       sgs->group_no_capacity = 1;
> >> +                       sgs->group_type = group_overloaded;
> >> +               }
> >
> > I'm still a bit confused about SD_PREFER_SIBLING. What is the flag
> > supposed to do and why?
> 
> The goal is to spread tasks across the group even if the the latter is
> not overloaded. for SMT level, the goal is to have 1 task per core
> before 1 task per HW thread

That makes more sense and is in line with how I understand SMT
scheduling. So we try to have at least one task per group. Where each
group is a domain with SD_PREFER_SIBLING.

Anyway, you don't change the prefer-sibling behaviour in this patch set.
I was just wondering how it would work for SMT balancing.

Thanks,
Morten
