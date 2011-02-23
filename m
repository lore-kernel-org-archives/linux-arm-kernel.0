From: ccross@android.com (Colin Cross)
Date: Wed, 23 Feb 2011 13:08:01 -0800
Subject: [PATCH 5/5] ARM: Tegra: Enable Harmony audio support
In-Reply-To: <1298487532-5000-6-git-send-email-swarren@nvidia.com>
References: <1298487532-5000-1-git-send-email-swarren@nvidia.com>
	<1298487532-5000-6-git-send-email-swarren@nvidia.com>
Message-ID: <AANLkTi=Nxh8YKBSDhVVAW4Sqzd6yKj=D6X=R+9KT+UBK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 10:58 AM, Stephen Warren <swarren@nvidia.com> wrote:
> * Set up platform data required by I2C, and ASoC machine & codec drivers.
> * Enable required GPIO pins as GPIOs.
> * Initialize audio-related clocks.
> * Correctly configure pinmux for audio-related GPIOs.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> NOTE: This patch will not apply until Olof's recently posted
> boards-for-next branch is merged.
>
> NOTE: This patch will not apply until the following two commits are
> present in Tegra for-next:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git
> 7cfe56172ac14d2031f1896ecb629033f71caafa
> ASoC: wm8903: Expose GPIOs through gpiolib
> Mark said he'd be OK with this being cherry-picked into the Tegra tree.
>
> git://git.fluff.org/bjdooks/linux.git
> db811ca0f48578f9940f49f284ac81e336b264ad
> i2c: tegra: Add i2c support
> Ben hasn't been asked whether a cherry-pick is OK. We could ask, or simply
> wait for the merge window to be open, Linus' tree to pick this change up,
> Tegra for-next to be rebased on Linus' tree, and then apply the patch below.
>
> Note: I manually tested cherry-picking both those changes into Tegra for-next,
> merging Olof's branch, and applying this patch series. The build succeeded,
> and Harmony booted to a shell prompt.
>
> ?arch/arm/mach-tegra/board-harmony-pinmux.c | ? 16 +++++---
> ?arch/arm/mach-tegra/board-harmony.c ? ? ? ?| ? 58 ++++++++++++++++++++++++++++
> ?arch/arm/mach-tegra/board-harmony.h ? ? ? ?| ? ?7 +++
> ?3 files changed, 75 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/board-harmony-pinmux.c b/arch/arm/mach-tegra/board-harmony-pinmux.c
> index 3ada474..4d63e2e 100644
> --- a/arch/arm/mach-tegra/board-harmony-pinmux.c
> +++ b/arch/arm/mach-tegra/board-harmony-pinmux.c
> @@ -27,11 +27,11 @@ static struct tegra_pingroup_config harmony_pinmux[] = {
> ? ? ? ?{TEGRA_PINGROUP_ATC, ? TEGRA_MUX_NAND, ? ? ? ? ?TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_NORMAL},
> ? ? ? ?{TEGRA_PINGROUP_ATD, ? TEGRA_MUX_GMI, ? ? ? ? ? TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_NORMAL},
> ? ? ? ?{TEGRA_PINGROUP_ATE, ? TEGRA_MUX_GMI, ? ? ? ? ? TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_NORMAL},
> - ? ? ? {TEGRA_PINGROUP_CDEV1, TEGRA_MUX_OSC, ? ? ? ? ? TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
> + ? ? ? {TEGRA_PINGROUP_CDEV1, TEGRA_MUX_PLLA_OUT, ? ? ?TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_NORMAL},
> ? ? ? ?{TEGRA_PINGROUP_CDEV2, TEGRA_MUX_PLLP_OUT4, ? ? TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
> ? ? ? ?{TEGRA_PINGROUP_CRTP, ?TEGRA_MUX_CRT, ? ? ? ? ? TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_TRISTATE},
> ? ? ? ?{TEGRA_PINGROUP_CSUS, ?TEGRA_MUX_VI_SENSOR_CLK, TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
> - ? ? ? {TEGRA_PINGROUP_DAP1, ?TEGRA_MUX_DAP1, ? ? ? ? ?TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_TRISTATE},
> + ? ? ? {TEGRA_PINGROUP_DAP1, ?TEGRA_MUX_DAP1, ? ? ? ? ?TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_NORMAL},
> ? ? ? ?{TEGRA_PINGROUP_DAP2, ?TEGRA_MUX_DAP2, ? ? ? ? ?TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_TRISTATE},
> ? ? ? ?{TEGRA_PINGROUP_DAP3, ?TEGRA_MUX_DAP3, ? ? ? ? ?TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_TRISTATE},
> ? ? ? ?{TEGRA_PINGROUP_DAP4, ?TEGRA_MUX_DAP4, ? ? ? ? ?TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_TRISTATE},
> @@ -114,13 +114,13 @@ static struct tegra_pingroup_config harmony_pinmux[] = {
> ? ? ? ?{TEGRA_PINGROUP_SLXK, ?TEGRA_MUX_PCIE, ? ? ? ? ?TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_TRISTATE},
> ? ? ? ?{TEGRA_PINGROUP_SPDI, ?TEGRA_MUX_RSVD2, ? ? ? ? TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_TRISTATE},
> ? ? ? ?{TEGRA_PINGROUP_SPDO, ?TEGRA_MUX_RSVD2, ? ? ? ? TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_TRISTATE},
> - ? ? ? {TEGRA_PINGROUP_SPIA, ?TEGRA_MUX_GMI, ? ? ? ? ? TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
> - ? ? ? {TEGRA_PINGROUP_SPIB, ?TEGRA_MUX_GMI, ? ? ? ? ? TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
> - ? ? ? {TEGRA_PINGROUP_SPIC, ?TEGRA_MUX_GMI, ? ? ? ? ? TEGRA_PUPD_PULL_UP, ? TEGRA_TRI_NORMAL},
> + ? ? ? {TEGRA_PINGROUP_SPIA, ?TEGRA_MUX_GMI, ? ? ? ? ? TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_NORMAL},
> + ? ? ? {TEGRA_PINGROUP_SPIB, ?TEGRA_MUX_GMI, ? ? ? ? ? TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_NORMAL},
> + ? ? ? {TEGRA_PINGROUP_SPIC, ?TEGRA_MUX_GMI, ? ? ? ? ? TEGRA_PUPD_PULL_UP, ? TEGRA_TRI_TRISTATE},
> ? ? ? ?{TEGRA_PINGROUP_SPID, ?TEGRA_MUX_SPI1, ? ? ? ? ?TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
> ? ? ? ?{TEGRA_PINGROUP_SPIE, ?TEGRA_MUX_SPI1, ? ? ? ? ?TEGRA_PUPD_PULL_UP, ? TEGRA_TRI_TRISTATE},
> ? ? ? ?{TEGRA_PINGROUP_SPIF, ?TEGRA_MUX_SPI1, ? ? ? ? ?TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
> - ? ? ? {TEGRA_PINGROUP_SPIG, ?TEGRA_MUX_SPI2_ALT, ? ? ?TEGRA_PUPD_PULL_UP, ? TEGRA_TRI_TRISTATE},
> + ? ? ? {TEGRA_PINGROUP_SPIG, ?TEGRA_MUX_SPI2_ALT, ? ? ?TEGRA_PUPD_NORMAL, ? ?TEGRA_TRI_TRISTATE},
> ? ? ? ?{TEGRA_PINGROUP_SPIH, ?TEGRA_MUX_SPI2_ALT, ? ? ?TEGRA_PUPD_PULL_UP, ? TEGRA_TRI_TRISTATE},
> ? ? ? ?{TEGRA_PINGROUP_UAA, ? TEGRA_MUX_ULPI, ? ? ? ? ?TEGRA_PUPD_PULL_UP, ? TEGRA_TRI_TRISTATE},
> ? ? ? ?{TEGRA_PINGROUP_UAB, ? TEGRA_MUX_ULPI, ? ? ? ? ?TEGRA_PUPD_PULL_UP, ? TEGRA_TRI_TRISTATE},
> @@ -147,6 +147,10 @@ static struct tegra_gpio_table gpio_table[] = {
> ? ? ? ?{ .gpio = TEGRA_GPIO_SD4_CD, ? ? ? ? ? ?.enable = true ?},
> ? ? ? ?{ .gpio = TEGRA_GPIO_SD4_WP, ? ? ? ? ? ?.enable = true ?},
> ? ? ? ?{ .gpio = TEGRA_GPIO_SD4_POWER, ? ? ? ? .enable = true ?},
> + ? ? ? { .gpio = TEGRA_GPIO_CDC_IRQ, ? ? ? ? ? .enable = true ?},
> + ? ? ? { .gpio = TEGRA_GPIO_HP_DET, ? ? ? ? ? ?.enable = true ?},
> + ? ? ? { .gpio = TEGRA_GPIO_INT_MIC_EN, ? ? ? ?.enable = true ?},
> + ? ? ? { .gpio = TEGRA_GPIO_EXT_MIC_EN, ? ? ? ?.enable = true ?},
> ?};
>
> ?void harmony_pinmux_init(void)
> diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
> index 2c4a234..afa4b5e 100644
> --- a/arch/arm/mach-tegra/board-harmony.c
> +++ b/arch/arm/mach-tegra/board-harmony.c
> @@ -2,6 +2,7 @@
> ?* arch/arm/mach-tegra/board-harmony.c
> ?*
> ?* Copyright (C) 2010 Google, Inc.
> + * Copyright (C) 2011 NVIDIA, Inc.
> ?*
> ?* This software is licensed under the terms of the GNU General Public
> ?* License version 2, as published by the Free Software Foundation, and
> @@ -21,13 +22,19 @@
> ?#include <linux/clk.h>
> ?#include <linux/dma-mapping.h>
> ?#include <linux/pda_power.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-tegra.h>
> ?#include <linux/io.h>
>
> +#include <sound/wm8903.h>
> +
> ?#include <asm/mach-types.h>
> ?#include <asm/mach/arch.h>
> ?#include <asm/mach/time.h>
> ?#include <asm/setup.h>
>
> +#include <mach/gpio.h>
> +#include <mach/harmony_audio.h>
> ?#include <mach/iomap.h>
> ?#include <mach/irqs.h>
> ?#include <mach/sdhci.h>
> @@ -60,11 +67,31 @@ static struct platform_device debug_uart = {
> ? ? ? ?},
> ?};
>
> +static struct harmony_audio_platform_data harmony_audio_pdata = {
> + ? ? ? .gpio_spkr_en ? ? ? ? ? = TEGRA_GPIO_SPKR_EN,
> + ? ? ? .gpio_hp_det ? ? ? ? ? ?= TEGRA_GPIO_HP_DET,
> + ? ? ? .gpio_int_mic_en ? ? ? ?= TEGRA_GPIO_INT_MIC_EN,
> + ? ? ? .gpio_ext_mic_en ? ? ? ?= TEGRA_GPIO_EXT_MIC_EN,
> +};
> +
> +static struct platform_device harmony_audio_device = {
> + ? ? ? .name ? = "tegra-snd-harmony",
> + ? ? ? .id ? ? = 0,
> + ? ? ? .dev ? ?= {
> + ? ? ? ? ? ? ? .platform_data ?= &harmony_audio_pdata,
> + ? ? ? },
> +};
> +
> ?static struct platform_device *harmony_devices[] __initdata = {
> ? ? ? ?&debug_uart,
> ? ? ? ?&tegra_sdhci_device1,
> ? ? ? ?&tegra_sdhci_device2,
> ? ? ? ?&tegra_sdhci_device4,
> + ? ? ? &tegra_i2c_device1,
> + ? ? ? &tegra_i2s_device1,
> + ? ? ? &tegra_das_device,
> + ? ? ? &tegra_pcm_device,
> + ? ? ? &harmony_audio_device,
> ?};
>
> ?static void __init tegra_harmony_fixup(struct machine_desc *desc,
> @@ -80,6 +107,10 @@ static void __init tegra_harmony_fixup(struct machine_desc *desc,
> ?static __initdata struct tegra_clk_init_table harmony_clk_init_table[] = {
> ? ? ? ?/* name ? ? ? ? parent ? ? ? ? ?rate ? ? ? ? ? ?enabled */
> ? ? ? ?{ "uartd", ? ? ?"pll_p", ? ? ? ?216000000, ? ? ?true },
> + ? ? ? { "pll_a", ? ? ?"pll_p_out1", ? 56448000, ? ? ? true },
> + ? ? ? { "pll_a_out0", "pll_a", ? ? ? ?11289600, ? ? ? true },
> + ? ? ? { "cdev1", ? ? ?NULL, ? ? ? ? ? 0, ? ? ? ? ? ? ?true },
> + ? ? ? { "i2s1", ? ? ? "pll_a_out0", ? 11289600, ? ? ? false},
> ? ? ? ?{ NULL, ? ? ? ? NULL, ? ? ? ? ? 0, ? ? ? ? ? ? ?0},
> ?};
>
> @@ -103,6 +134,30 @@ static struct tegra_sdhci_platform_data sdhci_pdata4 = {
> ? ? ? ?.is_8bit ? ? ? ?= 1,
> ?};
>
> +static struct tegra_i2c_platform_data i2c_pdata1 = {
> + ? ? ? .bus_clk_rate = 400000,
> +};
> +
> +static struct wm8903_platform_data harmony_wm8903_pdata = {
> + ? ? ? .irq_active_low = 0,
> + ? ? ? .micdet_cfg = 0,
> + ? ? ? .micdet_delay = 100,
> + ? ? ? .gpio_base = GPIO_WM8903(0),
> + ? ? ? .gpio_cfg = {
> + ? ? ? ? ? ? ? WM8903_GPIO_NO_CONFIG,
> + ? ? ? ? ? ? ? WM8903_GPIO_NO_CONFIG,
> + ? ? ? ? ? ? ? 0,
> + ? ? ? ? ? ? ? WM8903_GPIO_NO_CONFIG,
> + ? ? ? ? ? ? ? WM8903_GPIO_NO_CONFIG,
> + ? ? ? },
> +};
> +
> +static struct i2c_board_info __initdata wm8903_board_info = {
> + ? ? ? I2C_BOARD_INFO("wm8903", 0x1a),
> + ? ? ? .platform_data = &harmony_wm8903_pdata,
> + ? ? ? .irq = TEGRA_GPIO_TO_IRQ(TEGRA_GPIO_CDC_IRQ),
> +};
> +
> ?static void __init tegra_harmony_init(void)
> ?{
> ? ? ? ?tegra_clk_init_from_table(harmony_clk_init_table);
> @@ -112,8 +167,11 @@ static void __init tegra_harmony_init(void)
> ? ? ? ?tegra_sdhci_device1.dev.platform_data = &sdhci_pdata1;
> ? ? ? ?tegra_sdhci_device2.dev.platform_data = &sdhci_pdata2;
> ? ? ? ?tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
> + ? ? ? tegra_i2c_device1.dev.platform_data = &i2c_pdata1;
>
> ? ? ? ?platform_add_devices(harmony_devices, ARRAY_SIZE(harmony_devices));
> +
> + ? ? ? i2c_register_board_info(0, &wm8903_board_info, 1);
> ?}
>
> ?MACHINE_START(HARMONY, "harmony")
> diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
> index 4fe33b8..fbf2304 100644
> --- a/arch/arm/mach-tegra/board-harmony.h
> +++ b/arch/arm/mach-tegra/board-harmony.h
> @@ -17,12 +17,19 @@
> ?#ifndef _MACH_TEGRA_BOARD_HARMONY_H
> ?#define _MACH_TEGRA_BOARD_HARMONY_H
>
> +#define GPIO_WM8903(_x_) ? ? ? ? ? ? ? (TEGRA_NR_GPIOS + (_x_))
Can you name this HARMONY_GPIO_WM8903?

> +
> ?#define TEGRA_GPIO_SD2_CD ? ? ? ? ? ? ?TEGRA_GPIO_PI5
> ?#define TEGRA_GPIO_SD2_WP ? ? ? ? ? ? ?TEGRA_GPIO_PH1
> ?#define TEGRA_GPIO_SD2_POWER ? ? ? ? ? TEGRA_GPIO_PT3
> ?#define TEGRA_GPIO_SD4_CD ? ? ? ? ? ? ?TEGRA_GPIO_PH2
> ?#define TEGRA_GPIO_SD4_WP ? ? ? ? ? ? ?TEGRA_GPIO_PH3
> ?#define TEGRA_GPIO_SD4_POWER ? ? ? ? ? TEGRA_GPIO_PI6
> +#define TEGRA_GPIO_CDC_IRQ ? ? ? ? ? ? TEGRA_GPIO_PX3
> +#define TEGRA_GPIO_SPKR_EN ? ? ? ? ? ? GPIO_WM8903(2)
> +#define TEGRA_GPIO_HP_DET ? ? ? ? ? ? ?TEGRA_GPIO_PW2
> +#define TEGRA_GPIO_INT_MIC_EN ? ? ? ? ?TEGRA_GPIO_PX0
> +#define TEGRA_GPIO_EXT_MIC_EN ? ? ? ? ?TEGRA_GPIO_PX1
>
> ?void harmony_pinmux_init(void);
>
> --
> 1.7.1
>
>
