From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Mon, 8 Dec 2014 13:50:32 +0200
Subject: [PATCH] mm:add VM_BUG_ON() for page_mapcount()
In-Reply-To: <35FD53F367049845BC99AC72306C23D103E688B313F5@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103E688B313EE@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E688B313F1@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E688B313F5@CNBJMBX05.corpusers.net>
Message-ID: <20141208115032.GB28846@node.dhcp.inet.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 03:47:47PM +0800, Wang, Yalin wrote:
> This patch add VM_BUG_ON() for slab page,
> because _mapcount is an union with slab struct in struct page,
> avoid access _mapcount if this page is a slab page.
> Also remove the unneeded bracket.
> 
> Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
> ---
>  include/linux/mm.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 11b65cf..34124c4 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -373,7 +373,8 @@ static inline void reset_page_mapcount(struct page *page)
>  
>  static inline int page_mapcount(struct page *page)
>  {
> -	return atomic_read(&(page)->_mapcount) + 1;
> +	VM_BUG_ON(PageSlab(page));

VM_BUG_ON_PAGE(), please.

-- 
 Kirill A. Shutemov
