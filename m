From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 30 Oct 2017 15:44:03 -0600
Subject: [PATCH 03/17] coresight: Add helper for inserting
 synchronization packets
In-Reply-To: <20171019171553.24056-4-suzuki.poulose@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-4-suzuki.poulose@arm.com>
Message-ID: <20171030214403.GA25098@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 06:15:39PM +0100, Suzuki K Poulose wrote:
> Right now we open code filling the trace buffer with synchronization
> packets when the circular buffer wraps around in different drivers.
> Move this to a common place.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c   | 10 +++------
>  drivers/hwtracing/coresight/coresight-priv.h    |  8 ++++++++
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 27 ++++++++-----------------
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 13 +-----------
>  4 files changed, 20 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 56ecd7aff5eb..d7164ab8e229 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -203,7 +203,6 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
>  	bool lost = false;
>  	int i;
>  	u8 *buf_ptr;
> -	const u32 *barrier;
>  	u32 read_data, depth;
>  	u32 read_ptr, write_ptr;
>  	u32 frame_off, frame_endoff;
> @@ -234,19 +233,16 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
>  
>  	depth = drvdata->buffer_depth;
>  	buf_ptr = drvdata->buf;
> -	barrier = barrier_pkt;
>  	for (i = 0; i < depth; i++) {
>  		read_data = readl_relaxed(drvdata->base +
>  					  ETB_RAM_READ_DATA_REG);
> -		if (lost && *barrier) {
> -			read_data = *barrier;
> -			barrier++;
> -		}
> -
>  		*(u32 *)buf_ptr = read_data;
>  		buf_ptr += 4;
>  	}
>  
> +	if (lost)
> +		coresight_insert_barrier_packet(drvdata->buf);
> +
>  	if (frame_off) {
>  		buf_ptr -= (frame_endoff * 4);
>  		for (i = 0; i < frame_endoff; i++) {
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index f1d0e21d8cab..d12f64928c00 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -65,6 +65,7 @@ static DEVICE_ATTR_RO(name)
>  	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
>  
>  extern const u32 barrier_pkt[5];
> +#define CORESIGHT_BARRIER_PKT_SIZE (sizeof(barrier_pkt) - sizeof(u32))

When using a memcpy() there is no need to have a 0x0 at the end of the
barrier_pkt array.  A such I suggest you remove that and simply use sizeof()
in coresight_insert_barrier_packet().

I'll review the rest of your patches tomorrow.

>  
>  enum etm_addr_type {
>  	ETM_ADDR_TYPE_NONE,
> @@ -98,6 +99,13 @@ struct cs_buffers {
>  	void			**data_pages;
>  };
>  
> +static inline void coresight_insert_barrier_packet(void *buf)
> +{
> +	if (buf)
> +		memcpy(buf, barrier_pkt, CORESIGHT_BARRIER_PKT_SIZE);
> +}
> +
> +
>  static inline void CS_LOCK(void __iomem *addr)
>  {
>  	do {
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 0b6f1eb746de..d89bfb3042a2 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -43,39 +43,28 @@ static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>  
>  static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
>  {
> -	bool lost = false;
>  	char *bufp;
> -	const u32 *barrier;
> -	u32 read_data, status;
> +	u32 read_data, lost;
>  	int i;
>  
> -	/*
> -	 * Get a hold of the status register and see if a wrap around
> -	 * has occurred.
> -	 */
> -	status = readl_relaxed(drvdata->base + TMC_STS);
> -	if (status & TMC_STS_FULL)
> -		lost = true;
> -
> +	/* Check if the buffer was wrapped around. */
> +	lost = readl_relaxed(drvdata->base + TMC_STS) & TMC_STS_FULL;
>  	bufp = drvdata->buf;
>  	drvdata->len = 0;
> -	barrier = barrier_pkt;
>  	while (1) {
>  		for (i = 0; i < drvdata->memwidth; i++) {
>  			read_data = readl_relaxed(drvdata->base + TMC_RRD);
>  			if (read_data == 0xFFFFFFFF)
> -				return;
> -
> -			if (lost && *barrier) {
> -				read_data = *barrier;
> -				barrier++;
> -			}
> -
> +				goto done;
>  			memcpy(bufp, &read_data, 4);
>  			bufp += 4;
>  			drvdata->len += 4;
>  		}
>  	}
> +done:
> +	if (lost)
> +		coresight_insert_barrier_packet(drvdata->buf);
> +	return;
>  }
>  
>  static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 063f253f1c99..41535fa6b6cf 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -104,9 +104,7 @@ ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
>  
>  static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
>  {
> -	const u32 *barrier;
>  	u32 val;
> -	u32 *temp;
>  	u64 rwp;
>  
>  	rwp = tmc_read_rwp(drvdata);
> @@ -119,16 +117,7 @@ static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
>  	if (val & TMC_STS_FULL) {
>  		drvdata->buf = drvdata->vaddr + rwp - drvdata->paddr;
>  		drvdata->len = drvdata->size;
> -
> -		barrier = barrier_pkt;
> -		temp = (u32 *)drvdata->buf;
> -
> -		while (*barrier) {
> -			*temp = *barrier;
> -			temp++;
> -			barrier++;
> -		}
> -
> +		coresight_insert_barrier_packet(drvdata->buf);
>  	} else {
>  		drvdata->buf = drvdata->vaddr;
>  		drvdata->len = rwp - drvdata->paddr;
> -- 
> 2.13.6
> 
