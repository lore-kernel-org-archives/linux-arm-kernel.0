From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Mar 2017 12:37:01 +0000
Subject: System/uncore PMUs and unit aggregation
In-Reply-To: <CAFpQJXXehUbkr7SNTZfYVeADtXTwbH20Ya=Xwkke7LMXbb20=w@mail.gmail.com>
References: <20161117181708.GT22855@arm.com>
 <CAFpQJXXehUbkr7SNTZfYVeADtXTwbH20Ya=Xwkke7LMXbb20=w@mail.gmail.com>
Message-ID: <20170320123701.GL17263@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 04:38:28PM +0530, Ganapatrao Kulkarni wrote:
> On Thu, Nov 17, 2016 at 11:47 PM, Will Deacon <will.deacon@arm.com> wrote:
> > We currently have support for three arm64 system PMUs in flight:
> >
> >  [Cavium ThunderX] http://lkml.kernel.org/r/cover.1477741719.git.jglauber at cavium.com
> >  [Hisilicon Hip0x] http://lkml.kernel.org/r/1478151727-20250-1-git-send-email-anurup.m at huawei.com
> >  [Qualcomm L2] http://lkml.kernel.org/r/1477687813-11412-1-git-send-email-nleeder at codeaurora.org
> >
> > Each of which have to deal with multiple underlying hardware units in one
> > way or another. Mark and I recently expressed a desire to expose these
> > units to userspace as individual PMU instances, since this can allow:
> >
> >   * Fine-grained control of events from userspace, when you want to see
> >     individual numbers as opposed to a summed total
> >
> >   * Potentially ease migration to new SoC revisions, where the units
> >     are laid out slightly differently
> >
> >   * Easier handling of cases where the units aren't quite identical
> >
> > however, this received pushback from all of the patch authors, so there's
> > clearly a problem with this approach. I'm hoping we can try to resolve
> > this here.
> >
> > Speaking to Mark earlier today, we came up with the following rough rules
> > for drivers that present multiple hardware units as a single PMU:
> >
> >   1. If the units share some part of the programming interface (e.g. control
> >      registers or interrupts), then they must be handled by the same PMU.
> >      Otherwise, they should be treated independently as separate PMU
> >      instances.
> 
> How are we planning to handle multi-node scenario?
> if there are X separate PMUs on single socket, are we going to list 2X PMUs on
> dual socket?

Sure, why not? Retrofitting multi-node support into a PMU driver sounds
pretty messy to me, and I don't see the downside of exposing these as
separate instances (which is what they are).

Will
