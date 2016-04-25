From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 25 Apr 2016 15:41:13 +0100
Subject: [PATCH V3 14/18] coresight: tmc: keep track of memory width
In-Reply-To: <1461345255-11758-15-git-send-email-mathieu.poirier@linaro.org>
References: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
 <1461345255-11758-15-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <571E2C89.7010003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/04/16 18:14, Mathieu Poirier wrote:
> Accessing the HW configuration register each time the memory
> width is needed simply doesn't make sense.  It is much more
> efficient to read the value once and keep a reference for
> later use.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 14 +---------
>   drivers/hwtracing/coresight/coresight-tmc.c     | 34 +++++++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tmc.h     | 10 +++++---
>   3 files changed, 41 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index cc88c15ba45c..981c5ca75e36 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -41,25 +41,13 @@ void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>
>   static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
>   {
> -	enum tmc_mem_intf_width memwidth;
> -	u8 memwords;
>   	char *bufp;
>   	u32 read_data;
>   	int i;
>
> -	memwidth = BMVAL(readl_relaxed(drvdata->base + CORESIGHT_DEVID), 8, 10);
> -	if (memwidth == TMC_MEM_INTF_WIDTH_32BITS)
> -		memwords = 1;
> -	else if (memwidth == TMC_MEM_INTF_WIDTH_64BITS)
> -		memwords = 2;
> -	else if (memwidth == TMC_MEM_INTF_WIDTH_128BITS)
> -		memwords = 4;
> -	else
> -		memwords = 8;
> -
>   	bufp = drvdata->buf;
>   	while (1) {
> -		for (i = 0; i < memwords; i++) {
> +		for (i = 0; i < drvdata->memwidth; i++) {
>   			read_data = readl_relaxed(drvdata->base + TMC_RRD);
>   			if (read_data == 0xFFFFFFFF)
>   				return;
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 55806352b1f1..cb030a09659d 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -193,6 +193,39 @@ static const struct file_operations tmc_fops = {
>   	.llseek		= no_llseek,
>   };
>
> +static enum tmc_mem_intf_width tmc_get_memwidth(u32 devid)
> +{
> +	enum tmc_mem_intf_width memwidth;
> +
> +	/*
> +	 * Excerpt from the TRM:
> +	 *
> +	 * DEVID::MEMWIDTH[10:8]
> +	 * 0x2 Memory interface databus is 32 bits wide.
> +	 * 0x3 Memory interface databus is 64 bits wide.
> +	 * 0x4 Memory interface databus is 128 bits wide.
> +	 * 0x5 Memory interface databus is 256 bits wide.
> +	 */
> +	switch (BMVAL(devid, 8, 10)) {
> +	case 0x2:
> +		memwidth = TMC_MEM_INTF_WIDTH_32BITS;
> +		break;
> +	case 0x3:
> +		memwidth = TMC_MEM_INTF_WIDTH_64BITS;
> +		break;
> +	case 0x4:
> +		memwidth = TMC_MEM_INTF_WIDTH_128BITS;
> +		break;
> +	case 0x5:
> +		memwidth = TMC_MEM_INTF_WIDTH_256BITS;
> +		break;
> +	default:
> +		memwidth = 0;
> +	}
> +
> +	return memwidth;
> +}
> +
>   #define coresight_tmc_simple_func(name, offset)			\
>   	coresight_simple_func(struct tmc_drvdata, name, offset)
>
> @@ -306,6 +339,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>
>   	devid = readl_relaxed(drvdata->base + CORESIGHT_DEVID);
>   	drvdata->config_type = BMVAL(devid, 6, 7);
> +	drvdata->memwidth = tmc_get_memwidth(devid);
>
>   	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
>   		if (np)
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 9b4c215d2b6b..12a097f3d06c 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -81,10 +81,10 @@ enum tmc_mode {
>   };
>
>   enum tmc_mem_intf_width {
> -	TMC_MEM_INTF_WIDTH_32BITS	= 0x2,
> -	TMC_MEM_INTF_WIDTH_64BITS	= 0x3,
> -	TMC_MEM_INTF_WIDTH_128BITS	= 0x4,
> -	TMC_MEM_INTF_WIDTH_256BITS	= 0x5,
> +	TMC_MEM_INTF_WIDTH_32BITS	= 1,
> +	TMC_MEM_INTF_WIDTH_64BITS	= 2,
> +	TMC_MEM_INTF_WIDTH_128BITS	= 4,
> +	TMC_MEM_INTF_WIDTH_256BITS	= 8,
>   };

I think this would cause confusion for the reader. It would be good to
leave the definitions above as before and tmc_get_memwidth() doing:

i.e,
	case TMC_MEM_INTF_WIDTH_32BITS:
		memwidth = 1;
		break;

But we still store the memwidth in bytes.

Suzuki
