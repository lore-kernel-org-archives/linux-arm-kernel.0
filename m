From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 Jul 2014 11:15:21 -0600
Subject: [PATCH 2/6] clk: tegra: make tegra_clocks_apply_init_table
 arch_initcall
In-Reply-To: <1405437890-6468-3-git-send-email-pdeschrijver@nvidia.com>
References: <1405437890-6468-1-git-send-email-pdeschrijver@nvidia.com>
 <1405437890-6468-3-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <53CE9C29.5030508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2014 09:24 AM, Peter De Schrijver wrote:
> tegra_clocks_apply_init_table needs to be called after the udelay loop has
> been calibrated (see 441f199a37cfd66c5dd8dd45490bd3ea6971117d why that is).

Instead of just the commit ID, can you please mention the commit subject
too:

441f199a37cf "clk: tegra: defer application of init table"

> On existing Tegra SoCs this was done by calling tegra_clocks_apply_init_table
> from tegra_dt_init. To make this also work on ARM64, we need to
> change this into an initcall. tegra_dt_init is called from customize_machine
> which is an arch_initcall. Therefore this should also work on existing 32bit
> Tegra SoCs.

I still strongly dislike performing this basic initialization from
random separate initcalls. I think we should create a single initcall
for all the Tegra initialization, even if it isn't able to be a machine
descriptor hook function any more.

That said, discussions re: that are ongoing in other threads, so it's no
worth reworking this patch yet.
