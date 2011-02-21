From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Feb 2011 20:18:10 -0800
Subject: [PATCH v2 14/21] ARM: tegra: clock: Refcount periph clock enables
In-Reply-To: <1298154371-5641-16-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-16-git-send-email-ccross@android.com>
Message-ID: <AANLkTin8AmjM2CWoNh54NmyV6=298bGzDUPO+j4LTrBj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 19, 2011 at 2:26 PM, Colin Cross <ccross@android.com> wrote:
> Some peripheral clocks share enable bits. ?Refcount the enables so
> that calling clk_disable on one clock will not turn off another
> clock.
>
> Signed-off-by: Colin Cross <ccross@android.com>
> ---
> ?arch/arm/mach-tegra/tegra2_clocks.c | ? 35 +++++++++++++++++++++++++++++------
> ?1 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
> index 196c249..2734889 100644
> --- a/arch/arm/mach-tegra/tegra2_clocks.c
> +++ b/arch/arm/mach-tegra/tegra2_clocks.c
> @@ -154,6 +154,12 @@ static void __iomem *reg_pmc_base = IO_ADDRESS(TEGRA_PMC_BASE);
> ?*/
> ?static DEFINE_SPINLOCK(clock_register_lock);
>
> +/*
> + * Some peripheral clocks share an enable bit, so refcount the enable bits
> + * in registers CLK_ENABLE_L, CLK_ENABLE_H, and CLK_ENABLE_U
> + */
> +static int tegra_periph_clk_enable_refcount[3 * 32];

Given that this is always locked when incrementing/decrementing,
should it just be switched to an array of atomics instead?


-Olof
