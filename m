From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 12 Apr 2016 13:34:24 +0200
Subject: [PATCH] mtd: nand: s3c2410: fix bug in s3c2410_nand_correct_data()
In-Reply-To: <1460446235-987-1-git-send-email-zengzhaoxiu@163.com>
References: <20160411094901.74e68f91@bbrezillon>
 <1460446235-987-1-git-send-email-zengzhaoxiu@163.com>
Message-ID: <20160412133424.6ac1193e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Apr 2016 15:30:35 +0800
zengzhaoxiu at 163.com wrote:

> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> If there is only one bit difference in the ECC, the function should return 1.
> The result of "diff0 & ~(1<<fls(diff0))" is equal to diff0, so the function
> actually returns -1.
> 
> Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Applied.

Thanks,

Boris

> ---
>  drivers/mtd/nand/s3c2410.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
> index 9c9397b..86ffb73 100644
> --- a/drivers/mtd/nand/s3c2410.c
> +++ b/drivers/mtd/nand/s3c2410.c
> @@ -542,7 +542,8 @@ static int s3c2410_nand_correct_data(struct mtd_info *mtd, u_char *dat,
>  	diff0 |= (diff1 << 8);
>  	diff0 |= (diff2 << 16);
>  
> -	if ((diff0 & ~(1<<fls(diff0))) == 0)
> +	/* equal to "(diff0 & ~(1 << __ffs(diff0)))" */
> +	if ((diff0 & (diff0 - 1)) == 0)
>  		return 1;
>  
>  	return -1;



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
