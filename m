From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 16 Jul 2014 09:20:52 +0200
Subject: [PATCH 1/6] clk: tegra: don't abort clk init on error
In-Reply-To: <1405437890-6468-2-git-send-email-pdeschrijver@nvidia.com>
References: <1405437890-6468-1-git-send-email-pdeschrijver@nvidia.com>
 <1405437890-6468-2-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20140716072051.GC7978@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 06:24:31PM +0300, Peter De Schrijver wrote:
> Just continue initializing clocks if there's an error on one of them. This
> is useful if there's a mistake in the inittable, because the system could
> hang if clk_disable_unused() disables some of the critical clocks in this
> table.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/clk/tegra/clk.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
> index c0a7d77..d081732 100644
> --- a/drivers/clk/tegra/clk.c
> +++ b/drivers/clk/tegra/clk.c
> @@ -207,7 +207,7 @@ void __init tegra_init_from_table(struct tegra_clk_init_table *tbl,
>  	for (; tbl->clk_id < clk_max; tbl++) {
>  		clk = clks[tbl->clk_id];
>  		if (IS_ERR_OR_NULL(clk))
> -			return;
> +			continue;

Perhaps rather than silently ignoring, should this at least print out an
error? I'd even go as far as make it a full-blown WARN to make sure
people notice and this gets fixed early.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/e19dc78a/attachment.sig>
