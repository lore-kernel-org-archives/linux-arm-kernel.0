From: d.cristiani@idem-tech.it (dylan cristiani)
Date: Wed, 10 Nov 2010 12:09:12 +0100
Subject: hi marek
In-Reply-To: <1289382751.16575.2.camel@konomi>
References: <20101109184220.00003433@unknown>
	<201011091936.13781.marek.vasut@gmail.com>
	<20101110100709.00003d84@unknown>
	<AANLkTi=TupY6Equaifzs6qX8_1y-tNrPFtVB+0=k_Xyh@mail.gmail.com>
	<1289382751.16575.2.camel@konomi>
Message-ID: <20101110120912.000073d3@unknown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Nov 2010 10:52:31 +0100
Marek Vasut <marek.vasut.n900@gmail.com> wrote:

> > On Wed, Nov 10, 2010 at 5:07 PM, dylan cristiani
> > <d.cristiani@idem-tech.it> wrote:
> > > On Tue, 9 Nov 2010 19:36:13 +0100
> > > Marek Vasut <marek.vasut@gmail.com> wrote:
> > > 
> > > > On Tuesday 09 November 2010 18:42:20 dylan cristiani wrote:
> > > > > We heard some month ago, about ucb1400 irq passing, via
> > > > > ucb1400_platform_data; then you wrote the patch, that is
> > > > > currently into mainline; i've a little problem, probably due
> > > > > to my infinite ignorance: i'm writing a sort of my_pm.c
> > > > > driver to check whether the ac line is plugged or not, check
> > > > > the main battery voltage and so on (similar to
> > > > > arch/arm/mach-pxa/sharpsl_pm.c and corgi_pm.c if you know
> > > > > it); the problem is that the battery voltages are tied to the
> > > > > ucb1400 ADC inputs, and in my_pm.c driver i don't know how to
> > > > > find the ucb1400_ts structure address to call the functions i
> > > > > need to read these ADC input i.e.:
> > > > 
> > > > 1) CC lists
> > > > 
> > > > 2) Can you post the driver source you have ?
> > > > 
> > > > without seeing the source, I can't help you
> > > here it comes but please close your nose before reading....;-)
> > > 
> > > arch/arm/mach-pxa/nilux_pm.c
> > > 
> > > /*
> > > ?* Based on spitz_pm.c and sharp code.
> > > ?*
> > > ?* Distributed under term of GPLv2.
> > > ?*
> > > ?*/
> > > 
> > > #include <linux/module.h>
> > > #include <linux/stat.h>
> > > #include <linux/init.h>
> > > #include <linux/completion.h>
> > > #include <linux/kernel.h>
> > > #include <linux/delay.h>
> > > #include <linux/gpio.h>
> > > //#include <linux/input.h>
> > > #include <linux/device.h>
> > > #include <linux/interrupt.h>
> > > #include <linux/suspend.h>
> > > #include <linux/apm-emulation.h>
> > > #include <linux/platform_device.h>
> > > #include <linux/ucb1400.h>
> > > 
> > > #include <asm/irq.h>
> > > #include <asm/mach-types.h>
> > > #include <mach/hardware.h>
> > > 
> > > #include <mach/pm.h>
> > > #include <mach/pxa2xx-regs.h>
> > > #include <mach/regs-rtc.h>
> > > #include <mach/sharpsl_pm.h>
> > > 
> > > 
> > > #define AC_IN_INT ? ? ? ? ? ? ? 17
> > > #define NYLUX_BATT_VOLT ? ? ? ? 1
> > > #define NYLUX_STATUS_ACIN ? ? ? 4
> > > #define NYLUX_BKUPBATT_TEMP ? ? 2
> > > #define NYLUX_CHARGE_STATUS ? ? 3
> > > 
> > > 
> > > static struct ucb1400_ts *ucb;
> > > 
> > > static void nylux_charger_init(void)
> > > {
> > > }
> > > 
> > > static void nylux_charger_exit(void)
> > > {
> > > }
> > > 
> > > unsigned long nylux_read_main_battery(void)
> > > {
> > > // ? ? ?struct ucb1400_ts *ucb;
> > > ? ? ? ?unsigned int voltage = 0;
> > > 
> > > ? ? ? ?printk(KERN_INFO "Reading_Main_Battery\n");
> > > 
> > > ? ? ? ?ucb1400_adc_enable(ucb->ac97);
> > > 
> > > // ? ? ?printk(KERN_INFO "Post adc_enable\n");
> > > 
> > > ? ? ? ?mdelay(1);
> > > ? ? ? ?voltage = ucb1400_adc_read(ucb->ac97, UCB_ADC_INP_AD0, 0);
> > > ? ? ? ?printk(KERN_INFO "\nVVVVVVvoltage %d\n", voltage);
> > > 
> > > ? ? ? ?ucb1400_adc_disable(ucb->ac97);
> > > 
> > > ? ? ? ?return voltage;
> > > }
> > > 
> > > unsigned long nylux_read_bkup_battery(void)
> > > {
> > > // ? ? ?struct ucb1400_ts *ucb;
> > > ? ? ? ?unsigned int voltage;
> > > 
> > > ? ? ? ?ucb1400_adc_enable(ucb->ac97);
> > > 
> > > ? ? ? ?mdelay(1);
> > > ? ? ? ?voltage = ucb1400_adc_read(ucb->ac97, UCB_ADC_INP_AD1, 0);
> > > 
> > > ? ? ? ?ucb1400_adc_disable(ucb->ac97);
> > > ? ? ? ?//printk(KERN_INFO "Battery_bkup value = %d\n", voltage);
> > > 
> > > ? ? ? ?return voltage;
> > > }
> > > 
> > > unsigned long nylux_charge_status(void)
> > > {
> > > // ? ? ?struct ucb1400_ts *ucb;
> > > ? ? ? ?unsigned int status;
> > > 
> > > ? ? ? ?//printk(KERN_INFO "Charge_status\n");
> > > ? ? ? ?ucb1400_adc_enable(ucb->ac97);
> > > ? ? ? ?mdelay(1);
> > > ? ? ? ?status = ucb1400_adc_read(ucb->ac97, UCB_ADC_INP_AD2, 0);
> > > ? ? ? ?//printk(KERN_INFO "Charge status= %d\n", status);
> > > ? ? ? ?ucb1400_adc_disable(ucb->ac97);
> > > 
> > > ? ? ? ?return status;
> > > 
> > > }
> > > 
> > > static unsigned long nylux_read_devdata(int which)
> > > {
> > > ? ? ? ?unsigned long ret = ~0;
> > > 
> > > ? ? ? ?switch (which) {
> > > ? ? ? ?case NYLUX_BATT_VOLT:
> > > ? ? ? ? ? ? ? ?ret = nylux_read_main_battery();
> > > ? ? ? ? ? ? ? ?//printk(KERN_INFO "read_main_battery: %d\n", ret);
> > > ? ? ? ? ? ? ? ?break;
> > > ? ? ? ?//case NYLUX_BKUPBATT_TEMP:
> > > ? ? ? ? ? ? ? ?//ret = nylux_read_bkup_battery();
> > > ? ? ? ? ? ? ? ?//break;
> > > ? ? ? ?//case NYLUX_CHARGE_STATUS:
> > > ? ? ? ? ? ? ? ?//ret = nylux_charge_status();
> > > ? ? ? ? ? ? ? ?//break;
> > > ? ? ? ?case NYLUX_STATUS_ACIN: {
> > > ? ? ? ? ? ? ? ?ret = GPLR(AC_IN_INT) & GPIO_bit(AC_IN_INT);
> > > ? ? ? ? ? ? ? ?//printk(KERN_INFO "AC_IN = %d\n", ret);
> > > ? ? ? ? ? ? ? ?//ret = read_ac_status();
> > > ? ? ? ? ? ? ? ?//printk(KERN_INFO "read_ac_status: %d\n", ret);
> > > ? ? ? ? ? ? ? ?break;
> > > ? ? ? ?}
> > > 
> > > ? ? ? ?default:
> > > ? ? ? ? ? ? ? ?ret = ~0;
> > > ? ? ? ?}
> > > 
> > > ? ? ? ?return ret;
> > > 
> > > }
> > > 
> > > //******
> > > struct battery_thresh battery_levels[] = {
> > > ? ? ? ?{ 550, 100},
> > > ? ? ? ?{ 544, ?97},
> > > ? ? ? ?{ 541, ?93},
> > > ? ? ? ?{ 536, ?88},
> > > ? ? ? ?{ 531, ?83},
> > > ? ? ? ?{ 526, ?78},
> > > ? ? ? ?{ 522, ?73},
> > > ? ? ? ?{ 517, ?68},
> > > ? ? ? ?{ 514, ?63},
> > > ? ? ? ?{ 510, ?58},
> > > ? ? ? ?{ 506, ?53},
> > > ? ? ? ?{ 503, ?48},
> > > ? ? ? ?{ 499, ?43},
> > > ? ? ? ?{ 497, ?38},
> > > ? ? ? ?{ 495, ?33},
> > > ? ? ? ?{ 493, ?28},
> > > ? ? ? ?{ 492, ?23},
> > > ? ? ? ?{ 491, ?18},
> > > ? ? ? ?{ 489, ?13},
> > > ? ? ? ?{ 488, ? 8},
> > > ? ? ? ?{ 484, ? 3},
> > > ? ? ? ?{ 478, ? 0}
> > > };
> > > 
> > > struct sharpsl_charger_machinfo nylux_pm_machinfo = {
> > > ? ? ? ?.init ? ? ? ? ? ? = nylux_charger_init,
> > > ? ? ? ?.exit ? ? ? ? ? ? = nylux_charger_exit,
> > > ? ? ? ?.gpio_acin ? ? ? ?= AC_IN_INT,
> > > ? ? ? ?.read_devdata ? ? = nylux_read_devdata,
> > > ? ? ? ?.discharge ? ? ? ?= 0,
> > > ? ? ? ?.discharge1 ? ? ? = 0,
> > > ? ? ? ?.charge ? ? ? ? ? = 0,
> > > ? ? ? ?.measure_temp ? ? = 0,
> > > ? ? ? ?.presuspend ? ? ? = 0,
> > > ? ? ? ?.postsuspend ? ? ?= 0,
> > > ? ? ? ?.charger_wakeup ? = 0,
> > > ? ? ? ?.should_wakeup ? ?= 0,
> > > ? ? ? ?.bat_levels ? ? ? = 22,
> > > ? ? ? ?.bat_levels_noac ?= battery_levels,
> > > ? ? ? ?.bat_levels_acin ?= 0,
> > > ? ? ? ?.status_high_acin = 510,
> > > ? ? ? ?.status_low_acin ?= 490,
> > > ? ? ? ?.status_high_noac = 510,
> > > ? ? ? ?.status_low_noac ?= 490,
> > > ? ? ? ?.charge_on_volt ? = 0,
> > > ? ? ? ?.charge_on_temp ? = 0,
> > > ? ? ? ?.charge_acin_high = 0,
> > > ? ? ? ?.charge_acin_low ?= 0,
> > > ? ? ? ?.fatal_acin_volt ?= 0,
> > > ? ? ? ?.fatal_noacin_volt = 0,
> > > 
> > > ? ? ? ?.batfull_irq ? ? ?= 1
> > > };
> > > 
> > > 
> > > /*
> > > static int __init collie_pm_ucb_add(struct ucb1x00_dev *pdev)
> > > {
> > > ? ? ? ?sharpsl_pm.machinfo = &nylux_pm_machinfo;
> > > ? ? ? ?ucb = pdev->ucb;
> > > ? ? ? ?return 0;
> > > }
> > > 
> > > static struct ucb1x00_driver collie_pm_ucb_driver = {
> > > ? ? ? ?.add ? ? ? ? ? ?= collie_pm_ucb_add,
> > > };
> > > */
> > > 
> > > static struct platform_device *nyluxpm_device;
> > > 
> > > static int __devinit nyluxpm_init(void)
> > > {
> > > ? ? ? ?int ret;
> > > 
> > > ? ? ? ?nyluxpm_device = platform_device_alloc("sharpsl-pm", -1);
> > > ? ? ? ?if (!nyluxpm_device)
> > > ? ? ? ? ? ? ? ?return -ENOMEM;
> > > 
> > > ? ? ? ?nyluxpm_device->dev.platform_data = &nylux_pm_machinfo;
> > > ? ? ? ?ret = platform_device_add(nyluxpm_device);
> > > 
> > > ? ? ? ?if (ret)
> > > ? ? ? ? ? ? ? ?platform_device_put(nyluxpm_device);
> > > 
> > > // ? ? ?if (!ret)
> > > // ? ? ? ? ? ? ?ret =
> > > ucb1x00_register_driver(&collie_pm_ucb_driver);
> > > 
> > > ? ? ? ?return ret;
> > > }
> > > 
> > > static void nyluxpm_exit(void)
> > > {
> > > // ? ? ?ucb1x00_unregister_driver(&collie_pm_ucb_driver);
> > > ? ? ? ?platform_device_unregister(nyluxpm_device);
> > > }
> > > 
> > > module_init(nyluxpm_init);
> > > module_exit(nyluxpm_exit);
> > > 
> > > 
> > > thanks
> > > dylan
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel at lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > 
> > 
> > You should append your power driver into drivers/power directory.
> > There's an example of colie_battery.c. It's also based on udc.
> 
> That's basically what I said a few lines above ;-)
> 
> btw I think he's also intermixing ucb1x00 (ucb < 1400) and ucb1400

first of all thanks for the hint:
i digged a bit into collie_battery.c and i noticed that it uses struct
like 'ucb1x00' and 'ucb1x00_dev' while with ucb1400 i don't have
anything similar just struct 'ucb1400' that is sum of 'ucb1400_ts' and
'ucb1400_gpio', but i don't see how to use these strusctures properly
with my driver in fact 'ucb1x00' has a 'device' member into it while for
instance ucb1400_ts has an 'input_dev' member
