From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 5 Jul 2011 15:41:05 +0800
Subject: [PATCH 2/3] ARM: mmp: enable one wire controller in ttc dkb
In-Reply-To: <1302861927-6845-2-git-send-email-haojian.zhuang@marvell.com>
References: <1302861927-6845-1-git-send-email-haojian.zhuang@marvell.com>
	<1302861927-6845-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CAMPhdO_LZKNmhM7WEc_WmmiaQpzOdZJH8Gu2b_NB3M=hLJFt+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 6:05 PM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:
> Enable one wire controller in TTC DKB platform.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
> ?arch/arm/mach-mmp/include/mach/mfp-pxa910.h | ? ?3 +++
> ?arch/arm/mach-mmp/include/mach/pxa910.h ? ? | ? ?2 ++
> ?arch/arm/mach-mmp/pxa910.c ? ? ? ? ? ? ? ? ?| ? 15 +++++++++++++++
> ?arch/arm/mach-mmp/ttc_dkb.c ? ? ? ? ? ? ? ? | ? 13 ++++++++++++-
> ?4 files changed, 32 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> index fbd7ee8..4f8b7e8 100644
> --- a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> +++ b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> @@ -40,6 +40,9 @@
> ?#define GPIO124_MN_CLK_OUT ? ? MFP_CFG_DRV(GPIO124, AF1, MEDIUM)
> ?#define GPIO123_CLK_REQ ? ? ? ? ? ? ? ?MFP_CFG_DRV(GPIO123, AF0, MEDIUM)
>
> +/* one wire */
> +#define ONEWIRE_CLK_REQ ? ? ? ? ? ? ? ?MFP_CFG(GPIO123, AF2)
> +
> ?/* DFI */
> ?#define DF_IO0_ND_IO0 ? ? ? ? ?MFP_CFG(DF_IO0, AF0)
> ?#define DF_IO1_ND_IO1 ? ? ? ? ?MFP_CFG(DF_IO1, AF0)
> diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h b/arch/arm/mach-mmp/include/mach/pxa910.h
> index 91be755..38afd28 100644
> --- a/arch/arm/mach-mmp/include/mach/pxa910.h
> +++ b/arch/arm/mach-mmp/include/mach/pxa910.h
> @@ -21,6 +21,8 @@ extern struct pxa_device_desc pxa910_device_pwm3;
> ?extern struct pxa_device_desc pxa910_device_pwm4;
> ?extern struct pxa_device_desc pxa910_device_nand;
>
> +extern struct platform_device pxa910_device_1wire;
> +

And add the function below as well?

static inline int pxa910_add_1wire(struct ds1wm_driver_data *)

