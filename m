From: stefan.xk.nilsson@stericsson.com (Stefan Nilsson XK)
Date: Fri, 24 Sep 2010 09:02:16 +0200
Subject: [PATCH 1/4] Resources for U5500 mbox driver and modem irq handler
In-Reply-To: <1285264197-9316-2-git-send-email-stefan.xk.nilsson@stericsson.com>
References: <1285264197-9316-1-git-send-email-stefan.xk.nilsson@stericsson.com>
	<1285264197-9316-2-git-send-email-stefan.xk.nilsson@stericsson.com>
Message-ID: <4C9C4CF8.40307@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some reason my intro mail got lost in cyberspace,...

This patch set adds a driver for the U5500 mailbox which is used
for modem communication. It also introduces a generic U5500 modem
IRQ handler which can be configured to handle different IRQs from
the modem.


Summary:
  arch/arm/mach-ux500/Kconfig                    |   14 +
  arch/arm/mach-ux500/Makefile                   |    2 +
  arch/arm/mach-ux500/cpu-db5500.c               |   88 ++++
  arch/arm/mach-ux500/include/mach/db5500-regs.h |   14 +
  arch/arm/mach-ux500/include/mach/irqs-db5500.h |    1 +
  arch/arm/mach-ux500/include/mach/irqs.h        |   15 +-
  arch/arm/mach-ux500/include/mach/mbox.h        |   88 ++++
  arch/arm/mach-ux500/mbox.c                     |  567 
++++++++++++++++++++++++
  arch/arm/mach-ux500/modem_irq.c                |  139 ++++++
   9 files changed, 927 insertions(+), 1 deletions(-)

  create mode 100644 arch/arm/mach-ux500/include/mach/mbox.h
  create mode 100644 arch/arm/mach-ux500/mbox.c
  create mode 100644 arch/arm/mach-ux500/modem_irq.c

Best Regards

Stefan Nilsson

