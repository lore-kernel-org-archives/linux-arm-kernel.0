From: hughd@google.com (Hugh Dickins)
Date: Tue, 19 Feb 2013 10:56:27 -0800 (PST)
Subject: Should a swapped out page be deleted from swap cache?
In-Reply-To: <512338A6.1030602@gmail.com>
References: <CAFNq8R4UYvygk8+X+NZgyGjgU5vBsEv1UM6MiUxah6iW8=0HrQ@mail.gmail.com>
 <alpine.LNX.2.00.1302180939200.2246@eggly.anvils>
 <512338A6.1030602@gmail.com>
Message-ID: <alpine.LNX.2.00.1302191050330.2248@eggly.anvils>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Feb 2013, Ric Mason wrote:
> 
> There is a call of try_to_free_swap in function swap_writepage, if
> swap_writepage is call from shrink_page_list path, PageSwapCache(page) ==
> trure, PageWriteback(page) maybe false, page_swapcount(page) == 0, then will
> delete the page from swap cache and free swap slot, where I miss?

That's correct.  PageWriteback is sure to be false there.  page_swapcount
usually won't be 0 there, but sometimes it will be, and in that case we
do want to delete from swap cache and free the swap slot.

Hugh
