From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 13 Apr 2016 12:11:08 -0700
Subject: [GIT PULL] Qualcomm Driver Updates for v4.7
In-Reply-To: <20160413184134.GJ19945@localhost>
References: <1459540776-7056-1-git-send-email-andy.gross@linaro.org>
 <20160413181002.GH19945@localhost>
 <20160413182156.GE14441@codeaurora.org>
 <20160413184134.GJ19945@localhost>
Message-ID: <20160413191108.GF14441@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13, Olof Johansson wrote:
> On Wed, Apr 13, 2016 at 11:21:56AM -0700, Stephen Boyd wrote:
> > That was part of the original series[1]. Splitting up patches
> > into topic branches is problematic here it seems.
> > 
> > [1] http://lkml.kernel.org/r/1448485478-21699-3-git-send-email-sboyd at codeaurora.org
> 
> The HAVE.* options are usually expected to be set through selects, not
> necessarily driven by a user choosing them. So I think adding a select here is
> the right way to do it.
> 
> HAVE.* options are usually used for dependencies for the user-exposed options.
> I.e. only ask if you want arch timers if HAVE_ARM_ARCH_TIMERS is set, etc.
> 

Agreed. Perhaps the name is bad? I don't know the history of the
Kconfig, but HAVE_ARM_ARCH_TIMER is a user visible option, so
selecting it in Kconfig language doesn't make much sense to me.
Some other platforms are following the same design where it's
part of the defconfig while others are selecting it from Kconfig.
Mass confusion has set in.

If we want to change the design to be selected by all platforms
then we'll need to make HAVE_ARM_ARCH_TIMER into a hidden Kconfig
option so that users can't turn it off. In fact, we may want to
just obliterate the Kconfig entirely and have users select
ARM_ARCH_TIMER directly. Everything is multi-platform now, right?
If so then GENERIC_CLOCKEVENTS is selected all the time on CPU_V7
and the CPU_V7 dependency is not helping much.

Honestly, I view these clocksource selects as the only blocker in
the effort to get rid of machine type Kconfigs. Maybe that isn't
a good goal though.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