On 09/23/2010 07:49 PM, Stefan NILSSON9 wrote:
> From: Stefan Nilsson XK<stefan.xk.nilsson@stericsson.com>
>
> Acked-by: Linus Walleij<linus.walleij@stericsson.com>
> Signed-off-by: Stefan Nilsson XK<stefan.xk.nilsson@stericsson.com>
> ---
>   arch/arm/mach-ux500/cpu-db5500.c               |   88 ++++++++++++++++++++++++
>   arch/arm/mach-ux500/include/mach/db5500-regs.h |   14 ++++
>   arch/arm/mach-ux500/include/mach/irqs-db5500.h |    1 +
>   arch/arm/mach-ux500/include/mach/irqs.h        |   15 ++++-
>   4 files changed, 117 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
> index e9278f6..2f87075 100644
> --- a/arch/arm/mach-ux500/cpu-db5500.c
> +++ b/arch/arm/mach-ux500/cpu-db5500.c
> @@ -14,6 +14,7 @@
>   #include<mach/hardware.h>
>   #include<mach/devices.h>
>   #include<mach/setup.h>
> +#include<mach/irqs.h>
>
>   static struct map_desc u5500_io_desc[] __initdata = {
>   	__IO_DEV_DESC(U5500_GPIO0_BASE, SZ_4K),
> @@ -24,6 +25,90 @@ static struct map_desc u5500_io_desc[] __initdata = {
>   	__IO_DEV_DESC(U5500_PRCMU_BASE, SZ_4K),
>   };
>
> +static struct resource mbox0_resources[] = {
> +	{
> +		.name = "mbox_peer",
> +		.start = U5500_MBOX0_PEER_START,
> +		.end = U5500_MBOX0_PEER_END,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
> +		.name = "mbox_local",
> +		.start = U5500_MBOX0_LOCAL_START,
> +		.end = U5500_MBOX0_LOCAL_END,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
> +		.name = "mbox_irq",
> +		.start = MBOX_PAIR0_VIRT_IRQ,
> +		.end = MBOX_PAIR0_VIRT_IRQ,
> +		.flags = IORESOURCE_IRQ,
> +	}
> +};
> +
> +static struct resource mbox1_resources[] = {
> +	{
> +		.name = "mbox_peer",
> +		.start = U5500_MBOX1_PEER_START,
> +		.end = U5500_MBOX1_PEER_END,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
> +		.name = "mbox_local",
> +		.start = U5500_MBOX1_LOCAL_START,
> +		.end = U5500_MBOX1_LOCAL_END,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
> +		.name = "mbox_irq",
> +		.start = MBOX_PAIR1_VIRT_IRQ,
> +		.end = MBOX_PAIR1_VIRT_IRQ,
> +		.flags = IORESOURCE_IRQ,
> +	}
> +};
> +
> +static struct resource mbox2_resources[] = {
> +	{
> +		.name = "mbox_peer",
> +		.start = U5500_MBOX2_PEER_START,
> +		.end = U5500_MBOX2_PEER_END,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
> +		.name = "mbox_local",
> +		.start = U5500_MBOX2_LOCAL_START,
> +		.end = U5500_MBOX2_LOCAL_END,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
> +		.name = "mbox_irq",
> +		.start = MBOX_PAIR2_VIRT_IRQ,
> +		.end = MBOX_PAIR2_VIRT_IRQ,
> +		.flags = IORESOURCE_IRQ,
> +	}
> +};
> +
> +static struct platform_device mbox0_device = {
> +	.id = 0,
> +	.name = "mbox",
> +	.resource = mbox0_resources,
> +	.num_resources = ARRAY_SIZE(mbox0_resources),
> +};
> +
> +static struct platform_device mbox1_device = {
> +	.id = 1,
> +	.name = "mbox",
> +	.resource = mbox1_resources,
> +	.num_resources = ARRAY_SIZE(mbox1_resources),
> +};
> +
> +static struct platform_device mbox2_device = {
> +	.id = 2,
> +	.name = "mbox",
> +	.resource = mbox2_resources,
> +	.num_resources = ARRAY_SIZE(mbox2_resources),
> +};
> +
>   static struct platform_device *u5500_platform_devs[] __initdata = {
>   	&u5500_gpio_devs[0],
>   	&u5500_gpio_devs[1],
> @@ -33,6 +118,9 @@ static struct platform_device *u5500_platform_devs[] __initdata = {
>   	&u5500_gpio_devs[5],
>   	&u5500_gpio_devs[6],
>   	&u5500_gpio_devs[7],
> +	&mbox0_device,
> +	&mbox1_device,
> +	&mbox2_device,
>   };
>
>   void __init u5500_map_io(void)
> diff --git a/arch/arm/mach-ux500/include/mach/db5500-regs.h b/arch/arm/mach-ux500/include/mach/db5500-regs.h
> index 545c80f..3eafc0e 100644
> --- a/arch/arm/mach-ux500/include/mach/db5500-regs.h
> +++ b/arch/arm/mach-ux500/include/mach/db5500-regs.h
> @@ -100,4 +100,18 @@
>   #define U5500_GPIOBANK6_BASE	(U5500_GPIO4_BASE + 0x80)
>   #define U5500_GPIOBANK7_BASE	(U5500_GPIO4_BASE + 0x100)
>
> +#define U5500_MBOX_BASE		(U5500_MODEM_BASE + 0xFFD1000)
> +#define U5500_MBOX0_PEER_START	(U5500_MBOX_BASE + 0x40)
> +#define U5500_MBOX0_PEER_END	(U5500_MBOX_BASE + 0x5F)
> +#define U5500_MBOX0_LOCAL_START	(U5500_MBOX_BASE + 0x60)
> +#define U5500_MBOX0_LOCAL_END	(U5500_MBOX_BASE + 0x7F)
> +#define U5500_MBOX1_PEER_START	(U5500_MBOX_BASE + 0x80)
> +#define U5500_MBOX1_PEER_END	(U5500_MBOX_BASE + 0x9F)
> +#define U5500_MBOX1_LOCAL_START	(U5500_MBOX_BASE + 0xA0)
> +#define U5500_MBOX1_LOCAL_END	(U5500_MBOX_BASE + 0xBF)
> +#define U5500_MBOX2_PEER_START	(U5500_MBOX_BASE + 0x00)
> +#define U5500_MBOX2_PEER_END	(U5500_MBOX_BASE + 0x1F)
> +#define U5500_MBOX2_LOCAL_START	(U5500_MBOX_BASE + 0x20)
> +#define U5500_MBOX2_LOCAL_END	(U5500_MBOX_BASE + 0x3F)
> +
>   #endif
> diff --git a/arch/arm/mach-ux500/include/mach/irqs-db5500.h b/arch/arm/mach-ux500/include/mach/irqs-db5500.h
> index 6fbfe5e..bfa123d 100644
> --- a/arch/arm/mach-ux500/include/mach/irqs-db5500.h
> +++ b/arch/arm/mach-ux500/include/mach/irqs-db5500.h
> @@ -61,6 +61,7 @@
>   #define IRQ_DB5500_SDMMC0		(IRQ_SHPI_START + 60)
>   #define IRQ_DB5500_HSEM			(IRQ_SHPI_START + 61)
>   #define IRQ_DB5500_SBAG			(IRQ_SHPI_START + 63)
> +#define IRQ_DB5500_MODEM		(IRQ_SHPI_START + 65)
>   #define IRQ_DB5500_SPI1			(IRQ_SHPI_START + 96)
>   #define IRQ_DB5500_MSP2			(IRQ_SHPI_START + 98)
>   #define IRQ_DB5500_SRPTIMER		(IRQ_SHPI_START + 101)
> diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
> index 0d552d9..693aa57 100644
> --- a/arch/arm/mach-ux500/include/mach/irqs.h
> +++ b/arch/arm/mach-ux500/include/mach/irqs.h
> @@ -84,6 +84,19 @@
>   #include<mach/irqs-board-mop500.h>
>   #endif
>
> -#define NR_IRQS				IRQ_BOARD_END
> +/*
> + * After the board specific IRQ:s we reserve a range of IRQ:s in which virtual
> + * IRQ:s representing modem IRQ:s can be allocated
> + */
> +#define IRQ_MODEM_EVENTS_BASE (IRQ_BOARD_END + 1)
> +#define IRQ_MODEM_EVENTS_NBR 72
> +#define IRQ_MODEM_EVENTS_END (IRQ_MODEM_EVENTS_BASE + IRQ_MODEM_EVENTS_NBR)
> +
> +/* List of virtual IRQ:s that are allocated from the range above */
> +#define MBOX_PAIR0_VIRT_IRQ (IRQ_MODEM_EVENTS_BASE + 43)
> +#define MBOX_PAIR1_VIRT_IRQ (IRQ_MODEM_EVENTS_BASE + 45)
> +#define MBOX_PAIR2_VIRT_IRQ (IRQ_MODEM_EVENTS_BASE + 41)
> +
> +#define NR_IRQS				IRQ_MODEM_EVENTS_END
>
>   #endif /* ASM_ARCH_IRQS_H */
