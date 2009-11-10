From: jassisinghbrar@gmail.com (jassi brar)
Date: Tue, 10 Nov 2009 22:53:44 +0900
Subject: [PATCH]: S3C RTC driver: add support for S3C64xx
In-Reply-To: <b2e8f9f70911091746t845b285m3d30314ce7e9fd07@mail.gmail.com>
References: <b2e8f9f70911091746t845b285m3d30314ce7e9fd07@mail.gmail.com>
Message-ID: <1b68c6790911100553m267f35dav9638fc6c0340978d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2009 at 10:46 AM, Maurus Cuelenaere
<mcuelenaere@gmail.com> wrote:
> Add support for the S3C64xx SoC to the generic S3C RTC driver.
>
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
>
> ---
> ?arch/arm/mach-s3c6400/include/mach/map.h ?| ? ?1 +
> ?arch/arm/plat-s3c/include/plat/regs-rtc.h | ? ?4 ++
> ?arch/arm/plat-s3c24xx/devs.c ? ? ? ? ? ? ?| ? 14 ++++--
> ?arch/arm/plat-s3c64xx/Makefile ? ? ? ? ? ?| ? ?1 +
> ?drivers/rtc/Kconfig ? ? ? ? ? ? ? ? ? ? ? | ? ?2 +-
> ?drivers/rtc/rtc-s3c.c ? ? ? ? ? ? ? ? ? ? | ? 73 +++++++++++++++++++++++------
> ?6 files changed, 76 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-s3c6400/include/mach/map.h
> b/arch/arm/mach-s3c6400/include/mach/map.h
> index b34a5ed..ae7704c 100644
> --- a/arch/arm/mach-s3c6400/include/mach/map.h
> +++ b/arch/arm/mach-s3c6400/include/mach/map.h
> @@ -42,6 +42,7 @@
> ?#define S3C64XX_PA_FB ? ? ? ? ?(0x77100000)
> ?#define S3C64XX_PA_USB_HSOTG ? (0x7C000000)
> ?#define S3C64XX_PA_WATCHDOG ? ?(0x7E004000)
> +#define S3C64XX_PA_RTC ? ? ? ? (0x7E005000)
> ?#define S3C64XX_PA_ADC ? ? ? ? (0x7E00B000)
> ?#define S3C64XX_PA_SYSCON ? ? ?(0x7E00F000)
> ?#define S3C64XX_PA_AC97 ? ? ? ? ? ? ? ?(0x7F001000)
> diff --git a/arch/arm/plat-s3c/include/plat/regs-rtc.h
> b/arch/arm/plat-s3c/include/plat/regs-rtc.h
> index d5837cf..65c190d 100644
> --- a/arch/arm/plat-s3c/include/plat/regs-rtc.h
> +++ b/arch/arm/plat-s3c/include/plat/regs-rtc.h
> @@ -20,6 +20,10 @@
> ?#define S3C2410_RTCCON_CLKSEL (1<<1)
> ?#define S3C2410_RTCCON_CNTSEL (1<<2)
> ?#define S3C2410_RTCCON_CLKRST (1<<3)
> +#define S3C64XX_RTCCON_TICEN ?(1<<8)
> +
> +#define S3C64XX_RTCCON_TICMSK (0xF<<7)
> +#define S3C64XX_RTCCON_TICSHT (7)
>
> ?#define S3C2410_TICNT ? ? ? ?S3C2410_RTCREG(0x44)
> ?#define S3C2410_TICNT_ENABLE ?(1<<7)
> diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
> index f52a92c..7ec1acb 100644
> --- a/arch/arm/plat-s3c24xx/devs.c
> +++ b/arch/arm/plat-s3c24xx/devs.c
> @@ -32,6 +32,7 @@
>
> ?#include <plat/regs-serial.h>
> ?#include <plat/udc.h>
> +#include <plat/rtc.h>
>
> ?#include <plat/devs.h>
> ?#include <plat/cpu.h>
> @@ -291,11 +292,16 @@ static struct resource s3c_rtc_resource[] = {
> ? ? ? ?}
> ?};
>
> +static struct s3c_rtc_platdata s3c_rtc_pdata = {
> + ? ? ? .rtc_type ? ? ? = 0,
> +};
1) where is this structure defined?
    Perhaps u forgot to share the plat/rtc.h
