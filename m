From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 19 Jul 2018 16:46:50 +0200
Subject: [PATCH v2] mmc: sunxi: remove output of virtual base address
In-Reply-To: <20180719133554.30737-1-andre.przywara@arm.com>
References: <20180719133554.30737-1-andre.przywara@arm.com>
Message-ID: <20180719144650.hq3rtevp3gjkpvxh@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 02:35:54PM +0100, Andre Przywara wrote:
> Recent Linux versions refuse to print actual virtual kernel addresses,
> to not give a hint about the location of the kernel in a randomized virtual
> address space. This affects the output of the sunxi MMC controller
> driver, which now produces the rather uninformative line:
> 
> [    1.482660] sunxi-mmc 1c0f000.mmc: base:0x(____ptrval____) irq:8
> 
> Since the virtual base address is not really interesting in the first
> place, let's just drop this value. The same applies to Linux' notion of
> the interrupt number, which is independent from the GIC SPI number.
> We have the physical address as part of the DT node name, which is way
> more useful for debugging purposes.
> To keep a success message in the driver, we print some information that
> is not too obvious and that we learned while probing the device:
> the maximum request size and whether it uses the new timing mode.
> So the output turns into:
> sunxi-mmc 1c0f000.mmc: max request size: 16384 KB, uses new timings mode
> sunxi-mmc 1c11000.mmc: max request size: 2048 KB
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Changelog v1 ... v2:
> - dropped output of Linux interrupt number
> - added max request size and timings mode output
> 
>  drivers/mmc/host/sunxi-mmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 8e7f3e35ee3d..fbbc09d82338 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1407,7 +1407,10 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto error_free_dma;
>  
> -	dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->irq);
> +	dev_info(&pdev->dev, "max request size: %u KB%s\n",
> +		 mmc->max_req_size >> 10,
> +		 host->use_new_timings ? ", uses new timings mode" : "");

I really don't know how to feel about this one.

This isn't more useful to the regular user wanting to see if the
driver is probed, which is what this message should be about. 

And this one isn't clearer or more obvious than the previous one
(which was already pretty bad). I really think having some message
that basically says "MMC controller initialized" or something along
those lines would work better.

However, I can also see value in having this printed, for developers,
but maybe as dev_dbg?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180719/e2420d2e/attachment.sig>
