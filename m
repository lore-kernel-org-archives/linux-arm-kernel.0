From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 20 Mar 2014 00:30:21 -0700
Subject: [PATCH 11/35] mtd: st_spi_fsm: Use device size to determine
 address width
In-Reply-To: <1392735362-1245-12-git-send-email-lee.jones@linaro.org>
References: <1392735362-1245-1-git-send-email-lee.jones@linaro.org>
 <1392735362-1245-12-git-send-email-lee.jones@linaro.org>
Message-ID: <20140320073021.GC31517@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 02:55:38PM +0000, Lee Jones wrote:
> Take some known parameters, namely size and number of sectors and use
> them to determine weather a device can support 32bit addressing or not.
> If it can, set the associated flash capability flag for latter use.
> 
> Acked-by Angus Clark <angus.clark@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mtd/devices/st_spi_fsm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
> index 68fa12e..1d7a13a0 100644
> --- a/drivers/mtd/devices/st_spi_fsm.c
> +++ b/drivers/mtd/devices/st_spi_fsm.c
> @@ -670,6 +670,10 @@ static int stfsm_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	fsm->info = info;
>  
> +	/* Use device size to determine address width */
> +	if (info->sector_size * info->n_sectors > 0xFFFFFF)

Shouldn't you compare:

	if (info->sector_size * info->n_sectors > 0x1000000)

?

A device of size 0x1000000 can be addressed completely with only the
lower 24 bits.

> +		info->flags |= FLASH_FLAG_32BIT_ADDR;
> +
>  	platform_set_drvdata(pdev, fsm);
>  
>  	fsm->mtd.dev.parent	= &pdev->dev;

Brian