2) rtc_type isn't very neat. Runtime CPU detection is better.
 Even better, if you manage to segregate the differences between
two versions and pass them via platform data somehow.
For, example, driver could assume resolution as pdata->resolution
instead of 128 or 32768 or whatever for future SoCs.

> ?struct platform_device s3c_device_rtc = {
> - ? ? ? .name ? ? ? ? ? ? = "s3c2410-rtc",
> - ? ? ? .id ? ? ? ? ? ? ? = -1,
> - ? ? ? .num_resources ? ?= ARRAY_SIZE(s3c_rtc_resource),
> - ? ? ? .resource ? ? ? ? = s3c_rtc_resource,
> + ? ? ? .name ? ? ? ? ? ? ? ? ? = "s3c-rtc",
> + ? ? ? .id ? ? ? ? ? ? ? ? ? ? = -1,
> + ? ? ? .num_resources ? ? ? ? ?= ARRAY_SIZE(s3c_rtc_resource),
> + ? ? ? .resource ? ? ? ? ? ? ? = s3c_rtc_resource,
> + ? ? ? .dev.platform_data ? ? ?= &s3c_rtc_pdata,
> ?};
> ?EXPORT_SYMBOL(s3c_device_rtc);
> diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
> index a8c5d17..25d9f6d 100644
> --- a/arch/arm/plat-s3c64xx/Makefile
> +++ b/arch/arm/plat-s3c64xx/Makefile
> @@ -14,6 +14,7 @@ obj- ? ? ? ? ? ? ? ? ? ? ? ? ?:=
>
> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= dev-uart.o
> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= dev-adc.o
> +obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= dev-rtc.o
> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= cpu.o
> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= irq.o
> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= irq-eint.o
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 3c20dae..1b7a0c7 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -585,7 +585,7 @@ config RTC_DRV_OMAP
>
> ?config RTC_DRV_S3C
> ? ? ? ?tristate "Samsung S3C series SoC RTC"
> - ? ? ? depends on ARCH_S3C2410
> + ? ? ? depends on ARCH_S3C2410 || ARCH_S3C64XX
> ? ? ? ?help
> ? ? ? ? ?RTC (Realtime Clock) driver for the clock inbuilt into the
> ? ? ? ? ?Samsung S3C24XX series of SoCs. This can provide periodic
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index e0d7b99..03959b6 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -27,6 +27,7 @@
> ?#include <asm/io.h>
> ?#include <asm/irq.h>
> ?#include <plat/regs-rtc.h>
> +#include <plat/rtc.h>
>
> ?/* I have yet to find an S3C implementation with more than one
> ?* of these rtc blocks in */
> @@ -75,16 +76,28 @@ static void s3c_rtc_setaie(int to)
> ?static int s3c_rtc_setpie(struct device *dev, int enabled)
> ?{
> ? ? ? ?unsigned int tmp;
> + ? ? ? struct s3c_rtc_platdata* pdata = dev->platform_data;
>
> ? ? ? ?pr_debug("%s: pie=%d\n", __func__, enabled);
>
> ? ? ? ?spin_lock_irq(&s3c_rtc_pie_lock);
> - ? ? ? tmp = readb(s3c_rtc_base + S3C2410_TICNT) & ~S3C2410_TICNT_ENABLE;
>
> - ? ? ? if (enabled)
> - ? ? ? ? ? ? ? tmp |= S3C2410_TICNT_ENABLE;
> + ? ? ? if (pdata->rtc_type == 1) {
> + ? ? ? ? ? ? ? tmp = readb(s3c_rtc_base + S3C2410_RTCCON) & ~S3C64XX_RTCCON_TICEN;
> +
> + ? ? ? ? ? ? ? if (enabled)
> + ? ? ? ? ? ? ? ? ? ? ? tmp |= S3C64XX_RTCCON_TICEN;
> +
> + ? ? ? ? ? ? ? writeb(tmp, s3c_rtc_base + S3C2410_RTCCON);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? tmp = readb(s3c_rtc_base + S3C2410_TICNT) & ~S3C2410_TICNT_ENABLE;
> +
> + ? ? ? ? ? ? ? if (enabled)
> + ? ? ? ? ? ? ? ? ? ? ? tmp |= S3C2410_TICNT_ENABLE;
> +
> + ? ? ? ? ? ? ? writeb(tmp, s3c_rtc_base + S3C2410_TICNT);
> + ? ? ? }
>
> - ? ? ? writeb(tmp, s3c_rtc_base + S3C2410_TICNT);
> ? ? ? ?spin_unlock_irq(&s3c_rtc_pie_lock);
>
> ? ? ? ?return 0;
> @@ -93,14 +106,19 @@ static int s3c_rtc_setpie(struct device *dev, int enabled)
> ?static int s3c_rtc_setfreq(struct device *dev, int freq)
> ?{
> ? ? ? ?unsigned int tmp;
> + ? ? ? struct s3c_rtc_platdata* pdata = dev->platform_data;
>
> ? ? ? ?if (!is_power_of_2(freq))
> ? ? ? ? ? ? ? ?return -EINVAL;
>
> ? ? ? ?spin_lock_irq(&s3c_rtc_pie_lock);
>
> - ? ? ? tmp = readb(s3c_rtc_base + S3C2410_TICNT) & S3C2410_TICNT_ENABLE;
> - ? ? ? tmp |= (128 / freq)-1;
> + ? ? ? if (pdata->rtc_type == 1) {
> + ? ? ? ? ? ? ? tmp = (32768 / freq)-1;
> + ? ? ? } else {
> + ? ? ? ? ? ? ? tmp = readb(s3c_rtc_base + S3C2410_TICNT) & S3C2410_TICNT_ENABLE;
> + ? ? ? ? ? ? ? tmp |= (128 / freq)-1;
> + ? ? ? }
>
> ? ? ? ?writeb(tmp, s3c_rtc_base + S3C2410_TICNT);
> ? ? ? ?spin_unlock_irq(&s3c_rtc_pie_lock);
> @@ -282,10 +300,15 @@ static int s3c_rtc_setalarm(struct device *dev,
> struct rtc_wkalrm *alrm)
>
> ?static int s3c_rtc_proc(struct device *dev, struct seq_file *seq)
> ?{
> - ? ? ? unsigned int ticnt = readb(s3c_rtc_base + S3C2410_TICNT);
> + ? ? ? unsigned int ticnt;
> + ? ? ? struct s3c_rtc_platdata* pdata = dev->platform_data;
>
> - ? ? ? seq_printf(seq, "periodic_IRQ\t: %s\n",
> - ? ? ? ? ? ? ? ? ? ?(ticnt & S3C2410_TICNT_ENABLE) ? "yes" : "no" );
> + ? ? ? if (pdata->rtc_type == 1)
> + ? ? ? ? ? ? ? ticnt = readb(s3c_rtc_base + S3C2410_RTCCON) & S3C64XX_RTCCON_TICEN;
> + ? ? ? else
> + ? ? ? ? ? ? ? ticnt = readb(s3c_rtc_base + S3C2410_TICNT) & S3C2410_TICNT_ENABLE;
> +
> + ? ? ? seq_printf(seq, "periodic_IRQ\t: %s\n", ticnt ?? "yes" : "no" );
> ? ? ? ?return 0;
> ?}
>
> @@ -346,16 +369,21 @@ static void s3c_rtc_enable(struct
> platform_device *pdev, int en)
> ?{
> ? ? ? ?void __iomem *base = s3c_rtc_base;
> ? ? ? ?unsigned int tmp;
> + ? ? ? struct s3c_rtc_platdata* pdata = pdev->dev.platform_data;
>
> ? ? ? ?if (s3c_rtc_base == NULL)
> ? ? ? ? ? ? ? ?return;
>
> ? ? ? ?if (!en) {
> ? ? ? ? ? ? ? ?tmp = readb(base + S3C2410_RTCCON);
> + ? ? ? ? ? ? ? if (pdata->rtc_type == 1)
> + ? ? ? ? ? ? ? ? ? ? ? tmp &= ~S3C64XX_RTCCON_TICEN;
> ? ? ? ? ? ? ? ?writeb(tmp & ~S3C2410_RTCCON_RTCEN, base + S3C2410_RTCCON);
>
> - ? ? ? ? ? ? ? tmp = readb(base + S3C2410_TICNT);
> - ? ? ? ? ? ? ? writeb(tmp & ~S3C2410_TICNT_ENABLE, base + S3C2410_TICNT);
> + ? ? ? ? ? ? ? if (pdata->rtc_type == 0) {
> + ? ? ? ? ? ? ? ? ? ? ? tmp = readb(base + S3C2410_TICNT);
> + ? ? ? ? ? ? ? ? ? ? ? writeb(tmp & ~S3C2410_TICNT_ENABLE, base + S3C2410_TICNT);
> + ? ? ? ? ? ? ? }
> ? ? ? ?} else {
> ? ? ? ? ? ? ? ?/* re-enable the device, and check it is ok */
>
> @@ -403,6 +431,7 @@ static int __devinit s3c_rtc_probe(struct
> platform_device *pdev)
> ?{
> ? ? ? ?struct rtc_device *rtc;
> ? ? ? ?struct resource *res;
> + ? ? ? struct s3c_rtc_platdata* pdata = pdev->dev.platform_data;
> ? ? ? ?int ret;
>
> ? ? ? ?pr_debug("%s: probe=%p\n", __func__, pdev);
> @@ -471,7 +500,10 @@ static int __devinit s3c_rtc_probe(struct
> platform_device *pdev)
> ? ? ? ? ? ? ? ?goto err_nortc;
> ? ? ? ?}
>
> - ? ? ? rtc->max_user_freq = 128;
> + ? ? ? if (pdata->rtc_type == 1)
> + ? ? ? ? ? ? ? rtc->max_user_freq = 32768;
> + ? ? ? else
> + ? ? ? ? ? ? ? rtc->max_user_freq = 128;
>
> ? ? ? ?platform_set_drvdata(pdev, rtc);
> ? ? ? ?return 0;
> @@ -491,20 +523,33 @@ static int __devinit s3c_rtc_probe(struct
> platform_device *pdev)
>
> ?/* RTC Power management control */
>
> -static int ticnt_save;
> +static int ticnt_save, ticnt_en_save;
>
> ?static int s3c_rtc_suspend(struct platform_device *pdev, pm_message_t state)
> ?{
> + ? ? ? struct s3c_rtc_platdata* pdata = pdev->dev.platform_data;
> +
> ? ? ? ?/* save TICNT for anyone using periodic interrupts */
> ? ? ? ?ticnt_save = readb(s3c_rtc_base + S3C2410_TICNT);
> + ? ? ? if (pdata->rtc_type == 1) {
> + ? ? ? ? ? ? ? ticnt_en_save = readb(s3c_rtc_base + S3C2410_RTCCON)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? & S3C64XX_RTCCON_TICEN;
> + ? ? ? }
> ? ? ? ?s3c_rtc_enable(pdev, 0);
> ? ? ? ?return 0;
> ?}
>
> ?static int s3c_rtc_resume(struct platform_device *pdev)
> ?{
> + ? ? ? struct s3c_rtc_platdata* pdata = pdev->dev.platform_data;
> + ? ? ? unsigned int tmp;
> +
> ? ? ? ?s3c_rtc_enable(pdev, 1);
> ? ? ? ?writeb(ticnt_save, s3c_rtc_base + S3C2410_TICNT);
> + ? ? ? if (pdata->rtc_type == 1 && ticnt_en_save) {
> + ? ? ? ? ? ? ? tmp = readb(s3c_rtc_base + S3C2410_RTCCON);
> + ? ? ? ? ? ? ? writeb(tmp | ticnt_en_save, s3c_rtc_base + S3C2410_RTCCON);
> + ? ? ? }
> ? ? ? ?return 0;
> ?}
> ?#else
> @@ -518,7 +563,7 @@ static struct platform_driver s3c2410_rtc_driver = {
> ? ? ? ?.suspend ? ? ? ?= s3c_rtc_suspend,
> ? ? ? ?.resume ? ? ? ? = s3c_rtc_resume,
> ? ? ? ?.driver ? ? ? ? = {
> - ? ? ? ? ? ? ? .name ? = "s3c2410-rtc",
> + ? ? ? ? ? ? ? .name ? = "s3c-rtc",
> ? ? ? ? ? ? ? ?.owner ?= THIS_MODULE,
> ? ? ? ?},
> ?};
why not use platform_device_id ?
