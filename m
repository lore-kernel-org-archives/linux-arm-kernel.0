From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 2 Sep 2010 10:08:00 +0900
Subject: [PATCH 08/13] ARM: S5P64X0: Move DMA support for S5P64X0
In-Reply-To: <1283324960-21629-9-git-send-email-kgene.kim@samsung.com>
References: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
	<1283324960-21629-9-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTi=1tJ-EnDmiossRWVPkumubicqXzqvXSrWQMqQ=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 1, 2010 at 4:09 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> This patch moves DMA support files in the mach-s5p64x0
> for S5P6440 and S5P6450 SoCs.
>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Jassi Brar <jassi.brar@samsung.com>
> ---
> ?arch/arm/{mach-s5p6440 => mach-s5p64x0}/dma.c ? ? ?| ? 75 ++++++++++++++++---
> ?.../include/mach/dma.h ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?0
> ?arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h | ? 28 +++++++
> ?3 files changed, 91 insertions(+), 12 deletions(-)
> ?rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/dma.c (56%)
> ?rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/include/mach/dma.h (100%)
>
> diff --git a/arch/arm/mach-s5p6440/dma.c b/arch/arm/mach-s5p64x0/dma.c
> similarity index 56%
> rename from arch/arm/mach-s5p6440/dma.c
> rename to arch/arm/mach-s5p64x0/dma.c
> index 07606ad..bc84678 100644
> --- a/arch/arm/mach-s5p6440/dma.c
> +++ b/arch/arm/mach-s5p64x0/dma.c
> @@ -1,4 +1,5 @@
> -/*
> +/* linux/arch/arm/mach-s5p64x0/dma.c
> + *
> ?* Copyright (C) 2010 Samsung Electronics Co. Ltd.
> ?* ? ? Jaswinder Singh <jassi.brar@samsung.com>
> ?*
> @@ -15,7 +16,7 @@
> ?* You should have received a copy of the GNU General Public License
> ?* along with this program; if not, write to the Free Software
> ?* Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> +*/
>
> ?#include <linux/platform_device.h>
> ?#include <linux/dma-mapping.h>
> @@ -30,11 +31,11 @@
>
> ?static u64 dma_dmamask = DMA_BIT_MASK(32);
>
> -static struct resource s5p6440_pdma_resource[] = {
> +static struct resource s5p64x0_pdma_resource[] = {
> ? ? ? ?[0] = {
> - ? ? ? ? ? ? ? .start ?= S5P6440_PA_PDMA,
> - ? ? ? ? ? ? ? .end ? ?= S5P6440_PA_PDMA + SZ_4K,
> - ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
> + ? ? ? ? ? ? ? .start ?= S5P64X0_PA_PDMA,
> + ? ? ? ? ? ? ? .end ? ?= S5P64X0_PA_PDMA + SZ_4K,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
> ? ? ? ?},
> ? ? ? ?[1] = {
> ? ? ? ? ? ? ? ?.start ?= IRQ_DMA0,
> @@ -80,11 +81,48 @@ static struct s3c_pl330_platdata s5p6440_pdma_pdata = {
> ? ? ? ?},
> ?};
>
> +static struct s3c_pl330_platdata s5p6450_pdma_pdata = {
> + ? ? ? .peri = {
> + ? ? ? ? ? ? ? [0] = DMACH_UART0_RX,
> + ? ? ? ? ? ? ? [1] = DMACH_UART0_TX,
> + ? ? ? ? ? ? ? [2] = DMACH_UART1_RX,
> + ? ? ? ? ? ? ? [3] = DMACH_UART1_TX,
> + ? ? ? ? ? ? ? [4] = DMACH_UART2_RX,
> + ? ? ? ? ? ? ? [5] = DMACH_UART2_TX,
> + ? ? ? ? ? ? ? [6] = DMACH_UART3_RX,
> + ? ? ? ? ? ? ? [7] = DMACH_UART3_TX,
> + ? ? ? ? ? ? ? [8] = DMACH_UART4_RX,
> + ? ? ? ? ? ? ? [9] = DMACH_UART4_TX,
> + ? ? ? ? ? ? ? [10] = DMACH_PCM0_TX,
> + ? ? ? ? ? ? ? [11] = DMACH_PCM0_RX,
> + ? ? ? ? ? ? ? [12] = DMACH_I2S0_TX,
> + ? ? ? ? ? ? ? [13] = DMACH_I2S0_RX,
> + ? ? ? ? ? ? ? [14] = DMACH_SPI0_TX,
> + ? ? ? ? ? ? ? [15] = DMACH_SPI0_RX,
> + ? ? ? ? ? ? ? [16] = DMACH_PCM1_TX,
> + ? ? ? ? ? ? ? [17] = DMACH_PCM1_RX,
> + ? ? ? ? ? ? ? [18] = DMACH_PCM2_TX,
> + ? ? ? ? ? ? ? [19] = DMACH_PCM2_RX,
> + ? ? ? ? ? ? ? [20] = DMACH_SPI1_TX,
> + ? ? ? ? ? ? ? [21] = DMACH_SPI1_RX,
> + ? ? ? ? ? ? ? [22] = DMACH_USI_TX,
> + ? ? ? ? ? ? ? [23] = DMACH_USI_RX,
> + ? ? ? ? ? ? ? [24] = DMACH_MAX,
> + ? ? ? ? ? ? ? [25] = DMACH_I2S1_TX,
> + ? ? ? ? ? ? ? [26] = DMACH_I2S1_RX,
> + ? ? ? ? ? ? ? [27] = DMACH_I2S2_TX,
> + ? ? ? ? ? ? ? [28] = DMACH_I2S2_RX,
> + ? ? ? ? ? ? ? [29] = DMACH_PWM,
> + ? ? ? ? ? ? ? [30] = DMACH_UART5_RX,
> + ? ? ? ? ? ? ? [31] = DMACH_UART5_TX,
> + ? ? ? },
> +};
> +
> ?static struct platform_device s5p6440_device_pdma = {
> ? ? ? ?.name ? ? ? ? ? = "s3c-pl330",
> ? ? ? ?.id ? ? ? ? ? ? = 1,

While at it, please make id 0  as well.


> - ? ? ? .num_resources ?= ARRAY_SIZE(s5p6440_pdma_resource),
> - ? ? ? .resource ? ? ? = s5p6440_pdma_resource,
> + ? ? ? .num_resources ?= ARRAY_SIZE(s5p64x0_pdma_resource),
> + ? ? ? .resource ? ? ? = s5p64x0_pdma_resource,
> ? ? ? ?.dev ? ? ? ? ? ?= {
> ? ? ? ? ? ? ? ?.dma_mask = &dma_dmamask,
> ? ? ? ? ? ? ? ?.coherent_dma_mask = DMA_BIT_MASK(32),
> @@ -92,14 +130,27 @@ static struct platform_device s5p6440_device_pdma = {
> ? ? ? ?},
> ?};
>
> -static struct platform_device *s5p6440_dmacs[] __initdata = {
> +static struct platform_device s5p6450_device_pdma = {
> + ? ? ? .name ? ? ? ? ? = "s3c-pl330",
> + ? ? ? .id ? ? ? ? ? ? = 0,
> + ? ? ? .num_resources ?= ARRAY_SIZE(s5p64x0_pdma_resource),
> + ? ? ? .resource ? ? ? = s5p64x0_pdma_resource,
> + ? ? ? .dev ? ? ? ? ? ?= {
> + ? ? ? ? ? ? ? .dma_mask = &dma_dmamask,
> + ? ? ? ? ? ? ? .coherent_dma_mask = DMA_BIT_MASK(32),
> + ? ? ? ? ? ? ? .platform_data = &s5p6450_pdma_pdata,
> + ? ? ? },
> +};
> +
> +static struct platform_device *s5p64x0_dmacs[] __initdata = {
> ? ? ? ?&s5p6440_device_pdma,
> + ? ? ? /* &s5p6450_device_pdma will be added */
> ?};
Let us simply call the DMAC as s5p64x0_device_pdma and use some
CPU detection method in s5p64x0_dma_init to assign either of
s5p6440_pdma_pdata and s5p6450_pdma_pdata to the platform_data

........

> + ? ? ? DMACH_MTOM_0,
> + ? ? ? DMACH_MTOM_1,
> + ? ? ? DMACH_MTOM_2,
> + ? ? ? DMACH_MTOM_3,
> + ? ? ? DMACH_MTOM_4,
> + ? ? ? DMACH_MTOM_5,
> + ? ? ? DMACH_MTOM_6,
> + ? ? ? DMACH_MTOM_7,

oops ... Mainline s3c dma api doesn't yet support Mem->Mem transfers.
You need to drop it.
