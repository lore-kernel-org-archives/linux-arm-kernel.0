From: romain.perier@free-electrons.com (Romain Perier)
Date: Fri, 17 Jun 2016 11:54:53 +0200
Subject: [PATCH 7/7] crypto: marvell: Add support for chaining crypto
 requests in TDMA mode
In-Reply-To: <20160615234353.4ca932cc@bbrezillon>
References: <1466018134-10779-1-git-send-email-romain.perier@free-electrons.com>
 <1466018134-10779-8-git-send-email-romain.perier@free-electrons.com>
 <20160615234353.4ca932cc@bbrezillon>
Message-ID: <5763C8ED.3050501@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le 15/06/2016 23:43, Boris Brezillon a ?crit :
> On Wed, 15 Jun 2016 21:15:34 +0200
> Romain Perier <romain.perier@free-electrons.com> wrote:
>
>> The Cryptographic Engines and Security Accelerators (CESA) supports the
>> Multi-Packet Chain Mode. With this mode enabled, multiple tdma requests
>> can be chained and processed by the hardware without software
>> interferences.
>
> intervention.

ack


> Not necessarily before sending them to the engine, it can be done while
> the engine is running.

I re-worded it

> Coding style issue:
>
> struct crypto_async_request *
> mv_cesa_dequeue_req_locked(struct mv_cesa_engine *engine,
> 			   struct crypto_async_request **backlog)

ack

>
>> +{
>> +	struct crypto_async_request *req;
>> +
>> +	*backlog = crypto_get_backlog(&engine->queue);
>> +	req = crypto_dequeue_request(&engine->queue);
>> +
>> +	if (!req)
>> +		return NULL;
>> +
>> +	return req;
>> +}
>> +
>> +static void mv_cesa_rearm_engine(struct mv_cesa_engine *engine)
>>   {
>>   	struct crypto_async_request *req, *backlog;
>>   	struct mv_cesa_ctx *ctx;
>>
>> -	backlog = crypto_get_backlog(&engine->queue);
>> -	req = crypto_dequeue_request(&engine->queue);
>> -	engine->req = req;
>>
>> +	spin_lock_bh(&engine->lock);
>> +	if (engine->req)
>> +		goto out_unlock;
>> +
>> +	req = mv_cesa_dequeue_req_locked(engine, &backlog);
>>   	if (!req)
>> -		return;
>> +		goto out_unlock;
>> +
>> +	engine->req = req;
>> +	spin_unlock_bh(&engine->lock);
>
> I'm not a big fan of those multiple 'unlock() locations', and since
> your code is pretty simple I'd prefer seeing something like.

mhhh, yes I have re-worked this function recently (the locking was more 
complicated before), I will change the code.

>
> 	spin_lock_bh(&engine->lock);
> 	if (!engine->req) {
> 		req = mv_cesa_dequeue_req_locked(engine, &backlog);
> 		engine->req = req;
> 	}
> 	spin_unlock_bh(&engine->lock);
>
> 	if (!req)
> 		return;
>
> With req and backlog initialized to NULL at the beginning of the
> function.

ack

>
>>
>>   	if (backlog)
>>   		backlog->complete(backlog, -EINPROGRESS);
>>
>>   	ctx = crypto_tfm_ctx(req->tfm);
>>   	ctx->ops->step(req);
>> +	return;
>
> Missing blank line.

ack

>
>> +out_unlock:
>> +	spin_unlock_bh(&engine->lock);
>> +}
>> +
>> +static int mv_cesa_std_process(struct mv_cesa_engine *engine, u32 status)
>> +{
>> +	struct crypto_async_request *req;
>> +	struct mv_cesa_ctx *ctx;
>> +	int res;
>> +
>> +	req = engine->req;
>> +	ctx = crypto_tfm_ctx(req->tfm);
>> +	res = ctx->ops->process(req, status);
>> +
>> +	if (res == 0) {
>> +		ctx->ops->complete(req);
>> +		mv_cesa_engine_enqueue_complete_request(engine, req);
>> +	} else if (res == -EINPROGRESS) {
>> +		ctx->ops->step(req);
>> +	} else {
>> +		ctx->ops->complete(req);
>
> Do we really have to call ->complete() in this case?

I was simply to be consistent with the old code (that is currently in 
mainline) but to be honest I don't think so...

>
>> +	}
>> +
>> +	return res;
>> +}
>> +
>> +static int mv_cesa_int_process(struct mv_cesa_engine *engine, u32 status)
>> +{
>> +	if (engine->chain.first && engine->chain.last)
>> +		return mv_cesa_tdma_process(engine, status);
>
> Missing blank line.

ack

>
>> +	return mv_cesa_std_process(engine, status);
>> +}
>> +
>> +static inline void mv_cesa_complete_req(struct mv_cesa_ctx *ctx,
>> +	struct crypto_async_request *req, int res)
>
> Align parameters to the open parenthesis.

ack



