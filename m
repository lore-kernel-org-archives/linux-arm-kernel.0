From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 15 Aug 2011 15:06:50 +0530
Subject: [PATCH 07/15] ARM: EXYNOS4: Use generic DMA PL330 driver
In-Reply-To: <1311744697-10264-8-git-send-email-boojin.kim@samsung.com>
References: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
	<1311744697-10264-8-git-send-email-boojin.kim@samsung.com>
Message-ID: <CAJuYYwT9k2+D-VrrdeF2qW1f7CV9wvq3vgPYobNmP680Jnr3yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boojin,

On 27 July 2011 11:01, Boojin Kim <boojin.kim@samsung.com> wrote:
> This patch makes Samsung EXYNOS4 to use DMA PL330 driver
> on DMADEVICE. The EXYNOS4 uses DMA generic APIs instead of
> SAMSUNG specific S3C-PL330 APIs.
>
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?arch/arm/mach-exynos4/Kconfig | ? ?2 +-
> ?arch/arm/mach-exynos4/clock.c | ? 16 ++-
> ?arch/arm/mach-exynos4/dma.c ? | ?299 ++++++++++++++++++++++++++---------------
> ?3 files changed, 198 insertions(+), 119 deletions(-)
>

[...]

> diff --git a/arch/arm/mach-exynos4/dma.c b/arch/arm/mach-exynos4/dma.c
> index 564bb53..d57d662 100644

[...]

> +struct amba_device exynos4_device_pdma0 = {
> + ? ? ? .dev = {
> + ? ? ? ? ? ? ? .init_name = "dma-pl330.0",
> ? ? ? ? ? ? ? ?.dma_mask = &dma_dmamask,
> ? ? ? ? ? ? ? ?.coherent_dma_mask = DMA_BIT_MASK(32),
> ? ? ? ? ? ? ? ?.platform_data = &exynos4_pdma0_pdata,
> ? ? ? ?},
> + ? ? ? .res = {
> + ? ? ? ? ? ? ? .start = EXYNOS4_PA_PDMA0,
> + ? ? ? ? ? ? ? .end = EXYNOS4_PA_PDMA0 + SZ_4K,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
> + ? ? ? },
> + ? ? ? .irq = {IRQ_PDMA0, NO_IRQ},
> + ? ? ? .periphid = 0x00041330,
> ?};
>

[...]

> +struct amba_device exynos4_device_pdma1 = {
> + ? ? ? .dev = {
> + ? ? ? ? ? ? ? .init_name = "dma-pl330.1",
> ? ? ? ? ? ? ? ?.dma_mask = &dma_dmamask,
> ? ? ? ? ? ? ? ?.coherent_dma_mask = DMA_BIT_MASK(32),
> ? ? ? ? ? ? ? ?.platform_data = &exynos4_pdma1_pdata,
> ? ? ? ?},
> -};
> -
> -static struct platform_device *exynos4_dmacs[] __initdata = {
> - ? ? ? &exynos4_device_pdma0,
> - ? ? ? &exynos4_device_pdma1,
> + ? ? ? .res = {
> + ? ? ? ? ? ? ? .start = EXYNOS4_PA_PDMA1,
> + ? ? ? ? ? ? ? .end = EXYNOS4_PA_PDMA1 + SZ_4K,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
> + ? ? ? },
> + ? ? ? .irq = {IRQ_PDMA1, NO_IRQ},
> + ? ? ? .periphid = 0x00041330,
> ?};
>
> ?static int __init exynos4_dma_init(void)
> ?{
> - ? ? ? platform_add_devices(exynos4_dmacs, ARRAY_SIZE(exynos4_dmacs));
> + ? ? ? amba_device_register(&exynos4_device_pdma0, &iomem_resource);

How would the 'exynos4_device_pdma1' instance get registered? Should
there be a amba_device_register call for 'exynos4_device_pdma1'
instance as well?

Thanks,
Thomas.
