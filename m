From: jangra.pankaj9@gmail.com (Pankaj Jangra)
Date: Fri, 22 Jun 2012 23:12:17 +0530
Subject: [PATCH 01/11] ARM: omap: clk: add clk_prepare and clk_unprepare
In-Reply-To: <1340372890-10091-2-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-2-git-send-email-rnayak@ti.com>
Message-ID: <CADTbHxr27_DSrF4amviGicb2_5_=eTx19YecgeAOM5SGrnvscA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 22, 2012 at 7:18 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> As part of Common Clk Framework (CCF) the clk_enable() operation
> was split into a clk_prepare() which could sleep, and a clk_enable()
> which should never sleep. Similarly the clk_disable() was
> split into clk_disable() and clk_unprepare(). This was
> needed to handle complex cases where in a clk gate/ungate
> would require a slow and a fast part to be implemented.
> None of the clocks below seem to be in the 'complex' clocks
> category and are just simple clocks which are enabled/disabled
> through simple register writes.
> Most of the instances also seem to be called in non-atomic
> context which means its safe to move all of those from
> using a clk_enable() to clk_prepare_enable() and clk_disable() to
> clk_disable_unprepare().
> For a few others where there is a possibility they get called from
> an interrupt or atomic context, there is an additonal clk_prepare()
> done immediately following a clk_get() and a clk_unprepare()
> immediately preceding the clk_put().
> This is in preparation of OMAP moving to CCF.
>
> Based on initial changes from Mike turquette.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
> ?arch/arm/mach-omap2/board-apollon.c ? ? | ? ?4 ++--
> ?arch/arm/mach-omap2/board-h4.c ? ? ? ? ?| ? ?6 +++---
> ?arch/arm/mach-omap2/board-omap4panda.c ?| ? ?2 +-
> ?arch/arm/mach-omap2/clock3xxx.c ? ? ? ? | ? ?8 ++++----
> ?arch/arm/mach-omap2/display.c ? ? ? ? ? | ? ?4 ++--
> ?arch/arm/mach-omap2/gpmc.c ? ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-omap2/omap_hwmod.c ? ? ? ?| ? ?3 +++
> ?arch/arm/mach-omap2/omap_phy_internal.c | ? ?3 +++
> ?arch/arm/mach-omap2/pm24xx.c ? ? ? ? ? ?| ? ?2 ++
> ?arch/arm/mach-omap2/usb-fs.c ? ? ? ? ? ?| ? ?4 ++--
> ?10 files changed, 23 insertions(+), 15 deletions(-)
>
> ?}
>

> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index 5fb47a1..e5f8e48 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -471,7 +471,7 @@ int omap_dss_reset(struct omap_hwmod *oh)
>
> ? ? ? ?for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
> ? ? ? ? ? ? ? ?if (oc->_clk)
> - ? ? ? ? ? ? ? ? ? ? ? clk_enable(oc->_clk);
> + ? ? ? ? ? ? ? ? ? ? ? clk_prepare_enable(oc->_clk);
>
> ? ? ? ?dispc_disable_outputs();
>
> @@ -498,7 +498,7 @@ int omap_dss_reset(struct omap_hwmod *oh)
>
> ? ? ? ?for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
> ? ? ? ? ? ? ? ?if (oc->_clk)
> - ? ? ? ? ? ? ? ? ? ? ? clk_disable(oc->_clk);
> + ? ? ? ? ? ? ? ? ? ? ? clk_disable_unprepare(oc->_clk);
>
Just a doubt. Isn't it the same clocks you are preparing in omap_hwmod.c ?

> ? ? ? ?r = (c == MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOUT : 0;
>
d> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
b/arch/arm/mach-omap2/omap_hwmod.c
> index bf86f7e..2746bce 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -608,6 +608,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
> ? ? ? ? ? ? ? ? ? ? ? ? ? oh->name, oh->main_clk);
> ? ? ? ? ? ? ? ?return -EINVAL;
> ? ? ? ?}
> + ? ? ? clk_prepare(oh->_clk);
>
> ? ? ? ?if (!oh->_clk->clkdm)
> ? ? ? ? ? ? ? ?pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
> @@ -644,6 +645,7 @@ static int _init_interface_clks(struct omap_hwmod *oh)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? oh->name, os->clk);
> ? ? ? ? ? ? ? ? ? ? ? ?ret = -EINVAL;
> ? ? ? ? ? ? ? ?}
> + ? ? ? ? ? ? ? clk_prepare(os->_clk);
> ? ? ? ? ? ? ? ?os->_clk = c;

You should do clk_prepare() after os->_clk = c statement. Otherwise
you are operating on a uninitialized structure pointer.
> ? ? ? ?}
>
> @@ -671,6 +673,7 @@ static int _init_opt_clks(struct omap_hwmod *oh)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? oh->name, oc->clk);
> ? ? ? ? ? ? ? ? ? ? ? ?ret = -EINVAL;
> ? ? ? ? ? ? ? ?}
> + ? ? ? ? ? ? ? clk_prepare(oc->_clk);

Same here. You are preparing the uninitialized clk structure.

> ? ? ? ? ? ? ? ?oc->_clk = c;
> ? ? ? ?}
>
d
