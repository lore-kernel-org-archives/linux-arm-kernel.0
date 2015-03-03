From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 3 Mar 2015 12:18:46 +0200
Subject: [PATCH] mtd: nand: pxa3xx: Switch FIFO draining to jiffies-based
 timeout
In-Reply-To: <1425376529-1860-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1425376529-1860-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150303101846.GO15668@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Tue, Mar 03, 2015 at 10:55:29AM +0100, Maxime Ripard wrote:
> Now that the driver handles the FIFO draining in a threaded interrupt, we can
> base our timeout on jiffies and sleeping, instead of using mdelay.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/mtd/nand/pxa3xx_nand.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index 3f09f2e9aeb4..1eb957c347cd 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -496,16 +496,15 @@ static void drain_fifo(struct pxa3xx_nand_info *info, void *data, int len)
>  		while (len > 8) {
>  			__raw_readsl(info->mmio_base + NDDB, data, 8);
>  
> -			for (timeout = 0;
> -			     !(nand_readl(info, NDSR) & NDSR_RDDREQ);
> -			     timeout++) {
> -				if (timeout >= 5) {
> +			timeout = jiffies + msecs_to_jiffies(5);
> +			while (!(nand_readl(info, NDSR) & NDSR_RDDREQ)) {
> +				if (!time_before(jiffies, timeout)) {
>  					dev_err(&info->pdev->dev,
>  						"Timeout on RDDREQ while draining the FIFO\n");
>  					return;
>  				}
>  
> -				mdelay(1);
> +				msleep(1);
>  			}

You may want to consider using readl_relaxed_poll_timeout() from 
linux/iopoll.h, which was introduced in v4.0-rc1.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
