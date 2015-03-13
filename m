From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 13 Mar 2015 14:15:13 +0100
Subject: [RFC PATCH 03/18] mmc: msm: pass dmov resources via device
In-Reply-To: <1425497592-1831064-4-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
 <1425497592-1831064-4-git-send-email-arnd@arndb.de>
Message-ID: <CAPDyKFr9PtQ9NyRjj6HVRjj_m_gFXQx-pyLrGGPcJeaEKuZkQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2015 at 20:32, Arnd Bergmann <arnd@arndb.de> wrote:
> The data mover code that got moved here from arch/arm was not
> using the device model at all. This tries to retrofit it
> passing the irq and mmio address using resources.
>
> The approach is a little half-baked, but it still seems better
> than the original code. One problem now is that the resources
> are not getting cleaned up properly. Instead of doing something
> that I can't test myself, I just disable module unloading to
> avoid having to rewrite more than necessary.
>
> It's unclear whether this works with multiple sdcc devices.
> What I know is that no platform in the kernel registers more
> than one at the moment, and I suspect that trying to use more
> than one was already broken. If it was working previously,
> it most likely keeps working, and it's unlikely that we will
> see new users of this driver that require more than one
> device.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  arch/arm/mach-msm/devices-msm7x00.c | 44 +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-msm/devices-qsd8x50.c | 44 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/msm_sdcc.c         | 46 ++++++++++++++++++++++---------------
>  3 files changed, 115 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-msm/devices-msm7x00.c b/arch/arm/mach-msm/devices-msm7x00.c
> index d83404d4b328..aa3feeb96414 100644
> --- a/arch/arm/mach-msm/devices-msm7x00.c
> +++ b/arch/arm/mach-msm/devices-msm7x00.c
> @@ -211,6 +211,17 @@ static struct resource resources_sdc1[] = {
>                 .name   = "status_irq"
>         },
>         {
> +               .start  = INT_ADM_AARM,
> +               .end    = INT_ADM_AARM,
> +               .flags  = IORESOURCE_IRQ,
> +               .name   = "dmov_irq",
> +       },
> +       {
> +               .start  = MSM_DMOV_PHYS + (3 * 0x400),
> +               .end    = MSM_DMOV_PHYS + (4 * 0x400) - 1,
> +               .flags  = IORESOURCE_MEM,
> +       },
> +       {
>                 .start  = 8,
>                 .end    = 8,
>                 .flags  = IORESOURCE_DMA,
> @@ -234,6 +245,17 @@ static struct resource resources_sdc2[] = {
>                 .name   = "status_irq"
>         },
>         {
> +               .start  = INT_ADM_AARM,
> +               .end    = INT_ADM_AARM,
> +               .flags  = IORESOURCE_IRQ,
> +               .name   = "dmov_irq",
> +       },
> +       {
> +               .start  = MSM_DMOV_PHYS + (3 * 0x400),
> +               .end    = MSM_DMOV_PHYS + (4 * 0x400) - 1,
> +               .flags  = IORESOURCE_MEM,
> +       },
> +       {
>                 .start  = 8,
>                 .end    = 8,
>                 .flags  = IORESOURCE_DMA,
> @@ -257,6 +279,17 @@ static struct resource resources_sdc3[] = {
>                 .name   = "status_irq"
>         },
>         {
> +               .start  = INT_ADM_AARM,
> +               .end    = INT_ADM_AARM,
> +               .flags  = IORESOURCE_IRQ,
> +               .name   = "dmov_irq",
> +       },
> +       {
> +               .start  = MSM_DMOV_PHYS + (3 * 0x400),
> +               .end    = MSM_DMOV_PHYS + (4 * 0x400) - 1,
> +               .flags  = IORESOURCE_MEM,
> +       },
> +       {
>                 .start  = 8,
>                 .end    = 8,
>                 .flags  = IORESOURCE_DMA,
> @@ -280,6 +313,17 @@ static struct resource resources_sdc4[] = {
>                 .name   = "status_irq"
>         },
>         {
> +               .start  = INT_ADM_AARM,
> +               .end    = INT_ADM_AARM,
> +               .flags  = IORESOURCE_IRQ,
> +               .name   = "dmov_irq",
> +       },
> +       {
> +               .start  = MSM_DMOV_PHYS + (3 * 0x400),
> +               .end    = MSM_DMOV_PHYS + (4 * 0x400) - 1,
> +               .flags  = IORESOURCE_MEM,
> +       },
> +       {
>                 .start  = 8,
>                 .end    = 8,
>                 .flags  = IORESOURCE_DMA,
> diff --git a/arch/arm/mach-msm/devices-qsd8x50.c b/arch/arm/mach-msm/devices-qsd8x50.c
> index dfc884521fc1..6db025cef825 100644
> --- a/arch/arm/mach-msm/devices-qsd8x50.c
> +++ b/arch/arm/mach-msm/devices-qsd8x50.c
> @@ -175,6 +175,17 @@ static struct resource resources_sdc1[] = {
>                 .name   = "status_irq"
>         },
>         {
> +               .start  = INT_ADM_AARM,
> +               .end    = INT_ADM_AARM,
> +               .flags  = IORESOURCE_IRQ,
> +               .name   = "dmov_irq",
> +       },
> +       {
> +               .start  = MSM_DMOV_PHYS + (3 * 0x400),
> +               .end    = MSM_DMOV_PHYS + (4 * 0x400) - 1,
> +               .flags  = IORESOURCE_MEM,
> +       },
> +       {
>                 .start  = 8,
>                 .end    = 8,
>                 .flags  = IORESOURCE_DMA,
> @@ -198,6 +209,17 @@ static struct resource resources_sdc2[] = {
>                 .name   = "status_irq"
>         },
>         {
> +               .start  = INT_ADM_AARM,
> +               .end    = INT_ADM_AARM,
> +               .flags  = IORESOURCE_IRQ,
> +               .name   = "dmov_irq",
> +       },
> +       {
> +               .start  = MSM_DMOV_PHYS + (3 * 0x400),
> +               .end    = MSM_DMOV_PHYS + (4 * 0x400) - 1,
> +               .flags  = IORESOURCE_MEM,
> +       },
> +       {
>                 .start  = 8,
>                 .end    = 8,
>                 .flags  = IORESOURCE_DMA,
> @@ -221,6 +243,17 @@ static struct resource resources_sdc3[] = {
>                 .name   = "status_irq"
>         },
>         {
> +               .start  = INT_ADM_AARM,
> +               .end    = INT_ADM_AARM,
> +               .flags  = IORESOURCE_IRQ,
> +               .name   = "dmov_irq",
> +       },
> +       {
> +               .start  = MSM_DMOV_PHYS + (3 * 0x400),
> +               .end    = MSM_DMOV_PHYS + (4 * 0x400) - 1,
> +               .flags  = IORESOURCE_MEM,
> +       },
> +       {
>                 .start  = 8,
>                 .end    = 8,
>                 .flags  = IORESOURCE_DMA,
> @@ -244,6 +277,17 @@ static struct resource resources_sdc4[] = {
>                 .name   = "status_irq"
>         },
>         {
> +               .start  = INT_ADM_AARM,
> +               .end    = INT_ADM_AARM,
> +               .flags  = IORESOURCE_IRQ,
> +               .name   = "dmov_irq",
> +       },
> +       {
> +               .start  = MSM_DMOV_PHYS + (3 * 0x400),
> +               .end    = MSM_DMOV_PHYS + (4 * 0x400) - 1,
> +               .flags  = IORESOURCE_MEM,
> +       },
> +       {
>                 .start  = 8,
>                 .end    = 8,
>                 .flags  = IORESOURCE_DMA,
> diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
> index 83dc4e5d9963..3002e377e9f7 100644
> --- a/drivers/mmc/host/msm_sdcc.c
> +++ b/drivers/mmc/host/msm_sdcc.c
> @@ -45,7 +45,6 @@
>  #include <asm/sizes.h>
>
>  #include <linux/platform_data/mmc-msm_sdcc.h>
> -#include <mach/msm_iomap.h>
>  #include <mach/clk.h>
>
>  /* data mover definitions */
> @@ -170,16 +169,7 @@ typedef struct {
>
>  #define MSM_DMOV_CHANNEL_COUNT 16
>
> -#define DMOV_SD0(off, ch) (MSM_DMOV_BASE + 0x0000 + (off) + ((ch) << 2))
> -#define DMOV_SD1(off, ch) (MSM_DMOV_BASE + 0x0400 + (off) + ((ch) << 2))
> -#define DMOV_SD2(off, ch) (MSM_DMOV_BASE + 0x0800 + (off) + ((ch) << 2))
> -#define DMOV_SD3(off, ch) (MSM_DMOV_BASE + 0x0C00 + (off) + ((ch) << 2))
> -
> -#if defined(CONFIG_ARCH_MSM7X30)
> -#define DMOV_SD_AARM DMOV_SD2
> -#else
> -#define DMOV_SD_AARM DMOV_SD3
> -#endif
> +#define DMOV_SD_AARM(off, ch) (msm_dmov_base + (off) + ((ch) << 2))
>
>  #define DMOV_CMD_PTR(ch)      DMOV_SD_AARM(0x000, ch)
>  #define DMOV_RSLT(ch)         DMOV_SD_AARM(0x040, ch)
> @@ -203,6 +193,8 @@ enum {
>
>  static DEFINE_SPINLOCK(msm_dmov_lock);
>  static struct clk *msm_dmov_clk;
> +static int msm_dmov_irq;
> +static void __iomem *msm_dmov_base;
>  static unsigned int channel_active;
>  static struct list_head ready_commands[MSM_DMOV_CHANNEL_COUNT];
>  static struct list_head active_commands[MSM_DMOV_CHANNEL_COUNT];
> @@ -248,7 +240,7 @@ static void msm_dmov_enqueue_cmd(unsigned id, struct msm_dmov_cmd *cmd)
>                 PRINT_IO("msm_dmov_enqueue_cmd(%d), start command, status %x\n", id, status);
>                 list_add_tail(&cmd->list, &active_commands[id]);
>                 if (!channel_active)
> -                       enable_irq(INT_ADM_AARM);
> +                       enable_irq(msm_dmov_irq);
>                 channel_active |= 1U << id;
>                 writel(cmd->cmdptr, DMOV_CMD_PTR(id));
>         } else {
> @@ -370,7 +362,7 @@ static irqreturn_t msm_datamover_irq_handler(int irq, void *dev_id)
>         }
>
>         if (!channel_active) {
> -               disable_irq_nosync(INT_ADM_AARM);
> +               disable_irq_nosync(msm_dmov_irq);
>                 clk_disable(msm_dmov_clk);
>         }
>
> @@ -378,12 +370,18 @@ static irqreturn_t msm_datamover_irq_handler(int irq, void *dev_id)
>         return IRQ_HANDLED;
>  }
>
> -static int __init msm_init_datamover(void)
> +static int msm_init_datamover(int irq, resource_size_t phys)
>  {
>         int i;
>         int ret;
>         struct clk *clk;
>
> +       if (msm_dmov_irq || msm_dmov_base)
> +               return -EBUSY;
> +
> +       msm_dmov_irq = irq;
> +       msm_dmov_base = ioremap(phys, 0x400);
> +
>         for (i = 0; i < MSM_DMOV_CHANNEL_COUNT; i++) {
>                 INIT_LIST_HEAD(&ready_commands[i]);
>                 INIT_LIST_HEAD(&active_commands[i]);
> @@ -394,13 +392,12 @@ static int __init msm_init_datamover(void)
>                 return PTR_ERR(clk);
>         clk_prepare(clk);
>         msm_dmov_clk = clk;
> -       ret = request_irq(INT_ADM_AARM, msm_datamover_irq_handler, 0, "msmdatamover", NULL);
> +       ret = request_irq(msm_dmov_irq, msm_datamover_irq_handler, 0, "msmdatamover", NULL);
>         if (ret)
>                 return ret;
> -       disable_irq(INT_ADM_AARM);
> +       disable_irq(msm_dmov_irq);
>         return 0;
>  }
> -module_init(msm_init_datamover);
>
>  /* now the actual SD card driver */
>
> @@ -1529,8 +1526,10 @@ msmsdcc_probe(struct platform_device *pdev)
>         struct mmc_host *mmc;
>         struct resource *cmd_irqres = NULL;
>         struct resource *stat_irqres = NULL;
> +       struct resource *dmov_irqres = NULL;
>         struct resource *memres = NULL;
>         struct resource *dmares = NULL;
> +       struct resource *dmovres = NULL;
>         int ret;
>
>         /* must have platform data */
> @@ -1549,17 +1548,22 @@ msmsdcc_probe(struct platform_device *pdev)
>         }
>
>         memres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       dmovres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>         dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
>         cmd_irqres = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
>                                                   "cmd_irq");
>         stat_irqres = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
>                                                    "status_irq");
> +       dmov_irqres = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
> +                                                  "dmov_irq");
>
> -       if (!cmd_irqres || !memres) {
> +       if (!cmd_irqres || !memres || !dmov_irqres || !dmovres) {
>                 pr_err("%s: Invalid resource\n", __func__);
>                 return -ENXIO;
>         }
>
> +       msm_init_datamover(dmov_irqres->start, dmovres->start);
> +
>         /*
>          * Setup our host structure
>          */
> @@ -1826,7 +1830,11 @@ static struct platform_driver msmsdcc_driver = {
>         },
>  };
>
> -module_platform_driver(msmsdcc_driver);
> +static int __init msmsdcc_init(void)
> +{
> +       return platform_driver_register(&msmsdcc_driver);
> +}
> +module_init(msmsdcc_init);
>
>  MODULE_DESCRIPTION("Qualcomm MSM 7X00A Multimedia Card Interface driver");
>  MODULE_LICENSE("GPL");
> --
> 2.1.0.rc2
>
