From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Fri, 5 Dec 2014 13:05:32 +0200
Subject: [RFC V2] mm:add KPF_ZERO_PAGE flag for /proc/kpageflags
In-Reply-To: <35FD53F367049845BC99AC72306C23D103E688B313F1@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103E688B313EE@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E688B313F1@CNBJMBX05.corpusers.net>
Message-ID: <20141205110532.GA8782@node.dhcp.inet.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 06:21:17PM +0800, Wang, Yalin wrote:
> This patch add KPF_ZERO_PAGE flag for zero_page,
> so that userspace process can notice zero_page from
> /proc/kpageflags, and then do memory analysis more accurately.
> 
> Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
> ---
>  fs/proc/page.c                         | 14 +++++++++++---
>  include/linux/huge_mm.h                | 12 ++++++++++++
>  include/uapi/linux/kernel-page-flags.h |  1 +
>  mm/huge_memory.c                       |  7 +------
>  4 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 1e3187d..dbe5630 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -5,6 +5,7 @@
>  #include <linux/ksm.h>
>  #include <linux/mm.h>
>  #include <linux/mmzone.h>
> +#include <linux/huge_mm.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
>  #include <linux/hugetlb.h>
> @@ -121,9 +122,16 @@ u64 stable_page_flags(struct page *page)
>  	 * just checks PG_head/PG_tail, so we need to check PageLRU/PageAnon
>  	 * to make sure a given page is a thp, not a non-huge compound page.
>  	 */
> -	else if (PageTransCompound(page) && (PageLRU(compound_head(page)) ||
> -					     PageAnon(compound_head(page))))
> -		u |= 1 << KPF_THP;
> +	else if (PageTransCompound(page)) {
> +		struct page *head = compound_head(page);
> +
> +		if (PageLRU(head) || PageAnon(head))
> +			u |= 1 << KPF_THP;
> +		else if (is_huge_zero_page(head))
> +			u |= 1 << KPF_ZERO_PAGE;

IIUC, KPF_THP bit should be set for huge zero page too.

-- 
 Kirill A. Shutemov
