From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 16 Oct 2013 18:07:44 +0200
Subject: [PATCH 1/2] ARM: AT91: pm: factorize standby function
In-Reply-To: <525EB8F3.2040104@linaro.org>
References: <1381830109-1398-1-git-send-email-daniel.lezcano@linaro.org>
 <1381933497-20262-1-git-send-email-plagnioj@jcrosoft.com>
 <525EAAF8.8080005@linaro.org>
 <20131016154851.GB14104@ns203013.ovh.net>
 <525EB8F3.2040104@linaro.org>
Message-ID: <20131016160744.GC14104@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:04 Wed 16 Oct     , Daniel Lezcano wrote:
> On 10/16/2013 05:48 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >On 17:04 Wed 16 Oct     , Daniel Lezcano wrote:
> >>On 10/16/2013 04:24 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>>Detect presence of second bank. So we do not need to have on function per SoC
> >>>
> >>>Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> >>>Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> >>
> >>Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> >as discuss with Nico please take via your tree with my Ack
> >
> >Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> As they are based on my previous patches:
> 
> [PATCH V4 1/2] ARM: at91: cpuidle: convert to platform driver
> [PATCH V4 2/2] ARM: at91: cpuidle: Move driver to drivers/cpuidle
> 
> Shall I assume they are acked-by you ?

yes
> 
> Shall I take the patch:
> 
> [PATCH 2/2] ARM: AT91: DT: pm: select ram controller standby based on DT
> 
> also with your acked-by ?
I wrote it so no ;-)

