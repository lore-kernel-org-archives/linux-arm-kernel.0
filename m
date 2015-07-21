From: roger.pau@citrix.com (=?UTF-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=)
Date: Tue, 21 Jul 2015 11:54:52 +0200
Subject: [PATCH v2 05/20] block/xen-blkfront: Split blkif_queue_request
 in 2
In-Reply-To: <1436474552-31789-6-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-6-git-send-email-julien.grall@citrix.com>
Message-ID: <55AE16EC.2020204@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 09/07/15 a les 22.42, Julien Grall ha escrit:
> Currently, blkif_queue_request has 2 distinct execution path:
>     - Send a discard request
>     - Send a read/write request
> 
> The function is also allocating grants to use for generating the
> request. Although, this is only used for read/write request.
> 
> Rather than having a function with 2 distinct execution path, separate
> the function in 2. This will also remove one level of tabulation.
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Roger Pau Monn? <roger.pau@citrix.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: David Vrabel <david.vrabel@citrix.com>

Patch looks fine, although with so much indentation changes it's kind of
hard to review.

Acked-by: Roger Pau Monn? <roger.pau@citrix.com>

Just one minor change below.

[...]

> @@ -595,6 +603,24 @@ static int blkif_queue_request(struct request *req)
>  	return 0;
>  }
>  
> +/*
> + * Generate a Xen blkfront IO request from a blk layer request.  Reads
> + * and writes are handled as expected.
> + *
> + * @req: a request struct
> + */
> +static int blkif_queue_request(struct request *req)
> +{
> +	struct blkfront_info *info = req->rq_disk->private_data;
> +
> +	if (unlikely(info->connected != BLKIF_STATE_CONNECTED))
> +		return 1;
> +
> +	if (unlikely(req->cmd_flags & (REQ_DISCARD | REQ_SECURE)))
> +		return blkif_queue_discard_req(req);
> +	else
> +		return blkif_queue_rw_req(req);

There's no need for the else clause.

Roger.
