From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 9 Sep 2015 17:20:22 +0800
Subject: [PATCH V3 4/5] clk: core: add CLK_OPS_PARENT_ON flags to support
 clocks require parent on
In-Reply-To: <20150819110703.GB30536@shlinux1.ap.freescale.net>
References: <1438089585-30103-1-git-send-email-aisheng.dong@freescale.com>
 <1438089585-30103-5-git-send-email-aisheng.dong@freescale.com>
 <20150814010109.GW26614@codeaurora.org>
 <20150817124514.GA30536@shlinux1.ap.freescale.net>
 <20150819110703.GB30536@shlinux1.ap.freescale.net>
Message-ID: <CAA+hA=SOk-VAHXhnWWJo3mEDX-6oyjpMpNctJCzY+PjCuJGq5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping...

On Wed, Aug 19, 2015 at 7:07 PM, Dong Aisheng
<aisheng.dong@freescale.com> wrote:
> On Mon, Aug 17, 2015 at 08:45:18PM +0800, Dong Aisheng wrote:
>> On Thu, Aug 13, 2015 at 06:01:09PM -0700, Stephen Boyd wrote:
>> > On 07/28, Dong Aisheng wrote:
>> > > On Freescale i.MX7D platform, all clocks operations, including
>> > > enable/disable, rate change and re-parent, requires its parent
>> > > clock on. Current clock core can not support it well.
>> > > This patch introduce a new flag CLK_OPS_PARENT_ON to handle this
>> > > special case in clock core that enable its parent clock firstly for
>> > > each operation and disable it later after operation complete.
>> > >
>> > > This patch fixes disaling clocks while its parent is off.
>> > > This is a special case that is caused by a state mis-align between
>> > > HW and SW in clock tree during booting.
>> > > Usually in uboot, we may enable all clocks in HW by default.
>> > > And during kernel booting time, the parent clock could be disabled in its
>> > > driver probe due to calling clk_prepare_enable and clk_disable_unprepare.
>> > > Because it's child clock is only enabled in HW while its SW usecount
>> > > in clock tree is still 0, so clk_disable of parent clock will gate
>> > > the parent clock in both HW and SW usecount ultimately.
>> > > Then there will be a clock is on in HW while its parent is disabled.
>> > >
>> > > Later when clock core does clk_disable_unused, this clock disable
>> > > will cause system hang due to the limitation of operation requiring
>> > > its parent clock on.
>> > >
>> > > Cc: Mike Turquette <mturquette@linaro.org>
>> > > Cc: Stephen Boyd <sboyd@codeaurora.org>
>> > > Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
>> > > ---
>> >
>> > Sorry, I still don't agree with this patch. There's no reason we
>> > should be turning on clocks during late init so that we can turn
>> > off clocks.
>>
>> Can't the reason be that it's fairly possible one clock is enabled
>> in HW while it's parent is disabled in initial clock tree state
>> and to enable parent clocks to disable itself is required by its special
>> HW characteristic?
>>
>> Dosen't it quite clear from HW point of view?
>>
>> > If there's some sort of problem in doing that we
>> > should figure it out and make it so that during late init we turn
>> > off clocks from the leaves of the tree to the root.
>> >
>>
>> Turning off clocks from the leaves to root probably may require clock core
>> to provide a way to keep the parent clock enabled once finding its child
>> is still on in HW (clk_core_is_enabled() returns true) but enable_count
>> is zero before late init.
>>
>> One possible solution may be leaving parent clocks on in HW during disable
>> once finding its child is on in HW and only decrease the parent's refcount,
>> and then replying on the later clk_disable_unused() to disable both child
>> and parent from leave to root.
>> e.g. clock A: parent, clock B: child of A
>> Initial state: clock B is enabled in HW while refcount is zero
>> Step1: Driver A enable clock A during probe
>>  A: refcount becomes 1 HW state: enabled
>> Step2: Driver A disable clock A after probe
>>  A: refcount becomes 0 HW state: enabled (only decrease refcount)
>>
>> Then Clock A will be the same state as B, HW enabled while refcount is zero(
>> means no users), the later clk_disable_unusersd() will disable them all
>> from leave to root.
>>
>> This is a workable solution but seems much more complicated than the exist
>> one in this patch which is only 5 lines of code changes.
>>
>> And the question is:
>> since we already have the support of CLK_OPS_PARENT_ON (required by
>> clock set_rate/re-parent), why we still need invent another complicated
>> mechanism to support avoiding enable parent clock only for clk_disable_unused()?
>> Is that really worthy?
>> And it's also less power efficiency than the one in the patch.
>>
>> > I agree that there's a problem here where we don't properly
>> > handle keeping children clocks on if a driver comes in and turns
>> > off a clock in the middle of the tree before late init. That's a
>> > real bug, and we should fix it.
>>
>> Sorry, i still can't understand it's a bug.
>> Can you help explain more?
>>
>> It looks to me like reasonable.
>> Enable/disable clock in driver is just one case, the initial clock tree may
>> also have such cases.
>> (Here i took the 'children clocks' you said as the one who's child clock is on
>> in HW while refcount is zero, fix me if wrong)
>>
>> And it seems not so quite make sense to not physically disable the clock
>> when there's already no child users(refcount becomes zero) and i don't
>> think the child clock's default enablement state in HW means a valid user
>> since it's just caused by misalignment between HW and SW clock tree during
>> kernel booting phase which is meaningless.
>> And that seems is why the clk_disable_unused() function exist for fixing
>> this state misalignment issue.
>>
>> > Mike Turquette has been doing
>> > some work to have a way to indicate that certain clocks should be
>> > kept on until client drivers grab them.
>>
>> Sorry i can't see how this help on my issue.
>>
>> > I think it will also make
>> > sure to up refcounts on parent clocks in the middle of the tree
>> > when it figures out that a child clock is enabled. Would that be
>> > all that we need to do to fix this problem?
>> >
>>
>> Then when will we down the refcounts on parent clocks and when to disable it?
>> The current clk_disable_unused() only handle HW clk enable/disable, no
>> refcount operations.
>> Not sure how this is going to fix my issues.
>>
>> And again, as i said above, i don't think it makes much sense to not disable
>> parent only if child is enabled in HW, unless there's more strong reasons.
>>
>> > Also, the subject of this patch and patch 5 are the same. Why?
>> >
>>
>> Sorry, mainly because the full feature of CLK_OPS_PARENT_ON is divided into
>> two patches for better review, their commit message is different.
>> patch 4 is adding support for clk_disable_unused() while patch 5 is for
>> clk_setrate/clk_reparent.
>> I could reform the subject if needed.
>>
>> Regards
>> Dong Aisheng
>>
>
> Hi Mike & Stephen,
>
> Any comments about this?
>
> Regards
> Dong Aisheng
>
>> > --
>> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>> > a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
