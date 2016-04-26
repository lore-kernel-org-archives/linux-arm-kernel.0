From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 25 Apr 2016 18:50:18 -0700
Subject: [Patch v2 4/8] firmware: qcom: scm: Add memory allocation API
In-Reply-To: <1461625725-32425-5-git-send-email-andy.gross@linaro.org>
References: <1461625725-32425-1-git-send-email-andy.gross@linaro.org>
 <1461625725-32425-5-git-send-email-andy.gross@linaro.org>
Message-ID: <20160426015018.GI29990@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25, Andy Gross wrote:
> This patch adds APIs for the scm-32 and scm-64 to use for coherent memory
> allocation.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  drivers/firmware/qcom_scm.c | 16 ++++++++++++++++
>  drivers/firmware/qcom_scm.h |  4 ++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index d4e9145..8f78938 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -20,6 +20,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/clk.h>
> +#include <linux/dma-mapping.h>
>  
>  #include "qcom_scm.h"
>  
> @@ -158,6 +159,21 @@ bool qcom_scm_is_available(void)
>  }
>  EXPORT_SYMBOL(qcom_scm_is_available);
>  
> +void *qcom_scm_alloc_buffer(size_t size, dma_addr_t *dma_addr,
> +				      gfp_t gfp)
> +{
> +	if (__scm)
> +		return dma_alloc_writecombine(__scm->dev, size, dma_addr, gfp);
> +	else
> +		return ERR_PTR(-ENODEV);

Any reason we can't use the streaming APIs? That's pretty much
how we were doing things before. This changes it to be a
different memory type buffer which may be slower to read/write to.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
