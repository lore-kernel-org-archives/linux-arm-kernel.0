From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Thu, 09 Jun 2016 21:28:30 +0900
Subject: [PATCH] mmc: dw_mmc: fix 32bit little-endian access of des1 field
In-Reply-To: <1465306639-9537-1-git-send-email-ben.dooks@codethink.co.uk>
References: <CGME20160607133726epcas1p1c3274577f12dbf456a7a6bf3efb6e1fe@epcas1p1.samsung.com>
 <1465306639-9537-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <575960EE.8040702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On 06/07/2016 10:37 PM, Ben Dooks wrote:
> The IDMAC_SET_BUFFER1_SIZE() macro modifies des1, but does
> not check if the value being passed is big or little endian
> desptire the des1 field being marked as __le32.
> 
> Fix the issue by ensuring the values are changed from the
> cpu endian to the descriptor endian by using cpu_to_le32.
> 
> Spotted whilst doing big endian conversion work on Exynos,
> and stops the mmc worker thread from stalling.

Applied this patch. Thanks!

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Matthew Leach <matt.leach@codethink.co.uk>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 2cc6123..544397e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -92,7 +92,7 @@ struct idmac_desc {
>  
>  	__le32		des1;	/* Buffer sizes */
>  #define IDMAC_SET_BUFFER1_SIZE(d, s) \
> -	((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))
> +	((d)->des1 = ((d)->des1 & cpu_to_le32(0x03ffe000)) | (cpu_to_le32((s) & 0x1fff)))
>  
>  	__le32		des2;	/* buffer 1 physical address */
>  
> 
