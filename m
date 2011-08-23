From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 23 Aug 2011 09:05:22 +0200
Subject: [PATCH 2/2] ARM: i.MX5/mm: use static mapping for TZIC
In-Reply-To: <1314014005-9923-3-git-send-email-jason.hui@linaro.org>
References: <1314014005-9923-1-git-send-email-jason.hui@linaro.org>
	<1314014005-9923-3-git-send-email-jason.hui@linaro.org>
Message-ID: <20110823070522.GI16557@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason,

On Mon, Aug 22, 2011 at 07:53:25PM +0800, Jason Liu wrote:
> We can use static mapping for TZIC to get rid of the
> duplicated code for ioremap and the error handling of
> ioremap, which will made code more clean and consistent.
> 
> Signed-off-by: Jason Liu <jason.hui@linaro.org>
> ---
>  arch/arm/mach-mx5/mm.c                |   20 ++++----------------
>  arch/arm/plat-mxc/include/mach/mx51.h |    1 +
>  arch/arm/plat-mxc/include/mach/mx53.h |    1 +
>  3 files changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
> index f8ebe37..adfe889 100644
> --- a/arch/arm/mach-mx5/mm.c
> +++ b/arch/arm/mach-mx5/mm.c
> @@ -25,6 +25,7 @@
>   * Define the MX51 memory map.
>   */
>  static struct map_desc mx51_io_desc[] __initdata = {
> +	imx_map_entry(MX51, TZIC, MT_DEVICE),
>  	imx_map_entry(MX51, IRAM, MT_DEVICE),
>  	imx_map_entry(MX51, DEBUG, MT_DEVICE),
>  	imx_map_entry(MX51, AIPS1, MT_DEVICE),
> @@ -36,6 +37,7 @@ static struct map_desc mx51_io_desc[] __initdata = {
>   * Define the MX53 memory map.
>   */
>  static struct map_desc mx53_io_desc[] __initdata = {
> +	imx_map_entry(MX53, TZIC, MT_DEVICE),
>  	imx_map_entry(MX53, AIPS1, MT_DEVICE),
>  	imx_map_entry(MX53, SPBA0, MT_DEVICE),
>  	imx_map_entry(MX53, AIPS2, MT_DEVICE),
> @@ -100,32 +102,18 @@ void __init imx50_init_early(void)
>  void __init mx51_init_irq(void)
>  {
>  	unsigned long tzic_addr;
> -	void __iomem *tzic_virt;
>  
>  	if (mx51_revision() < IMX_CHIP_REVISION_2_0)
>  		tzic_addr = MX51_TZIC_BASE_ADDR_TO1;
>  	else
>  		tzic_addr = MX51_TZIC_BASE_ADDR;
>  
> -	tzic_virt = ioremap(tzic_addr, SZ_16K);
> -	if (!tzic_virt)
> -		panic("unable to map TZIC interrupt controller\n");
> -
> -	tzic_init_irq(tzic_virt);
> +	tzic_init_irq(MX51_IO_ADDRESS(tzic_addr));
arch/arm/plat-mxc/include/mach/hardware.h has a list of all SoCs with
the memory areas mapped that you are expected to update if you add
another mapping. If you had done that, you would have noticed that
MX51_TZIC_BASE_ADDR (== 0xe0000000) maps to the very same address as
MX51_DEBUG_BASE_ADDR (== 0x60000000).
So only one of these two can be statically mapped (or the function needs
to change).

Having said that it would be nice to use a static mapping for TZIC. Do
we really need MX51_DEBUG mapped?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
