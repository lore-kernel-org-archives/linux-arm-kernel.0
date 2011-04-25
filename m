From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 26 Apr 2011 09:52:19 +1200
Subject: [PATCH 03/14] at91: factorize at91 interrupts init to soc
In-Reply-To: <1303756284-26529-3-git-send-email-plagnioj@jcrosoft.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-3-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4DB5ED13.2020803@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2011 06:31 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> they are the same except the default priority
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>

Looks good.

Reviewed-by: Ryan Mallon <ryan@bluewatersys.com>

> ---
>  arch/arm/mach-at91/at572d940hf.c          |   13 +------------
>  arch/arm/mach-at91/at91cap9.c             |   13 +------------
>  arch/arm/mach-at91/at91rm9200.c           |   13 +------------
>  arch/arm/mach-at91/at91sam9260.c          |   13 +------------
>  arch/arm/mach-at91/at91sam9261.c          |   13 +------------
>  arch/arm/mach-at91/at91sam9263.c          |   13 +------------
>  arch/arm/mach-at91/at91sam9g45.c          |   13 +------------
>  arch/arm/mach-at91/at91sam9rl.c           |   13 +------------
>  arch/arm/mach-at91/board-1arm.c           |    2 +-
>  arch/arm/mach-at91/board-afeb-9260v1.c    |    2 +-
>  arch/arm/mach-at91/board-at572d940hf_ek.c |    2 +-
>  arch/arm/mach-at91/board-cam60.c          |    2 +-
>  arch/arm/mach-at91/board-cap9adk.c        |    2 +-
>  arch/arm/mach-at91/board-carmeva.c        |    2 +-
>  arch/arm/mach-at91/board-cpu9krea.c       |    2 +-
>  arch/arm/mach-at91/board-cpuat91.c        |    2 +-
>  arch/arm/mach-at91/board-csb337.c         |    2 +-
>  arch/arm/mach-at91/board-csb637.c         |    2 +-
>  arch/arm/mach-at91/board-eb9200.c         |    2 +-
>  arch/arm/mach-at91/board-ecbat91.c        |    2 +-
>  arch/arm/mach-at91/board-eco920.c         |    2 +-
>  arch/arm/mach-at91/board-flexibity.c      |    2 +-
>  arch/arm/mach-at91/board-foxg20.c         |    2 +-
>  arch/arm/mach-at91/board-gsia18s.c        |    2 +-
>  arch/arm/mach-at91/board-kafa.c           |    2 +-
>  arch/arm/mach-at91/board-kb9202.c         |    2 +-
>  arch/arm/mach-at91/board-neocore926.c     |    2 +-
>  arch/arm/mach-at91/board-pcontrol-g20.c   |    2 +-
>  arch/arm/mach-at91/board-picotux200.c     |    2 +-
>  arch/arm/mach-at91/board-qil-a9260.c      |    2 +-
>  arch/arm/mach-at91/board-rm9200dk.c       |    2 +-
>  arch/arm/mach-at91/board-rm9200ek.c       |    2 +-
>  arch/arm/mach-at91/board-sam9-l9260.c     |    2 +-
>  arch/arm/mach-at91/board-sam9260ek.c      |    2 +-
>  arch/arm/mach-at91/board-sam9261ek.c      |    2 +-
>  arch/arm/mach-at91/board-sam9263ek.c      |    2 +-
>  arch/arm/mach-at91/board-sam9g20ek.c      |    2 +-
>  arch/arm/mach-at91/board-sam9m10g45ek.c   |    2 +-
>  arch/arm/mach-at91/board-sam9rlek.c       |    2 +-
>  arch/arm/mach-at91/board-snapper9260.c    |    2 +-
>  arch/arm/mach-at91/board-stamp9g20.c      |    2 +-
>  arch/arm/mach-at91/board-usb-a9260.c      |    2 +-
>  arch/arm/mach-at91/board-usb-a9263.c      |    2 +-
>  arch/arm/mach-at91/board-yl-9200.c        |    2 +-
>  arch/arm/mach-at91/generic.h              |    9 +--------
>  arch/arm/mach-at91/soc.c                  |   12 ++++++++++++
>  arch/arm/mach-at91/soc.h                  |    1 +
>  47 files changed, 58 insertions(+), 140 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
> index df0d691..15ecb64 100644
> --- a/arch/arm/mach-at91/at572d940hf.c
> +++ b/arch/arm/mach-at91/at572d940hf.c
> @@ -359,19 +359,8 @@ static unsigned int at572d940hf_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  	0,	/* Advanced Interrupt Controller */
>  };
>  
> -void __init at572d940hf_init_interrupts(unsigned int priority[NR_AIC_IRQS])
> -{
> -	if (!priority)
> -		priority = at572d940hf_default_irq_priority;
> -
> -	/* Initialize the AIC interrupt controller */
> -	at91_aic_init(priority);
> -
> -	/* Enable GPIO interrupts */
> -	at91_gpio_irq_setup();
> -}
> -
>  struct at91_soc __initdata at572d940hf_soc = {
>  	.name = "at572d940hf",
> +	.default_irq_priority = at572d940hf_default_irq_priority,
>  	.init = at572d940hf_initialize,
>  };
> diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
> index 4c06b19..6bf8eba 100644
> --- a/arch/arm/mach-at91/at91cap9.c
> +++ b/arch/arm/mach-at91/at91cap9.c
> @@ -366,19 +366,8 @@ static unsigned int at91cap9_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  	0,	/* Advanced Interrupt Controller (IRQ1) */
>  };
>  
> -void __init at91cap9_init_interrupts(unsigned int priority[NR_AIC_IRQS])
> -{
> -	if (!priority)
> -		priority = at91cap9_default_irq_priority;
> -
> -	/* Initialize the AIC interrupt controller */
> -	at91_aic_init(priority);
> -
> -	/* Enable GPIO interrupts */
> -	at91_gpio_irq_setup();
> -}
> -
>  struct at91_soc __initdata at91cap9_soc = {
>  	.name = "at91cap9",
> +	.default_irq_priority = at91cap9_default_irq_priority,
>  	.init = at91cap9_initialize,
>  };
> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> index 46ae08f..abc4cc9 100644
> --- a/arch/arm/mach-at91/at91rm9200.c
> +++ b/arch/arm/mach-at91/at91rm9200.c
> @@ -339,19 +339,8 @@ static unsigned int at91rm9200_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  	0	/* Advanced Interrupt Controller (IRQ6) */
>  };
>  
> -void __init at91rm9200_init_interrupts(unsigned int priority[NR_AIC_IRQS])
> -{
> -	if (!priority)
> -		priority = at91rm9200_default_irq_priority;
> -
> -	/* Initialize the AIC interrupt controller */
> -	at91_aic_init(priority);
> -
> -	/* Enable GPIO interrupts */
> -	at91_gpio_irq_setup();
> -}
> -
>  struct at91_soc __initdata at91rm9200_soc = {
>  	.name = "at91rm9200",
> +	.default_irq_priority = at91rm9200_default_irq_priority,
>  	.init = at91rm9200_initialize,
>  };
> diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
> index b1a9aa4..2838921 100644
> --- a/arch/arm/mach-at91/at91sam9260.c
> +++ b/arch/arm/mach-at91/at91sam9260.c
> @@ -360,19 +360,8 @@ static unsigned int at91sam9260_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  	0,	/* Advanced Interrupt Controller */
>  };
>  
> -void __init at91sam9260_init_interrupts(unsigned int priority[NR_AIC_IRQS])
> -{
> -	if (!priority)
> -		priority = at91sam9260_default_irq_priority;
> -
> -	/* Initialize the AIC interrupt controller */
> -	at91_aic_init(priority);
> -
> -	/* Enable GPIO interrupts */
> -	at91_gpio_irq_setup();
> -}
> -
>  struct at91_soc __initdata at91sam9260_soc = {
>  	.name = "at91sam9260",
> +	.default_irq_priority = at91sam9260_default_irq_priority,
>  	.init = at91sam9260_initialize,
>  };
> diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
> index 3851e77..768f4b7 100644
> --- a/arch/arm/mach-at91/at91sam9261.c
> +++ b/arch/arm/mach-at91/at91sam9261.c
> @@ -326,19 +326,8 @@ static unsigned int at91sam9261_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  	0,	/* Advanced Interrupt Controller */
>  };
>  
> -void __init at91sam9261_init_interrupts(unsigned int priority[NR_AIC_IRQS])
> -{
> -	if (!priority)
> -		priority = at91sam9261_default_irq_priority;
> -
> -	/* Initialize the AIC interrupt controller */
> -	at91_aic_init(priority);
> -
> -	/* Enable GPIO interrupts */
> -	at91_gpio_irq_setup();
> -}
> -
>  struct at91_soc __initdata at91sam9261_soc = {
>  	.name = "at91sam9261",
> +	.default_irq_priority = at91sam9261_default_irq_priority,
>  	.init = at91sam9261_initialize,
>  };
> diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
> index 481a890..97aae4f 100644
> --- a/arch/arm/mach-at91/at91sam9263.c
> +++ b/arch/arm/mach-at91/at91sam9263.c
> @@ -336,19 +336,8 @@ static unsigned int at91sam9263_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  	0,	/* Advanced Interrupt Controller (IRQ1) */
>  };
>  
> -void __init at91sam9263_init_interrupts(unsigned int priority[NR_AIC_IRQS])
> -{
> -	if (!priority)
> -		priority = at91sam9263_default_irq_priority;
> -
> -	/* Initialize the AIC interrupt controller */
> -	at91_aic_init(priority);
> -
> -	/* Enable GPIO interrupts */
> -	at91_gpio_irq_setup();
> -}
> -
>  struct at91_soc __initdata at91sam9263_soc = {
>  	.name = "at91sam9263",
> +	.default_irq_priority = at91sam9263_default_irq_priority,
>  	.init = at91sam9263_initialize,
>  };
> diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
> index 9cb5090..b497614 100644
> --- a/arch/arm/mach-at91/at91sam9g45.c
> +++ b/arch/arm/mach-at91/at91sam9g45.c
> @@ -363,19 +363,8 @@ static unsigned int at91sam9g45_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  	0,	/* Advanced Interrupt Controller (IRQ0) */
>  };
>  
> -void __init at91sam9g45_init_interrupts(unsigned int priority[NR_AIC_IRQS])
> -{
> -	if (!priority)
> -		priority = at91sam9g45_default_irq_priority;
> -
> -	/* Initialize the AIC interrupt controller */
> -	at91_aic_init(priority);
> -
> -	/* Enable GPIO interrupts */
> -	at91_gpio_irq_setup();
> -}
> -
>  struct at91_soc __initdata at91sam9g45_soc = {
>  	.name = "at91sam9g45",
> +	.default_irq_priority = at91sam9g45_default_irq_priority,
>  	.init = at91sam9g45_initialize,
>  };
> diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
> index e6f23c3..53287d5 100644
> --- a/arch/arm/mach-at91/at91sam9rl.c
> +++ b/arch/arm/mach-at91/at91sam9rl.c
> @@ -323,19 +323,8 @@ static unsigned int at91sam9rl_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  	0,	/* Advanced Interrupt Controller */
>  };
>  
> -void __init at91sam9rl_init_interrupts(unsigned int priority[NR_AIC_IRQS])
> -{
> -	if (!priority)
> -		priority = at91sam9rl_default_irq_priority;
> -
> -	/* Initialize the AIC interrupt controller */
> -	at91_aic_init(priority);
> -
> -	/* Enable GPIO interrupts */
> -	at91_gpio_irq_setup();
> -}
> -
>  struct at91_soc __initdata at91sam9rl_soc = {
>  	.name = "at91sam9rl",
> +	.default_irq_priority = at91sam9rl_default_irq_priority,
>  	.init = at91sam9rl_initialize,
>  };
> diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
> index b0d235e..ba08329 100644
> --- a/arch/arm/mach-at91/board-1arm.c
> +++ b/arch/arm/mach-at91/board-1arm.c
> @@ -65,7 +65,7 @@ static void __init onearm_map_io(void)
>  
>  static void __init onearm_init_irq(void)
>  {
> -	at91rm9200_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  static struct at91_eth_data __initdata onearm_eth_data = {
> diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
> index 855c641..3103bb1 100644
> --- a/arch/arm/mach-at91/board-afeb-9260v1.c
> +++ b/arch/arm/mach-at91/board-afeb-9260v1.c
> @@ -72,7 +72,7 @@ static void __init afeb9260_map_io(void)
>  
>  static void __init afeb9260_init_irq(void)
>  {
> -	at91sam9260_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-at572d940hf_ek.c b/arch/arm/mach-at91/board-at572d940hf_ek.c
> index ca796c2..1d24493 100644
> --- a/arch/arm/mach-at91/board-at572d940hf_ek.c
> +++ b/arch/arm/mach-at91/board-at572d940hf_ek.c
> @@ -70,7 +70,7 @@ static void __init eb_map_io(void)
>  
>  static void __init eb_init_irq(void)
>  {
> -	at572d940hf_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
> index f6b08f0..d3a65e2 100644
> --- a/arch/arm/mach-at91/board-cam60.c
> +++ b/arch/arm/mach-at91/board-cam60.c
> @@ -59,7 +59,7 @@ static void __init cam60_map_io(void)
>  
>  static void __init cam60_init_irq(void)
>  {
> -	at91sam9260_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
> index f9138dc..8f0a53e 100644
> --- a/arch/arm/mach-at91/board-cap9adk.c
> +++ b/arch/arm/mach-at91/board-cap9adk.c
> @@ -67,7 +67,7 @@ static void __init cap9adk_map_io(void)
>  
>  static void __init cap9adk_init_irq(void)
>  {
> -	at91cap9_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
> index f87fd72..cb888cf 100644
> --- a/arch/arm/mach-at91/board-carmeva.c
> +++ b/arch/arm/mach-at91/board-carmeva.c
> @@ -59,7 +59,7 @@ static void __init carmeva_map_io(void)
>  
>  static void __init carmeva_init_irq(void)
>  {
> -	at91rm9200_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  static struct at91_eth_data __initdata carmeva_eth_data = {
> diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
> index c228d3a..544995c 100644
> --- a/arch/arm/mach-at91/board-cpu9krea.c
> +++ b/arch/arm/mach-at91/board-cpu9krea.c
> @@ -83,7 +83,7 @@ static void __init cpu9krea_map_io(void)
>  
>  static void __init cpu9krea_init_irq(void)
>  {
> -	at91sam9260_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  /*
> diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
> index 7858e3c..33ddbfa 100644
> --- a/arch/arm/mach-at91/board-cpuat91.c
> +++ b/arch/arm/mach-at91/board-cpuat91.c
> @@ -84,7 +84,7 @@ static void __init cpuat91_map_io(void)
>  
>  static void __init cpuat91_init_irq(void)
>  {
> -	at91rm9200_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  static struct at91_eth_data __initdata cpuat91_eth_data = {
> diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
> index a3dd759..354e85e 100644
> --- a/arch/arm/mach-at91/board-csb337.c
> +++ b/arch/arm/mach-at91/board-csb337.c
> @@ -60,7 +60,7 @@ static void __init csb337_map_io(void)
>  
>  static void __init csb337_init_irq(void)
>  {
> -	at91rm9200_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  static struct at91_eth_data __initdata csb337_eth_data = {
> diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
> index 5849ed1..9bff91f 100644
> --- a/arch/arm/mach-at91/board-csb637.c
> +++ b/arch/arm/mach-at91/board-csb637.c
> @@ -54,7 +54,7 @@ static void __init csb637_map_io(void)
>  
>  static void __init csb637_init_irq(void)
>  {
> -	at91rm9200_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  static struct at91_eth_data __initdata csb637_eth_data = {
> diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
> index 1dee160..8101ef0 100644
> --- a/arch/arm/mach-at91/board-eb9200.c
> +++ b/arch/arm/mach-at91/board-eb9200.c
> @@ -62,7 +62,7 @@ static void __init eb9200_map_io(void)
>  
>  static void __init eb9200_init_irq(void)
>  {
> -	at91rm9200_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  static struct at91_eth_data __initdata eb9200_eth_data = {
> diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
> index 3bfc55a..7fb26f9 100644
> --- a/arch/arm/mach-at91/board-ecbat91.c
> +++ b/arch/arm/mach-at91/board-ecbat91.c
> @@ -66,7 +66,7 @@ static void __init ecb_at91map_io(void)
>  
>  static void __init ecb_at91init_irq(void)
>  {
> -	at91rm9200_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  static struct at91_eth_data __initdata ecb_at91eth_data = {
> diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
> index 85d0742..9c979bb 100644
> --- a/arch/arm/mach-at91/board-eco920.c
> +++ b/arch/arm/mach-at91/board-eco920.c
> @@ -49,7 +49,7 @@ static void __init eco920_map_io(void)
>  
>  static void __init eco920_init_irq(void)
>  {
> -	at91rm9200_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  static struct at91_eth_data __initdata eco920_eth_data = {
> diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
> index 345ba51..15cf7ab 100644
> --- a/arch/arm/mach-at91/board-flexibity.c
> +++ b/arch/arm/mach-at91/board-flexibity.c
> @@ -51,7 +51,7 @@ static void __init flexibity_map_io(void)
>  
>  static void __init flexibity_init_irq(void)
>  {
> -	at91sam9260_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  /* USB Host port */
> diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
> index 6948af9..53032d4 100644
> --- a/arch/arm/mach-at91/board-foxg20.c
> +++ b/arch/arm/mach-at91/board-foxg20.c
> @@ -103,7 +103,7 @@ static void __init foxg20_map_io(void)
>  
>  static void __init foxg20_init_irq(void)
>  {
> -	at91sam9260_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
> index bc28136..41f7164 100644
> --- a/arch/arm/mach-at91/board-gsia18s.c
> +++ b/arch/arm/mach-at91/board-gsia18s.c
> @@ -77,7 +77,7 @@ static void __init gsia18s_map_io(void)
>  
>  static void __init init_irq(void)
>  {
> -	at91sam9260_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  /*
> diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
> index 944ad13..cf7e7a0 100644
> --- a/arch/arm/mach-at91/board-kafa.c
> +++ b/arch/arm/mach-at91/board-kafa.c
> @@ -63,7 +63,7 @@ static void __init kafa_map_io(void)
>  
>  static void __init kafa_init_irq(void)
>  {
> -	at91rm9200_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  static struct at91_eth_data __initdata kafa_eth_data = {
> diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
> index e744e44..a56cdee 100644
> --- a/arch/arm/mach-at91/board-kb9202.c
> +++ b/arch/arm/mach-at91/board-kb9202.c
> @@ -71,7 +71,7 @@ static void __init kb9202_map_io(void)
>  
>  static void __init kb9202_init_irq(void)
>  {
> -	at91rm9200_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  static struct at91_eth_data __initdata kb9202_eth_data = {
> diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
> index 2bd4cda..2d1dec2 100644
> --- a/arch/arm/mach-at91/board-neocore926.c
> +++ b/arch/arm/mach-at91/board-neocore926.c
> @@ -68,7 +68,7 @@ static void __init neocore926_map_io(void)
>  
>  static void __init neocore926_init_irq(void)
>  {
> -	at91sam9263_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
> index feb6578..aa0a660 100644
> --- a/arch/arm/mach-at91/board-pcontrol-g20.c
> +++ b/arch/arm/mach-at91/board-pcontrol-g20.c
> @@ -56,7 +56,7 @@ static void __init pcontrol_g20_map_io(void)
>  
>  static void __init init_irq(void)
>  {
> -	at91sam9260_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
> index d22b1a3..3267b95 100644
> --- a/arch/arm/mach-at91/board-picotux200.c
> +++ b/arch/arm/mach-at91/board-picotux200.c
> @@ -62,7 +62,7 @@ static void __init picotux200_map_io(void)
>  
>  static void __init picotux200_init_irq(void)
>  {
> -	at91rm9200_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  static struct at91_eth_data __initdata picotux200_eth_data = {
> diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
> index d977e7e..e26fa6e 100644
> --- a/arch/arm/mach-at91/board-qil-a9260.c
> +++ b/arch/arm/mach-at91/board-qil-a9260.c
> @@ -74,7 +74,7 @@ static void __init ek_map_io(void)
>  
>  static void __init ek_init_irq(void)
>  {
> -	at91sam9260_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
> index 0175eef..c14f2c2 100644
> --- a/arch/arm/mach-at91/board-rm9200dk.c
> +++ b/arch/arm/mach-at91/board-rm9200dk.c
> @@ -67,7 +67,7 @@ static void __init dk_map_io(void)
>  
>  static void __init dk_init_irq(void)
>  {
> -	at91rm9200_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  static struct at91_eth_data __initdata dk_eth_data = {
> diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
> index 882d016..ffd69c0 100644
> --- a/arch/arm/mach-at91/board-rm9200ek.c
> +++ b/arch/arm/mach-at91/board-rm9200ek.c
> @@ -67,7 +67,7 @@ static void __init ek_map_io(void)
>  
>  static void __init ek_init_irq(void)
>  {
> -	at91rm9200_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  static struct at91_eth_data __initdata ek_eth_data = {
> diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
> index 36f765a..e4e19aa 100644
> --- a/arch/arm/mach-at91/board-sam9-l9260.c
> +++ b/arch/arm/mach-at91/board-sam9-l9260.c
> @@ -69,7 +69,7 @@ static void __init ek_map_io(void)
>  
>  static void __init ek_init_irq(void)
>  {
> -	at91sam9260_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
> index cc864a9..2307a1c 100644
> --- a/arch/arm/mach-at91/board-sam9260ek.c
> +++ b/arch/arm/mach-at91/board-sam9260ek.c
> @@ -72,7 +72,7 @@ static void __init ek_map_io(void)
>  
>  static void __init ek_init_irq(void)
>  {
> -	at91sam9260_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
> index 010636c..e1c4274 100644
> --- a/arch/arm/mach-at91/board-sam9261ek.c
> +++ b/arch/arm/mach-at91/board-sam9261ek.c
> @@ -71,7 +71,7 @@ static void __init ek_map_io(void)
>  
>  static void __init ek_init_irq(void)
>  {
> -	at91sam9261_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
> index 0c3a54d..43c421d 100644
> --- a/arch/arm/mach-at91/board-sam9263ek.c
> +++ b/arch/arm/mach-at91/board-sam9263ek.c
> @@ -70,7 +70,7 @@ static void __init ek_map_io(void)
>  
>  static void __init ek_init_irq(void)
>  {
> -	at91sam9263_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
> index 74676c6..5a5df34 100644
> --- a/arch/arm/mach-at91/board-sam9g20ek.c
> +++ b/arch/arm/mach-at91/board-sam9g20ek.c
> @@ -83,7 +83,7 @@ static void __init ek_map_io(void)
>  
>  static void __init ek_init_irq(void)
>  {
> -	at91sam9260_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
> index 15ccaad..fef316a 100644
> --- a/arch/arm/mach-at91/board-sam9m10g45ek.c
> +++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
> @@ -65,7 +65,7 @@ static void __init ek_map_io(void)
>  
>  static void __init ek_init_irq(void)
>  {
> -	at91sam9g45_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
> index 7b232b3..535c975 100644
> --- a/arch/arm/mach-at91/board-sam9rlek.c
> +++ b/arch/arm/mach-at91/board-sam9rlek.c
> @@ -55,7 +55,7 @@ static void __init ek_map_io(void)
>  
>  static void __init ek_init_irq(void)
>  {
> -	at91sam9rl_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
> index db5e67a..a5d5d89 100644
> --- a/arch/arm/mach-at91/board-snapper9260.c
> +++ b/arch/arm/mach-at91/board-snapper9260.c
> @@ -57,7 +57,7 @@ static void __init snapper9260_map_io(void)
>  
>  static void __init snapper9260_init_irq(void)
>  {
> -	at91sam9260_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  static struct at91_usbh_data __initdata snapper9260_usbh_data = {
> diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
> index bd0c8ce..1b435c3 100644
> --- a/arch/arm/mach-at91/board-stamp9g20.c
> +++ b/arch/arm/mach-at91/board-stamp9g20.c
> @@ -78,7 +78,7 @@ static void __init portuxg20_map_io(void)
>  
>  static void __init init_irq(void)
>  {
> -	at91sam9260_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-usb-a9260.c b/arch/arm/mach-at91/board-usb-a9260.c
> index 8b0955f..7cc63c8 100644
> --- a/arch/arm/mach-at91/board-usb-a9260.c
> +++ b/arch/arm/mach-at91/board-usb-a9260.c
> @@ -62,7 +62,7 @@ static void __init ek_map_io(void)
>  
>  static void __init ek_init_irq(void)
>  {
> -	at91sam9260_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-usb-a9263.c b/arch/arm/mach-at91/board-usb-a9263.c
> index 5b2a7bb..1fac2fe 100644
> --- a/arch/arm/mach-at91/board-usb-a9263.c
> +++ b/arch/arm/mach-at91/board-usb-a9263.c
> @@ -61,7 +61,7 @@ static void __init ek_map_io(void)
>  
>  static void __init ek_init_irq(void)
>  {
> -	at91sam9263_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
> index b473252..e9ca130 100644
> --- a/arch/arm/mach-at91/board-yl-9200.c
> +++ b/arch/arm/mach-at91/board-yl-9200.c
> @@ -81,7 +81,7 @@ static void __init yl9200_map_io(void)
>  
>  static void __init yl9200_init_irq(void)
>  {
> -	at91rm9200_init_interrupts(NULL);
> +	at91_init_interrupts(NULL);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
> index e1a5007..3b5ff68 100644
> --- a/arch/arm/mach-at91/generic.h
> +++ b/arch/arm/mach-at91/generic.h
> @@ -14,15 +14,8 @@ extern void __init at91_initialize(unsigned long main_clock);
>  extern void __init at91x40_initialize(unsigned long main_clock);
>  
>   /* Interrupts */
> -extern void __init at91rm9200_init_interrupts(unsigned int priority[]);
> -extern void __init at91sam9260_init_interrupts(unsigned int priority[]);
> -extern void __init at91sam9261_init_interrupts(unsigned int priority[]);
> -extern void __init at91sam9263_init_interrupts(unsigned int priority[]);
> -extern void __init at91sam9rl_init_interrupts(unsigned int priority[]);
> -extern void __init at91sam9g45_init_interrupts(unsigned int priority[]);
> +extern void __init at91_init_interrupts(unsigned int priority[]);
>  extern void __init at91x40_init_interrupts(unsigned int priority[]);
> -extern void __init at91cap9_init_interrupts(unsigned int priority[]);
> -extern void __init at572d940hf_init_interrupts(unsigned int priority[]);
>  extern void __init at91_aic_init(unsigned int priority[]);
>  
>   /* Timer */
> diff --git a/arch/arm/mach-at91/soc.c b/arch/arm/mach-at91/soc.c
> index 81f5815..f0a1661 100644
> --- a/arch/arm/mach-at91/soc.c
> +++ b/arch/arm/mach-at91/soc.c
> @@ -20,6 +20,18 @@
>  
>  static struct at91_soc __initdata current_soc;
>  
> +void __init at91_init_interrupts(unsigned int *priority)
> +{
> +	if (!priority)
> +		priority = current_soc.default_irq_priority;
> +
> +	/* Initialize the AIC interrupt controller */
> +	at91_aic_init(priority);
> +
> +	/* Enable GPIO interrupts */
> +	at91_gpio_irq_setup();
> +}
> +
>  static struct map_desc at91_io_desc __initdata = {
>  	.virtual	= AT91_VA_BASE_SYS,
>  	.pfn		= __phys_to_pfn(AT91_BASE_SYS),
> diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
> index 6c30d74..9aac491 100644
> --- a/arch/arm/mach-at91/soc.h
> +++ b/arch/arm/mach-at91/soc.h
> @@ -8,6 +8,7 @@
>  
>  struct at91_soc {
>  	char *name;
> +	unsigned int *default_irq_priority;
>  
>  	void (*init)(unsigned long main_clock);
>  };


-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
