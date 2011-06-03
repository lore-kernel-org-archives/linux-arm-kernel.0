From: vimal.newwork@gmail.com (Vimal Singh)
Date: Sat, 4 Jun 2011 02:44:41 +0530
Subject: [PATCH] omap: cleanup NAND platform data
In-Reply-To: <1307130993-15265-1-git-send-email-notasas@gmail.com>
References: <1307130993-15265-1-git-send-email-notasas@gmail.com>
Message-ID: <BANLkTimnP-HuvVruB5hNSMHVnQUmned8Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 4, 2011 at 1:26 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> omap_nand_platform_data fields 'options', 'gpio_irq', 'nand_setup' and
> 'dma_channel' are never referenced by the NAND driver, yet various
> board files are initializing those fields. This is both incorrect and
> confusing, so remove them. This allows to get rid of a global
> variable in gpmc-nand.c.
>
> This also corrects an issue where some boards are trying to pass NAND
> 16bit flag through .options, but the driver is using .devsize instead
> and ignoring .options.
>
> Finally, .dev_ready is treated as a flag by the driver, so make it bool
> instead of a function pointer.
>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> ?arch/arm/mach-omap2/board-cm-t35.c ? ? ? ? | ? ?2 --
> ?arch/arm/mach-omap2/board-cm-t3517.c ? ? ? | ? ?1 -
> ?arch/arm/mach-omap2/board-flash.c ? ? ? ? ?| ? ?4 ----
> ?arch/arm/mach-omap2/common-board-devices.c | ? ?6 ++----
> ?arch/arm/mach-omap2/gpmc-nand.c ? ? ? ? ? ?| ? 10 +++-------
> ?arch/arm/plat-omap/include/plat/nand.h ? ? | ? ?6 +-----
> ?6 files changed, 6 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index c63115b..99238e6 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -164,9 +164,7 @@ static struct mtd_partition cm_t35_nand_partitions[] = {
> ?static struct omap_nand_platform_data cm_t35_nand_data = {
> ? ? ? ?.parts ? ? ? ? ? ? ? ? ?= cm_t35_nand_partitions,
> ? ? ? ?.nr_parts ? ? ? ? ? ? ? = ARRAY_SIZE(cm_t35_nand_partitions),
> - ? ? ? .dma_channel ? ? ? ? ? ?= -1, ? /* disable DMA in OMAP NAND driver */
> ? ? ? ?.cs ? ? ? ? ? ? ? ? ? ? = 0,
> -
> ?};
>
> ?static void __init cm_t35_init_nand(void)
> diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
> index 08f08e8..c80d862 100644
> --- a/arch/arm/mach-omap2/board-cm-t3517.c
> +++ b/arch/arm/mach-omap2/board-cm-t3517.c
> @@ -237,7 +237,6 @@ static struct mtd_partition cm_t3517_nand_partitions[] = {
> ?static struct omap_nand_platform_data cm_t3517_nand_data = {
> ? ? ? ?.parts ? ? ? ? ? ? ? ? ?= cm_t3517_nand_partitions,
> ? ? ? ?.nr_parts ? ? ? ? ? ? ? = ARRAY_SIZE(cm_t3517_nand_partitions),
> - ? ? ? .dma_channel ? ? ? ? ? ?= -1, ? /* disable DMA in OMAP NAND driver */
> ? ? ? ?.cs ? ? ? ? ? ? ? ? ? ? = 0,
> ?};
>
> diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
> index 729892f..aa1b0cb 100644
> --- a/arch/arm/mach-omap2/board-flash.c
> +++ b/arch/arm/mach-omap2/board-flash.c
> @@ -132,11 +132,7 @@ static struct gpmc_timings nand_timings = {
> ?};
>
> ?static struct omap_nand_platform_data board_nand_data = {
> - ? ? ? .nand_setup ? ? = NULL,
> ? ? ? ?.gpmc_t ? ? ? ? = &nand_timings,
> - ? ? ? .dma_channel ? ?= -1, ? ? ? ? ? /* disable DMA in OMAP NAND driver */
> - ? ? ? .dev_ready ? ? ?= NULL,
> - ? ? ? .devsize ? ? ? ?= 0, ? ?/* '0' for 8-bit, '1' for 16-bit device */
> ?};
>
> ?void
> diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
> index e94903b..366171d 100644
> --- a/arch/arm/mach-omap2/common-board-devices.c
> +++ b/arch/arm/mach-omap2/common-board-devices.c
> @@ -115,9 +115,7 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
> ?#endif
>
> ?#if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
> -static struct omap_nand_platform_data nand_data = {
> - ? ? ? .dma_channel ? ?= -1, ? ? ? ? ? /* disable DMA in OMAP NAND driver */
> -};
> +static struct omap_nand_platform_data nand_data;
>
> ?void __init omap_nand_flash_init(int options, struct mtd_partition *parts,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int nr_parts)
> @@ -148,7 +146,7 @@ void __init omap_nand_flash_init(int options, struct mtd_partition *parts,
> ? ? ? ? ? ? ? ?nand_data.cs = nandcs;
> ? ? ? ? ? ? ? ?nand_data.parts = parts;
> ? ? ? ? ? ? ? ?nand_data.nr_parts = nr_parts;
> - ? ? ? ? ? ? ? nand_data.options = options;
> + ? ? ? ? ? ? ? nand_data.devsize = options;
>
> ? ? ? ? ? ? ? ?printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
> ? ? ? ? ? ? ? ?if (gpmc_nand_init(&nand_data) < 0)
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> index c1791d0..8ad210b 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -20,8 +20,6 @@
> ?#include <plat/board.h>
> ?#include <plat/gpmc.h>
>
> -static struct omap_nand_platform_data *gpmc_nand_data;
> -
> ?static struct resource gpmc_nand_resource = {
> ? ? ? ?.flags ? ? ? ? ?= IORESOURCE_MEM,
> ?};
> @@ -33,7 +31,7 @@ static struct platform_device gpmc_nand_device = {
> ? ? ? ?.resource ? ? ? = &gpmc_nand_resource,
> ?};
>
> -static int omap2_nand_gpmc_retime(void)
> +static int omap2_nand_gpmc_retime(struct omap_nand_platform_data *gpmc_nand_data)
> ?{
> ? ? ? ?struct gpmc_timings t;
> ? ? ? ?int err;
> @@ -83,13 +81,11 @@ static int omap2_nand_gpmc_retime(void)
> ? ? ? ?return 0;
> ?}
>
> -int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data)
> +int __init gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data)
> ?{
> ? ? ? ?int err = 0;
> ? ? ? ?struct device *dev = &gpmc_nand_device.dev;
>
> - ? ? ? gpmc_nand_data = _nand_data;
> - ? ? ? gpmc_nand_data->nand_setup = omap2_nand_gpmc_retime;

Purpose of doing this was to be able to utilise
'omap2_nand_gpmc_retime', when DVFS is ready to use it,
for changing timing parameter dynamically when a frequency change is done.

-- 
Regards,
Vimal Singh
