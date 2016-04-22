From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 22 Apr 2016 19:30:34 +0200
Subject: [PATCH v2 04/11] clocksource/moxart: Generalise timer for use on
 other socs
In-Reply-To: <1461225849-28074-5-git-send-email-joel@jms.id.au>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
 <1461225849-28074-5-git-send-email-joel@jms.id.au>
Message-ID: <571A5FBA.9010204@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2016 10:04 AM, Joel Stanley wrote:
> The moxart timer IP is shared with another soc made by Aspeed.
> Generalise the registers that differ so the same driver can be used for
> both.
>
> As we now depend on CLKSRC_MMIO, create a Kconfig symbol for the driver
> so we can express this dependency.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

In the future, please Cc the maintainers.

>   .../bindings/timer/moxa,moxart-timer.txt           |  4 +-
>   drivers/clocksource/Kconfig                        |  6 ++
>   drivers/clocksource/Makefile                       |  2 +-
>   drivers/clocksource/moxart_timer.c                 | 90 +++++++++++++++++-----
>   4 files changed, 79 insertions(+), 23 deletions(-)

[ ... ]

> +config MOXART_TIMER
> +	def_bool ARCH_MOXART || ARCH_ASPEED
> +	depends on ARM && OF
> +	select CLKSRC_OF
> +	select CLKSRC_MMIO

Refer to the other drivers to see how they are selected (eg. digicolor 
or mtk).

[ ... ]

> -#define TIMEREG_CR_1_ENABLE	BIT(0)
> -#define TIMEREG_CR_1_CLOCK	BIT(1)
> -#define TIMEREG_CR_1_INT	BIT(2)
> -#define TIMEREG_CR_2_ENABLE	BIT(3)
> -#define TIMEREG_CR_2_CLOCK	BIT(4)
> -#define TIMEREG_CR_2_INT	BIT(5)
> -#define TIMEREG_CR_3_ENABLE	BIT(6)
> -#define TIMEREG_CR_3_CLOCK	BIT(7)
> -#define TIMEREG_CR_3_INT	BIT(8)
> -#define TIMEREG_CR_COUNT_UP	BIT(9)
> -
> -#define TIMER1_ENABLE		(TIMEREG_CR_2_ENABLE | TIMEREG_CR_1_ENABLE)
> -#define TIMER1_DISABLE		(TIMEREG_CR_2_ENABLE)
> +#define MOXART_CR_1_ENABLE	BIT(0)
> +#define MOXART_CR_1_CLOCK	BIT(1)
> +#define MOXART_CR_1_INT		BIT(2)
> +#define MOXART_CR_2_ENABLE	BIT(3)
> +#define MOXART_CR_2_CLOCK	BIT(4)
> +#define MOXART_CR_2_INT		BIT(5)
> +#define MOXART_CR_3_ENABLE	BIT(6)
> +#define MOXART_CR_3_CLOCK	BIT(7)
> +#define MOXART_CR_3_INT		BIT(8)
> +#define MOXART_CR_COUNT_UP	BIT(9)
> +
> +#define MOXART_TIMER1_ENABLE	(MOXART_CR_2_ENABLE | MOXART_CR_1_ENABLE)
> +#define MOXART_TIMER1_DISABLE	(MOXART_CR_2_ENABLE)
> +
> +/*
> + * The ASpeed variant of the IP block has a different layout
> + * for the control register
> + */
> +#define ASPEED_CR_1_ENABLE	BIT(0)
> +#define ASPEED_CR_1_CLOCK	BIT(1)
> +#define ASPEED_CR_1_INT		BIT(2)
> +#define ASPEED_CR_2_ENABLE	BIT(4)
> +#define ASPEED_CR_2_CLOCK	BIT(5)
> +#define ASPEED_CR_2_INT		BIT(6)
> +#define ASPEED_CR_3_ENABLE	BIT(8)
> +#define ASPEED_CR_3_CLOCK	BIT(9)
> +#define ASPEED_CR_3_INT		BIT(10)
> +
> +#define ASPEED_TIMER1_ENABLE	(ASPEED_CR_2_ENABLE | ASPEED_CR_1_ENABLE)
> +#define ASPEED_TIMER1_DISABLE	(ASPEED_CR_2_ENABLE)

