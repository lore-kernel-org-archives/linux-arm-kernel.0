From: ccross@android.com (Colin Cross)
Date: Wed, 24 Nov 2010 15:41:58 -0800
Subject: [PATCH] ARM: tegra: irq: protect irq suspend with CONFIG_PM
In-Reply-To: <3C7A7ACA8617D24290826EC008B5CD0817D747F9E6@HQMAIL03.nvidia.com>
References: <3C7A7ACA8617D24290826EC008B5CD0817D747F9E6@HQMAIL03.nvidia.com>
Message-ID: <AANLkTi=PMGDD--dH1uZen-Yhm5ZM3JUOr7b-QCUhcyp_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 19, 2010 at 2:50 PM, Allen Martin <AMartin@nvidia.com> wrote:
> Protect irq suspend/resume functions behind #ifdef CONFIG_PM.
> This prevents a link error if CONFIG_PM is turned off.
>
> Signed-off-by: Allen Martin <amartin@nvidia.com>
> ---
> ?arch/arm/mach-tegra/irq.c | ? ?4 ++++
> ?1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
> index 458f9c8..47b7064 100644
> --- a/arch/arm/mach-tegra/irq.c
> +++ b/arch/arm/mach-tegra/irq.c
> @@ -146,6 +146,7 @@ void tegra_set_lp0_wake_pads(u32 wake_enb, u32 wake_level, u32 wake_any)
> ? ? ? ?writel(wake_enb, pmc + PMC_WAKE_MASK);
> ?}
>
> +#ifdef CONFIG_PM
> ?static void tegra_irq_handle_wake(void)
> ?{
> ? ? ? ?int wake;
> @@ -174,6 +175,7 @@ static void tegra_irq_handle_wake(void)
> ? ? ? ? ? ? ? ?generic_handle_irq(irq);
> ? ? ? ?}
> ?}
> +#endif
>
> ?static void tegra_mask(unsigned int irq)
> ?{
> @@ -251,6 +253,7 @@ void __init tegra_init_irq(void)
> ? ? ? ?}
> ?}
>
> +#ifdef CONFIG_PM
> ?void tegra_irq_suspend(void)
> ?{
> ? ? ? ?tegra_legacy_irq_suspend();
> @@ -261,6 +264,7 @@ void tegra_irq_resume(void)
> ? ? ? ?tegra_legacy_irq_resume();
> ? ? ? ?tegra_irq_handle_wake();
> ?}
> +#endif
>
> ?#ifdef CONFIG_DEBUG_FS
> ?static int tegra_wake_irq_debug_show(struct seq_file *s, void *data)
> --
> 1.7.2.3
>
>

Acked.  I'll put it in the tegra repository for now, it will go into
for-next with the next batch of updates.

Your mailer is also converting tabs to spaces.
