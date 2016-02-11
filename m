From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 10 Feb 2016 17:00:58 -0800
Subject: [PATCH 0/3] clk: Add support for critical clocks
In-Reply-To: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
References: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20160211010058.26445.37542@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

Quoting Lee Jones (2016-01-18 06:28:48)
> Some platforms contain clocks which if gated, will cause undefined or
> catastrophic behaviours.  As such they are not to be turned off, ever.
> Many of these such clocks do not have devices, thus device drivers
> where clocks may be enabled and references taken to ensure they stay
> enabled do not exist.  Therefore, we must handle these such cases in
> the core.
> 
> This patchset defines an CLK_IS_CRITICAL flag which the core can use
> to identify critical clocks and subsequently refuse to gate them.
> Once a clock has been recognised as critical, we take extra
> references to ensure the continued functionality of the clock
> whatever else happens.
> 
> Mike,
> 
> It's been 17 weeks since our meeting in San Francisco and I'm keen to
> move this forward.  As per our meeting, the plan is to separate our
> two requirements, as users who require both critical clocks AND the
> hand-off feature do not currently exist.  If you'd like to continue
> enablement of the hand-off functionality you were interested in, I'll
> continue on with critical clocks, as we still need this for our
> platform.
> 
> I'm hoping this isn't the wrong approach, but if it is, let me know
> how it can be improved and I'll re-roll.

Thanks for getting this going again. I've made tiny modifications to
your patches and reposted in this thread (w/ attribution to you of
course). Please let me know what you think.

Regarding Architecting The Perfect Solution, my take away from our
face-to-face discussion wass that handoff clocks covered every need of
critical (always on) clocks with a single exception, and that exception
is enough to merit supporting both.

The one area where we disagree is support for the DT property. You need
this because at least one of the platforms you care about use an
unfortunate, legacy clock binding style that came from a time before we
knew any better.

I definitely will never add a critical-clock property to the common
clock binding, but I cannot leave you without a solution either. I've
added kerneldoc around the function that sets the critical clock flag
making it clear that it should only be called from the setup functions
for clocks using the legacy binding style. It won't be called from
clk_register, __clk_init, or otherwise, but on a per-driver basis. This
removes the need for drivers to open code a solution where they match on
clk string name and add the flag or something super gross like that.

I will also repost my 3 handoff patches, rebased on top of your 3
critical clock patches. I'm sure they'll be pals and get along just
great.

Best regards,
Mike

> 
> Kind regards,
> Lee
> 
> Lee Jones (3):
>   clk: Allow clocks to be marked as CRITICAL
>   clk: WARN_ON about to disable a critical clock
>   clk: Provide OF helper to mark clocks as CRITICAL
> 
>  drivers/clk/clk.c            | 13 ++++++++++++-
>  include/linux/clk-provider.h | 23 +++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> -- 
> 1.9.1
> 