>> @@ -116,16 +181,15 @@ int mv_cesa_queue_req(struct crypto_async_request *req,
>>   	struct mv_cesa_engine *engine = creq->engine;
>>
>>   	spin_lock_bh(&engine->lock);
>> +	if (mv_cesa_req_get_type(creq) == CESA_DMA_REQ)
>> +		mv_cesa_tdma_chain(engine, creq);
>
> Missing blank line.

ack


>> diff --git a/drivers/crypto/marvell/cesa.h b/drivers/crypto/marvell/cesa.h
>> index 5626aa7..e0fee1f 100644
>> --- a/drivers/crypto/marvell/cesa.h
>> +++ b/drivers/crypto/marvell/cesa.h
>> @@ -271,7 +271,9 @@ struct mv_cesa_op_ctx {
>>   /* TDMA descriptor flags */
>>   #define CESA_TDMA_DST_IN_SRAM			BIT(31)
>>   #define CESA_TDMA_SRC_IN_SRAM			BIT(30)
>> -#define CESA_TDMA_TYPE_MSK			GENMASK(29, 0)
>> +#define CESA_TDMA_END_OF_REQ			BIT(29)
>> +#define CESA_TDMA_NOT_CHAIN			BIT(28)
>
> I would name it CESA_TDMA_BREAK_CHAIN.

ack

>
>> +#define CESA_TDMA_TYPE_MSK			GENMASK(27, 0)
>>   #define CESA_TDMA_DUMMY				0
>>   #define CESA_TDMA_DATA				1
>>   #define CESA_TDMA_OP				2
>> @@ -431,6 +433,9 @@ struct mv_cesa_dev {
>>    *			SRAM
>>    * @queue:		fifo of the pending crypto requests
>>    * @load:		engine load counter, useful for load balancing
>> + * @chain:		list of the current tdma descriptors being processed
>> + * 			by this engine.
>> + * @complete_queue:	fifo of the processed requests by the engine
>>    *
>>    * Structure storing CESA engine information.
>>    */
>> @@ -448,6 +453,8 @@ struct mv_cesa_engine {
>>   	struct gen_pool *pool;
>>   	struct crypto_queue queue;
>>   	atomic_t load;
>> +	struct mv_cesa_tdma_chain chain;
>> +	struct list_head complete_queue;
>>   };
>>
>>   /**
>> @@ -618,6 +625,28 @@ struct mv_cesa_ahash_req {
>>
>>   extern struct mv_cesa_dev *cesa_dev;
>>
>> +
>> +static inline void mv_cesa_engine_enqueue_complete_request(
>> +	struct mv_cesa_engine *engine, struct crypto_async_request *req)
>
> Coding style issue (see my previous comments).

ok


>>
>> +struct crypto_async_request *mv_cesa_dequeue_req_locked(
>> +		      struct mv_cesa_engine *engine,
>> +		      struct crypto_async_request **backlog);
>
> Ditto.

ok


>> +void
>> +mv_cesa_tdma_chain(struct mv_cesa_engine *engine, struct mv_cesa_req *dreq)
>> +{
>> +	if (engine->chain.first == NULL && engine->chain.last == NULL) {
>> +		engine->chain.first = dreq->chain.first;
>> +		engine->chain.last  = dreq->chain.last;
>> +	} else {
>> +		struct mv_cesa_tdma_desc *last;
>> +
>> +		last = engine->chain.last;
>> +		last->next = dreq->chain.first;
>> +		engine->chain.last = dreq->chain.last;
>
> Missing blank line.

ack

>
>> +		if (!(last->flags & CESA_TDMA_NOT_CHAIN))
>> +			last->next_dma = dreq->chain.first->cur_dma;
>> +	}
>> +}
>> +
>> +int
>> +mv_cesa_tdma_process(struct mv_cesa_engine *engine, u32 status)
>> +{
>> +	struct crypto_async_request *req = NULL;
>> +	struct mv_cesa_tdma_desc *tdma = NULL, *next = NULL;
>> +	dma_addr_t tdma_cur;
>> +	int res = 0;
>> +
>> +	tdma_cur = readl(engine->regs + CESA_TDMA_CUR);
>> +
>> +	for (tdma = engine->chain.first; tdma; tdma = next) {
>> +		spin_lock_bh(&engine->lock);
>> +		next = tdma->next;
>> +		spin_unlock_bh(&engine->lock);
>> +
>> +		if (tdma->flags & CESA_TDMA_END_OF_REQ) {
>> +			struct crypto_async_request *backlog = NULL;
>> +			struct mv_cesa_ctx *ctx;
>> +
>> +			spin_lock_bh(&engine->lock);
>> +			/*
>> +			 * if req is NULL, this means we're processing the
>> +			 * request in engine->req.
>> +			 */
>> +			if (!req)
>> +				req = engine->req;
>> +			else
>> +				req = mv_cesa_dequeue_req_locked(engine,
>> +								 &backlog);
>> +
>> +			/* Re-chaining to the next request */
>> +			engine->chain.first = tdma->next;
>> +			tdma->next = NULL;
>> +
>> +			/* If this is the last request, clear the chain */
>> +			if (engine->chain.first == NULL)
>> +				engine->chain.last  = NULL;
>> +			spin_unlock_bh(&engine->lock);
>> +
>> +			ctx = crypto_tfm_ctx(req->tfm);
>> +			res = ctx->ops->process(req, status);
>
> Hm, that's not exactly true. The status you're passing here is only
> valid for the last request that has been processed. Say you queued 3
> requests. 2 of them were correctly processed, but the last one
> triggered an error. You don't want the first 2 requests to be
> considered bad.

I will re-work this part


>
>> +			ctx->ops->complete(req);
>> +
>> +			if (res == 0)
>> +				mv_cesa_engine_enqueue_complete_request(engine,
>> +									req);
>> +
>> +			if (backlog)
>> +				backlog->complete(backlog, -EINPROGRESS);
>> +		}
>
> Missing blank line.

ok

>
>> +		if (res || tdma->cur_dma == tdma_cur)
>> +			break;
>> +	}
>> +
>> +	if (res) {
>> +		spin_lock_bh(&engine->lock);
>> +		engine->req = req;
>> +		spin_unlock_bh(&engine->lock);
>> +	}
>
> Maybe you can add a comment explaining that you are actually setting
> the last processed request into engine->req, so that the core can know
> which request was faulty.
>
I added a comment


Thanks !
Romain
-- 
Romain Perier, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
