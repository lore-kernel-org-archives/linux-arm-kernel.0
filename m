From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Wed, 29 Nov 2017 14:15:58 +0800
Subject: [RFCv2 PATCH 09/36] iommu/fault: Allow blocking fault handlers
In-Reply-To: <20171006133203.22803-10-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-10-jean-philippe.brucker@arm.com>
Message-ID: <7e1c8ea4-e568-1000-17de-62f8562c7169@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
> -	if (domain->ext_handler) {
> +	if (domain->handler_flags & IOMMU_FAULT_HANDLER_ATOMIC) {
> +		fault->flags |= IOMMU_FAULT_ATOMIC;

Why remove the condition of domain->ext_handler? should it be much better like:
  if ((domain->handler_flags & IOMMU_FAULT_HANDLER_ATOMIC) && domain->ext_handler)

If domain->ext_handler is NULL, and (domain->handler_flags & IOMMU_FAULT_HANDLER_ATOMIC)
is true. It will oops, right?

>  		ret = domain->ext_handler(domain, dev, fault,
>  					  domain->handler_token);

Thanks
Yisheng Xie