You probably can remove all the unused macro definition here for both 
MOXART and ASPEED to have something just a couple of definition.

>   static void __iomem *base;
>   static unsigned int clock_count_per_tick;
> +static unsigned int t1_disable_val, t1_enable_val;

It will be cleaner to:

1. Factor out:
	writel(TIMER1_DISABLE, base + TIMER_CR);
	writel(TIMER1_ENABLE, base + TIMER_CR);

diff --git a/drivers/clocksource/moxart_timer.c 
b/drivers/clocksource/moxart_timer.c
index 19857af..aede6f1 100644
--- a/drivers/clocksource/moxart_timer.c
+++ b/drivers/clocksource/moxart_timer.c
@@ -58,15 +58,25 @@
  static void __iomem *base;
  static unsigned int clock_count_per_tick;

-static int moxart_shutdown(struct clock_event_device *evt)
+static inline void moxart_disable(struct clock_event_device *evt)
  {
         writel(TIMER1_DISABLE, base + TIMER_CR);
+}
+
+static inline void moxart_enable(struct clock_event_device *evt)
+{
+       writel(TIMER1_ENABLE, base + TIMER_CR);
+}
+
+static int moxart_shutdown(struct clock_event_device *evt)
+{
+       moxart_disable(evt);
         return 0;
  }

  static int moxart_set_oneshot(struct clock_event_device *evt)
  {
-       writel(TIMER1_DISABLE, base + TIMER_CR);
+       moxart_disable(evt);
         writel(~0, base + TIMER1_BASE + REG_LOAD);
         return 0;
  }
@@ -74,7 +84,7 @@ static int moxart_set_oneshot(struct 
clock_event_device *evt)
  static int moxart_set_periodic(struct clock_event_device *evt)
  {
         writel(clock_count_per_tick, base + TIMER1_BASE + REG_LOAD);
-       writel(TIMER1_ENABLE, base + TIMER_CR);
+       moxart_enable(evt);
         return 0;
  }

@@ -83,12 +93,12 @@ static int moxart_clkevt_next_event(unsigned long 
cycles,
  {
         u32 u;

-       writel(TIMER1_DISABLE, base + TIMER_CR);
+       moxart_disable(evt);

         u = readl(base + TIMER1_BASE + REG_COUNT) - cycles;
         writel(u, base + TIMER1_BASE + REG_MATCH1);

-       writel(TIMER1_ENABLE, base + TIMER_CR);
+       moxart_enable(evt);

         return 0;
  }

2. Encapsulate clkevt and use container_of

-static void __iomem *base;
-static unsigned int clock_count_per_tick;
+struct moxart_timer {
+       void __iomem *base;
+       unsigned int clock_count_per_tick;
+       struct clock_event_device clkevt;
+};
+
+static struct moxart_timer moxart_timer = {
+       .clkevt = {
+               .name                   = "moxart_timer",
+               .rating                 = 200,
+               .features               = CLOCK_EVT_FEAT_PERIODIC |
+                                               CLOCK_EVT_FEAT_ONESHOT,
+               .set_state_shutdown     = moxart_shutdown,
+               .set_state_periodic     = moxart_set_periodic,
+               .set_state_oneshot      = moxart_set_oneshot,
+               .tick_resume            = moxart_set_oneshot,
+               .set_next_event         = moxart_clkevt_next_event,
+       },
+};
+
+static inline struct moxart_timer *clkevt_to_moxart(struct 
clock_event_device *evt)
+{
+       return container_of(evt, struct moxart_timer, clkevt);
+}

  static inline void moxart_disable(struct clock_event_device *evt)
  {
-       writel(TIMER1_DISABLE, base + TIMER_CR);
+       writel(TIMER1_DISABLE, clkevt_to_moxart(evt)->base + TIMER_CR);
  }

3. And finally, add 't1_disable' / 't2_disable' to the structure.


   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
