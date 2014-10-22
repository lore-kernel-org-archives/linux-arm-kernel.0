From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Oct 2014 14:48:33 +0100
Subject: [PATCH] tty/serial: earlycon: Fix print for implied MMIO case
In-Reply-To: <1413536471-3454-1-git-send-email-galak@codeaurora.org>
References: <1413536471-3454-1-git-send-email-galak@codeaurora.org>
Message-ID: <20141022134833.GJ22642@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 17, 2014 at 10:01:11AM +0100, Kumar Gala wrote:
> For the case in which we just provide an address as an argument to the
> earlycon console type like:
> 
> earlycon=msm_serial_dm,0xf991e000

Personally it would be nice to see this when using pl011 as an earlyon.
Currently I get:

  Early serial console at I/O port 0x0 (options '')

With this patch I get:

  Early serial console at MMIO 0x7ff80000 (options '')

> We would report this as an IO port based mapping and not as MMIO.  Simple
> fix to use the port->iotype to decide which message to print.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>

Acked-by: Mark RUtland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  drivers/tty/serial/earlycon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index a514ee6..64fe25a 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -98,7 +98,7 @@ static int __init parse_options(struct earlycon_device *device,
>  		strlcpy(device->options, options, length);
>  	}
>  
> -	if (mmio || mmio32)
> +	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM32)
>  		pr_info("Early serial console at MMIO%s 0x%llx (options '%s')\n",
>  			mmio32 ? "32" : "",
>  			(unsigned long long)port->mapbase,
> -- 
> Qualcomm Innovation Center, Inc.
>  The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>  a Linux Foundation Collaborative Project
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
