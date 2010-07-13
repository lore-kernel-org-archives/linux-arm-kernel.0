From: mel@csn.ul.ie (Mel Gorman)
Date: Tue, 13 Jul 2010 10:28:52 +0100
Subject: About SECTION_SIZE_BITS for Sparsemem
In-Reply-To: <20100713120315.c6c418f4.kamezawa.hiroyu@jp.fujitsu.com>
References: <000601cb219c$c7830b60$56892220$%kim@samsung.com>
	<AANLkTinTrt7VKuKvleiJj4lv2tWqCcDYHVXAQIHLA7bh@mail.gmail.com>
	<001b01cb21aa$ef0e4d80$cd2ae880$%kim@samsung.com>
	<AANLkTinkujX3VbL0sXjjghovr8eX9Os0huw3OTBut2UP@mail.gmail.com>
	<20100713092522.6d9939ac.kamezawa.hiroyu@jp.fujitsu.com>
	<AANLkTimHNBUo30sp1azUcWQiDpADGyEW_N-dwU0nJy9u@mail.gmail.com>
	<20100713120315.c6c418f4.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <20100713092852.GC29885@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 12:03:15PM +0900, KAMEZAWA Hiroyuki wrote:
> On Tue, 13 Jul 2010 11:05:26 +0900
> Minchan Kim <minchan.kim@gmail.com> wrote:
> 
> > On Tue, Jul 13, 2010 at 9:25 AM, KAMEZAWA Hiroyuki
> > <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 
> > > For example, prepare a page filled with (1 << PG_reserved).
> > > and replace it with unnecessary memmap rather than freeing a page for memmap.
> > 
> > Hmm. I don't got your point.
> > The problem is that we access struct page by pfn number not address.
> > 
> > You mean let's remain memmap on hole with changing PageReseved instead of free?
> > 
> Like a ZERO_PAGE, preparing RESERVED_PAGE, 
> which is filled with (1 << PG_reserved) as
> 
>   0x00000400,0x00000400,0x00000400,0x00000400
>   .....
> 
> And map this pages to every hole. Then, you only waste a page to fill all holes
> because "struct page" is aligned to 4bytes.
> 

I like this idea. It would allow memmap_valid_within to be thrown away
altogether and it maintains the assumptions of the memory model and
sounds "cheap".

> 
> > I think it's not a good idea to add new flag. If
> > Kame. Could you review my RFC patch which makes pfn_valid check more
> > tightly on sparsemem?
> Sure.
> 
> Thanks,
> -Kame
> 

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
