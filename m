From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 10 May 2012 18:25:16 +0900
Subject: [PATCH] ARM: SAMSUNG: Fix for S3C2412 EBI memory mapping.
In-Reply-To: <1336607209-6409-1-git-send-email-jose.goncalves@inov.pt>
References: <1336607209-6409-1-git-send-email-jose.goncalves@inov.pt>
Message-ID: <036701cd2e8e$cf4cc100$6de64300$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jos? Miguel Gon?alves wrote:
> 
> While upgrading the kernel on a S3C2412 based board I've noted that it was
> impossible to boot the board with a 2.6.32 or upper kernel.
> I've tracked down the problem to the EBI virtual memory mapping that is in
> conflict with the IO mapping definition in arch/arm/mach-s3c24xx/s3c2412.c.
> 
> Signed-off-by: Jos? Miguel Gon?alves <jose.goncalves@inov.pt>
> ---
>  arch/arm/plat-samsung/include/plat/map-s3c.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/include/plat/map-s3c.h b/arch/arm/plat-
> samsung/include/plat/map-s3c.h
> index 7d04875..c0c70a8 100644
> --- a/arch/arm/plat-samsung/include/plat/map-s3c.h
> +++ b/arch/arm/plat-samsung/include/plat/map-s3c.h
> @@ -22,7 +22,7 @@
>  #define S3C24XX_VA_WATCHDOG	S3C_VA_WATCHDOG
> 
>  #define S3C2412_VA_SSMC		S3C_ADDR_CPU(0x00000000)
> -#define S3C2412_VA_EBI		S3C_ADDR_CPU(0x00010000)
> +#define S3C2412_VA_EBI		S3C_ADDR_CPU(0x00100000)
> 
>  #define S3C2410_PA_UART		(0x50000000)
>  #define S3C24XX_PA_UART		S3C2410_PA_UART
> --
> 1.7.5.4

Yeah, as you said, the mapping for SSMC invade EBI area but I think, just SZ_4K is enough for SSMC. So following is better in this case. How do you think? And there is no problem on your board?

diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
index d4bc7f9..ac906bf 100644
--- a/arch/arm/mach-s3c24xx/s3c2412.c
+++ b/arch/arm/mach-s3c24xx/s3c2412.c
@@ -72,7 +72,7 @@ static struct map_desc s3c2412_iodesc[] __initdata = {
 	{
 		.virtual = (unsigned long)S3C2412_VA_SSMC,
 		.pfn     = __phys_to_pfn(S3C2412_PA_SSMC),
-		.length  = SZ_1M,
+		.length  = SZ_4K,
 		.type    = MT_DEVICE,
 	},
 	{

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
