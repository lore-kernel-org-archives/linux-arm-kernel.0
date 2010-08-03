From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 3 Aug 2010 19:13:17 +0800
Subject: [PATCH 3/3] [ARM] pxa: Add support for Fast Ethernet driver.
In-Reply-To: <1280849830-5350-4-git-send-email-ssanap@marvell.com>
References: <1280849830-5350-1-git-send-email-ssanap@marvell.com>
	<1280849830-5350-2-git-send-email-ssanap@marvell.com>
	<1280849830-5350-3-git-send-email-ssanap@marvell.com>
	<1280849830-5350-4-git-send-email-ssanap@marvell.com>
Message-ID: <AANLkTin9V6A3Y2La=yFdSbUUE7bUfwHRt-nTW2tMJwqD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 3, 2010 at 11:37 PM, Sachin Sanap <ssanap@marvell.com> wrote:
> In order to make this patch compile, even if the PXA168 ethernet driver
> with it's header defining the platform data isn't merged yet, ifdefs
> have been added. Its effect is that the function results in a no-op
> function if the driver hasn't been activated.
>
> These ifdefs can be removed after the Ethernet driver has been merged.
>

I'd rather this be posted after the ethernet driver is merged, which
is going to happen in netdev mailing list. What's the status of that
driver being upstream by the way?

