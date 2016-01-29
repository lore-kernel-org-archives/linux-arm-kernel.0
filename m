From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 29 Jan 2016 09:30:41 +0100 (CET)
Subject: [PATCH v2] irqchip: gicv3-its: Fix memory leak in
 its_free_tables()
In-Reply-To: <1454042578-13933-1-git-send-email-shankerd@codeaurora.org>
References: <1454042578-13933-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <alpine.DEB.2.11.1601290930000.3886@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Jan 2016, Shanker Donthineni wrote:
> @@ -807,9 +810,10 @@ static void its_free_tables(struct its_node *its)
>  	int i;
>  
>  	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
> -		if (its->tables[i]) {
> -			free_page((unsigned long)its->tables[i]);
> -			its->tables[i] = NULL;
> +		if (its->tables[i].base) {
> +			free_pages((unsigned long)its->tables[i].base,
> +				   get_order(its->tables[i].size));
> +			its->tables[i].base = NULL;
>  		}
>  	}
>  }
> @@ -880,6 +884,7 @@ retry_alloc_baser:
>  		if (alloc_pages > GITS_BASER_PAGES_MAX) {
>  			alloc_pages = GITS_BASER_PAGES_MAX;
>  			order = get_order(GITS_BASER_PAGES_MAX * psz);
> +			alloc_size = (1 << order) * PAGE_SIZE;

Why don't you record the order instead of converting back and forth ?

Thanks,

	tglx
