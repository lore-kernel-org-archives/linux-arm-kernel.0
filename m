From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 Feb 2017 15:47:27 +0000
Subject: [PATCH v2] arm64: cache: Skip an unnecessary data cache clean
 PoU operation
In-Reply-To: <1486588777-1929-1-git-send-email-shankerd@codeaurora.org>
References: <1486588777-1929-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <20170221154726.7zahvbeftxobiula@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 03:19:37PM -0600, Shanker Donthineni wrote:
> The cache management functions always do the data cache PoU
> (point of unification) operations even though it is not required
> on some systems. No need to clean data cache till PoU if all the
> cache levels below PoUIS are WT (Write-Through) caches. It causes
> a huge performance degradation when operating on a larger memory
> area, especially THP with 64K page size kernel.
> 
> For each online CPU, check the need of 'dc cvau' instruction and
> update a global variable __dcache_flags. The two functions
> __flush_cache_user_range() and __clean_dcache_area_pou() are
> modified to skip an unnecessary code execution based on flags.
> It won't change the existing behavior if any one of the online
> CPU is capable of WB cache below PoUIS level.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
[...]
> +#define CLIDR_LOUIS_SHIFT	(21)
> +#define CLIDR_LOUIS_MASK	(0x7)
> +#define CLIDR_LOUIS(x)		(((x) >> CLIDR_LOUIS_SHIFT) & CLIDR_LOUIS_MASK)

According to the ARMv8 ARM, CLIDR_EL1 "identifies the type of cache, or
caches, that are implemented at each level and can be managed using the
architected cache maintenance instructions that operate by set/way". The
key part is "set/way" here and hence you cannot use CLIDR_EL1 and
CCSIDR_EL1 to infer whether you can skip cache maintenance by VA.

> +	/* Go through all the cache level below LoUIS */
> +	for (lvl = 0; lvl < louis; lvl++) {
> +		csidr = cache_get_ccsidr(lvl << 1);
> +		if (csidr & CCSIDR_EL1_WRITE_BACK) {

The type bits have also been deprecated in ARMv8 (we need to update the
kernel or just remove the cache topology detection entirely, leaving it
just to DT).

-- 
Catalin
