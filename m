From: padma.kvr@gmail.com (Padma Venkat)
Date: Wed, 1 Aug 2012 18:39:44 +0530
Subject: [PATCH] ARM: EXYNOS: Add clocks for EXYNOS Audio Subsystem.
In-Reply-To: <031501cd6f98$dd67c550$98374ff0$%kim@samsung.com>
References: <1343218056-30432-1-git-send-email-padma.v@samsung.com>
 <031501cd6f98$dd67c550$98374ff0$%kim@samsung.com>
Message-ID: <CAAgF-Bdp817_RD3n6Sdo9zi=OrB4-Uiu5PDt4UB1BL-f0M4aJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 1, 2012 at 9:21 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Padmavathi Venna wrote:
>>
>> Audiocdclk frequency is 16.9344MHz in SMDK5250 and this clock is
>> board specific. So this patch adds a function to set the required
>> audio codec clk frequency from machine file.
>>
>> This patch also adds all the required clock instances for audio
>> subsystem and adds the clock alias names for i2sclk and busclk.
>>
>> Signed-off-by: Taylor Hutt <thutt@chromium.org>
>> Signed-off-by: sangsu4u.park <sangsu4u.park@samsung.com>
>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>> ---
>>  arch/arm/mach-exynos/clock-exynos5.c           |  129
>> ++++++++++++++++++++++++
>>  arch/arm/mach-exynos/common.h                  |    1 +
>>  arch/arm/mach-exynos/include/mach/regs-audss.h |   12 ++
>>  arch/arm/mach-exynos/mach-exynos5-dt.c         |    1 +
>>  4 files changed, 143 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-
>> exynos/clock-exynos5.c
>> index 774533c..681450a 100644
>> --- a/arch/arm/mach-exynos/clock-exynos5.c
>> +++ b/arch/arm/mach-exynos/clock-exynos5.c
>> @@ -20,10 +20,13 @@
>>  #include <plat/pll.h>
>>  #include <plat/s5p-clock.h>
>>  #include <plat/clock-clksrc.h>
>> +#include <plat/devs.h>
>
> Why do we need above on this patch?
It's by mistake. I will remove this line in the next patch set.
>
>>  #include <plat/pm.h>
>> +#include <plat/cpu.h>
>
> Same as above.
It's by mistake. I will remove this line in the next patch set.
>
>>
>>  #include <mach/map.h>
>>  #include <mach/regs-clock.h>
>> +#include <mach/regs-audss.h>
>
> See below my comment.
>
>>  #include <mach/sysmmu.h>
>>
>>  #include "common.h"
>> @@ -106,6 +109,16 @@ static struct clk exynos5_clk_sclk_usbphy = {
>>       .rate           = 48000000,
>>  };
>>
>> +struct clk exynos5_clk_audiocdclk0 = {
>> +     .id = -1,
>> +     .name   = "audiocdclk",
>> +};
>> +
>> +void exynos5_set_audiocdclk_rate(unsigned long rate)
>> +{
>> +     clk_default_setrate(&exynos5_clk_audiocdclk0, rate);
>> +}
>> +
>>  static int exynos5_clksrc_mask_top_ctrl(struct clk *clk, int enable)
>>  {
>>       return s5p_gatectrl(EXYNOS5_CLKSRC_MASK_TOP, clk, enable);
>> @@ -171,6 +184,16 @@ static int exynos5_clk_ip_gps_ctrl(struct clk *clk,
>> int enable)
>>       return s5p_gatectrl(EXYNOS5_CLKGATE_IP_GPS, clk, enable);
>>  }
>>
>> +static int exynos5_clksrc_mask_maudio_ctrl(struct clk *clk, int enable)
>> +{
>> +     return s5p_gatectrl(EXYNOS5_CLKSRC_MASK_MAUDIO, clk, enable);
>> +}
>> +
>> +static int exynos5_clk_audss_ctrl(struct clk *clk, int enable)
>> +{
>> +     return s5p_gatectrl(EXYNOS_CLKGATE_AUDSS, clk, enable);
>> +}
>> +
>>  static int exynos5_clk_ip_mfc_ctrl(struct clk *clk, int enable)
>>  {
>>       return s5p_gatectrl(EXYNOS5_CLKGATE_IP_MFC, clk, enable);
>> @@ -635,6 +658,11 @@ static struct clk exynos5_init_clocks_off[] = {
>>               .ctrlbit        = (1 << 3),
>>       }, {
>>               .name           = "iis",
>> +             .devname        = "samsung-i2s.0",
>> +             .enable         = exynos5_clk_audss_ctrl,
>> +             .ctrlbit        = (3 << 2),
>> +     }, {
>> +             .name           = "iis",
>>               .devname        = "samsung-i2s.1",
>>               .enable         = exynos5_clk_ip_peric_ctrl,
>>               .ctrlbit        = (1 << 20),
>> @@ -645,6 +673,11 @@ static struct clk exynos5_init_clocks_off[] = {
>>               .ctrlbit        = (1 << 21),
>>       }, {
>>               .name           = "pcm",
>> +             .devname        = "samsung-pcm.0",
>> +             .enable         = exynos5_clk_audss_ctrl,
>> +             .ctrlbit        = (3 << 4),
>> +     }, {
>> +             .name           = "pcm",
>>               .devname        = "samsung-pcm.1",
>>               .enable         = exynos5_clk_ip_peric_ctrl,
>>               .ctrlbit        = (1 << 22),
>> @@ -870,6 +903,95 @@ static struct clk exynos5_init_clocks_on[] = {
>>       }
>>  };
>>
>> +static struct clk *clkset_sclk_audio0_list[] = {
>> +     [0] = &exynos5_clk_audiocdclk0,
>> +     [1] = &clk_ext_xtal_mux,
>> +     [2] = &exynos5_clk_sclk_hdmi27m,
>> +     [3] = &exynos5_clk_sclk_dptxphy,
>> +     [4] = &exynos5_clk_sclk_usbphy,
>> +     [5] = &exynos5_clk_sclk_hdmiphy,
>> +     [6] = &exynos5_clk_mout_mpll.clk,
>> +     [7] = &exynos5_clk_mout_epll.clk,
>> +     [8] = &exynos5_clk_sclk_vpll.clk,
>> +     [9] = &exynos5_clk_mout_cpll.clk,
>> +};
>> +
>> +static struct clksrc_sources exynos5_clkset_sclk_audio0 = {
>> +     .sources        = clkset_sclk_audio0_list,
>> +     .nr_sources     = ARRAY_SIZE(clkset_sclk_audio0_list),
>> +};
>> +
>> +static struct clksrc_clk exynos5_clk_sclk_audio0 = {
>> +     .clk    = {
>> +             .name           = "audio-bus",
>
> sclk_audio?
Yes. The name of this clock instance can be changed to sclk_audio for
better understanding.
>
>> +             .enable         = exynos5_clksrc_mask_maudio_ctrl,
>> +             .ctrlbit        = (1 << 0),
>> +     },
>> +     .sources = &exynos5_clkset_sclk_audio0,
>> +     .reg_src = { .reg = EXYNOS5_CLKSRC_MAUDIO, .shift = 0, .size = 4 },
>> +     .reg_div = { .reg = EXYNOS5_CLKDIV_MAUDIO, .shift = 0, .size = 4 },
>> +};
>> +
>> +static struct clk *exynos5_clkset_mout_audss_list[] = {
>> +     &clk_ext_xtal_mux,
>> +     &clk_fout_epll,
>> +};
>> +
>> +static struct clksrc_sources clkset_mout_audss = {
>> +     .sources        = exynos5_clkset_mout_audss_list,
>> +     .nr_sources     = ARRAY_SIZE(exynos5_clkset_mout_audss_list),
>> +};
>> +
>> +static struct clksrc_clk exynos5_clk_mout_audss = {
>> +     .clk    = {
>> +             .name           = "mout_audss",
>> +     },
>> +     .sources = &clkset_mout_audss,
>> +     .reg_src = { .reg = EXYNOS_CLKSRC_AUDSS, .shift = 0, .size = 1 },
>> +};
>> +
>> +static struct clk *exynos5_clkset_sclk_audss_list[] = {
>> +     &exynos5_clk_mout_audss.clk,
>> +     &exynos5_clk_audiocdclk0,
>> +     &exynos5_clk_sclk_audio0.clk,
>> +};
>> +
>> +static struct clksrc_sources exynos5_clkset_sclk_audss = {
>> +     .sources        = exynos5_clkset_sclk_audss_list,
>> +     .nr_sources     = ARRAY_SIZE(exynos5_clkset_sclk_audss_list),
>> +};
>> +
>> +static struct clksrc_clk exynos5_clk_sclk_audss_i2s = {
>
> exynos5_clk_sclk_i2s?
As these clock instances are from AudioSS clock controller, these are
named like that. If not looking good, I will change this to
exynos5_clk_sclk_i2s0
>
>> +     .clk            = {
>> +             .name           = "i2sclk",
>
> sclk_i2s?
hmm, as per the user manual the instance of this clock in clock
controller of AudioSS has the name "i2sclk". So this clock is named
like that.
>
>> +             .devname        = "samsung-i2s.0",
>> +             .enable         = exynos5_clk_audss_ctrl,
>> +             .ctrlbit        = (1 << 3),
>> +     },
>> +     .sources = &exynos5_clkset_sclk_audss,
>> +     .reg_src = { .reg = EXYNOS_CLKSRC_AUDSS, .shift = 2, .size = 2 },
>
> The parent of sclk_i2s0 is sclk_audio0? So why do we need above?
No. The parent of this clock is not only sclk_audio0. It has 3 source
mux. one is MOUTASS,IISCDCLK0,SCLK_AUDIO0.
>
>> +     .reg_div = { .reg = EXYNOS_CLKDIV_AUDSS, .shift = 8, .size = 4 },
>> +};
>> +
>> +static struct clksrc_clk exynos5_clk_dout_audss_srp = {
>
> exynos5_clk_dout_srp?
As it is instance in audio sub system clock controller it is named like that.
>
>> +     .clk    = {
>> +             .name           = "dout_srp",
>> +             .parent         = &exynos5_clk_mout_audss.clk,
>> +     },
>> +     .reg_div = { .reg = EXYNOS_CLKDIV_AUDSS, .shift = 0, .size = 4 },
>> +};
>> +
>> +static struct clksrc_clk exynos5_clk_sclk_audss_bus = {
>
> exynos5_clk_sclk_bus?
Same as above.
>
>> +     .clk    = {
>> +             .name           = "busclk",
>
> sclk_bus?
As per the user manual the instance of this clock in clock controller
of AudioSS has the name "busclk". So this clock is named like that.
>
>> +             .devname        = "samsung-i2s.0",
>> +             .parent         = &exynos5_clk_dout_audss_srp.clk,
>> +             .enable         = exynos5_clk_audss_ctrl,
>> +             .ctrlbit        = (1 << 2),
>> +     },
>> +     .reg_div = { .reg = EXYNOS_CLKDIV_AUDSS, .shift = 4, .size = 4 },
>> +};
>> +
>>  static struct clk exynos5_clk_pdma0 = {
>>       .name           = "dma",
>>       .devname        = "dma-pl330.0",
>> @@ -1240,6 +1362,9 @@ static struct clksrc_clk *exynos5_sysclks[] = {
>>       &exynos5_clk_mdout_spi0,
>>       &exynos5_clk_mdout_spi1,
>>       &exynos5_clk_mdout_spi2,
>> +     &exynos5_clk_mout_audss,
>> +     &exynos5_clk_dout_audss_srp,
>> +     &exynos5_clk_sclk_audio0,
>>  };
>>
>>  static struct clk *exynos5_clk_cdev[] = {
>> @@ -1257,6 +1382,8 @@ static struct clksrc_clk *exynos5_clksrc_cdev[] = {
>>       &exynos5_clk_sclk_mmc1,
>>       &exynos5_clk_sclk_mmc2,
>>       &exynos5_clk_sclk_mmc3,
>> +     &exynos5_clk_sclk_audss_bus,
>> +     &exynos5_clk_sclk_audss_i2s,
>>  };
>>
>>  static struct clk_lookup exynos5_clk_lookup[] = {
>> @@ -1274,6 +1401,8 @@ static struct clk_lookup exynos5_clk_lookup[] = {
>>       CLKDEV_INIT("dma-pl330.0", "apb_pclk", &exynos5_clk_pdma0),
>>       CLKDEV_INIT("dma-pl330.1", "apb_pclk", &exynos5_clk_pdma1),
>>       CLKDEV_INIT("dma-pl330.2", "apb_pclk", &exynos5_clk_mdma1),
>> +     CLKDEV_INIT("samsung-i2s.0", "i2s_opclk0",
>> &exynos5_clk_sclk_audss_i2s.clk),
>> +     CLKDEV_INIT("samsung-i2s.0", "i2s_opclk1",
>> &exynos5_clk_sclk_audss_bus.clk),
>
> Maybe 'samsung-i2s.1' ?
No. I2S controller 0 has mux for RCLK source clocks. These are the
alias names for source clks of RCLK in I2S controller0. So it should
be 'samsung-i2s.0'.
>
> +       CLKDEV_INIT("samsung-i2s.1", "i2s_opclk1",
> &exynos5_clk_sclk_audss_bus.clk),
>
>>  };
>>
>>  static unsigned long exynos5_epll_get_rate(struct clk *clk)
>> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
>> index aed2eeb..1bf25a5 100644
>> --- a/arch/arm/mach-exynos/common.h
>> +++ b/arch/arm/mach-exynos/common.h
>> @@ -13,6 +13,7 @@
>>  #define __ARCH_ARM_MACH_EXYNOS_COMMON_H
>>
>>  extern struct sys_timer exynos4_timer;
>> +extern void exynos5_set_audiocdclk_rate(unsigned long rate);
>>
>>  void exynos_init_io(struct map_desc *mach_desc, int size);
>>  void exynos4_init_irq(void);
>> diff --git a/arch/arm/mach-exynos/include/mach/regs-audss.h
>> b/arch/arm/mach-exynos/include/mach/regs-audss.h
>> index ca5a8b6..4bc9bf9 100644
>> --- a/arch/arm/mach-exynos/include/mach/regs-audss.h
>> +++ b/arch/arm/mach-exynos/include/mach/regs-audss.h
>> @@ -15,4 +15,16 @@
>>
>>  #define EXYNOS4_AUDSS_INT_MEM        (0x03000000)
>>
>> +#define EXYNOS_AUDSSREG(x)           (S5P_VA_AUDSS + (x))
>> +
>> +#define EXYNOS_CLKSRC_AUDSS_OFFSET   0x0
>> +#define EXYNOS_CLKDIV_AUDSS_OFFSET   0x4
>> +#define EXYNOS_CLKGATE_AUDSS_OFFSET  0x8
>> +
>> +#define EXYNOS_CLKSRC_AUDSS          (EXYNOS_AUDSSREG \
>> +                                     (EXYNOS_CLKSRC_AUDSS_OFFSET))
>> +#define EXYNOS_CLKDIV_AUDSS          (EXYNOS_AUDSSREG \
>> +                                     (EXYNOS_CLKDIV_AUDSS_OFFSET))
>> +#define EXYNOS_CLKGATE_AUDSS         (EXYNOS_AUDSSREG \
>> +                                     (EXYNOS_CLKGATE_AUDSS_OFFSET))
>
> Firstly, I don't know why we need to define XXX_OFFSET, how about just use
> the value directly?
Yes. I will remove the XXX_OFFSET definitions.
>
> And you said, above definitions would be in mach/regs-clock.h or regarding
> clock header file if they are for clock.
As these are related to AUDSS clock controller a seperate file is
created for that. If not required I will add these definitions in
regs-clock.h.
>
>>  #endif /* _PLAT_REGS_AUDSS_H */
>> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-
>> exynos/mach-exynos5-dt.c
>> index ef770bc..c334eea 100644
>> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
>> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
>> @@ -69,6 +69,7 @@ static void __init exynos5250_dt_machine_init(void)
>>  {
>>       of_platform_populate(NULL, of_default_bus_match_table,
>>                               exynos5250_auxdata_lookup, NULL);
>> +     exynos5_set_audiocdclk_rate(16934400);
>
> As you commented, the value of clock can be changed according to the board,
> and this file, mach-exynos5-dt.c is not only for smdk5250, now there is no
> board for exynos5250 though.
Please suggest me some file where I can call this function then.
>
> [...]
>
> Thanks.
>
> Best regards,
> Kgene.

Thanks for your review.

Best Regards
Padma
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
