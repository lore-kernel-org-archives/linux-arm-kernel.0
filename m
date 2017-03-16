From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 16 Mar 2017 16:38:28 +0530
Subject: System/uncore PMUs and unit aggregation
In-Reply-To: <20161117181708.GT22855@arm.com>
References: <20161117181708.GT22855@arm.com>
Message-ID: <CAFpQJXXehUbkr7SNTZfYVeADtXTwbH20Ya=Xwkke7LMXbb20=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Thu, Nov 17, 2016 at 11:47 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi all,
>
> We currently have support for three arm64 system PMUs in flight:
>
>  [Cavium ThunderX] http://lkml.kernel.org/r/cover.1477741719.git.jglauber at cavium.com
>  [Hisilicon Hip0x] http://lkml.kernel.org/r/1478151727-20250-1-git-send-email-anurup.m at huawei.com
>  [Qualcomm L2] http://lkml.kernel.org/r/1477687813-11412-1-git-send-email-nleeder at codeaurora.org
>
> Each of which have to deal with multiple underlying hardware units in one
> way or another. Mark and I recently expressed a desire to expose these
> units to userspace as individual PMU instances, since this can allow:
>
>   * Fine-grained control of events from userspace, when you want to see
>     individual numbers as opposed to a summed total
>
>   * Potentially ease migration to new SoC revisions, where the units
>     are laid out slightly differently
>
>   * Easier handling of cases where the units aren't quite identical
>
> however, this received pushback from all of the patch authors, so there's
> clearly a problem with this approach. I'm hoping we can try to resolve
> this here.
>
> Speaking to Mark earlier today, we came up with the following rough rules
> for drivers that present multiple hardware units as a single PMU:
>
>   1. If the units share some part of the programming interface (e.g. control
>      registers or interrupts), then they must be handled by the same PMU.
>      Otherwise, they should be treated independently as separate PMU
>      instances.

How are we planning to handle multi-node scenario?
if there are X separate PMUs on single socket, are we going to list 2X PMUs on
dual socket?
>
>   2. If the units are handled by the same PMU, then care must be taken to
>      handle event groups correctly. That is, if the units cannot be started
>      and stopped atomically, cross-unit groups must be rejected by the
>      driver. Furthermore, any cross-unit scheduling constraints must be
>      honoured so that all the units targetted by a group can schedule the
>      group concurrently.
>
>   3. Summing the counters across units is only permitted if the units
>      can all be started and stopped atomically. Otherwise, the counters
>      should be exposed individually. It's up to the driver author to
>      decide what makes sense to sum.
>
>   4. Unit topology can optionally be described in sysfs (we should pick
>      some standard directory naming here), and then events targetting
>      specific units can have the unit identifier extracted from the topology
>      encoded in some configN fields.
>
> The million dollar question is: how does that fit in with the drivers I
> mentioned at the top? Is this overly restrictive, or have we missed stuff?
>
> We certainly want to allow flexibility in the way in which the drivers
> talk to the hardware, but given that these decisions directly affect the
> user ABI, some consistent ground rules are required.
>
> For Cavium ThunderX, it's not clear whether or not the individual units
> could be expressed as separate PMUs, or whether they're caught by one of
> the rules above. The Qualcomm L2 looks like it's doing the right thing
> and we can't quite work out what the Hisilicon Hip0x topology looks like,
> since the interaction with djtag is confusing.
>
> If the driver authors (on To:) could shed some light on this, then that
> would be much appreciated!
>
> Thanks,
>
> Will
>

thanks
Ganapat
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
