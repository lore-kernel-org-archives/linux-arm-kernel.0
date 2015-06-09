From: vbabka@suse.cz (Vlastimil Babka)
Date: Tue, 09 Jun 2015 18:14:25 +0200
Subject: [PATCH V3] mm:add VM_BUG_ON_PAGE() for page_mapcount()
In-Reply-To: <35FD53F367049845BC99AC72306C23D103E688B313FA@CNBJMBX05.corpusers.net>
References: <010b01d012ca$05244060$0f6cc120$@alibaba-inc.com>
 <35FD53F367049845BC99AC72306C23D103E688B313F9@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E688B313FA@CNBJMBX05.corpusers.net>
Message-ID: <557710E1.6060103@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2014 10:59 AM, Wang, Yalin wrote:
> This patch add VM_BUG_ON_PAGE() for slab page,
> because _mapcount is an union with slab struct in struct page,
> avoid access _mapcount if this page is a slab page.
> Also remove the unneeded bracket.
>
> Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
> ---
>   include/linux/mm.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b464611..a117527 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -449,7 +449,8 @@ static inline void page_mapcount_reset(struct page *page)
>
>   static inline int page_mapcount(struct page *page)
>   {
> -	return atomic_read(&(page)->_mapcount) + 1;
> +	VM_BUG_ON_PAGE(PageSlab(page), page);
> +	return atomic_read(&page->_mapcount) + 1;
>   }
>

I think this might theoretically trigger on the following code in 
compaction's isolate_migratepages_block():

/*
   * Migration will fail if an anonymous page is pinned in memory,
   * so avoid taking lru_lock and isolating it unnecessarily in an
   * admittedly racy check.
   */
if (!page_mapping(page) &&
     page_count(page) > page_mapcount(page))
	continue;

This is done after PageLRU() was positive, but the lru_lock might be not 
taken yet. So, there's some time window during which the page might have 
been reclaimed from LRU and become a PageSlab(page). !page_mapping(page) 
will be true in that case so it will proceed with page_mapcount(page) 
test and trigger the VM_BUG_ON.

(That test was added by DavidR year ago in commit 
119d6d59dcc0980dcd581fdadb6b2033b512a473)

Vlastimil





>   static inline int page_count(struct page *page)
>
