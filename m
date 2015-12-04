From: james.morse@arm.com (James Morse)
Date: Fri, 04 Dec 2015 16:26:41 +0000
Subject: [PATCH v3 09/10] PM / Hibernate: Publish pages restored in-place
 to arch code
In-Reply-To: <20151203120925.GA2220@red-moon>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
 <1448559168-8363-10-git-send-email-james.morse@arm.com>
 <20151203120925.GA2220@red-moon>
Message-ID: <5661BEC1.5040400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 03/12/15 12:09, Lorenzo Pieralisi wrote:
> On Thu, Nov 26, 2015 at 05:32:47PM +0000, James Morse wrote:
>> @@ -2427,25 +2434,31 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
>>  	if (PageHighMem(page))
>>  		return get_highmem_page_buffer(page, ca);
> 
> I know it is not a problem for arm64, but you should export the
> "restored" highmem pages list too because arch code may need to use
> it for the same reasons this patch was implemented.

I'm not sure it can be for the same reasons:
kernel/power/snapshot.c:swap_two_pages_data() does the copy for highmem
pages, and then kunmap-s them... if the page is to be used for
execution, it needs to be re-mapped first, possibly at a different address.
The place to do cache maintenance is in the kunmap/kmap calls.


Thanks,

James
