From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jan 2017 18:56:14 +0000
Subject: System/uncore PMUs and unit aggregation
In-Reply-To: <582EB89B.5050708@gmail.com>
References: <20161117181708.GT22855@arm.com>
 <582EB89B.5050708@gmail.com>
Message-ID: <20170110185614.GC12728@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 01:45:23PM +0530, Anurup M wrote:
> On Thursday 17 November 2016 11:47 PM, Will Deacon wrote:
> >We currently have support for three arm64 system PMUs in flight:
> >
> >  [Cavium ThunderX] http://lkml.kernel.org/r/cover.1477741719.git.jglauber at cavium.com
> >  [Hisilicon Hip0x] http://lkml.kernel.org/r/1478151727-20250-1-git-send-email-anurup.m at huawei.com
> >  [Qualcomm L2] http://lkml.kernel.org/r/1477687813-11412-1-git-send-email-nleeder at codeaurora.org
> >
> >Each of which have to deal with multiple underlying hardware units in one
> >way or another. Mark and I recently expressed a desire to expose these
> >units to userspace as individual PMU instances, since this can allow:
> >
> >   * Fine-grained control of events from userspace, when you want to see
> >     individual numbers as opposed to a summed total
> >
> >   * Potentially ease migration to new SoC revisions, where the units
> >     are laid out slightly differently
> >
> >   * Easier handling of cases where the units aren't quite identical
> >
> >however, this received pushback from all of the patch authors, so there's
> >clearly a problem with this approach. I'm hoping we can try to resolve
> >this here.
> >
> >Speaking to Mark earlier today, we came up with the following rough rules
> >for drivers that present multiple hardware units as a single PMU:
> >
> >   1. If the units share some part of the programming interface (e.g. control
> >      registers or interrupts), then they must be handled by the same PMU.
> >      Otherwise, they should be treated independently as separate PMU
> >      instances.
> The Hisilicon Hip0x chip has units like L3 cache, Miscellaneous nodes, DDR
> controller etc.
> There are such units in multiple CPU die's in the chip.
> 
> The L3 cache is further divided as banks which have separate set of
> interface (control registers, interrupts etc..).
> As per the suggestion, each L3 cache banks will be exposed as a individual
> PMU instance.
> So for e.g. in a board using Hip0x chip with 2 sockets and each socket
> consists of 2 CPU die,
> There will be a total of 16 L3 cache PMU's which will be exposed.
> 
> My doubt here is
> Each L3 cache PMU has total 22 statistics events. So if registered as a
> separate PMU, will it not
> create multiple entries (with same event names) in event listing for
> multiple L3 cache PMU's.
> Is there a way to avoid this? or this is acceptable?
> 
> Just a thought, If we can group them as single PMU and add a config
> parameter in the event listing to
> identify the L3 cache bank(sub unit). e.g:  event name will appear as
> "hisi_l3c2/read_allocate,bank=?/".
> And user can choose count from bank 0x01 as -e
> "hisi_l3c2/read_allocate,bank=0x01/".
> And for aggregate count, bank=0xff.
> Does it over complicate? Please share your comments.

Adding a bank field to the config looks fine to me. I'm assuming the banks
aren't CPU affine?

Will
