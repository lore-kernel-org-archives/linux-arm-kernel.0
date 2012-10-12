From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 12 Oct 2012 18:27:06 +0200
Subject: [PATCH 3/4] ARM: AT91: Add AT91RM9200 support to DT board
In-Reply-To: <50783714.2000702@atmel.com>
References: <1349993126-9519-1-git-send-email-manabian@gmail.com>
 <1349993126-9519-3-git-send-email-manabian@gmail.com>
 <20121012142251.GC12801@game.jcrosoft.org>
 <50783714.2000702@atmel.com>
Message-ID: <20121012162706.GI12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:28 Fri 12 Oct     , ludovic.desroches wrote:
> Le 10/12/2012 04:22 PM, Jean-Christophe PLAGNIOL-VILLARD a ?crit :
> >On 00:05 Fri 12 Oct     , Joachim Eastwood wrote:
> >>Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> >>---
> >>
> >>Hi,
> >>
> >>This patch has some potential issues.
> >>Before this patch board-dt would fail building when only AT91RM9200 was enabled because at91sam926x_timer symbol would be missing. This patch uses the at91rm9200_timer which
> >>will fail if AT91RM9200 is not enabled.
> >this need work with ot wtihout rm9200
> >>
> >>Any thoughts on solving this? As mention above this bug exists in mainline now.
> >duplicate the board-dt with one for rm9200 only
> >as rm9200 ans sam9 are 2 distict familly
> 
> Why not adding a new machine descriptor for rm9200 in order to
> prevent file duplication?
because the soc are different and can only be compile if the timer is enable
and I do not want to enable the rm9200 timer on sam9 so instead of a ifdef i
the board-dt create a new board is better as we have a 50 lines file

with different board_compat and different machine descriptor

Best Regards,
J.
> 
> Regards
> 
> Ludovic
> 
> >>
> >>I had to create a new at91rm9200_dt_initialize since at91_dt_initialize will panic when it tries to add rstc and shdwc.
> >>Is it okay to add at91rm9200_dt_initialize or should we fix at91_dt_rstc and at91_dt_shdwc to not panic when DT nodes are not found?
> >it's ok
> >>
> >
> >can you add a board too rm9200ek will be good
> >
> >Best Regards,
> >J.
> >>regards
> >>Joachim Eastwood
> >>
> >>  arch/arm/mach-at91/board-dt.c | 15 +++++++++++++++
> >>  arch/arm/mach-at91/generic.h  |  1 +
> >>  arch/arm/mach-at91/setup.c    | 14 ++++++++++++++
> >>  3 files changed, 30 insertions(+)
> >>
> >>diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
> >>index e8f45c4..0e73317 100644
> >>--- a/arch/arm/mach-at91/board-dt.c
> >>+++ b/arch/arm/mach-at91/board-dt.c
> >>@@ -45,11 +45,26 @@ static void __init at91_dt_device_init(void)
> >>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> >>  }
> >>
> >>+static const char *at91rm9200_dt_board_compat[] __initdata = {
> >>+	"atmel,at91rm9200",
> >>+	NULL
> >>+};
> >>+
> >>  static const char *at91_dt_board_compat[] __initdata = {
> >>  	"atmel,at91sam9",
> >>  	NULL
> >>  };
> >>
> >>+DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200 (Device Tree)")
> >>+	.timer		= &at91rm9200_timer,
> >>+	.map_io		= at91_map_io,
> >>+	.handle_irq	= at91_aic_handle_irq,
> >>+	.init_early	= at91rm9200_dt_initialize,
> >>+	.init_irq	= at91_dt_init_irq,
> >>+	.init_machine	= at91_dt_device_init,
> >>+	.dt_compat	= at91rm9200_dt_board_compat,
> >>+MACHINE_END
> >>+
> >>  DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM (Device Tree)")
> >>  	/* Maintainer: Atmel */
> >>  	.timer		= &at91sam926x_timer,
> >>diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
> >>index f496506..9bb5ce5 100644
> >>--- a/arch/arm/mach-at91/generic.h
> >>+++ b/arch/arm/mach-at91/generic.h
> >>@@ -20,6 +20,7 @@ extern void __init at91_init_sram(int bank, unsigned long base,
> >>  extern void __init at91rm9200_set_type(int type);
> >>  extern void __init at91_initialize(unsigned long main_clock);
> >>  extern void __init at91x40_initialize(unsigned long main_clock);
> >>+extern void __init at91rm9200_dt_initialize(void);
> >>  extern void __init at91_dt_initialize(void);
> >>
> >>   /* Interrupts */
> >>diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> >>index da9881b..2c1fdd4 100644
> >>--- a/arch/arm/mach-at91/setup.c
> >>+++ b/arch/arm/mach-at91/setup.c
> >>@@ -338,6 +338,7 @@ static void at91_dt_rstc(void)
> >>  }
> >>
> >>  static struct of_device_id ramc_ids[] = {
> >>+	{ .compatible = "atmel,at91rm9200-sdramc" },
> >>  	{ .compatible = "atmel,at91sam9260-sdramc" },
> >>  	{ .compatible = "atmel,at91sam9g45-ddramc" },
> >>  	{ /*sentinel*/ }
> >>@@ -436,6 +437,19 @@ end:
> >>  	of_node_put(np);
> >>  }
> >>
> >>+void __init at91rm9200_dt_initialize(void)
> >>+{
> >>+	at91_dt_ramc();
> >>+
> >>+	/* Init clock subsystem */
> >>+	at91_dt_clock_init();
> >>+
> >>+	/* Register the processor-specific clocks */
> >>+	at91_boot_soc.register_clocks();
> >>+
> >>+	at91_boot_soc.init();
> >>+}
> >>+
> >>  void __init at91_dt_initialize(void)
> >>  {
> >>  	at91_dt_rstc();
> >>--
> >>1.7.12.2
> >>
> >
> >_______________________________________________
> >linux-arm-kernel mailing list
> >linux-arm-kernel at lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> >
> 
