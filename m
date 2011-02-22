From: ccross@google.com (Colin Cross)
Date: Mon, 21 Feb 2011 19:21:42 -0800
Subject: [PATCH 4/4] ARM: tegra: Move pinmux init call
In-Reply-To: <1298173137-9242-5-git-send-email-swarren@nvidia.com>
References: <1298173137-9242-1-git-send-email-swarren@nvidia.com>
	<1298173137-9242-5-git-send-email-swarren@nvidia.com>
Message-ID: <AANLkTimcadeAHWuFApw_H+AEs+hgURxCRO2X92M9cehG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 19, 2011 at 7:38 PM, Stephen Warren <swarren@nvidia.com> wrote:
> In order for the clock initialization to pick up the results of the
> pinmux initialization (which will initialize various parameters of
> clocks cdev1, cdev2), the pinmux initialization must happen first.
> Move the pinmux init to achieve this.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> ?arch/arm/mach-tegra/board-harmony.c ? | ? ?4 ++--
> ?arch/arm/mach-tegra/board-trimslice.c | ? ?4 ++--
> ?2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
> index b9dbdb1..eea5ad6 100644
> --- a/arch/arm/mach-tegra/board-harmony.c
> +++ b/arch/arm/mach-tegra/board-harmony.c
> @@ -104,12 +104,12 @@ static __initdata struct tegra_clk_init_table harmony_clk_init_table[] = {
>
> ?static void __init tegra_harmony_init(void)
> ?{
> + ? ? ? harmony_pinmux_init();
> +
> ? ? ? ?tegra_common_init();
>
> ? ? ? ?tegra_clk_init_from_table(harmony_clk_init_table);
>
> - ? ? ? harmony_pinmux_init();
> -
> ? ? ? ?platform_add_devices(harmony_devices, ARRAY_SIZE(harmony_devices));
> ?}
>
> diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
> index ef233b2..aef6abb 100644
> --- a/arch/arm/mach-tegra/board-trimslice.c
> +++ b/arch/arm/mach-tegra/board-trimslice.c
> @@ -85,12 +85,12 @@ subsys_initcall(tegra_trimslice_pci_init);
>
> ?static void __init tegra_trimslice_init(void)
> ?{
> + ? ? ? trimslice_pinmux_init();
> +
> ? ? ? ?tegra_common_init();
>
> ? ? ? ?tegra_clk_init_from_table(trimslice_clk_init_table);
>
> - ? ? ? trimslice_pinmux_init();
> -
> ? ? ? ?platform_add_devices(trimslice_devices, ARRAY_SIZE(trimslice_devices));
> ?}

This isn't going to work any more.  In order for the timer to get a
reference to its clock, clocks have to be up before the system timer
is initialized, so Russell added an init_early hook for clock
initialization.  init_machine happens much later, so the per-board
pinmux init will always happen after clock init.

The calls from clk_dev1/2 init into tegra_pinmux_get_func should be
fine, but they will pick up the bootloader's settings instead of the
board pinmux table settings.  You would need to use the pinmux tables
to untristate the pins (or maybe add untristating, but not
re-tristating, to the clk_enable op?), and add clk_dev1/2 entries to
the clock init table to set the parent to get the correct pinmux
settings.
