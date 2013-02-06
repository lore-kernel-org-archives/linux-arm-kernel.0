From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 6 Feb 2013 14:32:22 +0200
Subject: [PATCH v5 01/10] clk: tegra: Refactor PLL programming code
In-Reply-To: <20130205132355.GD3073@tbergstrom-lnx.Nvidia.com>
References: <1359713962-16822-1-git-send-email-pdeschrijver@nvidia.com>
 <1359713962-16822-2-git-send-email-pdeschrijver@nvidia.com>
 <510F4FF7.3050502@nvidia.com>
 <20130204143233.GV2364@tbergstrom-lnx.Nvidia.com>
 <51109BB3.8000706@nvidia.com>
 <20130205132355.GD3073@tbergstrom-lnx.Nvidia.com>
Message-ID: <20130206123222.GI3073@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 02:23:55PM +0100, Peter De Schrijver wrote:
> On Tue, Feb 05, 2013 at 06:42:11AM +0100, Prashant Gaikwad wrote:
> > On Monday 04 February 2013 08:02 PM, Peter De Schrijver wrote:
> > > On Mon, Feb 04, 2013 at 07:06:47AM +0100, Prashant Gaikwad wrote:
> > >> On Friday 01 February 2013 03:48 PM, Peter De Schrijver wrote:
> > > ...
> > >
> > >>> -static int clk_pll_wait_for_lock(struct tegra_clk_pll *pll,
> > >>> -                                void __iomem *lock_addr, u32 lock_bit_idx)
> > >>> +static int clk_pll_wait_for_lock(struct tegra_clk_pll *pll)
> > >>>    {
> > >>>           int i;
> > >>> -       u32 val;
> > >>> +       u32 val, lock_bit;
> > >>> +       void __iomem *lock_addr;
> > >>>
> > >>>           if (!(pll->flags & TEGRA_PLL_USE_LOCK)) {
> > >>>                   udelay(pll->params->lock_delay);
> > >>>                   return 0;
> > >>>           }
> > >>>
> > >>> +       lock_addr = pll->clk_base + pll->params->base_reg;
> > >> This will not work for PLLE. Lock bit for PLLE is in misc register.
> > >>
> > >>> +       lock_bit = BIT(pll->params->lock_bit_idx);
> > >>> +
> > >>>           for (i = 0; i < pll->params->lock_delay; i++) {
> > >>>                   val = readl_relaxed(lock_addr);
> > >>> -               if (val & BIT(lock_bit_idx)) {
> > >>> +               if (val & lock_bit) {
> > >> Need to change the lock bit idx parameter for Tegra20 and Tegra30 PLLs
> > >> else this patch will break those.
> > >>
> > > Looking at commit 37c26a906527b8a6a252614ca83d21ad318c4e84 and commit
> > > b08e8c0ecc42afa3a2e1019851af741980dd5a6b, these fields seem correctly
> > > initialized for both Tegra20 and Tegra30? Or am I missing something?
> > 
> > Ohh, I missed to read
> > 
> > lock_bit = BIT(pll->params->lock_bit_idx);
> > 
> > 
> > Am I missing something about PLLE lock_addr also?
> > 
> 
> Ah no indeed... my bad. So we need a lock_addr field.
> 

Or a flag. Flag seems less invasive for now.

Cheers,

Peter.
