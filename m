From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Tue, 26 Jun 2012 16:11:30 +0530
Subject: [PATCH v2 05/17] i2c: omap: split out [XR]DR and [XR]RDY
In-Reply-To: <1339691067-919-6-git-send-email-balbi@ti.com>
References: <1339691067-919-1-git-send-email-balbi@ti.com>
 <1339691067-919-6-git-send-email-balbi@ti.com>
Message-ID: <4FE991DA.5070301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,
On Thursday 14 June 2012 09:54 PM, Felipe Balbi wrote:
>  			return IRQ_HANDLED;
>  		}
>  
> -		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
> +		if (stat & OMAP_I2C_STAT_RDR) {
>  			u8 num_bytes = 1;
>  
> +			if (dev->fifo_size)
> +				num_bytes = dev->fifo_size;
In case of a draining interrupt. The byte count may not be the fifo size.
Do you agree?
> +
> +			while (num_bytes--) {
> +				if (!dev->buf_len) {
