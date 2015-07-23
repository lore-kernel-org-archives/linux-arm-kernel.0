From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 23 Jul 2015 18:18:08 +0100
Subject: [PATCH v2 06/20] block/xen-blkfront: Store a page rather a pfn
 in the grant structure
In-Reply-To: <alpine.DEB.2.02.1507161610570.17378@kaball.uk.xensource.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-7-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1507161610570.17378@kaball.uk.xensource.com>
Message-ID: <55B121D0.8070507@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 16/07/15 16:11, Stefano Stabellini wrote:
> On Thu, 9 Jul 2015, Julien Grall wrote:
>> All the usage of the field pfn are done using the same idiom:
>>
>> pfn_to_page(grant->pfn)
>>
>> This will  return always the same page. Store directly the page in the
>> grant to clean up the code.
>>
>> Signed-off-by: Julien Grall <julien.grall@citrix.com>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Roger Pau Monn? <roger.pau@citrix.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: David Vrabel <david.vrabel@citrix.com>
>> ---
>>     Changes in v2:
>>         - Patch added
>> ---
>>  drivers/block/xen-blkfront.c | 37 ++++++++++++++++++-------------------
>>  1 file changed, 18 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
>> index 7107d58..7b81d23 100644
>> --- a/drivers/block/xen-blkfront.c
>> +++ b/drivers/block/xen-blkfront.c
>> @@ -67,7 +67,7 @@ enum blkif_state {
>>  
>>  struct grant {
>>  	grant_ref_t gref;
>> -	unsigned long pfn;
>> +	struct page *page;
>>  	struct list_head node;
>>  };
>>  
>> @@ -219,7 +219,7 @@ static int fill_grant_buffer(struct blkfront_info *info, int num)
>>  				kfree(gnt_list_entry);
>>  				goto out_of_memory;
>>  			}
>> -			gnt_list_entry->pfn = page_to_pfn(granted_page);
>> +			gnt_list_entry->page = granted_page;
>>  		}
>>  
>>  		gnt_list_entry->gref = GRANT_INVALID_REF;
>> @@ -234,7 +234,7 @@ out_of_memory:
>>  	                         &info->grants, node) {
>>  		list_del(&gnt_list_entry->node);
>>  		if (info->feature_persistent)
>> -			__free_page(pfn_to_page(gnt_list_entry->pfn));
>> +			__free_page(gnt_list_entry->page);
>>  		kfree(gnt_list_entry);
>>  		i--;
>>  	}
>> @@ -243,7 +243,7 @@ out_of_memory:
>>  }
>>  
>>  static struct grant *get_grant(grant_ref_t *gref_head,
>> -                               unsigned long pfn,
>> +			       struct page *page,
>>                                 struct blkfront_info *info)
> 
> indentation

The indentation of the parameters wasn't valid. I will indent correctly
"struct blkfront_info *info" rather than to use invalid indent.


> Aside from this:
> 
> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Thank you,

Regards,

-- 
Julien Grall
