From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 14 Nov 2011 15:50:34 +0100
Subject: [PATCH 07/12] ARM: at91: make smc register base soc independent
In-Reply-To: <1321207952-13556-7-git-send-email-plagnioj@jcrosoft.com>
References: <20111113180954.GD15318@game.jcrosoft.org>
 <1321207952-13556-7-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4EC12ABA.7060902@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean-Christophe,

Please, add more comments here. You add a new parameter to
*_smc_configure(), it can be good to say something about it...

On 11/13/2011 07:12 PM, Jean-Christophe PLAGNIOL-VILLARD :
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

With my little comments addressed:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/mach-at91/at91cap9.c                  |    2 +
>  arch/arm/mach-at91/at91rm9200.c                |    1 +
>  arch/arm/mach-at91/at91sam9260.c               |    2 +
>  arch/arm/mach-at91/at91sam9261.c               |    2 +
>  arch/arm/mach-at91/at91sam9263.c               |    3 +
>  arch/arm/mach-at91/at91sam9g45.c               |    2 +
>  arch/arm/mach-at91/at91sam9rl.c                |    2 +
>  arch/arm/mach-at91/board-cam60.c               |    2 +-
>  arch/arm/mach-at91/board-cap9adk.c             |    4 +-
>  arch/arm/mach-at91/board-cpu9krea.c            |    4 +-
>  arch/arm/mach-at91/board-dt.c                  |    2 +-
>  arch/arm/mach-at91/board-neocore926.c          |    2 +-
>  arch/arm/mach-at91/board-pcontrol-g20.c        |    4 +-
>  arch/arm/mach-at91/board-qil-a9260.c           |    2 +-
>  arch/arm/mach-at91/board-sam9-l9260.c          |    2 +-
>  arch/arm/mach-at91/board-sam9260ek.c           |    2 +-
>  arch/arm/mach-at91/board-sam9261ek.c           |    4 +-
>  arch/arm/mach-at91/board-sam9263ek.c           |    2 +-
>  arch/arm/mach-at91/board-sam9g20ek.c           |    2 +-
>  arch/arm/mach-at91/board-sam9m10g45ek.c        |    2 +-
>  arch/arm/mach-at91/board-sam9rlek.c            |    2 +-
>  arch/arm/mach-at91/board-snapper9260.c         |    2 +-
>  arch/arm/mach-at91/board-stamp9g20.c           |    2 +-
>  arch/arm/mach-at91/board-usb-a926x.c           |    4 +-
>  arch/arm/mach-at91/include/mach/at91cap9.h     |    2 +-
>  arch/arm/mach-at91/include/mach/at91sam9260.h  |    2 +-
>  arch/arm/mach-at91/include/mach/at91sam9261.h  |    2 +-
>  arch/arm/mach-at91/include/mach/at91sam9263.h  |    4 +-
>  arch/arm/mach-at91/include/mach/at91sam9_smc.h |   17 ++---
>  arch/arm/mach-at91/include/mach/at91sam9g45.h  |    2 +-
>  arch/arm/mach-at91/include/mach/at91sam9rl.h   |    2 +-
>  arch/arm/mach-at91/sam9_smc.c                  |  110 ++++++++++++++----------
>  arch/arm/mach-at91/sam9_smc.h                  |    3 +-
>  33 files changed, 114 insertions(+), 88 deletions(-)
>  rewrite arch/arm/mach-at91/sam9_smc.c (61%)
> 
> diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
> index abfe368..1ea9312 100644
> --- a/arch/arm/mach-at91/at91cap9.c
> +++ b/arch/arm/mach-at91/at91cap9.c
> @@ -28,6 +28,7 @@
>  #include "soc.h"
>  #include "generic.h"
>  #include "clock.h"
> +#include "sam9_smc.h"
>  
>  /* --------------------------------------------------------------------
>   *  Clocks
> @@ -336,6 +337,7 @@ static void __init at91cap9_map_io(void)
>  static void __init at91cap9_ioremap_registers(void)
>  {
>  	at91sam926x_ioremap_pit(AT91CAP9_BASE_PIT);
> +	at91sam9_ioremap_smc(0, AT91CAP9_BASE_SMC);
>  }
>  
>  static void __init at91cap9_initialize(void)
> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> index c67d50c..c06c14f 100644
> --- a/arch/arm/mach-at91/at91rm9200.c
> +++ b/arch/arm/mach-at91/at91rm9200.c
> @@ -23,6 +23,7 @@
>  #include "soc.h"
>  #include "generic.h"
>  #include "clock.h"
> +#include "sam9_smc.h"
>  
>  static struct map_desc at91rm9200_io_desc[] __initdata = {
>  	{
> diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
> index 0030d5f..fc1f734 100644
> --- a/arch/arm/mach-at91/at91sam9260.c
> +++ b/arch/arm/mach-at91/at91sam9260.c
> @@ -26,6 +26,7 @@
>  #include "soc.h"
>  #include "generic.h"
>  #include "clock.h"
> +#include "sam9_smc.h"
>  
>  /* --------------------------------------------------------------------
>   *  Clocks
> @@ -328,6 +329,7 @@ static void __init at91sam9260_map_io(void)
>  static void __init at91sam9260_ioremap_registers(void)
>  {
>  	at91sam926x_ioremap_pit(AT91SAM9260_BASE_PIT);
> +	at91sam9_ioremap_smc(0, AT91SAM9260_BASE_SMC);
>  }
>  
>  static void __init at91sam9260_initialize(void)
> diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
> index 348d5ae..804181a 100644
> --- a/arch/arm/mach-at91/at91sam9261.c
> +++ b/arch/arm/mach-at91/at91sam9261.c
> @@ -25,6 +25,7 @@
>  #include "soc.h"
>  #include "generic.h"
>  #include "clock.h"
> +#include "sam9_smc.h"
>  
>  /* --------------------------------------------------------------------
>   *  Clocks
> @@ -288,6 +289,7 @@ static void __init at91sam9261_map_io(void)
>  static void __init at91sam9261_ioremap_registers(void)
>  {
>  	at91sam926x_ioremap_pit(AT91SAM9261_BASE_PIT);
> +	at91sam9_ioremap_smc(0, AT91SAM9261_BASE_SMC);
>  }
>  
>  static void __init at91sam9261_initialize(void)
> diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
> index 09ccf73..b8f4996 100644
> --- a/arch/arm/mach-at91/at91sam9263.c
> +++ b/arch/arm/mach-at91/at91sam9263.c
> @@ -24,6 +24,7 @@
>  #include "soc.h"
>  #include "generic.h"
>  #include "clock.h"
> +#include "sam9_smc.h"
>  
>  /* --------------------------------------------------------------------
>   *  Clocks
> @@ -306,6 +307,8 @@ static void __init at91sam9263_map_io(void)
>  static void __init at91sam9263_ioremap_registers(void)
>  {
>  	at91sam926x_ioremap_pit(AT91SAM9263_BASE_PIT);
> +	at91sam9_ioremap_smc(0, AT91SAM9263_BASE_SMC0);
> +	at91sam9_ioremap_smc(1, AT91SAM9263_BASE_SMC1);
>  }
>  
>  static void __init at91sam9263_initialize(void)
> diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
> index aa8b441..ce3233f 100644
> --- a/arch/arm/mach-at91/at91sam9g45.c
> +++ b/arch/arm/mach-at91/at91sam9g45.c
> @@ -26,6 +26,7 @@
>  #include "soc.h"
>  #include "generic.h"
>  #include "clock.h"
> +#include "sam9_smc.h"
>  
>  /* --------------------------------------------------------------------
>   *  Clocks
> @@ -341,6 +342,7 @@ static void __init at91sam9g45_map_io(void)
>  static void __init at91sam9g45_ioremap_registers(void)
>  {
>  	at91sam926x_ioremap_pit(AT91SAM9G45_BASE_PIT);
> +	at91sam9_ioremap_smc(0, AT91SAM9G45_BASE_SMC);
>  }
>  
>  static void __init at91sam9g45_initialize(void)
> diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
> index 291fc99..1bcccd7 100644
> --- a/arch/arm/mach-at91/at91sam9rl.c
> +++ b/arch/arm/mach-at91/at91sam9rl.c
> @@ -25,6 +25,7 @@
>  #include "soc.h"
>  #include "generic.h"
>  #include "clock.h"
> +#include "sam9_smc.h"
>  
>  /* --------------------------------------------------------------------
>   *  Clocks
> @@ -293,6 +294,7 @@ static void __init at91sam9rl_map_io(void)
>  static void __init at91sam9rl_ioremap_registers(void)
>  {
>  	at91sam926x_ioremap_pit(AT91SAM9RL_BASE_PIT);
> +	at91sam9_ioremap_smc(0, AT91SAM9RL_BASE_SMC);
>  }
>  
>  static void __init at91sam9rl_initialize(void)
> diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
> index f90cfb3..02ded92 100644
> --- a/arch/arm/mach-at91/board-cam60.c
> +++ b/arch/arm/mach-at91/board-cam60.c
> @@ -163,7 +163,7 @@ static struct sam9_smc_config __initdata cam60_nand_smc_config = {
>  static void __init cam60_add_device_nand(void)
>  {
>  	/* configure chip-select 3 (NAND) */
> -	sam9_smc_configure(3, &cam60_nand_smc_config);
> +	sam9_smc_configure(0, 3, &cam60_nand_smc_config);
>  
>  	at91_add_device_nand(&cam60_nand_data);
>  }
> diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
> index 5dffd3b..da2616f 100644
> --- a/arch/arm/mach-at91/board-cap9adk.c
> +++ b/arch/arm/mach-at91/board-cap9adk.c
> @@ -212,7 +212,7 @@ static void __init cap9adk_add_device_nand(void)
>  		cap9adk_nand_smc_config.mode |= AT91_SMC_DBW_8;
>  
>  	/* configure chip-select 3 (NAND) */
> -	sam9_smc_configure(3, &cap9adk_nand_smc_config);
> +	sam9_smc_configure(0, 3, &cap9adk_nand_smc_config);
>  
>  	at91_add_device_nand(&cap9adk_nand_data);
>  }
> @@ -282,7 +282,7 @@ static __init void cap9adk_add_device_nor(void)
>  	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_EBI_VDDIOMSEL_3_3V);
>  
>  	/* configure chip-select 0 (NOR) */
> -	sam9_smc_configure(0, &cap9adk_nor_smc_config);
> +	sam9_smc_configure(0, 0, &cap9adk_nor_smc_config);
>  
>  	platform_device_register(&cap9adk_nor_flash);
>  }
> diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
> index fc885a4..7dd752e 100644
> --- a/arch/arm/mach-at91/board-cpu9krea.c
> +++ b/arch/arm/mach-at91/board-cpu9krea.c
> @@ -156,7 +156,7 @@ static struct sam9_smc_config __initdata cpu9krea_nand_smc_config = {
>  
>  static void __init cpu9krea_add_device_nand(void)
>  {
> -	sam9_smc_configure(3, &cpu9krea_nand_smc_config);
> +	sam9_smc_configure(0, 3, &cpu9krea_nand_smc_config);
>  	at91_add_device_nand(&cpu9krea_nand_data);
>  }
>  
> @@ -238,7 +238,7 @@ static __init void cpu9krea_add_device_nor(void)
>  	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_VDDIOMSEL_3_3V);
>  
>  	/* configure chip-select 0 (NOR) */
> -	sam9_smc_configure(0, &cpu9krea_nor_smc_config);
> +	sam9_smc_configure(0, 0, &cpu9krea_nor_smc_config);
>  
>  	platform_device_register(&cpu9krea_nor_flash);
>  }
> diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
> index 0b7d327..41d84d9 100644
> --- a/arch/arm/mach-at91/board-dt.c
> +++ b/arch/arm/mach-at91/board-dt.c
> @@ -82,7 +82,7 @@ static void __init ek_add_device_nand(void)
>  		ek_nand_smc_config.mode |= AT91_SMC_DBW_8;
>  
>  	/* configure chip-select 3 (NAND) */
> -	sam9_smc_configure(3, &ek_nand_smc_config);
> +	sam9_smc_configure(0, 3, &ek_nand_smc_config);
>  
>  	at91_add_device_nand(&ek_nand_data);
>  }
> diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
> index ef816c1..a9b9adc 100644
> --- a/arch/arm/mach-at91/board-neocore926.c
> +++ b/arch/arm/mach-at91/board-neocore926.c
> @@ -213,7 +213,7 @@ static struct sam9_smc_config __initdata neocore926_nand_smc_config = {
>  static void __init neocore926_add_device_nand(void)
>  {
>  	/* configure chip-select 3 (NAND) */
> -	sam9_smc_configure(3, &neocore926_nand_smc_config);
> +	sam9_smc_configure(0, 3, &neocore926_nand_smc_config);
>  
>  	at91_add_device_nand(&neocore926_nand_data);
>  }
> diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
> index 49e3f69..0e3c632 100644
> --- a/arch/arm/mach-at91/board-pcontrol-g20.c
> +++ b/arch/arm/mach-at91/board-pcontrol-g20.c
> @@ -96,9 +96,9 @@ static struct sam9_smc_config __initdata pcontrol_smc_config[2] = { {
>  static void __init add_device_pcontrol(void)
>  {
>  	/* configure chip-select 4 (IO compatible to 8051  X4 ) */
> -	sam9_smc_configure(4, &pcontrol_smc_config[0]);
> +	sam9_smc_configure(0, 4, &pcontrol_smc_config[0]);
>  	/* configure chip-select 7 (FerroRAM 256KiBx16bit MR2A16A  D4 ) */
> -	sam9_smc_configure(7, &pcontrol_smc_config[1]);
> +	sam9_smc_configure(0, 7, &pcontrol_smc_config[1]);
>  }
>  
>  
> diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
> index 07421bd..89d44c0 100644
> --- a/arch/arm/mach-at91/board-qil-a9260.c
> +++ b/arch/arm/mach-at91/board-qil-a9260.c
> @@ -161,7 +161,7 @@ static struct sam9_smc_config __initdata ek_nand_smc_config = {
>  static void __init ek_add_device_nand(void)
>  {
>  	/* configure chip-select 3 (NAND) */
> -	sam9_smc_configure(3, &ek_nand_smc_config);
> +	sam9_smc_configure(0, 3, &ek_nand_smc_config);
>  
>  	at91_add_device_nand(&ek_nand_data);
>  }
> diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
> index 072d53a..e0283c5 100644
> --- a/arch/arm/mach-at91/board-sam9-l9260.c
> +++ b/arch/arm/mach-at91/board-sam9-l9260.c
> @@ -162,7 +162,7 @@ static struct sam9_smc_config __initdata ek_nand_smc_config = {
>  static void __init ek_add_device_nand(void)
>  {
>  	/* configure chip-select 3 (NAND) */
> -	sam9_smc_configure(3, &ek_nand_smc_config);
> +	sam9_smc_configure(0, 3, &ek_nand_smc_config);
>  
>  	at91_add_device_nand(&ek_nand_data);
>  }
> diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
> index 4f10181..00db0f8 100644
> --- a/arch/arm/mach-at91/board-sam9260ek.c
> +++ b/arch/arm/mach-at91/board-sam9260ek.c
> @@ -211,7 +211,7 @@ static void __init ek_add_device_nand(void)
>  		ek_nand_smc_config.mode |= AT91_SMC_DBW_8;
>  
>  	/* configure chip-select 3 (NAND) */
> -	sam9_smc_configure(3, &ek_nand_smc_config);
> +	sam9_smc_configure(0, 3, &ek_nand_smc_config);
>  
>  	at91_add_device_nand(&ek_nand_data);
>  }
> diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
> index b005b73..a879b33 100644
> --- a/arch/arm/mach-at91/board-sam9261ek.c
> +++ b/arch/arm/mach-at91/board-sam9261ek.c
> @@ -131,7 +131,7 @@ static struct sam9_smc_config __initdata dm9000_smc_config = {
>  static void __init ek_add_device_dm9000(void)
>  {
>  	/* Configure chip-select 2 (DM9000) */
> -	sam9_smc_configure(2, &dm9000_smc_config);
> +	sam9_smc_configure(0, 2, &dm9000_smc_config);
>  
>  	/* Configure Reset signal as output */
>  	at91_set_gpio_output(AT91_PIN_PC10, 0);
> @@ -217,7 +217,7 @@ static void __init ek_add_device_nand(void)
>  		ek_nand_smc_config.mode |= AT91_SMC_DBW_8;
>  
>  	/* configure chip-select 3 (NAND) */
> -	sam9_smc_configure(3, &ek_nand_smc_config);
> +	sam9_smc_configure(0, 3, &ek_nand_smc_config);
>  
>  	at91_add_device_nand(&ek_nand_data);
>  }
> diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
> index bccdcf2..7b25ca1 100644
> --- a/arch/arm/mach-at91/board-sam9263ek.c
> +++ b/arch/arm/mach-at91/board-sam9263ek.c
> @@ -218,7 +218,7 @@ static void __init ek_add_device_nand(void)
>  		ek_nand_smc_config.mode |= AT91_SMC_DBW_8;
>  
>  	/* configure chip-select 3 (NAND) */
> -	sam9_smc_configure(3, &ek_nand_smc_config);
> +	sam9_smc_configure(0, 3, &ek_nand_smc_config);
>  
>  	at91_add_device_nand(&ek_nand_data);
>  }
> diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
> index 64fc75c..0579f06 100644
> --- a/arch/arm/mach-at91/board-sam9g20ek.c
> +++ b/arch/arm/mach-at91/board-sam9g20ek.c
> @@ -195,7 +195,7 @@ static void __init ek_add_device_nand(void)
>  		ek_nand_smc_config.mode |= AT91_SMC_DBW_8;
>  
>  	/* configure chip-select 3 (NAND) */
> -	sam9_smc_configure(3, &ek_nand_smc_config);
> +	sam9_smc_configure(0, 3, &ek_nand_smc_config);
>  
>  	at91_add_device_nand(&ek_nand_data);
>  }
> diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
> index 92de9127..3e0d5a9 100644
> --- a/arch/arm/mach-at91/board-sam9m10g45ek.c
> +++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
> @@ -175,7 +175,7 @@ static void __init ek_add_device_nand(void)
>  		ek_nand_smc_config.mode |= AT91_SMC_DBW_8;
>  
>  	/* configure chip-select 3 (NAND) */
> -	sam9_smc_configure(3, &ek_nand_smc_config);
> +	sam9_smc_configure(0, 3, &ek_nand_smc_config);
>  
>  	at91_add_device_nand(&ek_nand_data);
>  }
> diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
> index b2b7482..c561eda 100644
> --- a/arch/arm/mach-at91/board-sam9rlek.c
> +++ b/arch/arm/mach-at91/board-sam9rlek.c
> @@ -119,7 +119,7 @@ static struct sam9_smc_config __initdata ek_nand_smc_config = {
>  static void __init ek_add_device_nand(void)
>  {
>  	/* configure chip-select 3 (NAND) */
> -	sam9_smc_configure(3, &ek_nand_smc_config);
> +	sam9_smc_configure(0, 3, &ek_nand_smc_config);
>  
>  	at91_add_device_nand(&ek_nand_data);
>  }
> diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
> index 0df01c6..645d833 100644
> --- a/arch/arm/mach-at91/board-snapper9260.c
> +++ b/arch/arm/mach-at91/board-snapper9260.c
> @@ -149,7 +149,7 @@ static struct i2c_board_info __initdata snapper9260_i2c_devices[] = {
>  static void __init snapper9260_add_device_nand(void)
>  {
>  	at91_set_A_periph(AT91_PIN_PC14, 0);
> -	sam9_smc_configure(3, &snapper9260_nand_smc_config);
> +	sam9_smc_configure(0, 3, &snapper9260_nand_smc_config);
>  	at91_add_device_nand(&snapper9260_nand_data);
>  }
>  
> diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
> index 936e5fd..f94ac86 100644
> --- a/arch/arm/mach-at91/board-stamp9g20.c
> +++ b/arch/arm/mach-at91/board-stamp9g20.c
> @@ -108,7 +108,7 @@ static struct sam9_smc_config __initdata nand_smc_config = {
>  static void __init add_device_nand(void)
>  {
>  	/* configure chip-select 3 (NAND) */
> -	sam9_smc_configure(3, &nand_smc_config);
> +	sam9_smc_configure(0, 3, &nand_smc_config);
>  
>  	at91_add_device_nand(&nand_data);
>  }
> diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
> index 0a20bab..6f893cf 100644
> --- a/arch/arm/mach-at91/board-usb-a926x.c
> +++ b/arch/arm/mach-at91/board-usb-a926x.c
> @@ -245,9 +245,9 @@ static void __init ek_add_device_nand(void)
>  
>  	/* configure chip-select 3 (NAND) */
>  	if (machine_is_usb_a9g20())
> -		sam9_smc_configure(3, &usb_a9g20_nand_smc_config);
> +		sam9_smc_configure(0, 3, &usb_a9g20_nand_smc_config);
>  	else
> -		sam9_smc_configure(3, &usb_a9260_nand_smc_config);
> +		sam9_smc_configure(0, 3, &usb_a9260_nand_smc_config);
>  
>  	at91_add_device_nand(&ek_nand_data);
>  }
> diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
> index ad8d298..d7d0b68 100644
> --- a/arch/arm/mach-at91/include/mach/at91cap9.h
> +++ b/arch/arm/mach-at91/include/mach/at91cap9.h
> @@ -81,7 +81,6 @@
>   */
>  #define AT91_BCRAMC	(0xffffe400 - AT91_BASE_SYS)
>  #define AT91_DDRSDRC0	(0xffffe600 - AT91_BASE_SYS)
> -#define AT91_SMC	(0xffffe800 - AT91_BASE_SYS)
>  #define AT91_MATRIX	(0xffffea00 - AT91_BASE_SYS)
>  #define AT91_CCFG	(0xffffeb10 - AT91_BASE_SYS)
>  #define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
> @@ -96,6 +95,7 @@
>  
>  #define AT91CAP9_BASE_ECC	0xffffe200
>  #define AT91CAP9_BASE_DMA	0xffffec00
> +#define AT91CAP9_BASE_SMC	0xffffe800
>  #define AT91CAP9_BASE_PIOA	0xfffff200
>  #define AT91CAP9_BASE_PIOB	0xfffff400
>  #define AT91CAP9_BASE_PIOC	0xfffff600
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
> index b8c85dc..e55ab6a 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9260.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
> @@ -81,7 +81,6 @@
>   * System Peripherals (offset from AT91_BASE_SYS)
>   */
>  #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
> -#define AT91_SMC	(0xffffec00 - AT91_BASE_SYS)
>  #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
>  #define AT91_CCFG	(0xffffef10 - AT91_BASE_SYS)
>  #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
> @@ -93,6 +92,7 @@
>  #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
>  
>  #define AT91SAM9260_BASE_ECC	0xffffe800
> +#define AT91SAM9260_BASE_SMC	0xffffec00
>  #define AT91SAM9260_BASE_PIOA	0xfffff400
>  #define AT91SAM9260_BASE_PIOB	0xfffff600
>  #define AT91SAM9260_BASE_PIOC	0xfffff800
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
> index 0dccaff..1ea2d6b 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9261.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
> @@ -66,7 +66,6 @@
>   * System Peripherals (offset from AT91_BASE_SYS)
>   */
>  #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
> -#define AT91_SMC	(0xffffec00 - AT91_BASE_SYS)
>  #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
>  #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
>  #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
> @@ -76,6 +75,7 @@
>  #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
>  #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
>  
> +#define AT91SAM9261_BASE_SMC	0xffffec00
>  #define AT91SAM9261_BASE_PIOA	0xfffff400
>  #define AT91SAM9261_BASE_PIOB	0xfffff600
>  #define AT91SAM9261_BASE_PIOC	0xfffff800
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
> index 735408e..b827ff7 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9263.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
> @@ -75,9 +75,7 @@
>   * System Peripherals (offset from AT91_BASE_SYS)
>   */
>  #define AT91_SDRAMC0	(0xffffe200 - AT91_BASE_SYS)
> -#define AT91_SMC0	(0xffffe400 - AT91_BASE_SYS)
>  #define AT91_SDRAMC1	(0xffffe800 - AT91_BASE_SYS)
> -#define AT91_SMC1	(0xffffea00 - AT91_BASE_SYS)
>  #define AT91_MATRIX	(0xffffec00 - AT91_BASE_SYS)
>  #define AT91_CCFG	(0xffffed10 - AT91_BASE_SYS)
>  #define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
> @@ -89,7 +87,9 @@
>  #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
>  
>  #define AT91SAM9263_BASE_ECC0	0xffffe000
> +#define AT91SAM9263_BASE_SMC0	0xffffe400
>  #define AT91SAM9263_BASE_ECC1	0xffffe600
> +#define AT91SAM9263_BASE_SMC1	0xffffea00
>  #define AT91SAM9263_BASE_PIOA	0xfffff200
>  #define AT91SAM9263_BASE_PIOB	0xfffff400
>  #define AT91SAM9263_BASE_PIOC	0xfffff600
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9_smc.h b/arch/arm/mach-at91/include/mach/at91sam9_smc.h
> index 57de620..eb18a70 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9_smc.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9_smc.h
> @@ -16,7 +16,9 @@
>  #ifndef AT91SAM9_SMC_H
>  #define AT91SAM9_SMC_H
>  
> -#define AT91_SMC_SETUP(n)	(AT91_SMC + 0x00 + ((n)*0x10))	/* Setup Register for CS n */
> +#include <mach/cpu.h>
> +
> +#define AT91_SMC_SETUP		0x00				/* Setup Register for CS n */
>  #define		AT91_SMC_NWESETUP	(0x3f << 0)			/* NWE Setup Length */
>  #define			AT91_SMC_NWESETUP_(x)	((x) << 0)
>  #define		AT91_SMC_NCS_WRSETUP	(0x3f << 8)			/* NCS Setup Length in Write Access */
> @@ -26,7 +28,7 @@
>  #define		AT91_SMC_NCS_RDSETUP	(0x3f << 24)			/* NCS Setup Length in Read Access */
>  #define			AT91_SMC_NCS_RDSETUP_(x)	((x) << 24)
>  
> -#define AT91_SMC_PULSE(n)	(AT91_SMC + 0x04 + ((n)*0x10))	/* Pulse Register for CS n */
> +#define AT91_SMC_PULSE		0x04				/* Pulse Register for CS n */
>  #define		AT91_SMC_NWEPULSE	(0x7f <<  0)			/* NWE Pulse Length */
>  #define			AT91_SMC_NWEPULSE_(x)	((x) << 0)
>  #define		AT91_SMC_NCS_WRPULSE	(0x7f <<  8)			/* NCS Pulse Length in Write Access */
> @@ -36,13 +38,13 @@
>  #define		AT91_SMC_NCS_RDPULSE	(0x7f << 24)			/* NCS Pulse Length in Read Access */
>  #define			AT91_SMC_NCS_RDPULSE_(x)((x) << 24)
>  
> -#define AT91_SMC_CYCLE(n)	(AT91_SMC + 0x08 + ((n)*0x10))	/* Cycle Register for CS n */
> +#define AT91_SMC_CYCLE		0x08				/* Cycle Register for CS n */
>  #define		AT91_SMC_NWECYCLE	(0x1ff << 0 )			/* Total Write Cycle Length */
>  #define			AT91_SMC_NWECYCLE_(x)	((x) << 0)
>  #define		AT91_SMC_NRDCYCLE	(0x1ff << 16)			/* Total Read Cycle Length */
>  #define			AT91_SMC_NRDCYCLE_(x)	((x) << 16)
>  
> -#define AT91_SMC_MODE(n)	(AT91_SMC + 0x0c + ((n)*0x10))	/* Mode Register for CS n */
> +#define AT91_SMC_MODE		0x0c				/* Mode Register for CS n */
>  #define		AT91_SMC_READMODE	(1 <<  0)			/* Read Mode */
>  #define		AT91_SMC_WRITEMODE	(1 <<  1)			/* Write Mode */
>  #define		AT91_SMC_EXNWMODE	(3 <<  4)			/* NWAIT Mode */
> @@ -66,11 +68,4 @@
>  #define			AT91_SMC_PS_16			(2 << 28)
>  #define			AT91_SMC_PS_32			(3 << 28)
>  
> -#if defined(AT91_SMC1)		/* The AT91SAM9263 has 2 Static Memory contollers */
> -#define AT91_SMC1_SETUP(n)	(AT91_SMC1 + 0x00 + ((n)*0x10))	/* Setup Register for CS n */
> -#define AT91_SMC1_PULSE(n)	(AT91_SMC1 + 0x04 + ((n)*0x10))	/* Pulse Register for CS n */
> -#define AT91_SMC1_CYCLE(n)	(AT91_SMC1 + 0x08 + ((n)*0x10))	/* Cycle Register for CS n */
> -#define AT91_SMC1_MODE(n)	(AT91_SMC1 + 0x0c + ((n)*0x10))	/* Mode Register for CS n */
> -#endif
> -
>  #endif
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
> index ba609f3..ac051d4 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
> @@ -88,7 +88,6 @@
>   */
>  #define AT91_DDRSDRC1	(0xffffe400 - AT91_BASE_SYS)
>  #define AT91_DDRSDRC0	(0xffffe600 - AT91_BASE_SYS)
> -#define AT91_SMC	(0xffffe800 - AT91_BASE_SYS)
>  #define AT91_MATRIX	(0xffffea00 - AT91_BASE_SYS)
>  #define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
>  #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
> @@ -101,6 +100,7 @@
>  
>  #define AT91SAM9G45_BASE_ECC	0xffffe200
>  #define AT91SAM9G45_BASE_DMA	0xffffec00
> +#define AT91SAM9G45_BASE_SMC	0xffffe800
>  #define AT91SAM9G45_BASE_PIOA	0xfffff200
>  #define AT91SAM9G45_BASE_PIOB	0xfffff400
>  #define AT91SAM9G45_BASE_PIOC	0xfffff600
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
> index bab09a7..846139d 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
> @@ -70,7 +70,6 @@
>   * System Peripherals (offset from AT91_BASE_SYS)
>   */
>  #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
> -#define AT91_SMC	(0xffffec00 - AT91_BASE_SYS)
>  #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
>  #define AT91_CCFG	(0xffffef10 - AT91_BASE_SYS)
>  #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
> @@ -85,6 +84,7 @@
>  
>  #define AT91SAM9RL_BASE_DMA	0xffffe600
>  #define AT91SAM9RL_BASE_ECC	0xffffe800
> +#define AT91SAM9RL_BASE_SMC	0xffffec00
>  #define AT91SAM9RL_BASE_PIOA	0xfffff400
>  #define AT91SAM9RL_BASE_PIOB	0xfffff600
>  #define AT91SAM9RL_BASE_PIOC	0xfffff800
> diff --git a/arch/arm/mach-at91/sam9_smc.c b/arch/arm/mach-at91/sam9_smc.c
> dissimilarity index 61%
> index 5eab6aa6..7604ccc 100644
> --- a/arch/arm/mach-at91/sam9_smc.c
> +++ b/arch/arm/mach-at91/sam9_smc.c
> @@ -1,47 +1,63 @@
> -/*
> - * linux/arch/arm/mach-at91/sam9_smc.c
> - *
> - * Copyright (C) 2008 Andrew Victor
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/io.h>
> -
> -#include <mach/at91sam9_smc.h>
> -
> -#include "sam9_smc.h"
> -
> -void __init sam9_smc_configure(int cs, struct sam9_smc_config* config)
> -{
> -	/* Setup register */
> -	at91_sys_write(AT91_SMC_SETUP(cs),
> -		  AT91_SMC_NWESETUP_(config->nwe_setup)
> -		| AT91_SMC_NCS_WRSETUP_(config->ncs_write_setup)
> -		| AT91_SMC_NRDSETUP_(config->nrd_setup)
> -		| AT91_SMC_NCS_RDSETUP_(config->ncs_read_setup)
> -	);
> -
> -	/* Pulse register */
> -	at91_sys_write(AT91_SMC_PULSE(cs),
> -		  AT91_SMC_NWEPULSE_(config->nwe_pulse)
> -		| AT91_SMC_NCS_WRPULSE_(config->ncs_write_pulse)
> -                | AT91_SMC_NRDPULSE_(config->nrd_pulse)
> -		| AT91_SMC_NCS_RDPULSE_(config->ncs_read_pulse)
> -	);
> -
> -	/* Cycle register */
> -	at91_sys_write(AT91_SMC_CYCLE(cs),
> -		  AT91_SMC_NWECYCLE_(config->write_cycle)
> -		| AT91_SMC_NRDCYCLE_(config->read_cycle)
> -	);
> -
> -	/* Mode register */
> -	at91_sys_write(AT91_SMC_MODE(cs),
> -		  config->mode
> -		| AT91_SMC_TDF_(config->tdf_cycles)
> -	);
> -}
> +/*
> + * linux/arch/arm/mach-at91/sam9_smc.c
> + *
> + * Copyright (C) 2008 Andrew Victor
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +#include <mach/at91sam9_smc.h>
> +
> +#include "sam9_smc.h"
> +
> +
> +#define AT91_SMC_CS(id, n)	(smc_base_addr[id] + ((n) * 0x10))
> +
> +static void __iomem *smc_base_addr[2];
> +
> +static void __init sam9_smc_cs_configure(void __iomem *base, struct sam9_smc_config* config)
> +{
> +
> +	/* Setup register */
> +	__raw_writel(AT91_SMC_NWESETUP_(config->nwe_setup)
> +		   | AT91_SMC_NCS_WRSETUP_(config->ncs_write_setup)
> +		   | AT91_SMC_NRDSETUP_(config->nrd_setup)
> +		   | AT91_SMC_NCS_RDSETUP_(config->ncs_read_setup),
> +		   base + AT91_SMC_SETUP);
> +
> +	/* Pulse register */
> +	__raw_writel(AT91_SMC_NWEPULSE_(config->nwe_pulse)
> +		   | AT91_SMC_NCS_WRPULSE_(config->ncs_write_pulse)
> +		   | AT91_SMC_NRDPULSE_(config->nrd_pulse)
> +		   | AT91_SMC_NCS_RDPULSE_(config->ncs_read_pulse),
> +		   base + AT91_SMC_PULSE);
> +
> +	/* Cycle register */
> +	__raw_writel(AT91_SMC_NWECYCLE_(config->write_cycle)
> +		   | AT91_SMC_NRDCYCLE_(config->read_cycle),
> +		   base + AT91_SMC_CYCLE);
> +
> +	/* Mode register */
> +	__raw_writel(config->mode
> +		   | AT91_SMC_TDF_(config->tdf_cycles),
> +		   base + AT91_SMC_MODE);
> +}
> +
> +void __init sam9_smc_configure(int id, int cs, struct sam9_smc_config* config)
> +{
> +	sam9_smc_cs_configure(AT91_SMC_CS(id, cs), config);
> +}
> +
> +void __init at91sam9_ioremap_smc(int id, u32 addr)
> +{
> +	if (id > 1)
> +		return;

Blank line here

> +	smc_base_addr[id] = ioremap(addr, 512);

Ditto: error path to ease debugging...

> +}
> diff --git a/arch/arm/mach-at91/sam9_smc.h b/arch/arm/mach-at91/sam9_smc.h
> index bf72cfb..039c5ce 100644
> --- a/arch/arm/mach-at91/sam9_smc.h
> +++ b/arch/arm/mach-at91/sam9_smc.h
> @@ -30,4 +30,5 @@ struct sam9_smc_config {
>  	u8 tdf_cycles:4;
>  };
>  
> -extern void __init sam9_smc_configure(int cs, struct sam9_smc_config* config);
> +extern void __init sam9_smc_configure(int id, int cs, struct sam9_smc_config* config);
> +extern void __init at91sam9_ioremap_smc(int id, u32 addr);


-- 
Nicolas Ferre
