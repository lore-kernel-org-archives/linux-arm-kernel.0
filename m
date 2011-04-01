From: ccross@android.com (Colin Cross)
Date: Fri, 1 Apr 2011 13:39:27 -0700
Subject: [PATCH] arm: tegra: fix error check in tegra2_clocks.c
In-Reply-To: <20110330155911.6dc0ef63@absol.kitzblitz>
References: <20110330155911.6dc0ef63@absol.kitzblitz>
Message-ID: <BANLkTimxRd6X2JhchrVw45MpbdpQw8Zpeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 6:59 AM, Nicolas Kaiser <nikai@nikai.net> wrote:
> Checking 'rate < 0' doesn't work because 'rate' is unsigned.
>
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
> ---
> Untested.
>
> ?arch/arm/mach-tegra/tegra2_clocks.c | ? ?9 +++++----
> ?1 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
> index 6d7c4ee..4459470 100644
> --- a/arch/arm/mach-tegra/tegra2_clocks.c
> +++ b/arch/arm/mach-tegra/tegra2_clocks.c
> @@ -1362,14 +1362,15 @@ static int tegra_clk_shared_bus_set_rate(struct clk *c, unsigned long rate)
> ?{
> ? ? ? ?unsigned long flags;
> ? ? ? ?int ret;
> + ? ? ? long new_rate = rate;
>
> - ? ? ? rate = clk_round_rate(c->parent, rate);
> - ? ? ? if (rate < 0)
> - ? ? ? ? ? ? ? return rate;
> + ? ? ? new_rate = clk_round_rate(c->parent, new_rate);
> + ? ? ? if (new_rate < 0)
> + ? ? ? ? ? ? ? return new_rate;
>
> ? ? ? ?spin_lock_irqsave(&c->parent->spinlock, flags);
>
> - ? ? ? c->u.shared_bus_user.rate = rate;
> + ? ? ? c->u.shared_bus_user.rate = new_rate;
> ? ? ? ?ret = tegra_clk_shared_bus_update(c->parent);
>
> ? ? ? ?spin_unlock_irqrestore(&c->parent->spinlock, flags);
> --
> 1.7.3.4
>

Acked-by: Colin Cross <ccross@android.com>