Best Regards,
J.
> 
> Thanks
>   -- Daniel
> 
> >>>---
> >>>  arch/arm/mach-at91/at91sam9260.c |  2 +-
> >>>  arch/arm/mach-at91/at91sam9261.c |  2 +-
> >>>  arch/arm/mach-at91/at91sam9263.c |  2 +-
> >>>  arch/arm/mach-at91/at91sam9g45.c |  2 +-
> >>>  arch/arm/mach-at91/at91sam9rl.c  |  2 +-
> >>>  arch/arm/mach-at91/pm.h          | 55 ++++++++++++++++++----------------------
> >>>  6 files changed, 29 insertions(+), 36 deletions(-)
> >>>
> >>>diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
> >>>index ffe9ce7..3b43d56 100644
> >>>--- a/arch/arm/mach-at91/at91sam9260.c
> >>>+++ b/arch/arm/mach-at91/at91sam9260.c
> >>>@@ -353,7 +353,7 @@ static void __init at91sam9260_initialize(void)
> >>>  	/* Register GPIO subsystem */
> >>>  	at91_gpio_init(at91sam9260_gpio, 3);
> >>>
> >>>-	at91_pm_set_standby(at91sam9_standby);
> >>>+	at91_pm_set_standby(at91sam9_sdram_standby);
> >>>  }
> >>>
> >>>  /* --------------------------------------------------------------------
> >>>diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
> >>>index 1edbb6f..a0857c3 100644
> >>>--- a/arch/arm/mach-at91/at91sam9261.c
> >>>+++ b/arch/arm/mach-at91/at91sam9261.c
> >>>@@ -295,7 +295,7 @@ static void __init at91sam9261_initialize(void)
> >>>  	/* Register GPIO subsystem */
> >>>  	at91_gpio_init(at91sam9261_gpio, 3);
> >>>
> >>>-	at91_pm_set_sandby(at91sam9_standby);
> >>>+	at91_pm_set_standby(at91sam9_sdram_standby);
> >>>  }
> >>>
> >>>  /* --------------------------------------------------------------------
> >>>diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
> >>>index 8c81c89..103a95b 100644
> >>>--- a/arch/arm/mach-at91/at91sam9263.c
> >>>+++ b/arch/arm/mach-at91/at91sam9263.c
> >>>@@ -332,7 +332,7 @@ static void __init at91sam9263_initialize(void)
> >>>  	/* Register GPIO subsystem */
> >>>  	at91_gpio_init(at91sam9263_gpio, 5);
> >>>
> >>>-	at91_pm_set_standby(at91sam9263_standby);
> >>>+	at91_pm_set_standby(at91sam9_sdram_standby);
> >>>  }
> >>>
> >>>  /* --------------------------------------------------------------------
> >>>diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
> >>>index 8460f52..f29731e 100644
> >>>--- a/arch/arm/mach-at91/at91sam9g45.c
> >>>+++ b/arch/arm/mach-at91/at91sam9g45.c
> >>>@@ -381,7 +381,7 @@ static void __init at91sam9g45_initialize(void)
> >>>  	/* Register GPIO subsystem */
> >>>  	at91_gpio_init(at91sam9g45_gpio, 5);
> >>>
> >>>-	at91_pm_set_standby(at91sam9g45_standby);
> >>>+	at91_pm_set_standby(at91_ddr_standby);
> >>>  }
> >>>
> >>>  /* --------------------------------------------------------------------
> >>>diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
> >>>index c7986e4..9e28f41 100644
> >>>--- a/arch/arm/mach-at91/at91sam9rl.c
> >>>+++ b/arch/arm/mach-at91/at91sam9rl.c
> >>>@@ -298,7 +298,7 @@ static void __init at91sam9rl_initialize(void)
> >>>  	/* Register GPIO subsystem */
> >>>  	at91_gpio_init(at91sam9rl_gpio, 4);
> >>>
> >>>-	at91_pm_set_standby(at91sam9_standby);
> >>>+	at91_pm_set_standby(at91sam9_sdram_standby);
> >>>  }
> >>>
> >>>  /* --------------------------------------------------------------------
> >>>diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
> >>>index 76dd1a7..3ed190c 100644
> >>>--- a/arch/arm/mach-at91/pm.h
> >>>+++ b/arch/arm/mach-at91/pm.h
> >>>@@ -49,16 +49,18 @@ static inline void at91rm9200_standby(void)
> >>>  /* We manage both DDRAM/SDRAM controllers, we need more than one value to
> >>>   * remember.
> >>>   */
> >>>-static inline void at91sam9g45_standby(void)
> >>>+static inline void at91_ddr_standby(void)
> >>>  {
> >>>  	/* Those two values allow us to delay self-refresh activation
> >>>  	 * to the maximum. */
> >>>-	u32 lpr0, lpr1;
> >>>-	u32 saved_lpr0, saved_lpr1;
> >>>+	u32 lpr0, lpr1 = 0;
> >>>+	u32 saved_lpr0, saved_lpr1 = 0;
> >>>
> >>>-	saved_lpr1 = at91_ramc_read(1, AT91_DDRSDRC_LPR);
> >>>-	lpr1 = saved_lpr1 & ~AT91_DDRSDRC_LPCB;
> >>>-	lpr1 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
> >>>+	if (at91_ramc_base[1]) {
> >>>+		saved_lpr1 = at91_ramc_read(1, AT91_DDRSDRC_LPR);
> >>>+		lpr1 = saved_lpr1 & ~AT91_DDRSDRC_LPCB;
> >>>+		lpr1 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
> >>>+	}
> >>>
> >>>  	saved_lpr0 = at91_ramc_read(0, AT91_DDRSDRC_LPR);
> >>>  	lpr0 = saved_lpr0 & ~AT91_DDRSDRC_LPCB;
> >>>@@ -66,25 +68,29 @@ static inline void at91sam9g45_standby(void)
> >>>
> >>>  	/* self-refresh mode now */
> >>>  	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr0);
> >>>-	at91_ramc_write(1, AT91_DDRSDRC_LPR, lpr1);
> >>>+	if (at91_ramc_base[1])
> >>>+		at91_ramc_write(1, AT91_DDRSDRC_LPR, lpr1);
> >>>
> >>>  	cpu_do_idle();
> >>>
> >>>  	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0);
> >>>-	at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
> >>>+	if (at91_ramc_base[1])
> >>>+		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
> >>>  }
> >>>
> >>>  /* We manage both DDRAM/SDRAM controllers, we need more than one value to
> >>>   * remember.
> >>>   */
> >>>-static inline void at91sam9263_standby(void)
> >>>+static inline void at91sam9_sdram_standby(void)
> >>>  {
> >>>-	u32 lpr0, lpr1;
> >>>-	u32 saved_lpr0, saved_lpr1;
> >>>+	u32 lpr0, lpr1 = 0;
> >>>+	u32 saved_lpr0, saved_lpr1 = 0;
> >>>
> >>>-	saved_lpr1 = at91_ramc_read(1, AT91_SDRAMC_LPR);
> >>>-	lpr1 = saved_lpr1 & ~AT91_SDRAMC_LPCB;
> >>>-	lpr1 |= AT91_SDRAMC_LPCB_SELF_REFRESH;
> >>>+	if (at91_ramc_base[1]) {
> >>>+		saved_lpr1 = at91_ramc_read(1, AT91_SDRAMC_LPR);
> >>>+		lpr1 = saved_lpr1 & ~AT91_SDRAMC_LPCB;
> >>>+		lpr1 |= AT91_SDRAMC_LPCB_SELF_REFRESH;
> >>>+	}
> >>>
> >>>  	saved_lpr0 = at91_ramc_read(0, AT91_SDRAMC_LPR);
> >>>  	lpr0 = saved_lpr0 & ~AT91_SDRAMC_LPCB;
> >>>@@ -92,27 +98,14 @@ static inline void at91sam9263_standby(void)
> >>>
> >>>  	/* self-refresh mode now */
> >>>  	at91_ramc_write(0, AT91_SDRAMC_LPR, lpr0);
> >>>-	at91_ramc_write(1, AT91_SDRAMC_LPR, lpr1);
> >>>+	if (at91_ramc_base[1])
> >>>+		at91_ramc_write(1, AT91_SDRAMC_LPR, lpr1);
> >>>
> >>>  	cpu_do_idle();
> >>>
> >>>  	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr0);
> >>>-	at91_ramc_write(1, AT91_SDRAMC_LPR, saved_lpr1);
> >>>-}
> >>>-
> >>>-static inline void at91sam9_standby(void)
> >>>-{
> >>>-	u32 saved_lpr, lpr;
> >>>-
> >>>-	saved_lpr = at91_ramc_read(0, AT91_SDRAMC_LPR);
> >>>-
> >>>-	lpr = saved_lpr & ~AT91_SDRAMC_LPCB;
> >>>-	at91_ramc_write(0, AT91_SDRAMC_LPR, lpr |
> >>>-			AT91_SDRAMC_LPCB_SELF_REFRESH);
> >>>-
> >>>-	cpu_do_idle();
> >>>-
> >>>-	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr);
> >>>+	if (at91_ramc_base[1])
> >>>+		at91_ramc_write(1, AT91_SDRAMC_LPR, saved_lpr1);
> >>>  }
> >>>
> >>>  #endif
> >>>
> >>
> >>
> >>--
> >>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
> >>
> >>Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >><http://twitter.com/#!/linaroorg> Twitter |
> >><http://www.linaro.org/linaro-blog/> Blog
> >>
> >>
> >>_______________________________________________
> >>linux-arm-kernel mailing list
> >>linux-arm-kernel at lists.infradead.org
> >>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