> Signed-off-by: Sachin Sanap <ssanap@marvell.com>
> ---
> ?arch/arm/mach-mmp/aspenite.c ? ? ? ? ? ? ? | ? 34 ++++++++++++++++++++++++++++
> ?arch/arm/mach-mmp/include/mach/devices.h ? | ? ?1 +
> ?arch/arm/mach-mmp/include/mach/pxa168.h ? ?| ? ?9 +++++++
> ?arch/arm/mach-mmp/include/mach/regs-apmu.h | ? ?1 +
> ?arch/arm/mach-mmp/pxa168.c ? ? ? ? ? ? ? ? | ? ?3 ++
> ?5 files changed, 48 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
> index a235551..40f88ba 100644
> --- a/arch/arm/mach-mmp/aspenite.c
> +++ b/arch/arm/mach-mmp/aspenite.c
> @@ -24,10 +24,15 @@
> ?#include <mach/pxa168.h>
> ?#include <mach/gpio.h>
> ?#include <linux/i2c/pca953x.h>
> +#if defined(CONFIG_PXA168_ETH) || defined(CONFIG_PXA168_ETH_MODULE)
> +#include <mach/pxa168_eth.h>
> +#endif
>
> ?#include "common.h"
>
> ?#define GPIO_EXT1(x) ? (128 + 16 + (x))
> +#define ENET_RESET_N ? GPIO_EXT1(9)
> +#define ENET_COMA_N ? ?GPIO_EXT1(10)
>
> ?static unsigned long common_pin_config[] __initdata = {
> ? ? ? ?/* Data Flash Interface */
> @@ -177,7 +182,33 @@ static struct i2c_board_info aspenite_i2c_info[] __initdata = {
> ? ? ? ?},
> ?#endif
> ?};
> +#if defined(CONFIG_PXA168_ETH) || defined(CONFIG_PXA168_ETH_MODULE)
> +static int pxa168_eth_init(void)
> +{
> + ? ? ? if (gpio_request(ENET_RESET_N, "ENET_RESET_N")) {
> + ? ? ? ? ? ? ? printk(KERN_ERR "Request GPIO failed,"
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "gpio: %d\n", ENET_RESET_N);
> + ? ? ? ? ? ? ? return -EIO;
> + ? ? ? }
> + ? ? ? if (gpio_request(ENET_COMA_N, "ENET_COMA_N")) {
> + ? ? ? ? ? ? ? gpio_free(ENET_RESET_N);
> + ? ? ? ? ? ? ? printk(KERN_ERR "Request GPIO failed,"
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "gpio: %d\n", ENET_COMA_N);
> + ? ? ? ? ? ? ? return -EIO;
> + ? ? ? }
> + ? ? ? gpio_direction_output(ENET_RESET_N, 1);
> + ? ? ? gpio_direction_output(ENET_COMA_N, 1);
> + ? ? ? gpio_free(ENET_RESET_N);
> + ? ? ? gpio_free(ENET_COMA_N);
> + ? ? ? return 0;
> +}
>
> +static struct pxa168_eth_platform_data pxa168_eth_data = {
> + ? ? ? .phy_addr = 0, ? ? ? ? ?/* phy addr depends on boards */
> + ? ? ? .port_number = 0,
> + ? ? ? .init ? = pxa168_eth_init,
> +};
> +#endif
> ?static void __init common_init(void)
> ?{
> ? ? ? ?mfp_config(ARRAY_AND_SIZE(common_pin_config));
> @@ -188,6 +219,9 @@ static void __init common_init(void)
> ? ? ? ?pxa168_add_twsi(1, NULL, ARRAY_AND_SIZE(aspenite_pwri2c_info));
> ? ? ? ?pxa168_add_ssp(1);
> ? ? ? ?pxa168_add_nand(&aspenite_nand_info);
> +#if defined(CONFIG_PXA168_ETH) || defined(CONFIG_PXA168_ETH_MODULE)
> + ? ? ? pxa168_add_mfu(&pxa168_eth_data);
> +#endif
>
> ? ? ? ?/* off-chip devices */
> ? ? ? ?platform_device_register(&smc91x_device);
> diff --git a/arch/arm/mach-mmp/include/mach/devices.h b/arch/arm/mach-mmp/include/mach/devices.h
> index 1fa0a49..0cc0333 100644
> --- a/arch/arm/mach-mmp/include/mach/devices.h
> +++ b/arch/arm/mach-mmp/include/mach/devices.h
> @@ -46,4 +46,5 @@ struct pxa_device_desc mmp2_device_##_name __initdata = { ? ? ? ? ? ? \
> ? ? ? ?.dma ? ? ? ? ? ?= { _dma }, ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> ?}
>
> +extern struct pxa_device_desc pxa168_device_mfu;
> ?extern int pxa_register_device(struct pxa_device_desc *, void *, size_t);
> diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
> index 3b2bd5d..0e2ff24 100644
> --- a/arch/arm/mach-mmp/include/mach/pxa168.h
> +++ b/arch/arm/mach-mmp/include/mach/pxa168.h
> @@ -5,6 +5,9 @@
> ?#include <mach/devices.h>
> ?#include <plat/i2c.h>
> ?#include <plat/pxa3xx_nand.h>
> +#if defined(CONFIG_PXA168_ETH) || defined(CONFIG_PXA168_ETH_MODULE)
> +#include <mach/pxa168_eth.h>
> +#endif
>
> ?extern struct pxa_device_desc pxa168_device_uart1;
> ?extern struct pxa_device_desc pxa168_device_uart2;
> @@ -92,4 +95,10 @@ static inline int pxa168_add_nand(struct pxa3xx_nand_platform_data *info)
> ?{
> ? ? ? ?return pxa_register_device(&pxa168_device_nand, info, sizeof(*info));
> ?}
> +#if defined(CONFIG_PXA168_ETH) || defined(CONFIG_PXA168_ETH_MODULE)
> +static inline int pxa168_add_mfu(struct pxa168_eth_platform_data *data)
> +{
> + ? ? ? return pxa_register_device(&pxa168_device_mfu, data, sizeof(*data));
> +}
> +#endif
> ?#endif /* __ASM_MACH_PXA168_H */
> diff --git a/arch/arm/mach-mmp/include/mach/regs-apmu.h b/arch/arm/mach-mmp/include/mach/regs-apmu.h
> index 9190305..47b2ea6 100644
> --- a/arch/arm/mach-mmp/include/mach/regs-apmu.h
> +++ b/arch/arm/mach-mmp/include/mach/regs-apmu.h
> @@ -27,6 +27,7 @@
> ?#define APMU_DMA ? ? ? APMU_REG(0x064)
> ?#define APMU_GEU ? ? ? APMU_REG(0x068)
> ?#define APMU_BUS ? ? ? APMU_REG(0x06c)
> +#define APMU_MFU ? ? ? APMU_REG(0x0fc)
>
> ?#define APMU_FNCLK_EN ?(1 << 4)
> ?#define APMU_AXICLK_EN (1 << 3)
> diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
> index 652ae66..f7d1158 100644
> --- a/arch/arm/mach-mmp/pxa168.c
> +++ b/arch/arm/mach-mmp/pxa168.c
> @@ -79,6 +79,7 @@ static APBC_CLK(ssp4, PXA168_SSP4, 4, 0);
> ?static APBC_CLK(ssp5, PXA168_SSP5, 4, 0);
>
> ?static APMU_CLK(nand, NAND, 0x01db, 208000000);
> +static APMU_CLK(mfu, MFU, 0x9, 0);
>
> ?/* device and clock bindings */
> ?static struct clk_lookup pxa168_clkregs[] = {
> @@ -96,6 +97,7 @@ static struct clk_lookup pxa168_clkregs[] = {
> ? ? ? ?INIT_CLKREG(&clk_ssp4, "pxa168-ssp.3", NULL),
> ? ? ? ?INIT_CLKREG(&clk_ssp5, "pxa168-ssp.4", NULL),
> ? ? ? ?INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
> + ? ? ? INIT_CLKREG(&clk_mfu, "pxa168-mfu", "MFUCLK"),
> ?};
>
> ?static int __init pxa168_init(void)
> @@ -147,3 +149,4 @@ PXA168_DEVICE(ssp2, "pxa168-ssp", 1, SSP2, 0xd401c000, 0x40, 54, 55);
> ?PXA168_DEVICE(ssp3, "pxa168-ssp", 2, SSP3, 0xd401f000, 0x40, 56, 57);
> ?PXA168_DEVICE(ssp4, "pxa168-ssp", 3, SSP4, 0xd4020000, 0x40, 58, 59);
> ?PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 61);
> +PXA168_DEVICE(mfu, "pxa168-mfu", -1, MFU, 0xc0800000, 0x0fff);
> --
> 1.6.2.5
>
>
