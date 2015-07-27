From: olof@lixom.net (Olof Johansson)
Date: Mon, 27 Jul 2015 08:46:54 +0200
Subject: [PATCH] ARM: appropriate __init annotation for const data
In-Reply-To: <alpine.LFD.2.20.1507262354340.1806@knanqh.ubzr>
References: <alpine.LFD.2.20.1507241440550.1806@knanqh.ubzr>
 <alpine.LFD.2.20.1507262354340.1806@knanqh.ubzr>
Message-ID: <CAOesGMhn8_KtZy_DpG2UZhM4vghuZDYvbUKnG4UOrZat7yOipQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yeah, I noticed my own builder found a few issues too. I'll drop it
from the 4.2 fixes branch, and when you've respun we'll apply it for
4.3.


-Olof

On Mon, Jul 27, 2015 at 6:00 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> Well... The kbuild test robot reports section mismatch for some machines
> with this patch applied.  I fail to understand why.  Unless someone
> else figures out what's going on, you should probably drop this patch
> for now.
>
>
> On Fri, 24 Jul 2015, Nicolas Pitre wrote:
>
>>
>> Init data marked const should be annotated with __initconst for
>> correctness and not __initdata.  This also fixes LTO builds that
>> otherwise fails with section mismatch errors.
>>
>> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>>
>> diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
>> index 4e9837ded9..87eb359048 100644
>> --- a/arch/arm/mach-cns3xxx/core.c
>> +++ b/arch/arm/mach-cns3xxx/core.c
>> @@ -392,7 +392,7 @@ static void __init cns3xxx_init(void)
>>                          cns3xxx_auxdata, NULL);
>>  }
>>
>> -static const char *cns3xxx_dt_compat[] __initdata = {
>> +static const char *cns3xxx_dt_compat[] __initconst = {
>>       "cavium,cns3410",
>>       "cavium,cns3420",
>>       NULL,
>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
>> index 3b8740c083..676997895e 100644
>> --- a/arch/arm/mach-davinci/da850.c
>> +++ b/arch/arm/mach-davinci/da850.c
>> @@ -715,7 +715,7 @@ const short da850_lcdcntl_pins[] __initconst = {
>>       -1
>>  };
>>
>> -const short da850_vpif_capture_pins[] __initdata = {
>> +const short da850_vpif_capture_pins[] __initconst = {
>>       DA850_VPIF_DIN0, DA850_VPIF_DIN1, DA850_VPIF_DIN2, DA850_VPIF_DIN3,
>>       DA850_VPIF_DIN4, DA850_VPIF_DIN5, DA850_VPIF_DIN6, DA850_VPIF_DIN7,
>>       DA850_VPIF_DIN8, DA850_VPIF_DIN9, DA850_VPIF_DIN10, DA850_VPIF_DIN11,
>> @@ -725,7 +725,7 @@ const short da850_vpif_capture_pins[] __initdata = {
>>       -1
>>  };
>>
>> -const short da850_vpif_display_pins[] __initdata = {
>> +const short da850_vpif_display_pins[] __initconst = {
>>       DA850_VPIF_DOUT0, DA850_VPIF_DOUT1, DA850_VPIF_DOUT2, DA850_VPIF_DOUT3,
>>       DA850_VPIF_DOUT4, DA850_VPIF_DOUT5, DA850_VPIF_DOUT6, DA850_VPIF_DOUT7,
>>       DA850_VPIF_DOUT8, DA850_VPIF_DOUT9, DA850_VPIF_DOUT10,
>> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
>> index 438f68547f..33c3438235 100644
>> --- a/arch/arm/mach-davinci/da8xx-dt.c
>> +++ b/arch/arm/mach-davinci/da8xx-dt.c
>> @@ -59,7 +59,7 @@ static void __init da850_init_machine(void)
>>
>>  }
>>
>> -static const char *da850_boards_compat[] __initdata = {
>> +static const char *da850_boards_compat[] __initconst = {
>>       "enbw,cmc",
>>       "ti,da850-evm",
>>       "ti,da850",
>> diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
>> index 7858d5b6f6..d3c6cf1ef2 100644
>> --- a/arch/arm/mach-lpc32xx/phy3250.c
>> +++ b/arch/arm/mach-lpc32xx/phy3250.c
>> @@ -248,7 +248,7 @@ static void __init lpc3250_machine_init(void)
>>                            lpc32xx_auxdata_lookup, NULL);
>>  }
>>
>> -static char const *lpc32xx_dt_compat[] __initdata = {
>> +static const char *lpc32xx_dt_compat[] __initconst = {
>>       "nxp,lpc3220",
>>       "nxp,lpc3230",
>>       "nxp,lpc3240",
>> diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
>> index b2296c9309..2dde9ccee9 100644
>> --- a/arch/arm/mach-mmp/mmp-dt.c
>> +++ b/arch/arm/mach-mmp/mmp-dt.c
>> @@ -20,12 +20,12 @@
>>
>>  extern void __init mmp_dt_init_timer(void);
>>
>> -static const char *pxa168_dt_board_compat[] __initdata = {
>> +static const char *pxa168_dt_board_compat[] __initconst = {
>>       "mrvl,pxa168-aspenite",
>>       NULL,
>>  };
>>
>> -static const char *pxa910_dt_board_compat[] __initdata = {
>> +static const char *pxa910_dt_board_compat[] __initconst = {
>>       "mrvl,pxa910-dkb",
>>       NULL,
>>  };
>> diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
>> index 998c0f533a..5f305f3cc5 100644
>> --- a/arch/arm/mach-mmp/mmp2-dt.c
>> +++ b/arch/arm/mach-mmp/mmp2-dt.c
>> @@ -30,7 +30,7 @@ static void __init mmp_init_time(void)
>>       of_clk_init(NULL);
>>  }
>>
>> -static const char *mmp2_dt_board_compat[] __initdata = {
>> +static const char *mmp2_dt_board_compat[] __initconst = {
>>       "mrvl,mmp2-brownstone",
>>       NULL,
>>  };
>> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
>> index 2e7cec86e5..0c352bff67 100644
>> --- a/arch/arm/mach-mxs/mach-mxs.c
>> +++ b/arch/arm/mach-mxs/mach-mxs.c
>> @@ -528,7 +528,7 @@ static void mxs_restart(enum reboot_mode mode, const char *cmd)
>>       soft_restart(0);
>>  }
>>
>> -static const char *mxs_dt_compat[] __initdata = {
>> +static const char *mxs_dt_compat[] __initconst = {
>>       "fsl,imx28",
>>       "fsl,imx23",
>>       NULL,
>> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
>> index 076fd20d7e..c9ae7bed68 100644
>> --- a/arch/arm/mach-omap2/vc.c
>> +++ b/arch/arm/mach-omap2/vc.c
>> @@ -563,7 +563,7 @@ struct i2c_init_data {
>>       u8 hsscll_12;
>>  };
>>
>> -static const __initdata struct i2c_init_data omap4_i2c_timing_data[] = {
>> +static const struct i2c_init_data omap4_i2c_timing_data[] __initconst = {
>>       {
>>               .load = 50,
>>               .loadbits = 0x3,
>> diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
>> index 261bb7cb4e..99c222ea0e 100644
>> --- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
>> +++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
>> @@ -95,7 +95,7 @@ static struct voltagedomain *voltagedomains_am35xx[] __initdata = {
>>  };
>>
>>
>> -static const char *sys_clk_name __initdata = "sys_ck";
>> +static const char *sys_clk_name __initconst = "sys_ck";
>>
>>  void __init omap3xxx_voltagedomains_init(void)
>>  {
>> diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
>> index 48b22a0a0c..c98c36f629 100644
>> --- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
>> +++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
>> @@ -92,7 +92,7 @@ static struct voltagedomain *voltagedomains_omap4[] __initdata = {
>>       NULL,
>>  };
>>
>> -static const char *sys_clk_name __initdata = "sys_clkin_ck";
>> +static const char *sys_clk_name __initconst = "sys_clkin_ck";
>>
>>  void __init omap44xx_voltagedomains_init(void)
>>  {
>> diff --git a/arch/arm/mach-omap2/voltagedomains54xx_data.c b/arch/arm/mach-omap2/voltagedomains54xx_data.c
>> index 33d22b8725..953d7c164d 100644
>> --- a/arch/arm/mach-omap2/voltagedomains54xx_data.c
>> +++ b/arch/arm/mach-omap2/voltagedomains54xx_data.c
>> @@ -78,7 +78,7 @@ static struct voltagedomain *voltagedomains_omap5[] __initdata = {
>>       NULL,
>>  };
>>
>> -static const char *sys_clk_name __initdata = "sys_clkin";
>> +static const char *sys_clk_name __initconst = "sys_clkin";
>>
>>  void __init omap54xx_voltagedomains_init(void)
>>  {
>> diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
>> index 7e0e5bd0c9..0aa1e3ebd4 100644
>> --- a/arch/arm/mach-pxa/pxa-dt.c
>> +++ b/arch/arm/mach-pxa/pxa-dt.c
>> @@ -39,7 +39,7 @@ static void __init pxa3xx_dt_init(void)
>>                            pxa3xx_auxdata_lookup, NULL);
>>  }
>>
>> -static const char *pxa3xx_dt_board_compat[] __initdata = {
>> +static const char *pxa3xx_dt_board_compat[] __initconst = {
>>       "marvell,pxa300",
>>       "marvell,pxa310",
>>       "marvell,pxa320",
>> diff --git a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
>> index f886478b88..8d5acf1675 100644
>> --- a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
>> +++ b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
>> @@ -39,7 +39,7 @@ static void __init s3c2416_dt_machine_init(void)
>>       s3c_pm_init();
>>  }
>>
>> -static char const *s3c2416_dt_compat[] __initdata = {
>> +static const char *s3c2416_dt_compat[] __initconst = {
>>       "samsung,s3c2416",
>>       "samsung,s3c2450",
>>       NULL
>> diff --git a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
>> index 2fddf38192..ba122faef2 100644
>> --- a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
>> +++ b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
>> @@ -61,7 +61,7 @@ static void s3c64xx_dt_restart(enum reboot_mode mode, const char *cmd)
>>       soft_restart(0);
>>  }
>>
>> -static char const *s3c64xx_dt_compat[] __initdata = {
>> +static const char *s3c64xx_dt_compat[] __initconst = {
>>       "samsung,s3c6400",
>>       "samsung,s3c6410",
>>       NULL
>> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
>> index bf37e3c532..e67d24c073 100644
>> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
>> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
>> @@ -1348,7 +1348,7 @@ static void eva_restart(enum reboot_mode mode, const char *cmd)
>>       writel((1 << 31), RESCNT2);
>>  }
>>
>> -static const char *eva_boards_compat_dt[] __initdata = {
>> +static const char *eva_boards_compat_dt[] __initconst = {
>>       "renesas,armadillo800eva",
>>       NULL,
>>  };
>> diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
>> index 9a74efda3d..820c744260 100644
>> --- a/arch/arm/mach-shmobile/board-bockw-reference.c
>> +++ b/arch/arm/mach-shmobile/board-bockw-reference.c
>> @@ -72,7 +72,7 @@ static void __init bockw_init(void)
>>       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>  }
>>
>> -static const char *bockw_boards_compat_dt[] __initdata = {
>> +static const char *bockw_boards_compat_dt[] __initconst = {
>>       "renesas,bockw-reference",
>>       NULL,
>>  };
>> diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
>> index 25558d1f41..d266b40dbe 100644
>> --- a/arch/arm/mach-shmobile/board-bockw.c
>> +++ b/arch/arm/mach-shmobile/board-bockw.c
>> @@ -723,7 +723,7 @@ static void __init bockw_init_late(void)
>>       ADD_USB_FUNC_DEVICE_IF_POSSIBLE();
>>  }
>>
>> -static const char *bockw_boards_compat_dt[] __initdata = {
>> +static const char *bockw_boards_compat_dt[] __initconst = {
>>       "renesas,bockw",
>>       NULL,
>>  };
>> diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
>> index 260d8319fd..17f3e6abb0 100644
>> --- a/arch/arm/mach-shmobile/board-kzm9g.c
>> +++ b/arch/arm/mach-shmobile/board-kzm9g.c
>> @@ -898,7 +898,7 @@ static void kzm9g_restart(enum reboot_mode mode, const char *cmd)
>>       writel((1 << 31), RESCNT2);
>>  }
>>
>> -static const char *kzm9g_boards_compat_dt[] __initdata = {
>> +static const char *kzm9g_boards_compat_dt[] __initconst = {
>>       "renesas,kzm9g",
>>       NULL,
>>  };
>> diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
>> index b15eb92326..0fe127c625 100644
>> --- a/arch/arm/mach-shmobile/board-marzen-reference.c
>> +++ b/arch/arm/mach-shmobile/board-marzen-reference.c
>> @@ -38,7 +38,7 @@ static void __init marzen_init(void)
>>       r8a7779_init_irq_extpin_dt(1); /* IRQ1 as individual interrupt */
>>  }
>>
>> -static const char *marzen_boards_compat_dt[] __initdata = {
>> +static const char *marzen_boards_compat_dt[] __initconst = {
>>       "renesas,marzen",
>>       "renesas,marzen-reference",
>>       NULL,
>> diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
>> index 51db288f19..0660a64299 100644
>> --- a/arch/arm/mach-shmobile/board-marzen.c
>> +++ b/arch/arm/mach-shmobile/board-marzen.c
>> @@ -330,7 +330,7 @@ static void __init marzen_init(void)
>>       platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
>>  }
>>
>> -static const char *marzen_boards_compat_dt[] __initdata = {
>> +static const char *marzen_boards_compat_dt[] __initconst = {
>>          "renesas,marzen",
>>          NULL,
>>  };
>> diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
>> index 171174777b..7f4cd26a52 100644
>> --- a/arch/arm/mach-shmobile/setup-r7s72100.c
>> +++ b/arch/arm/mach-shmobile/setup-r7s72100.c
>> @@ -20,7 +20,7 @@
>>
>>  #include "common.h"
>>
>> -static const char *r7s72100_boards_compat_dt[] __initdata = {
>> +static const char *r7s72100_boards_compat_dt[] __initconst = {
>>       "renesas,r7s72100",
>>       NULL,
>>  };
>> diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
>> index 446cee6119..6a86b929b8 100644
>> --- a/arch/arm/mach-shmobile/setup-r8a73a4.c
>> +++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
>> @@ -20,7 +20,7 @@
>>
>>  #include "common.h"
>>
>> -static const char *r8a73a4_boards_compat_dt[] __initdata = {
>> +static const char *r8a73a4_boards_compat_dt[] __initconst = {
>>       "renesas,r8a73a4",
>>       NULL,
>>  };
>> diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
>> index 00291cc177..0c59ca1232 100644
>> --- a/arch/arm/mach-shmobile/setup-r8a7740.c
>> +++ b/arch/arm/mach-shmobile/setup-r8a7740.c
>> @@ -787,7 +787,7 @@ static void __init r8a7740_generic_init(void)
>>       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>  }
>>
>> -static const char *r8a7740_boards_compat_dt[] __initdata = {
>> +static const char *r8a7740_boards_compat_dt[] __initconst = {
>>       "renesas,r8a7740",
>>       NULL,
>>  };
>> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
>> index c49aa094fe..36c7c05afe 100644
>> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
>> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
>> @@ -615,7 +615,7 @@ void __init r8a7778_init_irq_dt(void)
>>       iounmap(base);
>>  }
>>
>> -static const char *r8a7778_compat_dt[] __initdata = {
>> +static const char *r8a7778_compat_dt[] __initconst = {
>>       "renesas,r8a7778",
>>       NULL,
>>  };
>> diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
>> index c03e562be1..2321c9de22 100644
>> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
>> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
>> @@ -756,7 +756,7 @@ u32 __init r8a7779_read_mode_pins(void)
>>       return mode;
>>  }
>>
>> -static const char *r8a7779_compat_dt[] __initdata = {
>> +static const char *r8a7779_compat_dt[] __initconst = {
>>       "renesas,r8a7779",
>>       NULL,
>>  };
>> diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
>> index ef8eb3af58..c0c6764747 100644
>> --- a/arch/arm/mach-shmobile/setup-r8a7791.c
>> +++ b/arch/arm/mach-shmobile/setup-r8a7791.c
>> @@ -23,7 +23,7 @@
>>  #include "r8a7791.h"
>>  #include "rcar-gen2.h"
>>
>> -static const char *r8a7791_boards_compat_dt[] __initdata = {
>> +static const char *r8a7791_boards_compat_dt[] __initconst = {
>>       "renesas,r8a7791",
>>       NULL,
>>  };
>> diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
>> index fb2ab7590a..cd267299e7 100644
>> --- a/arch/arm/mach-shmobile/setup-sh73a0.c
>> +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
>> @@ -794,7 +794,7 @@ static void __init sh73a0_generic_init(void)
>>       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>  }
>>
>> -static const char *sh73a0_boards_compat_dt[] __initdata = {
>> +static const char *sh73a0_boards_compat_dt[] __initconst = {
>>       "renesas,sh73a0",
>>       NULL,
>>  };
>> diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
>> index 26fda4ed4d..a92b1aab74 100644
>> --- a/arch/arm/mach-spear/time.c
>> +++ b/arch/arm/mach-spear/time.c
>> @@ -193,7 +193,7 @@ static void __init spear_clockevent_init(int irq)
>>       setup_irq(irq, &spear_timer_irq);
>>  }
>>
>> -const static struct of_device_id timer_of_match[] __initconst = {
>> +static const struct of_device_id timer_of_match[] __initconst = {
>>       { .compatible = "st,spear-timer", },
>>       { },
>>  };
>> diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
>> index b373acade3..255a267bb8 100644
>> --- a/arch/arm/mach-sti/board-dt.c
>> +++ b/arch/arm/mach-sti/board-dt.c
>> @@ -14,7 +14,7 @@
>>
>>  #include "smp.h"
>>
>> -static const char *stih41x_dt_match[] __initdata = {
>> +static const char *stih41x_dt_match[] __initconst = {
>>       "st,stih415",
>>       "st,stih416",
>>       "st,stih407",
>>
