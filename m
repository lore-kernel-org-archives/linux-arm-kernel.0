From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 23 Mar 2018 15:15:04 -0400
Subject: [PATCH v5 2/3] RDMA/i40iw: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521736009-23387-3-git-send-email-okaya@codeaurora.org>
References: <1521736009-23387-1-git-send-email-okaya@codeaurora.org>
 <1521736009-23387-3-git-send-email-okaya@codeaurora.org>
Message-ID: <352b0adc-5489-c919-fa0a-2a3a3b2d37a0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/22/2018 12:26 PM, Sinan Kaya wrote:
> +++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
> @@ -706,9 +706,11 @@ static void i40iw_sc_ccq_arm(struct i40iw_sc_cq *ccq)
>  	wmb();       /* make sure shadow area is updated before arming */
>  
>  	if (ccq->dev->is_pf)
> -		i40iw_wr32(ccq->dev->hw, I40E_PFPE_CQARM, ccq->cq_uk.cq_id);
> +		i40iw_wr32_relaxed(ccq->dev->hw, I40E_PFPE_CQARM,
> +				   ccq->cq_uk.cq_id);
>  	else
> -		i40iw_wr32(ccq->dev->hw, I40E_VFPE_CQARM1, ccq->cq_uk.cq_id);
> +		i40iw_wr32_relaxed(ccq->dev->hw, I40E_VFPE_CQARM1,
> +				   ccq->cq_uk.cq_id);

do we want an mmiowb() here?

>  }


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
