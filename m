From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 16 May 2011 23:06:10 +0800
Subject: [PATCH v5 8/8] MTD: physmap: let set_vpp() pass a platform_device
	instead of a map_info
In-Reply-To: <1305557977-16871-9-git-send-email-marc.zyngier@arm.com>
References: <1305557977-16871-1-git-send-email-marc.zyngier@arm.com>
	<1305557977-16871-9-git-send-email-marc.zyngier@arm.com>
Message-ID: <BANLkTi=-Lcg5Wk7yuipTTzrSxs0nNmpMaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 10:59 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> The set_vpp() method provided by physmap passes a map_info back to
> the platform code, which has little relevance as far as the platform
> is concerned (this parameter is completely unused).
>
> Instead, pass the platform_device, which can be used in the pismo
> driver to retrieve some important information in a nicer way, instead
> of the hack that was in place.

Not really sure if a 'struct device' would be more generic here, though this
case is simply a 'struct platform_device'.

>
> The empty set_vpp function in board-at572d940hf_ek.c is removed, as
> it serves no real purpose.
>
> Cc: Andrew Victor <linux@maxim.org.za>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> ?arch/arm/mach-at91/board-at572d940hf_ek.c | ? ?4 ---
> ?arch/arm/mach-integrator/integrator_ap.c ?| ? ?2 +-
> ?arch/arm/mach-integrator/integrator_cp.c ?| ? ?2 +-
> ?arch/arm/mach-omap1/flash.c ? ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-pxa/hx4700.c ? ? ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/magician.c ? ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-realview/core.c ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-s3c2410/nor-simtec.c ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-versatile/core.c ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-vexpress/v2m.c ? ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/plat-omap/include/plat/flash.h ? | ? ?2 +-
> ?drivers/mtd/maps/physmap.c ? ? ? ? ? ? ? ?| ? 15 ++++++++++-
> ?drivers/mtd/maps/pismo.c ? ? ? ? ? ? ? ? ?| ? 40 ++--------------------------
> ?include/linux/mtd/physmap.h ? ? ? ? ? ? ? | ? ?2 +-
> ?14 files changed, 28 insertions(+), 53 deletions(-)
>
> diff --git a/arch/arm/mach-at91/board-at572d940hf_ek.c b/arch/arm/mach-at91/board-at572d940hf_ek.c
> index 3929f1c..c139799 100644
> --- a/arch/arm/mach-at91/board-at572d940hf_ek.c
> +++ b/arch/arm/mach-at91/board-at572d940hf_ek.c
> @@ -134,14 +134,10 @@ static struct mtd_partition eb_nor_partitions[] = {
> ? ? ? ?},
> ?};
>
> -static void nor_flash_set_vpp(struct map_info* mi, int i) {
> -};
> -
> ?static struct physmap_flash_data nor_flash_data = {
> ? ? ? ?.width ? ? ? ? ?= 4,
> ? ? ? ?.parts ? ? ? ? ?= eb_nor_partitions,
> ? ? ? ?.nr_parts ? ? ? = ARRAY_SIZE(eb_nor_partitions),
> - ? ? ? .set_vpp ? ? ? ?= nor_flash_set_vpp,
> ?};
>
> ?static struct resource nor_flash_resources[] = {
> diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
> index 11bd49e..2aa98ee 100644
> --- a/arch/arm/mach-integrator/integrator_ap.c
> +++ b/arch/arm/mach-integrator/integrator_ap.c
> @@ -263,7 +263,7 @@ static void ap_flash_exit(struct platform_device *dev)
> ? ? ? ?}
> ?}
>
> -static void ap_flash_set_vpp(struct map_info *map, int on)
> +static void ap_flash_set_vpp(struct platform_device *pdev, int on)
> ?{
> ? ? ? ?void __iomem *reg = on ? SC_CTRLS : SC_CTRLC;
>
> diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
> index ec9628f..b676b41 100644
> --- a/arch/arm/mach-integrator/integrator_cp.c
> +++ b/arch/arm/mach-integrator/integrator_cp.c
> @@ -259,7 +259,7 @@ static void intcp_flash_exit(struct platform_device *dev)
> ? ? ? ?writel(val, INTCP_VA_CTRL_BASE + INTCP_FLASHPROG);
> ?}
>
> -static void intcp_flash_set_vpp(struct map_info *map, int on)
> +static void intcp_flash_set_vpp(struct platform_device *pdev, int on)
> ?{
> ? ? ? ?u32 val;
>
> diff --git a/arch/arm/mach-omap1/flash.c b/arch/arm/mach-omap1/flash.c
> index acd1616..1749cb3 100644
> --- a/arch/arm/mach-omap1/flash.c
> +++ b/arch/arm/mach-omap1/flash.c
> @@ -13,7 +13,7 @@
> ?#include <plat/tc.h>
> ?#include <plat/flash.h>
>
> -void omap1_set_vpp(struct map_info *map, int enable)
> +void omap1_set_vpp(struct platform_device *pdev, int enable)
> ?{
> ? ? ? ?static int count;
> ? ? ? ?u32 l;
> diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
> index 9cdcca5..f941a49 100644
> --- a/arch/arm/mach-pxa/hx4700.c
> +++ b/arch/arm/mach-pxa/hx4700.c
> @@ -735,7 +735,7 @@ static struct platform_device bq24022 = {
> ?* StrataFlash
> ?*/
>
> -static void hx4700_set_vpp(struct map_info *map, int vpp)
> +static void hx4700_set_vpp(struct platform_device *pdev, int vpp)
> ?{
> ? ? ? ?gpio_set_value(GPIO91_HX4700_FLASH_VPEN, vpp);
> ?}
> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
> index 9984ef7..e192057 100644
> --- a/arch/arm/mach-pxa/magician.c
> +++ b/arch/arm/mach-pxa/magician.c
> @@ -662,7 +662,7 @@ static struct pxaohci_platform_data magician_ohci_info = {
> ?* StrataFlash
> ?*/
>
> -static void magician_set_vpp(struct map_info *map, int vpp)
> +static void magician_set_vpp(struct platform_device *pdev, int vpp)
> ?{
> ? ? ? ?gpio_set_value(EGPIO_MAGICIAN_FLASH_VPP, vpp);
> ?}
> diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
> index d3f1dde..c8ec088 100644
> --- a/arch/arm/mach-realview/core.c
> +++ b/arch/arm/mach-realview/core.c
> @@ -77,7 +77,7 @@ void __init realview_adjust_zones(unsigned long *size, unsigned long *hole)
>
> ?#define REALVIEW_FLASHCTRL ? ?(__io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_FLASH_OFFSET)
>
> -static void realview_flash_set_vpp(struct map_info *map, int on)
> +static void realview_flash_set_vpp(struct platform_device *pdev, int on)
> ?{
> ? ? ? ?u32 val;
>
> diff --git a/arch/arm/mach-s3c2410/nor-simtec.c b/arch/arm/mach-s3c2410/nor-simtec.c
> index 598d130..ad9f750 100644
> --- a/arch/arm/mach-s3c2410/nor-simtec.c
> +++ b/arch/arm/mach-s3c2410/nor-simtec.c
> @@ -32,7 +32,7 @@
>
> ?#include "nor-simtec.h"
>
> -static void simtec_nor_vpp(struct map_info *map, int vpp)
> +static void simtec_nor_vpp(struct platform_device *pdev, int vpp)
> ?{
> ? ? ? ?unsigned int val;
> ? ? ? ?unsigned long flags;
> diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
> index 06f406a..335d825 100644
> --- a/arch/arm/mach-versatile/core.c
> +++ b/arch/arm/mach-versatile/core.c
> @@ -190,7 +190,7 @@ void __init versatile_map_io(void)
>
> ?#define VERSATILE_FLASHCTRL ? ?(__io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_FLASH_OFFSET)
>
> -static void versatile_flash_set_vpp(struct map_info *map, int on)
> +static void versatile_flash_set_vpp(struct platform_device *pdev, int on)
> ?{
> ? ? ? ?u32 val;
>
> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> index e326815..f860314 100644
> --- a/arch/arm/mach-vexpress/v2m.c
> +++ b/arch/arm/mach-vexpress/v2m.c
> @@ -206,7 +206,7 @@ static struct platform_device v2m_usb_device = {
> ? ? ? ?.dev.platform_data = &v2m_usb_config,
> ?};
>
> -static void v2m_flash_set_vpp(struct map_info *map, int on)
> +static void v2m_flash_set_vpp(struct platform_device *pdev, int on)
> ?{
> ? ? ? ?writel(on != 0, MMIO_P2V(V2M_SYS_FLASH));
> ?}
> diff --git a/arch/arm/plat-omap/include/plat/flash.h b/arch/arm/plat-omap/include/plat/flash.h
> index 3e63270..3083195 100644
> --- a/arch/arm/plat-omap/include/plat/flash.h
> +++ b/arch/arm/plat-omap/include/plat/flash.h
> @@ -11,6 +11,6 @@
>
> ?#include <linux/mtd/map.h>
>
> -extern void omap1_set_vpp(struct map_info *map, int enable);
> +extern void omap1_set_vpp(struct platform_device *pdev, int enable);
>
> ?#endif
> diff --git a/drivers/mtd/maps/physmap.c b/drivers/mtd/maps/physmap.c
> index 49676b7..89fe8be 100644
> --- a/drivers/mtd/maps/physmap.c
> +++ b/drivers/mtd/maps/physmap.c
> @@ -74,6 +74,18 @@ static int physmap_flash_remove(struct platform_device *dev)
> ? ? ? ?return 0;
> ?}
>
> +static void physmap_set_vpp(struct map_info *map, int state)
> +{
> + ? ? ? struct platform_device *pdev;
> + ? ? ? struct physmap_flash_data *physmap_data;
> +
> + ? ? ? pdev = (struct platform_device *)map->map_priv_1;
> + ? ? ? physmap_data = pdev->dev.platform_data;
> +
> + ? ? ? if (physmap_data->set_vpp)
> + ? ? ? ? ? ? ? physmap_data->set_vpp(pdev, state);
> +}
> +
> ?static const char *rom_probe_types[] = {
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"cfi_probe",
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"jedec_probe",
> @@ -134,8 +146,9 @@ static int physmap_flash_probe(struct platform_device *dev)
> ? ? ? ? ? ? ? ?info->map[i].phys = dev->resource[i].start;
> ? ? ? ? ? ? ? ?info->map[i].size = resource_size(&dev->resource[i]);
> ? ? ? ? ? ? ? ?info->map[i].bankwidth = physmap_data->width;
> - ? ? ? ? ? ? ? info->map[i].set_vpp = physmap_data->set_vpp;
> + ? ? ? ? ? ? ? info->map[i].set_vpp = physmap_set_vpp;
> ? ? ? ? ? ? ? ?info->map[i].pfow_base = physmap_data->pfow_base;
> + ? ? ? ? ? ? ? info->map[i].map_priv_1 = (unsigned long)dev;
>
> ? ? ? ? ? ? ? ?info->map[i].virt = devm_ioremap(&dev->dev, info->map[i].phys,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? info->map[i].size);
> diff --git a/drivers/mtd/maps/pismo.c b/drivers/mtd/maps/pismo.c
> index f4ce273..65bd1cd 100644
> --- a/drivers/mtd/maps/pismo.c
> +++ b/drivers/mtd/maps/pismo.c
> @@ -50,39 +50,13 @@ struct pismo_data {
> ? ? ? ?struct platform_device ?*dev[PISMO_NUM_CS];
> ?};
>
> -/* FIXME: set_vpp could do with a better calling convention */
> -static struct pismo_data *vpp_pismo;
> -static DEFINE_MUTEX(pismo_mutex);
> -
> -static int pismo_setvpp_probe_fix(struct pismo_data *pismo)
> +static void pismo_set_vpp(struct platform_device *pdev, int on)
> ?{
> - ? ? ? mutex_lock(&pismo_mutex);
> - ? ? ? if (vpp_pismo) {
> - ? ? ? ? ? ? ? mutex_unlock(&pismo_mutex);
> - ? ? ? ? ? ? ? kfree(pismo);
> - ? ? ? ? ? ? ? return -EBUSY;
> - ? ? ? }
> - ? ? ? vpp_pismo = pismo;
> - ? ? ? mutex_unlock(&pismo_mutex);
> - ? ? ? return 0;
> -}
> -
> -static void pismo_setvpp_remove_fix(struct pismo_data *pismo)
> -{
> - ? ? ? mutex_lock(&pismo_mutex);
> - ? ? ? if (vpp_pismo == pismo)
> - ? ? ? ? ? ? ? vpp_pismo = NULL;
> - ? ? ? mutex_unlock(&pismo_mutex);
> -}
> -
> -static void pismo_set_vpp(struct map_info *map, int on)
> -{
> - ? ? ? struct pismo_data *pismo = vpp_pismo;
> + ? ? ? struct i2c_client *client = to_i2c_client(pdev->dev.parent);
> + ? ? ? struct pismo_data *pismo = i2c_get_clientdata(client);
>
> ? ? ? ?pismo->vpp(pismo->vpp_data, on);
> ?}
> -/* end of hack */
> -
>
> ?static unsigned int __devinit pismo_width_to_bytes(unsigned int width)
> ?{
> @@ -231,9 +205,6 @@ static int __devexit pismo_remove(struct i2c_client *client)
> ? ? ? ?for (i = 0; i < ARRAY_SIZE(pismo->dev); i++)
> ? ? ? ? ? ? ? ?platform_device_unregister(pismo->dev[i]);
>
> - ? ? ? /* FIXME: set_vpp needs saner arguments */
> - ? ? ? pismo_setvpp_remove_fix(pismo);
> -
> ? ? ? ?kfree(pismo);
>
> ? ? ? ?return 0;
> @@ -257,11 +228,6 @@ static int __devinit pismo_probe(struct i2c_client *client,
> ? ? ? ?if (!pismo)
> ? ? ? ? ? ? ? ?return -ENOMEM;
>
> - ? ? ? /* FIXME: set_vpp needs saner arguments */
> - ? ? ? ret = pismo_setvpp_probe_fix(pismo);
> - ? ? ? if (ret)
> - ? ? ? ? ? ? ? return ret;
> -
> ? ? ? ?pismo->client = client;
> ? ? ? ?if (pdata) {
> ? ? ? ? ? ? ? ?pismo->vpp = pdata->set_vpp;
> diff --git a/include/linux/mtd/physmap.h b/include/linux/mtd/physmap.h
> index d37cca0..49b9590 100644
> --- a/include/linux/mtd/physmap.h
> +++ b/include/linux/mtd/physmap.h
> @@ -24,7 +24,7 @@ struct physmap_flash_data {
> ? ? ? ?unsigned int ? ? ? ? ? ?width;
> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? (*init)(struct platform_device *);
> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?(*exit)(struct platform_device *);
> - ? ? ? void ? ? ? ? ? ? ? ? ? ?(*set_vpp)(struct map_info *, int);
> + ? ? ? void ? ? ? ? ? ? ? ? ? ?(*set_vpp)(struct platform_device *, int);
> ? ? ? ?unsigned int ? ? ? ? ? ?nr_parts;
> ? ? ? ?unsigned int ? ? ? ? ? ?pfow_base;
> ? ? ? ?char ? ? ? ? ? ? ? ? ? ?*probe_type;
> --
> 1.7.0.4
>
>
>
