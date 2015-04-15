From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 15 Apr 2015 21:11:44 +0200
Subject: [PATCH v4 04/10] mtd: pxa3xx_nand: rework flash detection and
 timing setup
In-Reply-To: <1429118648-19416-5-git-send-email-antoine.tenart@free-electrons.com>
References: <1429118648-19416-1-git-send-email-antoine.tenart@free-electrons.com>
 <1429118648-19416-5-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <552EB7F0.2090106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.04.2015 19:24, Antoine Tenart wrote:
> Rework the pxa3xx_nand driver to allow using functions exported by the
> nand framework to detect the flash and to configure the timings.
>
> Because this driver supports some non-ONFI devices, we also keep the
> custom timing setup of this driver so these devices won't break.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
[...]

Antoine,

there are some issues with this patch.

> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index dc0edbc406bb..438770c56bd3 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -251,15 +251,14 @@ static struct pxa3xx_nand_timing timing[] = {
>   };
>
>   static struct pxa3xx_nand_flash builtin_flash_types[] = {
> -{ "DEFAULT FLASH",      0,   0, 2048,  8,  8,    0, &timing[0] },
> -{ "64MiB 16-bit",  0x46ec,  32,  512, 16, 16, 4096, &timing[1] },
> -{ "256MiB 8-bit",  0xdaec,  64, 2048,  8,  8, 2048, &timing[1] },
> -{ "4GiB 8-bit",    0xd7ec, 128, 4096,  8,  8, 8192, &timing[1] },
> -{ "128MiB 8-bit",  0xa12c,  64, 2048,  8,  8, 1024, &timing[2] },
> -{ "128MiB 16-bit", 0xb12c,  64, 2048, 16, 16, 1024, &timing[2] },
> -{ "512MiB 8-bit",  0xdc2c,  64, 2048,  8,  8, 4096, &timing[2] },
> -{ "512MiB 16-bit", 0xcc2c,  64, 2048, 16, 16, 4096, &timing[2] },
> -{ "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, 2048, &timing[3] },
> +	{ 0x46ec, 16, 16, &timing[1] },
> +	{ 0xdaec,  8,  8, &timing[1] },
> +	{ 0xd7ec,  8,  8, &timing[1] },
> +	{ 0xa12c,  8,  8, &timing[2] },
> +	{ 0xb12c, 16, 16, &timing[2] },
> +	{ 0xdc2c,  8,  8, &timing[2] },
> +	{ 0xcc2c, 16, 16, &timing[2] },
> +	{ 0xba20, 16, 16, &timing[3] },

How about we get rid of the driver specific timings completely
and pick up the best onfi timing match instead? The nand_ids table
allows for a default_onfi_timing parameter even if onfi itself is
not supported.

For generic flash, i.e. no specific entry in the nand_ids table,
we either choose onfi mode 0 (most conservative) or an even slower
one.

[...]
> +static void pxa3xx_nand_set_sdr_timing(struct pxa3xx_nand_host *host,
> +				       const struct nand_sdr_timings *t)
> +{
> +	struct pxa3xx_nand_info *info = host->info_data;
> +	unsigned long nand_clk = clk_get_rate(info->clk);
> +	uint32_t ndtr0, ndtr1;
> +
> +	u32 tCH_min = DIV_ROUND_UP(t->tCH_min, 1000);
> +	u32 tCS_min = DIV_ROUND_UP(t->tCS_min, 1000);
> +	u32 tWH_min = DIV_ROUND_UP(t->tWH_min, 1000);
> +	u32 tWP_min = DIV_ROUND_UP(t->tWP_min, 1000);

While tWH_min is the minimum hold time of WE_n and tWP_min
the minimum pulse width, the sum of the two rounded values
may well exceed the minimum WE_n cycle width tWC_min.

How about we do below instead?

u32 tWH_min = DIV_ROUND_UP(t->tWH_min, 1000);
u32 tWP_min = DIV_ROUND_UP(t->tWC_min - tWH_min, 1000);
(note the missing t-> in front of tWH_min)

> +	u32 tREH_min = DIV_ROUND_UP(t->tREH_min, 1000);
> +	u32 tRP_min = DIV_ROUND_UP(t->tRP_min, 1000);

Same applies to tRH and tRP.	

> +	u32 tRST_max = DIV_ROUND_UP_ULL(t->tRST_max, 1000);
> +	u32 tWHR_min = DIV_ROUND_UP(t->tWHR_min, 1000);
> +	u32 tAR_min = DIV_ROUND_UP(t->tAR_min, 1000);
> +
> +	ndtr0 = NDTR0_tCH(ns2cycle(tCH_min, nand_clk)) |
> +		NDTR0_tCS(ns2cycle(tCS_min, nand_clk)) |
> +		NDTR0_tWH(ns2cycle(tWH_min, nand_clk)) |
> +		NDTR0_tWP(ns2cycle(tWP_min, nand_clk)) |
> +		NDTR0_tRH(ns2cycle(tREH_min, nand_clk)) |
> +		NDTR0_tRP(ns2cycle(tRP_min, nand_clk));
> +
> +	ndtr1 = NDTR1_tR(ns2cycle(tRST_max, nand_clk)) |

Well, tRST (max reset duration) is not tR (max page read
time) but much higher. I see that the onfi timings do not
directly encode tR but have extra timings for tPROG, tBERS,
tR, and tCCS.

I guess we'll have to amend sdr_timings for non-onfi devices
then.

Also, if you check the armada370 functional spec, there is
several meanings for tR register. Currently, pxa3xx nfc driver
does not use WAIT_MODE which is supported for NFCv2 (non-pxa3xx
SoCs). That will allow the controller to use R/Bn signal instead.

Anyways, timing conversion is already tricky enough, let's start
with 1:1 conversion and add additional modes later.

> +		NDTR1_tWHR(ns2cycle(tWHR_min, nand_clk)) |
> +		NDTR1_tAR(ns2cycle(tAR_min, nand_clk));
> +
> +	info->ndtr0cs0 = ndtr0;
> +	info->ndtr1cs0 = ndtr1;
> +	nand_writel(info, NDTR0CS0, ndtr0);
> +	nand_writel(info, NDTR1CS0, ndtr1);
> +}
> +
> +static int pxa3xx_nand_init_timings(struct pxa3xx_nand_host *host)
> +{
> +	const struct nand_sdr_timings *timings;
> +	struct nand_chip *chip = &host->chip;
> +	struct pxa3xx_nand_info *info = host->info_data;
> +	const struct pxa3xx_nand_flash *f = NULL;
> +	int mode, id, ntypes, i;
> +
> +	mode = onfi_get_async_timing_mode(chip);
> +	if (mode == ONFI_TIMING_MODE_UNKNOWN) {
> +		ntypes = ARRAY_SIZE(builtin_flash_types);
> +
> +		chip->cmdfunc(host->mtd, NAND_CMD_READID, 0x00, -1);
> +
> +		id = chip->read_byte(host->mtd);
> +		id |= chip->read_byte(host->mtd) << 0x8;
> +
> +		for (i = 0; i < ntypes; i++) {
> +			f = &builtin_flash_types[i];
> +
> +			if (f->chip_id == id)
> +				break;
> +		}
> +
> +		if (i == ntypes) {
> +			dev_err(&info->pdev->dev, "Error: timings not found\n");
> +			return -EINVAL;
> +		}
> +
> +		pxa3xx_nand_set_timing(host, f->timing);
> +
> +		if (f->flash_width == 16) {
> +			info->reg_ndcr |= NDCR_DWIDTH_M;
> +			chip->options |= NAND_BUSWIDTH_16;
> +		}
> +
> +		info->reg_ndcr |= (f->dfc_width == 16) ? NDCR_DWIDTH_C : 0;
> +	} else {
> +		mode = fls(mode) - 1;
> +		if (mode < 0)
> +			mode = 0;

Is mode really a bitmap? If so, the name of onfi_get_async_timing_mode()
is _very_ misleading. I would expect it to return the highest supported
mode number instead of a bitmap of the supported modes.

I'll have a deeper look into the patches later.

Sebastian

> +		timings = onfi_async_timing_mode_to_sdr_timings(mode);
> +		if (IS_ERR(timings))
> +			return PTR_ERR(timings);
> +
> +		pxa3xx_nand_set_sdr_timing(host, timings);
> +	}
> +
> +	return 0;
> +}
