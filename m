From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 5 May 2015 16:52:35 +0200
Subject: [PATCH v6 08/25] iommu: exynos: refactor function parameters to
 simplify code
In-Reply-To: <1430727380-10912-9-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
 <1430727380-10912-9-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20150505145235.GJ15736@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 04, 2015 at 10:16:03AM +0200, Marek Szyprowski wrote:
> @@ -719,14 +712,12 @@ static void exynos_iommu_domain_free(struct iommu_domain *domain)
>  
>  	spin_lock_irqsave(&priv->lock, flags);
>  
> -	list_for_each_entry(owner, &priv->clients, client) {
> -		while (!exynos_sysmmu_disable(owner->dev))
> -			; /* until System MMU is actually disabled */
> +	list_for_each_entry(data, &priv->clients, domain_node) {
> +		if (__sysmmu_disable(data))
> +			data->master = NULL;
> +		list_del_init(&data->domain_node);
>  	}

This needs list_for_each_entry_safe.
