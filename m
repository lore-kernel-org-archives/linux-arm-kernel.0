From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 26 Sep 2010 13:40:08 +0800
Subject: [PATCH 2/2] ARM: pxa: reduce the scope of
	get_memclk_frequency_10khz()
In-Reply-To: <1284941413-28103-2-git-send-email-haojian.zhuang@marvell.com>
References: <1284941413-28103-1-git-send-email-haojian.zhuang@marvell.com>
	<1284941413-28103-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <AANLkTinYwduf9oZm_2XOZFhXeeVKp-r-foORM2b7k5xs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 20, 2010 at 8:10 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> Up to now, only pxa2xx pcmcia driver is using the API. No other device driver
> is using this API in PXA3xx or any other PXA silicons.
>
> Restrict the scope only on pxa2xx and remove the implementation of pxa3xx. So
> we can avoid oo much checking on cpuid after more pxa chips supported.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>

Applied.

> ---
> ?arch/arm/mach-pxa/generic.c | ? ?3 +--
> ?arch/arm/mach-pxa/generic.h | ? ?2 --
> ?arch/arm/mach-pxa/pxa3xx.c ?| ? 17 -----------------
> ?3 files changed, 1 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
> index 6655dea..6451e9c 100644
> --- a/arch/arm/mach-pxa/generic.c
> +++ b/arch/arm/mach-pxa/generic.c
> @@ -79,8 +79,7 @@ unsigned int get_memclk_frequency_10khz(void)
> ? ? ? ? ? ? ? ?return pxa25x_get_memclk_frequency_10khz();
> ? ? ? ?else if (cpu_is_pxa27x())
> ? ? ? ? ? ? ? ?return pxa27x_get_memclk_frequency_10khz();
> - ? ? ? else
> - ? ? ? ? ? ? ? return pxa3xx_get_memclk_frequency_10khz();
> + ? ? ? return 0;
> ?}
> ?EXPORT_SYMBOL(get_memclk_frequency_10khz);
>
> diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
> index c6305c5..4b1ad27 100644
> --- a/arch/arm/mach-pxa/generic.h
> +++ b/arch/arm/mach-pxa/generic.h
> @@ -54,11 +54,9 @@ static inline void pxa2xx_clear_reset_status(unsigned int mask) {}
>
> ?#ifdef CONFIG_PXA3xx
> ?extern unsigned pxa3xx_get_clk_frequency_khz(int);
> -extern unsigned pxa3xx_get_memclk_frequency_10khz(void);
> ?extern void pxa3xx_clear_reset_status(unsigned int);
> ?#else
> ?#define pxa3xx_get_clk_frequency_khz(x) ? ? ? ? ? ? ? ?(0)
> -#define pxa3xx_get_memclk_frequency_10khz() ? ?(0)
> ?static inline void pxa3xx_clear_reset_status(unsigned int mask) {}
> ?#endif
>
> diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
> index cf2bd26..c85c3a7 100644
> --- a/arch/arm/mach-pxa/pxa3xx.c
> +++ b/arch/arm/mach-pxa/pxa3xx.c
> @@ -98,23 +98,6 @@ unsigned int pxa3xx_get_clk_frequency_khz(int info)
> ? ? ? ?return CLK / 1000;
> ?}
>
> -/*
> - * Return the current static memory controller clock frequency
> - * in units of 10kHz
> - */
> -unsigned int pxa3xx_get_memclk_frequency_10khz(void)
> -{
> - ? ? ? unsigned long acsr;
> - ? ? ? unsigned int smcfs, clk = 0;
> -
> - ? ? ? acsr = ACSR;
> -
> - ? ? ? smcfs = (acsr >> 23) & 0x7;
> - ? ? ? clk = (acsr & ACCR_D0CS) ? RO_CLK : smcfs_mult[smcfs] * BASE_CLK;
> -
> - ? ? ? return (clk / 10000);
> -}
> -
> ?void pxa3xx_clear_reset_status(unsigned int mask)
> ?{
> ? ? ? ?/* RESET_STATUS_* has a 1:1 mapping with ARSR */
> --
> 1.5.6.5
>
>
