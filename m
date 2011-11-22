From: javi.merino@arm.com (Javi Merino)
Date: Tue, 22 Nov 2011 17:16:22 +0000
Subject: [PATCH 1/4] ARM: PL330: Don't call the callbacks if there isn't
 any active transfer
In-Reply-To: <CAJe_ZhftO+481BfL0ErEcM_brfmSuTXkTEniLRYxxM2T7OM2QA@mail.gmail.com>
References: <1320244259-10496-1-git-send-email-javi.merino@arm.com>	<CAJe_Zhf+PAeM+wquQykXNDG74Nc+jQNXrp+RLMKSySCNPum8Tg@mail.gmail.com>	<4EC28A76.7080606@arm.com>	<CABb+yY1atyLA8Ej57JBEM0JL3oK5e6+1vO0UH5VTNiBsKQPueA@mail.gmail.com>
 <CAJe_ZhftO+481BfL0ErEcM_brfmSuTXkTEniLRYxxM2T7OM2QA@mail.gmail.com>
Message-ID: <4ECBD8E6.3010605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/11/11 06:24, Jassi Brar wrote:
> On 15 November 2011 22:30, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>> On Tue, Nov 15, 2011 at 9:21 PM, Javi Merino <javi.merino@arm.com> wrote:
>>> On 15/11/11 07:51, Jassi Brar wrote:
>>>>> There can be a stale struct pl330_req pointer from a previous run, but the
>>>>> memory may be free already.
>>>>>
>>>> Sorry I am unable to fathom the scenario. The pl330_request_channel resets
>>>> both pl330_req pointers. Maybe some real failure you saw, could help
>>>> me understand.
>>>
>>> You request a channel, submit a xfer, it finishes successfully and
>>> pl330_update() is called, which calls r->xfer_cb() and marks the request
>>> as done by making req->mc_len = 0 .  Then, if you call
>>> pl330_release_channel(), _callback(thrd->req[0].r, PL330_ERR_ABORT) is
>>> called and, as thrd_req[0].r and thrd_req[0].r->xfer_cb are not null,
>>> r->xfer_cb() is called again.  That's wrong, the xfer finished (maybe
>>> long time ago) and the callback was called back then.  You shouldn't
>>> call it again with an error.  You should only do so if the transfer was
>>> running or scheduled to run, that's why I suggest calling _callback() if
>>> !IS_FREE(req).
>>>
>> Usually flush is called before releasing the channel, which would
>> have taken care of it. But I agree, flush shouldn't be necessary.
>>
>> MARK_FREE(_pl330_req)  with _pl330_req.r != NULL   doesn't look neat.
>> So maybe we should move   _pl330_req.r = NULL   into MARK_FREE macro.
>> Which would require moving 'struct list_head rqd' from _pl330_req to
>> pl330_req, that should be ok though I think.
>>
> I think the following strikes just the right balance and should fix
> the issue ...
> 
> diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
> index 7129cfb..ecbca3f 100644
> --- a/arch/arm/common/pl330.c
> +++ b/arch/arm/common/pl330.c
> @@ -1480,13 +1480,19 @@ int pl330_update(const struct pl330_info *pi)
> 
>  	/* Now that we are in no hurry, do the callbacks */
>  	while (!list_empty(&pl330->req_done)) {
> +		struct pl330_req *r;
> +
>  		rqdone = container_of(pl330->req_done.next,
>  					struct _pl330_req, rqd);
> 
>  		list_del_init(&rqdone->rqd);
> 
> +		/* Detach the req */
> +		r = rqdone->r;
> +		rqdone->r = NULL;
> +
>  		spin_unlock_irqrestore(&pl330->lock, flags);
> -		_callback(rqdone->r, PL330_ERR_NONE);
> +		_callback(r, PL330_ERR_NONE);
>  		spin_lock_irqsave(&pl330->lock, flags);
>  	}

Right, and there's no need to patch pl330_chan_ctrl() in PL330_OP_ABORT
because _pl330_req.r is set to NULL in there already.

I'll try this patch and if it works we can submit it instead of my
original one.

Thanks,
Javi
