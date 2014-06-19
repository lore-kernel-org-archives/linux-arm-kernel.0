From: mina86@mina86.com (Michal Nazarewicz)
Date: Thu, 19 Jun 2014 21:24:04 +0200
Subject: [PATCH] arm64: fix MAX_ORDER for 64K pagesize
In-Reply-To: <1403201524.32688.62.camel@deneb.redhat.com>
References: <1402522435-13884-1-git-send-email-msalter@redhat.com>
 <alpine.DEB.2.02.1406111557030.27885@chino.kir.corp.google.com>
 <xa1t61jzwfo6.fsf@mina86.com> <1403201524.32688.62.camel@deneb.redhat.com>
Message-ID: <xa1tfvj01z57.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19 2014, Mark Salter <msalter@redhat.com> wrote:
> On Tue, 2014-06-17 at 20:32 +0200, Michal Nazarewicz wrote:
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 5dba293..6e657ce 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -801,7 +801,15 @@ void __init init_cma_reserved_pageblock(struct page *page)
>>  
>>  	set_page_refcounted(page);
>>  	set_pageblock_migratetype(page, MIGRATE_CMA);
>> -	__free_pages(page, pageblock_order);
>> +	if (pageblock_order > MAX_ORDER) {
>> +		struct page *subpage = p;
>> +		unsigned count = 1 << (pageblock_order - MAX_ORDER);
>> +		do {
>> +			__free_pages(subpage, pageblock_order);
>                                                ^^^^^^^
>                                                MAX_ORDER

D'oh!  I'll send a revised patch.

>> +		} while (subpage += MAX_ORDER_NR_PAGES, --count);
>> +	} else {
>> +		__free_pages(page, pageblock_order);
>> +	}
>>  	adjust_managed_page_count(page, pageblock_nr_pages);
>>  }
>>  #endif
>> --------- >8 ---------------------------------------------------------
>> 
>> Thoughts?  This has not been tested and I think it may cause performance
>> degradation in some cases since pageblock_order is not always
>> a constant, so the comparison may end up not being stripped away even on
>> systems where it's always false.

> This works with the above tweak. So it fixes the problm here, but I was
> not sure if we'd get bitten elsewhere by pageblock_order > MAX_ORDER.

This is always a possibility, but in such cases, it's a bug in CMA.
I've tried to keep in mind that pageblock_order may be greater than
MAX_ORDER when writing CMA, but I've never tested on such a system.

> It will be slower, but does it only gets called a few time at most at
> boot time, right?

Yes.  The performance degradation should be negligible since
init_cma_reserved is hardly a critical path and is called at most
MAX_CMA_AREAS times which by default is 8.  And I mean it will be slower
because it will have to perform a branch.


-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
