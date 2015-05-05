From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 5 May 2015 17:00:43 +0200
Subject: [PATCH v6 15/25] iommu: exynos: document internal structures
In-Reply-To: <1430727380-10912-16-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
 <1430727380-10912-16-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20150505150043.GM15736@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 04, 2015 at 10:16:10AM +0200, Marek Szyprowski wrote:
>  struct exynos_iommu_domain {
> -	struct list_head clients; /* list of sysmmu_drvdata.node */
> +	struct list_head clients; /* list of sysmmu_drvdata.domain_node */
>  	sysmmu_pte_t *pgtable; /* lv1 page table, 16KB */
>  	short *lv2entcnt; /* free lv2 entry counter for each section */
> -	spinlock_t lock; /* lock for this structure */
> +	spinlock_t lock; /* lock for modyfying list of clients */
>  	spinlock_t pgtablelock; /* lock for modifying page table @ pgtable */
>  	struct iommu_domain domain; /* generic domain data structure */
>  };
>  
> +/*
> + * This structure hold all data of a single SYSMMU controller, this includes
> + * hw resources like registers and clocks, pointers and list nodes to connect
> + * it to all other structures, internal state and parameters read from device
> + * tree. It is usually referenced by 'data' pointer.
> + */
>  struct sysmmu_drvdata {
> -	struct device *sysmmu;	/* System MMU's device descriptor */
> -	struct device *master;	/* Owner of system MMU */
> -	void __iomem *sfrbase;
> -	struct clk *clk;
> -	struct clk *clk_master;
> -	int activations;
> -	spinlock_t lock;
> -	struct exynos_iommu_domain *domain;
> -	struct list_head domain_node;
> -	struct list_head owner_node;
> -	phys_addr_t pgtable;
> -	int version;
> +	struct device *sysmmu; /* SYSMMU controller device */
> +	struct device *master; /* master device (owner of given SYSMMU) */
> +	void __iomem *sfrbase; /* our registers */
> +	struct clk *clk; /* SYSMMU's clock */
> +	struct clk *clk_master; /* master's device clock */
> +	int activations; /* number of calls to sysmmu_enable */
> +	spinlock_t lock; /* lock for modyfying enable/disable state */
> +	struct exynos_iommu_domain *domain; /* domain we belong to */
> +	struct list_head domain_node; /* node for domain clients list */
> +	struct list_head owner_node; /* node for owner clients list */
> +	phys_addr_t pgtable; /* assigned page table structure */
> +	int version; /* our version */
>  };

Please align the comments for the struct members to the same column for
better readability.