> ?static inline int pxa910_add_uart(int id)
> ?{
> ? ? ? ?struct pxa_device_desc *d = NULL;
> diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
> index 8f92ccd..b1c9fcf 100644
> --- a/arch/arm/mach-mmp/pxa910.c
> +++ b/arch/arm/mach-mmp/pxa910.c
> @@ -13,6 +13,7 @@
> ?#include <linux/init.h>
> ?#include <linux/list.h>
> ?#include <linux/io.h>
> +#include <linux/platform_device.h>
>
> ?#include <asm/mach/time.h>
> ?#include <mach/addr-map.h>
> @@ -109,6 +110,7 @@ static APBC_CLK(pwm1, PXA910_PWM1, 1, 13000000);
> ?static APBC_CLK(pwm2, PXA910_PWM2, 1, 13000000);
> ?static APBC_CLK(pwm3, PXA910_PWM3, 1, 13000000);
> ?static APBC_CLK(pwm4, PXA910_PWM4, 1, 13000000);
> +static APBC_CLK(w1, PXA910_ONEWIRE, 0, 26000000);
>
> ?static APMU_CLK(nand, NAND, 0x01db, 208000000);
> ?static APMU_CLK(u2o, USB, 0x1b, 480000000);
> @@ -125,6 +127,7 @@ static struct clk_lookup pxa910_clkregs[] = {
> ? ? ? ?INIT_CLKREG(&clk_pwm4, "pxa910-pwm.3", NULL),
> ? ? ? ?INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
> ? ? ? ?INIT_CLKREG(&clk_u2o, "pxa-u2o", "U2OCLK"),
> + ? ? ? INIT_CLKREG(&clk_w1, "pxa3xx-w1", NULL),
> ?};
>
> ?static int __init pxa910_init(void)
> @@ -180,3 +183,15 @@ PXA910_DEVICE(pwm2, "pxa910-pwm", 1, NONE, 0xd401a400, 0x10);
> ?PXA910_DEVICE(pwm3, "pxa910-pwm", 2, NONE, 0xd401a800, 0x10);
> ?PXA910_DEVICE(pwm4, "pxa910-pwm", 3, NONE, 0xd401ac00, 0x10);
> ?PXA910_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
> +
> +static struct resource pxa910_resource_1wire[] = {
> + ? ? ? {0xd4011800, ? ? ? ? 0xd4011813, ? ? ? ? "ds1wm-mem", IORESOURCE_MEM,},
> + ? ? ? {IRQ_PXA910_ONEWIRE, IRQ_PXA910_ONEWIRE, "ds1wm-irq", IORESOURCE_IRQ,},
> +};
> +
> +struct platform_device pxa910_device_1wire = {
> + ? ? ? .name ? ? ? ? ? = "pxa3xx-w1",
> + ? ? ? .id ? ? ? ? ? ? = -1,
> + ? ? ? .num_resources ?= ARRAY_SIZE(pxa910_resource_1wire),
> + ? ? ? .resource ? ? ? = pxa910_resource_1wire,
> +};

Is

PXA910_DEVICE(w1, "pxa3xx-w1", -1, ONEWIRE, 0xd4011800, 0x20);

sufficient to describe the device?

> diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
> index e411039..1820071 100644
> --- a/arch/arm/mach-mmp/ttc_dkb.c
> +++ b/arch/arm/mach-mmp/ttc_dkb.c
> @@ -11,10 +11,11 @@
> ?#include <linux/init.h>
> ?#include <linux/kernel.h>
> ?#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> ?#include <linux/mtd/mtd.h>
> ?#include <linux/mtd/partitions.h>
> ?#include <linux/mtd/onenand.h>
> -#include <linux/interrupt.h>
> +#include <linux/mfd/ds1wm.h>
>
> ?#include <asm/mach-types.h>
> ?#include <asm/mach/arch.h>
> @@ -55,6 +56,9 @@ static unsigned long ttc_dkb_pin_config[] __initdata = {
> ? ? ? ?DF_WEn_DF_WEn,
> ? ? ? ?DF_REn_DF_REn,
> ? ? ? ?DF_RDY0_DF_RDY0,
> +
> + ? ? ? /* ONE WIRE */
> + ? ? ? ONEWIRE_CLK_REQ,
> ?};
>
> ?static struct mtd_partition ttc_dkb_onenand_partitions[] = {
> @@ -109,7 +113,12 @@ static struct platform_device ttc_dkb_device_onenand = {
> ? ? ? ?},
> ?};
>
> +static struct ds1wm_driver_data ttc_dkb_1wire_data = {
> + ? ? ? .active_high ? ?= 1,
> +};
> +
> ?static struct platform_device *ttc_dkb_devices[] = {
> + ? ? ? &pxa910_device_1wire,
> ? ? ? ?&ttc_dkb_device_onenand,
> ?};
>
> @@ -121,6 +130,8 @@ static void __init ttc_dkb_init(void)
> ? ? ? ?pxa910_add_uart(1);
>
> ? ? ? ?/* off-chip devices */
> + ? ? ? platform_device_add_data(&pxa910_device_1wire, &ttc_dkb_1wire_data,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?sizeof(struct ds1wm_driver_data));


Then simply:

pxa910_add_1wire(&ttc_dkb_1wire_data);

here

> ? ? ? ?platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
> ?}
>
> --
> 1.5.6.5
>
>
