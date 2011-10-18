From: ccross@android.com (Colin Cross)
Date: Tue, 18 Oct 2011 11:23:46 -0700
Subject: [PATCH] [3.3] ARM: tegra: emc: max rate based on emc table
In-Reply-To: <1318961694-21105-1-git-send-email-olof@lixom.net>
References: <1318961694-21105-1-git-send-email-olof@lixom.net>
Message-ID: <CAMbhsRSgLvvPMd69z7aa8A=9ndYuUkmhmsEzK4WFd3AsQBohzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 11:14 AM, Olof Johansson <olof@lixom.net> wrote:
> Update max rate for emc clock based on configured EMC timings,
> but by default leave it at the same rate that firmware configured.
>
> Also update the shared clocks accordingly.
>
> This patch was based on work by Danny Huang <dahuang@nvidia.com>.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> ?arch/arm/mach-tegra/tegra2_emc.c | ? 19 +++++++++++++++++++
> ?1 files changed, 19 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/tegra2_emc.c b/arch/arm/mach-tegra/tegra2_emc.c
> index 0f7ae6e..bed7e74 100644
> --- a/arch/arm/mach-tegra/tegra2_emc.c
> +++ b/arch/arm/mach-tegra/tegra2_emc.c
> @@ -23,6 +23,7 @@
>
> ?#include <mach/iomap.h>
>
> +#include "clock.h"
> ?#include "tegra2_emc.h"
>
> ?#ifdef CONFIG_TEGRA_EMC_SCALING_ENABLE
> @@ -173,6 +174,24 @@ int tegra_emc_set_rate(unsigned long rate)
>
> ?void tegra_init_emc(const struct tegra_emc_table *table, int table_size)
> ?{
> + ? ? ? struct clk *c = clk_get_sys("emc", NULL);
> + ? ? ? struct clk *user;
> + ? ? ? unsigned long max = 0;
> + ? ? ? int i;
> +
> + ? ? ? /* Since default max_rate on emc clock is the same as firmware set
> + ? ? ? ?* it to before booting, raise it up here based on known timings.
> + ? ? ? ?*/
> +
> + ? ? ? for (i = 0; i < table_size; i++)
> + ? ? ? ? ? ? ? if (table[i].rate > max)
> + ? ? ? ? ? ? ? ? ? ? ? max = table[i].rate;
> +
> ? ? ? ?tegra_emc_table = table;
> ? ? ? ?tegra_emc_table_size = table_size;
> +
> + ? ? ? c->max_rate = max * 2 * 1000;
I don't think you should be modifying internal variables of the struct
clk from here.

> +
> + ? ? ? list_for_each_entry(user, &c->shared_bus_list, u.shared_bus_user.node)
> + ? ? ? ? ? ? ? user->max_rate = c->max_rate;
> ?}
> --
> 1.7.4.1
>
>
