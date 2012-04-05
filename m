From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 05 Apr 2012 11:33:30 +0100
Subject: [PATCH 1/2] serial: PL011: Repair NULL pointer dereference
In-Reply-To: <1333377064-8093-1-git-send-email-lee.jones@linaro.org>
References: <1333377064-8093-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1333622010.2328.3.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-04-02 at 15:31 +0100, Lee Jones wrote:
> The pl011 driver attempts to mask and clear UART interrupts
> at probe time, which subsequently fail with a NULL pointer
> dereference error. This is due to 'uap->port.membase' being
> used uninitialised. This patch moves the offending lines
> to a point of post-initialisation.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Tested-by: Jon Medhurst <tixy@linaro.org>

This fixes vexpress boot on v3.4-rc1.

> ---
>  drivers/tty/serial/amba-pl011.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 0c65c9e..b5c1f0f 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1946,10 +1946,6 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>  		goto unmap;
>  	}
>  
> -	/* Ensure interrupts from this UART are masked and cleared */
> -	writew(0, uap->port.membase + UART011_IMSC);
> -	writew(0xffff, uap->port.membase + UART011_ICR);
> -
>  	uap->vendor = vendor;
>  	uap->lcrh_rx = vendor->lcrh_rx;
>  	uap->lcrh_tx = vendor->lcrh_tx;
> @@ -1965,6 +1961,11 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>  	uap->port.ops = &amba_pl011_pops;
>  	uap->port.flags = UPF_BOOT_AUTOCONF;
>  	uap->port.line = i;
> +
> +	/* Ensure interrupts from this UART are masked and cleared */
> +	writew(0, uap->port.membase + UART011_IMSC);
> +	writew(0xffff, uap->port.membase + UART011_ICR);
> +
>  	pl011_dma_probe(uap);
>  
>  	snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", amba_rev(dev));
