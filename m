From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Feb 2015 10:47:44 +0100
Subject: [PATCH v3 1/2] mtd: nand: pxa3xx: Fix PIO FIFO draining
In-Reply-To: <87k2zha69p.fsf@free.fr>
References: <1424091072-7738-1-git-send-email-maxime.ripard@free-electrons.com>
 <1424091072-7738-2-git-send-email-maxime.ripard@free-electrons.com>
 <87oaotaa6r.fsf@free.fr> <20150216205825.GG25269@lukather>
 <87k2zha69p.fsf@free.fr>
Message-ID: <20150217094744.GI25269@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 16, 2015 at 10:36:02PM +0100, Robert Jarzmik wrote:
> Maxime Ripard <maxime.ripard@free-electrons.com> writes:
> 
> >> I don't think an mdelay(256) is acceptable.
> >
> > That's very true that this driver would need some love, but
> > valentine's day was last week.
>
> That doesn't cope with the 256ms mdelay. And a potential big mdelay
> is not what I'd call a bug fix, see below.

I really don't care about the delay itself, really.

Just splitting the readsl into several chunks seems to slow the FIFO
draining enough so that we don't even need to poll the RDDREQ bit.

I was asked (rightfully) for a timeout, and since there's no
particular indication in the datasheet on this, I came up with a
totally random and made-up number. If you want to suggest any other
random number, I'd be happy to use it.

Plus, saying that this is strictly equivalent to mdelay(256) is just
bad faith. It is a (very very very unlikely) worst case scenario.
During my tests, I've never experienced even a single delay being
used, let alone every single reads needing to poll the bit for 5ms,
always succeeding at the last attempt.

If we really care about this, we might as well start caring about
other theoretically possible situations, such as the NAND chip being
ripped off the board by an asteroid.

> > I'm sorry, but this is a patch targeted for stable. This is a pure
> > bugfix. I won't rewrite the whole driver solely to make the driver
> > better, especially since that would make such a patch (or more likely
> > a whole serie) unsuitable for stable.
> 
> This is the rewrite I was asking for (not tested), consider it against your
> "rewrite the whole driver" :
> 
> 	Modified   drivers/mtd/nand/pxa3xx_nand.c
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index e512902..6e569e9 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -576,11 +576,20 @@ static void start_data_dma(struct pxa3xx_nand_info *info)
>  {}
>  #endif
>  
> +static irqreturn_t pxa3xx_nand_irq_thread(int irq, void *data)
> +{
> +	struct pxa3xx_nand_info *info = data;
> +
> +	handle_data_pio(info);
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
>  {
>  	struct pxa3xx_nand_info *info = devid;
>  	unsigned int status, is_completed = 0, is_ready = 0;
>  	unsigned int ready, cmd_done;
> +	irqreturn_t ret = IRQ_HANDLED;
>  
>  	if (info->cs == 0) {
>  		ready           = NDSR_FLASH_RDY;
> @@ -622,7 +631,7 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
>  		} else {
>  			info->state = (status & NDSR_RDDREQ) ?
>  				      STATE_PIO_READING : STATE_PIO_WRITING;
> -			handle_data_pio(info);
> +			ret = IRQ_WAKE_THREAD;
>  		}
>  	}
>  	if (status & cmd_done) {
> @@ -663,7 +672,7 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
>  	if (is_ready)
>  		complete(&info->dev_ready);
>  NORMAL_IRQ_EXIT:
> -	return IRQ_HANDLED;
> +	return ret;
>  }
>  
>  static inline int is_buf_blank(uint8_t *buf, size_t len)
> @@ -1688,7 +1697,8 @@ static int alloc_nand_resource(struct platform_device *pdev)
>  	/* initialize all interrupts to be disabled */
>  	disable_int(info, NDSR_MASK);
>  
> -	ret = request_irq(irq, pxa3xx_nand_irq, 0, pdev->name, info);
> +	ret = request_threaded_irq(irq, pxa3xx_nand_irq,
> +				   pxa3xx_nand_irq_thread, 0, pdev->name, info);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to request IRQ\n");
>  		goto fail_free_buf;

While I agree that this change would be needed, it is still not stable
material, so both patches will have to go through separate ways (and
one will live without the other).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150217/bf5623eb/attachment.sig>
