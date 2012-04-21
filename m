From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Apr 2012 13:42:19 +0100
Subject: [PATCH 01/13] clk: Add non CONFIG_HAVE_CLK routines
In-Reply-To: <f48165b92f52e9a879cedacaddc548ac885bf73d.1335008617.git.viresh.kumar@st.com>
References: <cover.1335008617.git.viresh.kumar@st.com>
 <f48165b92f52e9a879cedacaddc548ac885bf73d.1335008617.git.viresh.kumar@st.com>
Message-ID: <20120421124219.GH24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 21, 2012 at 05:17:28PM +0530, Viresh Kumar wrote:
> Many drivers are shared between architectures that may or may not have HAVE_CLK
> selected for them. To remove compilation errors for them we enclose clk_*()
> calls in these drivers within #ifdef CONFIG_HAVE_CLK, #endif.

All you're doing is making drivers buildable.  Drivers will not be usable
with this (they'll error out because clk_get() will fail.)

For example:

-#ifndef CONFIG_HAVE_CLK
-/* Dummy stub for clk framework */
-#define clk_get(dev, id)       NULL
-#define clk_put(clock)         do {} while (0)
-#define clk_enable(clock)      do {} while (0)
-#define clk_disable(clock)     do {} while (0)
-#endif
-

along with your change in this patch changes the drivers behaviour.

A better solution would be to assume that if HAVE_CLK is not set, then
that means there's no control over clocks, and therefore the clk API
should become totally transparent and non-failure inducing.  So, having
clk_get() return NULL, and having all the other clk API functions ignore
their argument (just like the macros above) is the right solution here.
