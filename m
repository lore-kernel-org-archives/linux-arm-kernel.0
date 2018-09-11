From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 11 Sep 2018 13:54:51 -0600
Subject: [PATCH v2 1/2] coresight: tmc: Fix byte-address alignment for RRP
In-Reply-To: <1536652366-17119-2-git-send-email-leo.yan@linaro.org>
References: <1536652366-17119-1-git-send-email-leo.yan@linaro.org>
 <1536652366-17119-2-git-send-email-leo.yan@linaro.org>
Message-ID: <20180911195451.GB17613@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 03:52:45PM +0800, Leo Yan wrote:
> From the comment in the code, it claims the requirement for byte-address
> alignment for RRP register: 'for 32-bit, 64-bit and 128-bit wide trace
> memory, the four LSBs must be 0s. For 256-bit wide trace memory, the
> five LSBs must be 0s'.  This isn't consistent with the program, the
> program sets five LSBs as zeros for 32/64/128-bit wide trace memory and
> set six LSBs zeros for 256-bit wide trace memory.
> 
> After checking with the CoreSight Trace Memory Controller technical
> reference manual (ARM DDI 0461B, section 3.3.4 RAM Read Pointer
> Register), it proves the comment is right and the program does wrong
> setting.
> 
> This patch fixes byte-address alignment for RRP by following correct
> definition in the technical reference manual.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 4bf3bfd..b54a3db 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -417,10 +417,10 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
>  		case TMC_MEM_INTF_WIDTH_32BITS:
>  		case TMC_MEM_INTF_WIDTH_64BITS:
>  		case TMC_MEM_INTF_WIDTH_128BITS:
> -			mask = GENMASK(31, 5);
> +			mask = GENMASK(31, 4);
>  			break;
>  		case TMC_MEM_INTF_WIDTH_256BITS:
> -			mask = GENMASK(31, 6);
> +			mask = GENMASK(31, 5);
>  			break;
>  		}
>  
> -- 
> 2.7.4
>

Applied.

Thanks,
Mathieu 
