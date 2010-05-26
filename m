From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 May 2010 19:28:10 +0100
Subject: [PATCH 0/4] Patches for -next
In-Reply-To: <1274879195.6879.15.camel@e102109-lin.cambridge.arm.com>
References: <1274706410.4720.34.camel@e102109-lin.cambridge.arm.com>
	<1274879195.6879.15.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100526182810.GB6232@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 02:06:35PM +0100, Catalin Marinas wrote:
> +#ifdef CONFIG_SMP
> +void __sync_icache_dcache(pte_t pteval)
> +{
> +	struct page *page = pte_page(pteval);
> +	struct address_space *mapping = page_mapping(page);

Err. no.  You're assuming that the physical page associated with the
PTE always has a struct page.  What if it's a device mapping?  What
if it's a mapping for some memory which isn't being handled by the
kernel?

You want this to be:

	unsigned long pfn = pte_pfn(pteval);

	if (pfn_valid(pfn)) {
		struct page *page = pfn_to_page(pfn);
		struct address_space *mapping = page_mapping(page);
