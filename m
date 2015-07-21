From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 21 Jul 2015 12:12:12 +0100
Subject: [Xen-devel] [PATCH v2 05/20] block/xen-blkfront: Split
 blkif_queue_request in 2
In-Reply-To: <55AE16EC.2020204@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-6-git-send-email-julien.grall@citrix.com>
 <55AE16EC.2020204@citrix.com>
Message-ID: <55AE290C.8010103@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On 21/07/15 10:54, Roger Pau Monn? wrote:
> El 09/07/15 a les 22.42, Julien Grall ha escrit:
>> Currently, blkif_queue_request has 2 distinct execution path:
>>     - Send a discard request
>>     - Send a read/write request
>>
>> The function is also allocating grants to use for generating the
>> request. Although, this is only used for read/write request.
>>
>> Rather than having a function with 2 distinct execution path, separate
>> the function in 2. This will also remove one level of tabulation.
>>
>> Signed-off-by: Julien Grall <julien.grall@citrix.com>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Roger Pau Monn? <roger.pau@citrix.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: David Vrabel <david.vrabel@citrix.com>
> 
> Patch looks fine, although with so much indentation changes it's kind of
> hard to review.

I wasn't sure how to make this patch more easy to review and it seems
like diff is getting confused.

It's mostly removing one indentation layer (the if (req->cmd_flags ...))
and move the discard code in a separate function.

> Acked-by: Roger Pau Monn? <roger.pau@citrix.com>

Thank you.

> Just one minor change below.
> 
> [...]
> 
>> @@ -595,6 +603,24 @@ static int blkif_queue_request(struct request *req)
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Generate a Xen blkfront IO request from a blk layer request.  Reads
>> + * and writes are handled as expected.
>> + *
>> + * @req: a request struct
>> + */
>> +static int blkif_queue_request(struct request *req)
>> +{
>> +	struct blkfront_info *info = req->rq_disk->private_data;
>> +
>> +	if (unlikely(info->connected != BLKIF_STATE_CONNECTED))
>> +		return 1;
>> +
>> +	if (unlikely(req->cmd_flags & (REQ_DISCARD | REQ_SECURE)))
>> +		return blkif_queue_discard_req(req);
>> +	else
>> +		return blkif_queue_rw_req(req);
> 
> There's no need for the else clause.

I find it more readable and obvious to understand than:

if ( ... )
  return
return;

when there is only one line in the else. IIRC, the resulting assembly
will be the same.

Anyway, I can drop the else if you really want.

Regards,

-- 
Julien Grall
