From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 14 Aug 2015 21:50:17 -0700
Subject: [PATCH] soc: qcom: smem: Fix errant private access
In-Reply-To: <1439610990-8427-1-git-send-email-agross@codeaurora.org>
References: <1439610990-8427-1-git-send-email-agross@codeaurora.org>
Message-ID: <20150815045017.GK13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 14 Aug 20:56 PDT 2015, Andy Gross wrote:

> This patch corrects private partition item access.  Instead of falling back to
> global for instances where we have an actual host and remote partition existing,
> return the results of the private lookup.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---
>  drivers/soc/qcom/smem.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 7c2c324c..6603201d 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -484,8 +484,9 @@ int qcom_smem_get(unsigned host, unsigned item, void **ptr, size_t *size)
>  	if (ret)
>  		return ret;
>  
> -	ret = qcom_smem_get_private(__smem, host, item, ptr, size);
> -	if (ret == -ENOENT)
> +	if (host < SMEM_HOST_COUNT && __smem->partitions[host])
> +		ret = qcom_smem_get_private(__smem, host, item, ptr, size);
> +	else
>  		ret = qcom_smem_get_global(__smem, item, ptr, size);

Looks good, but you can drop the if statement in the beginning of the
qcom_smem_get_private() now.

Can you please also do the same change in the alloc path, to keep them
consistent?

Regards,
Bjorn
