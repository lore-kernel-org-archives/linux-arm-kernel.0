From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 16 Jul 2014 09:19:33 +0200
Subject: [PATCH 2/6] clk: tegra: make tegra_clocks_apply_init_table
 arch_initcall
In-Reply-To: <1405437890-6468-3-git-send-email-pdeschrijver@nvidia.com>
References: <1405437890-6468-1-git-send-email-pdeschrijver@nvidia.com>
 <1405437890-6468-3-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20140716071932.GB7978@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 06:24:32PM +0300, Peter De Schrijver wrote:
[...]
> diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
> index d081732..65cde4e 100644
> --- a/drivers/clk/tegra/clk.c
> +++ b/drivers/clk/tegra/clk.c
> @@ -290,10 +290,13 @@ struct clk ** __init tegra_lookup_dt_id(int clk_id,
>  
>  tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
>  
> -void __init tegra_clocks_apply_init_table(void)
> +static int __init tegra_clocks_apply_init_table(void)
>  {
>  	if (!tegra_clk_apply_init_table)
> -		return;
> +		return 0;

Shouldn't this be an error? Or perhaps WARN()? To make sure this gets
noticed since it's obviously a mistake. I'm wondering if perhaps we
could simply remove this check and let the kernel crash if it isn't a
valid function pointer. Is there a case where this not being set at
this point is even possible (or valid?). If not, perhaps it would be
better to just call the SoC generation versions of this function from
here directly rather than going through a function pointer?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/bd078c9d/attachment-0001.sig>
