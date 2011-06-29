From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 29 Jun 2011 10:11:22 +0300
Subject: [PATCH 2/9] MTD: pxa3xx_nand: enable multiple chip select support
In-Reply-To: <1309319494-17951-3-git-send-email-leiwen@marvell.com>
References: <1309246361.23597.30.camel@sauron>
	<1309319494-17951-3-git-send-email-leiwen@marvell.com>
Message-ID: <1309331487.23597.131.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-06-28 at 20:51 -0700, Lei Wen wrote:
> Current pxa3xx_nand controller has two chip select which
> both be workable. This patch enable this feature.
> 
> Update platform driver to support this feature.
> 
> Another notice should be taken that:
> When you want to use this feature, you should not enable the
> keep configuration feature, for two chip select could be
> attached with different nand chip. The different page size
> and timing requirement make the keep configuration impossible.
> 
> Signed-off-by: Lei Wen <leiwen@marvell.com>
> ---
>  arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |   19 +-
>  drivers/mtd/nand/pxa3xx_nand.c               |  493 +++++++++++++++----------
>  2 files changed, 313 insertions(+), 199 deletions(-)

If someone can review this patch - good let's see how many Reviewed-by
tags we get. But I think it is not very reviewable because of the size.

AFAICK, what you do here is

1. Introduce new structure struct pxa3xx_nand_host
2. Move several fields from struct pxa3xx_nand_info to struct
pxa3xx_nand_host

And only this alone adds a lot of noise to the patch.

And also you have some real functional changes.

So I'd suggest you to split this patch at least on 2 - the first one
would introduce struct pxa3xx_nand_host, moved some fields, and do all
the host<->info renamings. You can split this on several steps and move
only several fields at a time.

Then a separate patch would do some more functional changes. How does
this sound?

-- 
Best Regards,
Artem Bityutskiy
