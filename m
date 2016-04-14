From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 14 Apr 2016 12:19:44 +0100
Subject: [PATCH V2 12/15] coresight: tmc: keep track of memory width
In-Reply-To: <1460483692-25061-13-git-send-email-mathieu.poirier@linaro.org>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-13-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <570F7CD0.30500@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/16 18:54, Mathieu Poirier wrote:
> Accessing the HW configuration register each time the memory
> width is needed simply doesn't make sense.  It is much more
> efficient to read the value once and keep a reference for
> later use.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 8 +++-----
>   drivers/hwtracing/coresight/coresight-tmc.c     | 1 +
>   drivers/hwtracing/coresight/coresight-tmc.h     | 2 ++
>   3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 50d32e8ef4ea..a440784e3b27 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -41,18 +41,16 @@ void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>
>   static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
>   {
> -	enum tmc_mem_intf_width memwidth;
>   	u8 memwords;
>   	char *bufp;
>   	u32 read_data;
>   	int i;
>
> -	memwidth = BMVAL(readl_relaxed(drvdata->base + CORESIGHT_DEVID), 8, 10);
> -	if (memwidth == TMC_MEM_INTF_WIDTH_32BITS)
> +	if (drvdata->memwidth == TMC_MEM_INTF_WIDTH_32BITS)
>   		memwords = 1;
> -	else if (memwidth == TMC_MEM_INTF_WIDTH_64BITS)
> +	else if (drvdata->memwidth == TMC_MEM_INTF_WIDTH_64BITS)
>   		memwords = 2;
> -	else if (memwidth == TMC_MEM_INTF_WIDTH_128BITS)
> +	else if (drvdata->memwidth == TMC_MEM_INTF_WIDTH_128BITS)
>   		memwords = 4;


>   struct tmc_drvdata {
> @@ -118,6 +119,7 @@ struct tmc_drvdata {
>   	u32			size;
>   	local_t			mode;
>   	enum tmc_config_type	config_type;
> +	enum tmc_mem_intf_width	memwidth;

Could we not store the converted memwords here, instead of the enum value here
and convert it every time we access it ?

Cheers
Suzuki
