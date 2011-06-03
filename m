From: adrian.wenl@gmail.com (Lei Wen)
Date: Fri, 3 Jun 2011 23:04:39 +0800
Subject: [PATCH] MTD: pxa3xx_nand: Fix blank page ECC mismatch
In-Reply-To: <1307106198-11965-1-git-send-email-zonque@gmail.com>
References: <1307106198-11965-1-git-send-email-zonque@gmail.com>
Message-ID: <BANLkTimpLKkfSJbeuM6kc7bUE+JybTmVrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 3, 2011 at 9:03 PM, Daniel Mack <zonque@gmail.com> wrote:
> This bug was introduced in f8155a40 ("mtd: pxa3xx_nand: rework irq
> logic") and causes the PXA3xx NAND controller fail to operate with NAND
> flash that has empty pages. According to the comment in this block, the
> hardware controller will report a double-bit error for empty pages,
> which can and must be ignored.
>
> This patch restores the original behaviour of the driver.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Lei Wen <leiwen@marvell.com>
> Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: David Woodhouse <David.Woodhouse@intel.com>
> Cc: stable at kernel.org
> ---
> ?drivers/mtd/nand/pxa3xx_nand.c | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index 0c6ed72..60167d1 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -687,6 +687,8 @@ static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
> ? ? ? ? ? ? ? ? * OOB, ignore such double bit errors
> ? ? ? ? ? ? ? ? */
> ? ? ? ? ? ? ? ?if (is_buf_blank(buf, mtd->writesize))
> + ? ? ? ? ? ? ? ? ? ? ? info->retcode = ERR_NONE;
> + ? ? ? ? ? ? ? else
> ? ? ? ? ? ? ? ? ? ? ? ?mtd->ecc_stats.failed++;
> ? ? ? ?}
>
> --
> 1.7.5.1
>

Acked-by: Lei Wen <leiwen@marvell.com>
