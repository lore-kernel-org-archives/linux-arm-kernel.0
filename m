From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 25 Aug 2010 15:18:09 +0200
Subject: [PATCH 1/3] pxa: Hookup MAX7312 thats connected to I2C.
In-Reply-To: <AANLkTikqJ0KWMErk44Z=yj48dEALyz+dC9tEnLL53-V0@mail.gmail.com>
References: <1282727896.6968.96.camel@pe-lt522.marvell.com>
	<201008251459.28970.marek.vasut@gmail.com>
	<AANLkTikqJ0KWMErk44Z=yj48dEALyz+dC9tEnLL53-V0@mail.gmail.com>
Message-ID: <201008251518.09553.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 25. srpna 2010 15:14:35 Eric Miao napsal(a):
> On Wed, Aug 25, 2010 at 8:59 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Dne St 25. srpna 2010 11:18:16 Sachin Sanap napsal(a):
> >> Signed-off-by: Sachin Sanap <ssanap@marvell.com>
> >> ---
> >>  arch/arm/mach-mmp/aspenite.c |   31 +++++++++++++++++++++++++++++--
> >>  1 files changed, 29 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
> >> index 244655d..d19c26c 100644
> >> --- a/arch/arm/mach-mmp/aspenite.c
> >> +++ b/arch/arm/mach-mmp/aspenite.c
> >> @@ -23,9 +23,12 @@
> >>  #include <mach/mfp-pxa168.h>
> >>  #include <mach/pxa168.h>
> >>  #include <mach/gpio.h>
> >> +#include <linux/i2c/pca953x.h>
> >> 
> >>  #include "common.h"
> >> 
> >> +#define GPIO_EXT1(x) (128 + 16 + (x))
> >> +
> >>  static unsigned long common_pin_config[] __initdata = {
> >>       /* Data Flash Interface */
> >>       GPIO0_DFI_D15,
> >> @@ -66,6 +69,11 @@ static unsigned long common_pin_config[] __initdata =
> >> { GPIO115_I2S_BCLK,
> >>       GPIO116_I2S_RXD,
> >>       GPIO117_I2S_TXD,
> >> +
> >> +     /* i2c bus */
> >> +     GPIO105_CI2C_SDA,
> >> +     GPIO106_CI2C_SCL,
> >> +
> >>  };
> >> 
> >>  static struct smc91x_platdata smc91x_info = {
> >> @@ -130,17 +138,36 @@ static struct pxa3xx_nand_platform_data
> >> aspenite_nand_info = { .nr_parts      =
> >> ARRAY_SIZE(aspenite_nand_partitions), };
> >> 
> >> -static struct i2c_board_info aspenite_i2c_info[] __initdata = {
> >> +#if defined(CONFIG_GPIO_PCA953X)
> >> +static struct pca953x_platform_data max7312_data[] = {
> >> +     [0] = {
> >> +             .gpio_base      = GPIO_EXT1(0),
> >> +     },
> >> +};
> >> +#endif
> >> +
> >> +static struct i2c_board_info aspenite_pwri2c_info[] __initdata = {
> >>       { I2C_BOARD_INFO("wm8753", 0x1b), },
> >>  };
> >> 
> >> +static struct i2c_board_info aspenite_i2c_info[] __initdata = {
> >> +#if defined(CONFIG_GPIO_PCA953X)
> >> +     {
> >> +             I2C_BOARD_INFO("max7312", 0x20),
> >> +             .irq = IRQ_GPIO(120),
> >> +             .platform_data  = &max7312_data[0],
> >> +     },
> >> +#endif
> >> +};
> >> +
> > 
> > I see what you're trying to achieve here, but this seems quite clumsy
> > actually. Try this approach (see mach-pxa/colibri_pxa320.c for example):
> > 
> > #if defined(...aspenite_pi2c_chip is selected) ||
> > defined(...dtto..._MODULE) static <pi2c chips pdata>
> > aspenite_pwri2c_info = {
> > 
> > };
> > 
> > statid void __init aspenite_pi2c_init(void)
> > {
> >        pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(aspenite_pwri2c_info));
> > }
> > #else
> > static inline void aspenite_pi2c_init(void) {}
> > #endif
> 
> Or to leave those #ifdef .. #endif out completely. I don't actually care
> that much about the benefit of saving some additional bytes compared
> with the mess sometimes with all those #ifdef .. floating around.

Well if you use nice formating like I did with very descriptive comments (like 
palm has, balloon3 has, vpac has etc, where even blind dude has to notice what 
is in the code below), this much ifdefs is actually ok I think.

> 
> > static void __init common_init()
> > {
> > ...
> >        pxa168_add_uart(1);
> >        aspenite_pi2c_init();
> >        aspenite_i2c_init();
> > ...
> > }
> > 
> >>  static void __init common_init(void)
> >>  {
> >>       mfp_config(ARRAY_AND_SIZE(common_pin_config));
> >> 
> >>       /* on-chip devices */
> >>       pxa168_add_uart(1);
> >> -     pxa168_add_twsi(1, NULL, ARRAY_AND_SIZE(aspenite_i2c_info));
> >> +     pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(aspenite_i2c_info));
> >> +     pxa168_add_twsi(1, NULL, ARRAY_AND_SIZE(aspenite_pwri2c_info));
> > 
> > Why not just add:
> > pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(aspenite_pwri2c_info));
> > 
> > But anyway, this can be dumped with the code I outlined above. Cheers
> > ?
> > 
> >>       pxa168_add_ssp(1);
> >>       pxa168_add_nand(&aspenite_nand_info);
