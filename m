From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Jan 2018 17:41:45 +0000
Subject: [RFC 2/2] arm64: compat: cacheflush syscall: process only pages
 that are in the memory
In-Reply-To: <20180126111441.29353-2-m.szyprowski@samsung.com>
References: <20180126111441.29353-1-m.szyprowski@samsung.com>
 <CGME20180126111453eucas1p178663ac7b17d0c92cc889a42b3f5bcec@eucas1p1.samsung.com>
 <20180126111441.29353-2-m.szyprowski@samsung.com>
Message-ID: <20180126174145.6gtfjjoxb57d7qwt@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 12:14:41PM +0100, Marek Szyprowski wrote:
> @@ -32,23 +33,36 @@
>  static long
>  __do_compat_cache_op(unsigned long start, unsigned long end)
[...]
> +		if (follow_page(vma, start, 0)) {
> +			ret = __flush_cache_user_range(start, start + chunk);
> +			if (ret)
> +				goto done;
> +		}

This looks pretty expensive for pages already in memory. Could we do
some tricks with the AT instruction in __flush_cache_user_range() so
that we skip the flushing if the page isn't there? We know that when a
page is mapped, the cache will get cleaned/invalidated via set_pte_at()
+ sync_icache_dcache(), so the only problem of a race is flushing the
caches twice for a page. If a page gets unmapped after AT, we may bring
it back through the cache ops.

-- 
Catalin
