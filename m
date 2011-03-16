From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Mar 2011 16:51:04 +0100
Subject: PATCH [1/1] Clock support for VT8500/WM8505
In-Reply-To: <76F764B079F92A4E843589C893D0A0228D36@SERVER.prisktech.co.nz>
References: <76F764B079F92A4E843589C893D0A0228D36@SERVER.prisktech.co.nz>
Message-ID: <201103161651.05039.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

I just noticed that nobody has commented on these patches yet. The seems
generally well-written, but it does not completely follow the coding
style that we expect, so please consider these comments.

On Sunday 27 February 2011, Linux Mailing List Email Account wrote:
> Signed-off-by: Tony Prisk (linux at prisktech.co.nz)

When sending out emails for review and/or inclusion, please use the
following style:

* Use your own name as "From", it will be put in the author field
  when imported to git, so it should not say "Linux Mailing List
  Email Account"
* Always use unique subject lines for each patch, with a clear
  distinction between the parts of one series. In this specific
  case, patches 0 and 1 actually belong together and there is no
  point to split them, so it should just be one patch. Group
  them by functional changes, not by file.
* The notation [PATCH 0/3] means that this email is just a description
  of the patches that are sent as replies (as git-send-email --thread
  --no-chain-reply does). In the patch 0, list what you expect
  other people to do with the series (e.g. "please review", or
  "please merge into the ... tree"), and the changes that were
  done w.r.t the previous submission of the same series.
* In each patch following, explain what the patch does and why it
  is needed, as brief or elaborate as necessary. In some cases, 
  the description will be longer than the actual patch. Don't
  just repeat the one-line description from the subject, but
  go into more depth there. Remember that this text will be what
  gets to be the git history that people read with 'git log',
  and they may only see the one-line description or the
  full changelog, but not necessarily the patch.

> +#include "clock.h"
> +
> +static LIST_HEAD(clocks);
> +
> +static DEFINE_SPINLOCK(clocks_lock);
> +static DEFINE_MUTEX(clocks_mutex);

Minor detail: the mutex is used in only one place, and that cannot sleep,
so it would be reasonable to just have the spinlock here and use it for
both.

> +static void __clk_enable(struct clk *clk)
> +{
> +    if (clk->parent)
> +          __clk_enable(clk->parent);
> +    if (clk->usecount++ == 0)
> +          if (clk->type & CLK_ENABLE)
> +               clk->ops->enable(clk);
> +}

Throughout the patches, the whitespace appears to be damaged. Please
ensure that you always use tabs for indentation and that your email
client does not turn them into spaces.

> +EXPORT_SYMBOL(clk_enable);

New code should should generally use EXPORT_SYMBOL_GPL unless there
is a good (documented) reason to use the regular EXPORT_SYMBOL.

> +static void wmt_pm_wait_update(void)
> +{
> +    while (readl(clk_pmc_base + CLK_PM_STATUS_LOW) & CLK_PML_UPDATE_MASK)
> +          ;
> +}
> +
> +static void wmt_pm_wait_busy(void)
> +{
> +    while (readl(clk_pmc_base + CLK_PM_STATUS_LOW) & CLK_PML_BUSY)
> +          ;
> +}

In a busy_loop, use cpu_relax() to document that you are waiting for an
event. It doesn't make much difference unless you are on a virtualized
or SMT platform, but it's generally good practice nonetheless.

> +void clk_cpu_speedstep(u32 plla_mul, u32 arm_div, u32 ahb_div)
> +{

> +unsigned long getrate_pll(struct clk *clk)
> +{

> +int setrate_pll(struct clk *clk, unsigned long rate)
> +{

Any function that is used only in the file where it is defined
should be marked 'static' so it does not pollute the global namespace.

> +DEFINE_CKREF(ref, 25000000);
> +
> +DEFINE_CKPGNP(pll_a, &clk_ref, 0, &clkops_pll, CLK_PLLA_MULTIPLIER);
> +DEFINE_CKPGNP(arm, &clk_pll_a, 0, &clkops_arm, CLK_ARM_DIVISOR);
> +DEFINE_CKPG(ahb, &clk_arm, 0, &clkops_ahb, CLK_AHB_DIVISOR);

I suppose these could also become

static DEFINE_CKREF(...);

	Arnd
