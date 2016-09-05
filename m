From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 5 Sep 2016 08:51:46 +0200
Subject: [PATCH 1/2] mtd: nand: automate NAND timings selection
In-Reply-To: <1472820149-24241-2-git-send-email-s.hauer@pengutronix.de>
References: <1472820149-24241-1-git-send-email-s.hauer@pengutronix.de>
 <1472820149-24241-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20160905085146.239129bd@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

It feels weird to review his own patch, but I have a few comments. :)

On Fri,  2 Sep 2016 14:42:28 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> The NAND framework provides several helpers to query timing modes supported
> by a NAND chip, but this implies that all NAND controller drivers have
> to implement the same timings selection dance.
> 
> Provide a common logic to select the best timings based on ONFI or
> ->onfi_timing_mode_default information.  
> NAND controller willing to support timings adjustment should just
> implement the ->setup_data_interface() method.

Now I remember one of the reason I did not post a v2 (apart from not
having the time).

If understand the ONFI spec correctly, when you reset the NAND chip,
you get back to SDR+timing-mode0. In the core we do not control when
the reset command (0xff) is issued, and this prevents us from
re-applying the correct timing mode after a reset.

Maybe we should provide a nand_reset() helper to hide this complexity,
and patch all ->cmdfunc(NAND_CMD_RESET) callers to call nand_reset()
instead.

Note that the interface+timing-mode config is not necessarily the only
thing we'll have to re-apply after a reset (especially on MLC NANDs), so
having place where we can put all operations that should be done after
a reset is a good thing.

> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mtd/nand/nand_base.c | 196 ++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/mtd/nand.h     | 115 ++++++++++++++-----------
>  2 files changed, 261 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> index 77533f7..018fd56 100644
> --- a/drivers/mtd/nand/nand_base.c
> +++ b/drivers/mtd/nand/nand_base.c
> @@ -3322,6 +3322,148 @@ static void nand_onfi_detect_micron(struct nand_chip *chip,
>  	chip->setup_read_retry = nand_setup_read_retry_micron;
>  }
>  
> +/**
> + * nand_setup_data_interface - Setup the data interface and timings on the
> + *			       controller side
> + * @mtd: MTD device structure
> + * @conf: new configuration to apply
> + *
> + * Try to configure the NAND controller to support the provided data
> + * interface configuration.
> + *
> + * Returns 0 in case of success or -ERROR_CODE.
> + */
> +static int nand_setup_data_interface(struct mtd_info *mtd,
> +				     const struct nand_data_interface *conf)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	int ret;
> +
> +	if (!chip->setup_data_interface)
> +		return -ENOTSUPP;
> +
> +	ret = chip->setup_data_interface(mtd, conf, false);
> +	if (ret)
> +		return ret;
> +
> +	*chip->data_iface = *conf;

Maybe we can just switch the pointers here instead of copying its
content.
This would require turning the chip->data_iface into const, or passing
non-const parameter to nand_setup_data_interface(), but I don't see any
good reason to do this extra copy.

> +
> +	return 0;
> +}
> +

Thanks,

Boris
