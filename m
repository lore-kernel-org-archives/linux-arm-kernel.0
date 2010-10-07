From: vimal.newwork@gmail.com (Vimal Singh)
Date: Thu, 7 Oct 2010 23:09:49 +0530
Subject: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw
	read/write
In-Reply-To: <1285063280-4057-10-git-send-email-manjugk@ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
	<1285063280-4057-10-git-send-email-manjugk@ti.com>
Message-ID: <AANLkTikUpZ9FxPUoQE64hJcT31GiAC7868MPCr=Bm_0o@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 21, 2010 at 3:31 PM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
> Following sparse warnings exists due to use of writel/w and readl/w functions.
>
> This patch fixes the sparse warnings by converting readl/w functions usage into
> __raw_readl/__raw_readw functions.
>
[...]
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -481,7 +481,7 @@ static int omap_verify_buf(struct mtd_info *mtd, const u_char * buf, int len)
>
> ? ? ? ?len >>= 1;
> ? ? ? ?while (len--) {
> - ? ? ? ? ? ? ? if (*p++ != cpu_to_le16(readw(info->nand.IO_ADDR_R)))
> + ? ? ? ? ? ? ? if (*p++ != cpu_to_le16(__raw_readw(info->nand.IO_ADDR_R)))

There was an old comment to remove use of 'cpu_to_le16' from driver, I
just missed it. Can you rather use 'ioread16_rep' for reading data.

-- 
Regards,
Vimal Singh
