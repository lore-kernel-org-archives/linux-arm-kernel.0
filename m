From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 15 May 2015 09:18:55 +0800
Subject: [PATCH 02/18] ARM: imx: Add the definitions for imx_timer and
 its versions
In-Reply-To: <1430405073-13106-3-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
 <1430405073-13106-3-git-send-email-shenwei.wang@freescale.com>
Message-ID: <20150515011855.GA10411@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 09:44:17AM -0500, Shenwei Wang wrote:
> A struct was added to describe the imx hardware timers.
> Added four macros to define the imx timer version.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> ---
>  arch/arm/mach-imx/time.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
> index eef6b66..5df3c53 100644
> --- a/arch/arm/mach-imx/time.c
> +++ b/arch/arm/mach-imx/time.c
> @@ -81,6 +81,21 @@
>  #define timer_is_v1()	(cpu_is_mx1() || cpu_is_mx21() || cpu_is_mx27())
>  #define timer_is_v2()	(!timer_is_v1())
>  
> +#define IMX_TIMER_V0         (0)
> +#define IMX_TIMER_V1         (1)
> +#define IMX_TIMER_V2         (2)
> +#define IMX_TIMER_V3         (3)

I prefer to use an enum type instead of macros. Also I do not like the
versions which are numbered by software arbitrarily.  Instead, I'd like
to use SoC name that firstly integrates the version to code the
type/version.

Shawn

> +
> +struct imx_timer {
> +	void __iomem *timer_base;
> +	int version;
> +	struct clock_event_device evt;
> +	struct irqaction act;
> +	void (*gpt_irq_enable)(struct imx_timer *);
> +	void (*gpt_irq_disable)(struct imx_timer *);
> +	void (*gpt_irq_acknowledge)(struct imx_timer *);
> +};
> +
>  static struct clock_event_device clockevent_mxc;
>  static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
>  
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
