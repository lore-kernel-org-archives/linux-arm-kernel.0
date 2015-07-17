From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 17 Jul 2015 15:32:46 +0100
Subject: [PATCH v2 12/20] xen/balloon: Don't rely on the page granularity
 is the same for Xen and Linux
In-Reply-To: <alpine.DEB.2.02.1507161819200.17378@kaball.uk.xensource.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-13-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1507161819200.17378@kaball.uk.xensource.com>
Message-ID: <55A9120E.4020302@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 17/07/15 15:03, Stefano Stabellini wrote:
>> ---
>>  drivers/xen/balloon.c | 147 +++++++++++++++++++++++++++++++++++---------------
>>  1 file changed, 105 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
>> index fd93369..19a72b1 100644
>> --- a/drivers/xen/balloon.c
>> +++ b/drivers/xen/balloon.c
>> @@ -230,6 +230,7 @@ static enum bp_state reserve_additional_memory(long credit)
>>  	nid = memory_add_physaddr_to_nid(hotplug_start_paddr);
>>  
>>  #ifdef CONFIG_XEN_HAVE_PVMMU
>> +	/* TODO */
> 
> I think you need to be more verbose than that: TODO what?

It was for me to remember fixing reserve_additional_memory. I did it and
forgot to remove the TODO when I clean up.

I will drop it in the next version.

[...]

>>  static enum bp_state increase_reservation(unsigned long nr_pages)
>>  {
>>  	int rc;
>> -	unsigned long  pfn, i;
>> +	unsigned long i, frame_idx;
>>  	struct page   *page;
>>  	struct xen_memory_reservation reservation = {
>>  		.address_bits = 0,
>> @@ -343,44 +406,43 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
>>  	}
>>  #endif
>>  
>> -	if (nr_pages > ARRAY_SIZE(frame_list))
>> -		nr_pages = ARRAY_SIZE(frame_list);
>> +	if (nr_pages > (ARRAY_SIZE(frame_list) / XEN_PFN_PER_PAGE))
>> +		nr_pages = ARRAY_SIZE(frame_list) / XEN_PFN_PER_PAGE;
>>  
>> +	frame_idx = 0;
>>  	page = list_first_entry_or_null(&ballooned_pages, struct page, lru);
>>  	for (i = 0; i < nr_pages; i++) {
>>  		if (!page) {
>>  			nr_pages = i;
>>  			break;
>>  		}
>> -		frame_list[i] = page_to_pfn(page);
>> +
>> +		rc = xen_apply_to_page(page, set_frame, &frame_idx);
>> +
>>  		page = balloon_next_page(page);
>>  	}
>>  
>>  	set_xen_guest_handle(reservation.extent_start, frame_list);
>> -	reservation.nr_extents = nr_pages;
>> +	reservation.nr_extents = nr_pages * XEN_PFN_PER_PAGE;
>>  	rc = HYPERVISOR_memory_op(XENMEM_populate_physmap, &reservation);
>>  	if (rc <= 0)
>>  		return BP_EAGAIN;
>>  
>> -	for (i = 0; i < rc; i++) {
>> +	/* rc is equal to the number of Xen page populated */
>> +	nr_pages = rc / XEN_PFN_PER_PAGE;
> 
> Here we are purposedly ignoring any spares (rc % XEN_PFN_PER_PAGE).
> Instead of leaking them, maybe we should givem them back to Xen since we
> cannot use them?

I will give a look to do it.

>> +	for (i = 0; i < nr_pages; i++) {
>>  		page = balloon_retrieve(false);
>>  		BUG_ON(page == NULL);
>>  
>> -		pfn = page_to_pfn(page);
>> -
>>  #ifdef CONFIG_XEN_HAVE_PVMMU
>> +		frame_idx = 0;
> 
> Shouldn't this be before the beginning of the loop above?

Hmmmm... Yes. Note that I only compiled tested on x86, it would be good
if someone test on real hardware at some point (I don't have any x86 Xen
setup).

Regards,

-- 
Julien Grall
