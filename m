From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Mar 2017 14:48:39 +0000
Subject: [PATCH] arm/dma-mapping: use for_each_sg
In-Reply-To: <e9923f7ea2c0fd866efb48be52ffe91d25dd0290.1490326970.git.geliangtang@gmail.com>
References: <e9923f7ea2c0fd866efb48be52ffe91d25dd0290.1490326970.git.geliangtang@gmail.com>
Message-ID: <20170324144838.GH7909@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 10:12:23PM +0800, Geliang Tang wrote:
> Use for_each_sg() instead of open-coding it.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

No.

> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 63eabb0..e551351 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1720,7 +1720,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
>  	if (iova == DMA_ERROR_CODE)
>  		return -ENOMEM;
>  
> -	for (count = 0, s = sg; count < (size >> PAGE_SHIFT); s = sg_next(s)) {
> +	for_each_sg(sg, s, size >> PAGE_SHIFT, count) {

This is _not_ equivalent.

#define for_each_sg(sglist, sg, nr, __i)        \
        for (__i = 0, sg = (sglist); __i < (nr); __i++, sg = sg_next(sg))

Putting the arguments into that gives:

        for (count = 0, s = sg; count < (size >> PAGE_SHIFT); count++, s = sg_next(s))

whereas the old code is:

	for (count = 0, s = sg; count < (size >> PAGE_SHIFT); s = sg_next(s))

Spot the difference?  "count++".

This is because "size >> PAGE_SHIFT" is not the number of scatterlist
entries, it's the number of pages to map.

Please be more careful in the future to ensure that, when cleaning up
code, that the code is indeed equivalent.  Subtle errors like this are
sometimes incredibly difficult to spot.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
