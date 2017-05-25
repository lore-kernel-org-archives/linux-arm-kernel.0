From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 May 2017 23:02:22 +0200
Subject: [PATCH 2/2] timer: imx-tpm: add imx tpm timer support
In-Reply-To: <1494660575-30465-2-git-send-email-aisheng.dong@nxp.com>
References: <1494660575-30465-1-git-send-email-aisheng.dong@nxp.com>
 <1494660575-30465-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAK8P3a1JEzZFn4FXi2tb2jOFtV-3MRD-7O3gPBiZDM4qc3BTnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 13, 2017 at 9:29 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:

> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 3356ab8..03dfd6a 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -590,6 +590,11 @@ config CLKSRC_IMX_GPT
>         depends on ARM && CLKDEV_LOOKUP
>         select CLKSRC_MMIO
>
> +config CLKSRC_IMX_TPM
> +       bool "Clocksource using i.MX TPM" if COMPILE_TEST
> +       depends on ARM && CLKDEV_LOOKUP && GENERIC_CLOCKEVENTS
> +       select CLKSRC_MMIO
> +

This needs a help text


> +static inline void tpm_timer_disable(void)
> +{
> +       unsigned int val;
> +
> +       /* channel disable */
> +       val = __raw_readl(timer_base + TPM_C0SC);
> +       val &= ~(TPM_C0SC_MODE_MASK | TPM_C0SC_CHIE);
> +       __raw_writel(val, timer_base + TPM_C0SC);
> +}

__raw_readl/__raw_writel is broken on big-endian kernels, please
use readl/writel instead.

        Arnd
