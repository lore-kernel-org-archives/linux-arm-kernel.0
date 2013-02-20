From: ric.masonn@gmail.com (Ric Mason)
Date: Wed, 20 Feb 2013 08:40:06 +0800
Subject: Should a swapped out page be deleted from swap cache?
In-Reply-To: <alpine.LNX.2.00.1302191050330.2248@eggly.anvils>
References: <CAFNq8R4UYvygk8+X+NZgyGjgU5vBsEv1UM6MiUxah6iW8=0HrQ@mail.gmail.com>
 <alpine.LNX.2.00.1302180939200.2246@eggly.anvils>
 <512338A6.1030602@gmail.com>
 <alpine.LNX.2.00.1302191050330.2248@eggly.anvils>
Message-ID: <51241B66.7080004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Hugh,

On 02/20/2013 02:56 AM, Hugh Dickins wrote:
> On Tue, 19 Feb 2013, Ric Mason wrote:
>> There is a call of try_to_free_swap in function swap_writepage, if
>> swap_writepage is call from shrink_page_list path, PageSwapCache(page) ==
>> trure, PageWriteback(page) maybe false, page_swapcount(page) == 0, then will
>> delete the page from swap cache and free swap slot, where I miss?
> That's correct.  PageWriteback is sure to be false there.  page_swapcount
> usually won't be 0 there, but sometimes it will be, and in that case we
> do want to delete from swap cache and free the swap slot.

1) If PageSwapCache(page)  == true, PageWriteback(page) == false, 
page_swapcount(page) == 0  in swap_writepage(shrink_page_list path), 
then will delete the page from swap cache and free swap slot, in 
function swap_writepage:

if (try_to_free_swap(page)) {
     unlock_page(page);
     goto out;
}
writeback will not execute, that's wrong. Where I miss?

2) In the function pageout, page will be set PG_Reclaim flag, since this 
flag is set, end_swap_bio_write->end_page_writeback:
if (TestClearPageReclaim(page))
      rotate_reclaimable_page(page);
it means that page will be add to the tail of lru list, page is clean 
anonymous page this time and will be reclaim to buddy system soon, correct?
If is correct, what is the meaning of rotate here?

>
> Hugh
