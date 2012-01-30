From: mel@csn.ul.ie (Mel Gorman)
Date: Mon, 30 Jan 2012 11:24:28 +0000
Subject: [PATCH 03/15] mm: compaction: introduce
 isolate_migratepages_range().
In-Reply-To: <1327568457-27734-4-git-send-email-m.szyprowski@samsung.com>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <1327568457-27734-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120130112428.GF25268@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 10:00:45AM +0100, Marek Szyprowski wrote:
> From: Michal Nazarewicz <mina86@mina86.com>
> 
> This commit introduces isolate_migratepages_range() function which
> extracts functionality from isolate_migratepages() so that it can be
> used on arbitrary PFN ranges.
> 
> isolate_migratepages() function is implemented as a simple wrapper
> around isolate_migratepages_range().
> 
> Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Super, this is much easier to read. I have just one nit below but once
that is fixed;

Acked-by: Mel Gorman <mel@csn.ul.ie>

> @@ -313,7 +316,7 @@ static isolate_migrate_t isolate_migratepages(struct zone *zone,
>  		} else if (!locked)
>  			spin_lock_irq(&zone->lru_lock);
>  
> -		if (!pfn_valid_within(low_pfn))
> +		if (!pfn_valid(low_pfn))
>  			continue;
>  		nr_scanned++;
>  

This chunk looks unrelated to the rest of the patch.

I think what you are doing is patching around a bug that CMA exposed
which is very similar to the bug report at
http://www.spinics.net/lists/linux-mm/msg29260.html . Is this true?

If so, I posted a fix that only calls pfn_valid() when necessary. Can
you check if that works for you and if so, drop this hunk please? If
the patch does not work for you, then this hunk still needs to be
in a separate patch and handled separately as it would also be a fix
for -stable.

-- 
Mel Gorman
SUSE Labs
