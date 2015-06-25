From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 25 Jun 2015 10:50:19 +0200
Subject: [PATCH v2] gpio/xilinx: Use correct address when setting initial
 values.
In-Reply-To: <1435130385.30543.3.camel@localhost>
References: <1435130385.30543.3.camel@localhost>
Message-ID: <558BC0CB.4000908@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2015 09:19 AM, Rapha?l Teysseyre wrote:
> xgpio_save_regs() is used in this driver to setup the initial
> values of the registers in the hardware.
> 
> The relevant registers at that time are:
> 0x0 -> channel 0 data (32 bits, one for each GPIO on this channel).
> 0x4 -> channel 0 tri, controls in/out status for each GPIO of this channel.
> 0x8 -> channel 1 data
> 0xC -> channel 1 tri
> 
> gpio-xilinx.c defines these:
> XGPIO_DATA_OFFSET   (0x0)
> XGPIO_TRI_OFFSET    (0x4)
> XGPIO_CHANNEL_OFFSET	0x8
> 
> Before this patch, the "data" register value of channel 1 was written
> at 0x4 intead of 0x8 (overwriting the channel 0 "tri" register),
> and the "tri" register value for channel 1 was written at 0x8 instead of 0xC.
> 
> Signed-off-by: Rapha?l Teysseyre <rteysseyre@gmail.com>
> ---
>  drivers/gpio/gpio-xilinx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index 61243d1..e544b7a 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -220,9 +220,9 @@ static void xgpio_save_regs(struct of_mm_gpio_chip *mm_gc)
>  	if (!chip->gpio_width[1])
>  		return;
>  
> -	xgpio_writereg(mm_gc->regs + XGPIO_DATA_OFFSET + XGPIO_TRI_OFFSET,
> +	xgpio_writereg(mm_gc->regs + XGPIO_DATA_OFFSET + XGPIO_CHANNEL_OFFSET,
>  		       chip->gpio_state[1]);
> -	xgpio_writereg(mm_gc->regs + XGPIO_TRI_OFFSET + XGPIO_TRI_OFFSET,
> +	xgpio_writereg(mm_gc->regs + XGPIO_TRI_OFFSET + XGPIO_CHANNEL_OFFSET,
>  		       chip->gpio_dir[1]);
>  }


Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
