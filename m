From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 16 Jul 2015 16:54:25 +0200
Subject: [Xen-devel] [PATCH v2 02/20] xen: Introduce a function to split
 a Linux page into Xen page
In-Reply-To: <alpine.DEB.2.02.1507161520330.17378@kaball.uk.xensource.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-3-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1507161520330.17378@kaball.uk.xensource.com>
Message-ID: <55A7C5A1.7060006@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 16/07/2015 16:23, Stefano Stabellini wrote:
>> diff --git a/include/xen/page.h b/include/xen/page.h
>> index 8ebd37b..b1f7722 100644
>> --- a/include/xen/page.h
>> +++ b/include/xen/page.h
>> @@ -39,4 +39,24 @@ struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS];
>>
>>   extern unsigned long xen_released_pages;
>>
>> +typedef int (*xen_pfn_fn_t)(struct page *page, unsigned long pfn, void *data);
>> +/* Break down the page in 4KB granularity and call fn foreach xen pfn */
>> +static inline int xen_apply_to_page(struct page *page, xen_pfn_fn_t fn,
>> +				    void *data)
>> +{
>> +	unsigned long pfn = xen_page_to_pfn(page);
>> +	int i;
>> +	int ret;
>
> please initialize ret to 0

Hmmm... right. I'm not sure why the compiler didn't catch it.

>
>> +	for (i = 0; i < XEN_PFN_PER_PAGE; i++, pfn++) {
>> +		ret = fn(page, pfn, data);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +
>>   #endif	/* _XEN_PAGE_H */
>
>
> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Thank you,

-- 
Julien Grall
