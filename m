From: vbabka@suse.cz (Vlastimil Babka)
Date: Tue, 29 Nov 2016 11:50:37 +0100
Subject: [PATCH V2 fix 5/6] mm: hugetlb: add a new function to allocate a
 new gigantic page
In-Reply-To: <20161129090322.GB16569@sha-win-210.asiapac.arm.com>
References: <1479107259-2011-6-git-send-email-shijie.huang@arm.com>
 <1479279304-31379-1-git-send-email-shijie.huang@arm.com>
 <f6fc93b4-5c1c-bbab-7c74-a0d60d4afc84@suse.cz>
 <20161129090322.GB16569@sha-win-210.asiapac.arm.com>
Message-ID: <777f7e0c-c04b-77c3-b866-0787bad32aa8@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2016 10:03 AM, Huang Shijie wrote:
> On Mon, Nov 28, 2016 at 03:17:28PM +0100, Vlastimil Babka wrote:
>> On 11/16/2016 07:55 AM, Huang Shijie wrote:
>> > +static struct page *__hugetlb_alloc_gigantic_page(struct hstate *h,
>> > +		struct vm_area_struct *vma, unsigned long addr, int nid)
>> > +{
>> > +	NODEMASK_ALLOC(nodemask_t, nodes_allowed, GFP_KERNEL | __GFP_NORETRY);
>>
>> What if the allocation fails and nodes_allowed is NULL?
>> It might work fine now, but it's rather fragile, so I'd rather see an
> Yes.
>
>> explicit check.
> See the comment below.
>
>>
>> BTW same thing applies to __nr_hugepages_store_common().
>>
>> > +	struct page *page = NULL;
>> > +
>> > +	/* Not NUMA */
>> > +	if (!IS_ENABLED(CONFIG_NUMA)) {
>> > +		if (nid == NUMA_NO_NODE)
>> > +			nid = numa_mem_id();
>> > +
>> > +		page = alloc_gigantic_page(nid, huge_page_order(h));
>> > +		if (page)
>> > +			prep_compound_gigantic_page(page, huge_page_order(h));
>> > +
>> > +		NODEMASK_FREE(nodes_allowed);
>> > +		return page;
>> > +	}
>> > +
>> > +	/* NUMA && !vma */
>> > +	if (!vma) {
>> > +		if (nid == NUMA_NO_NODE) {
>> > +			if (!init_nodemask_of_mempolicy(nodes_allowed)) {
>> > +				NODEMASK_FREE(nodes_allowed);
>> > +				nodes_allowed = &node_states[N_MEMORY];
>> > +			}
>> > +		} else if (nodes_allowed) {
> The check is here.

It's below a possible usage of nodes_allowed as an argument of 
init_nodemask_of_mempolicy(mask). Which does

         if (!(mask && current->mempolicy))
                 return false;

which itself looks like an error at first sight :)

> Do we really need to re-arrange the code here for the explicit check? :)

We don't need it *now* to be correct, but I still find it fragile. Also it
mixes up the semantic of NULL as a conscious "default" value, and NULL as
a side-effect of memory allocation failure. Nothing good can come from that in 
the long term :)

> Thanks
> Huang Shijie
>> > +			init_nodemask_of_node(nodes_allowed, nid);
>> > +		} else {
>> > +			nodes_allowed = &node_states[N_MEMORY];
>> > +		}
>> > +
>> > +		page = alloc_fresh_gigantic_page(h, nodes_allowed, true);
>> > +
>
