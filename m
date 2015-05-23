From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 23 May 2015 16:35:36 +0200
Subject: [PATCH v9 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <55607CB7.8020505@gmail.com>
References: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
 <1431608341-10936-5-git-send-email-clabbe.montjoie@gmail.com>
 <20150517104508.468b032f@bbrezillon> <55607CB7.8020505@gmail.com>
Message-ID: <20150523163536.2d64ef8d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Corentin,

On Sat, 23 May 2015 15:12:23 +0200
Corentin LABBE <clabbe.montjoie@gmail.com> wrote:

> Le 17/05/2015 10:45, Boris Brezillon a ?crit :
> > Hi Corentin,
> > 
> > I started to review this new version, and I still think there's
> > something wrong with the way your processing crypto requests.
> > From my POV this is not asynchronous at all (see my comments inline),
> > but maybe Herbert can confirm that.
> > I haven't reviewed the hash part yet, but I guess it has the same
> > problem.
> 
> For resuming your conversation with Herbert, I have removed all CRYPTO_ALG_ASYNC flags.

Okay. I really think you can easily deal with asynchronous request (I
had a look at the datasheet), but I'll let maintainers decide whether
this is important or not.


> > 
> >> +
> >> +int sun4i_ss_aes_poll(struct ablkcipher_request *areq, u32 mode)
> >> +{
> >> +	u32 spaces;
> >> +	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(areq);
> >> +	struct sun4i_tfm_ctx *op = crypto_ablkcipher_ctx(tfm);
> >> +	struct sun4i_ss_ctx *ss = op->ss;
> >> +	unsigned int ivsize = crypto_ablkcipher_ivsize(tfm);
> >> +	/* when activating SS, the default FIFO space is 32 */
> >> +	u32 rx_cnt = 32;
> >> +	u32 tx_cnt = 0;
> >> +	u32 v;
> >> +	int i, sgnum, err = 0;
> >> +	unsigned int ileft = areq->nbytes;
> >> +	unsigned int oleft = areq->nbytes;
> >> +	unsigned int todo, miter_flag;
> >> +	unsigned long flags;
> >> +	struct sg_mapping_iter mi, mo;
> >> +	unsigned int oi, oo; /* offset for in and out */
> >> +
> >> +	if (areq->nbytes == 0)
> >> +		return 0;
> >> +
> >> +	if (areq->info == NULL) {
> >> +		dev_err(ss->dev, "ERROR: Empty IV\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (areq->src == NULL || areq->dst == NULL) {
> >> +		dev_err(ss->dev, "ERROR: Some SGs are NULL\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	spin_lock_irqsave(&ss->slock, flags);
> > 
> > Do you really need to take this lock so early ?
> > BTW, what is this lock protecting ?
> 
> As I have written in the header, the spinlock protect the usage of the device.
> In this case, I need to lock just before writing the key in the device.

I'm not denying the fact that you need some locking, just how this
locking is done: you're preventing the all system from receiving
interrupts for the all time your doing your crypto request.

Here is a suggestion (if you still want to keep the synchronous model,
which IMHO is not a good idea, but hey, that's not my call to make).

1/ wait for the device to be ready (using a waitqueue)
2/ take the lock
3/ check if the engine is busy (already handling another crypto
   request).
4.1/ If the engine is not busy, mark the engine as busy, release the
     lock and proceed with the crytpo request handling.
4.2/ If the engine is busy, release the lock and go back to 1/ 


> 
> > 
> > IMHO, taking a spinlock and disabling irqs for the whole time you're
> > executing a crypto request is not a good idea (it will prevent all
> > other irqs from running, and potentially introduce latencies in other
> > parts of the kernel).
> 
> Since crypto operation could be called by software interrupt, I need to disable them.
> (Confirmed by http://www.makelinux.net/ldd3/chp-5-sect-5 5.5.3)

Hm, you're not even using the interrupts provided by the IP to detect
when the engine is ready to accept new data chunks (which is another
aspect that should be addressed IMO), so I don't get why you need to
disable HW interrupts.
If you just want to disable SW interrupts, you can use spin_lock_bh()
instead of spin_lock_irqsave().

> 
> > 
> > What you can do though is declare the following fields in your crypto
> > engine struct (sun4i_ss_ctx):
> > - a crypto request queue (struct crypto_queue [1])
> > - a crypto_async_request variable storing the request being processed
> > - a lock protecting the queue and the current request variable
> > 
> > This way you'll only have to take the lock when queuing or dequeuing a
> > request.
> > 
> > Another comment, your implementation does not seem to be asynchronous at
> > all: you're blocking the caller until its crypto request is complete.
> > 
> > 
> >> +
> >> +	for (i = 0; i < op->keylen; i += 4)
> >> +		writel(*(op->key + i / 4), ss->base + SS_KEY0 + i);
> >> +
> >> +	if (areq->info != NULL) {
> >> +		for (i = 0; i < 4 && i < ivsize / 4; i++) {
> >> +			v = *(u32 *)(areq->info + i * 4);
> >> +			writel(v, ss->base + SS_IV0 + i * 4);
> >> +		}
> >> +	}
> >> +	writel(mode, ss->base + SS_CTL);
> >> +
> >> +	sgnum = sg_nents(areq->src);
> >> +	if (sgnum == 1)
> >> +		miter_flag = SG_MITER_FROM_SG | SG_MITER_ATOMIC;
> >> +	else
> >> +		miter_flag = SG_MITER_FROM_SG;
> > 
> > 
> > Why is the ATOMIC flag depending on the number of sg elements.
> > IMO it should only depends on the context you're currently in, and in
> > your specific case, you're always in atomic context since you've taken
> > a spinlock (and disabled irqs) a few lines above.
> > 
> > Note that with the approach I previously proposed, you can even get rid
> > of this ATMIC flag (or always set it depending on the context you're in
> > when dequeuing the crypto requests).
> > 
> 
> For sg_miter, the ATOMIC flag control the usage of kmap vs kmap_atomic.
> Since kmap_atomic must not be held too long, I use them only for short crypto operation.
> But I need to rebench for be sure that using kmap_atomic give faster result.
> If I keep that, I will add a comment explaining that.

Maybe you can call kmap_atomic when you're in standard context (even if
I'm not sure this is relevant), but you definitely can't call kmap when
you're in atomic context (see the might_sleep() line here [1]). And
since you've taken a spinlock (and disabled all the interrupts) a few
lines above, you're in atomic context here.

> > 
> >> +	sg_miter_start(&mo, areq->dst, sgnum, miter_flag);
> >> +	sg_miter_next(&mi);
> >> +	sg_miter_next(&mo);
> >> +	if (mi.addr == NULL || mo.addr == NULL) {
> >> +		err = -EINVAL;
> >> +		goto release_ss;
> >> +	}
> >> +
> >> +	ileft = areq->nbytes / 4;
> >> +	oleft = areq->nbytes / 4;
> >> +	oi = 0;
> >> +	oo = 0;
> >> +	do {
> >> +		todo = min3(rx_cnt, ileft, (mi.length - oi) / 4);
> >> +		if (todo > 0) {
> >> +			ileft -= todo;
> >> +			writesl(ss->base + SS_RXFIFO, mi.addr + oi, todo);
> > 
> > Is there anything guaranteeing that your pointer is aligned on a 4 byte
> > boundary ? If that's not the case, I guess you should copy it in a
> > temporary variable before using writesl.
> 
> The cra_alignmask is my guarantee.

Right.

> 
> > 
> >> +			oi += todo * 4;
> >> +		}
> >> +		if (oi == mi.length) {
> >> +			sg_miter_next(&mi);
> >> +			oi = 0;
> >> +		}
> >> +
> >> +		ispaces = readl_relaxed(ss->base + SS_FCSR);
> > 
> > Is there a good reason for using the _relaxed version of readl/writel
> > (the same comment applies a few lines below) ?
> 
> No, it is clearly a remaining of the times where all my read/write was with _relaxed.


Okay, then maybe you should reconsider using readl/writel, unless you
really know why you're using relaxed versions.

> > 
> >> +	spin_unlock_irqrestore(&ss->slock, flags);
> >> +	return err;
> >> +}
> >> +
> >> +/* Pure CPU driven way of doing DES/3DES with SS */
> >> +int sun4i_ss_des_poll(struct ablkcipher_request *areq, u32 mode)
> >> +{
> >> +	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(areq);
> >> +	struct sun4i_tfm_ctx *op = crypto_ablkcipher_ctx(tfm);
> >> +	struct sun4i_ss_ctx *ss = op->ss;
> >> +	int i, err = 0;
> >> +	int no_chunk = 1;
> >> +	struct scatterlist *in_sg = areq->src;
> >> +	struct scatterlist *out_sg = areq->dst;
> >> +	u8 kkey[256 / 8];
> >> +
> >> +	if (areq->nbytes == 0)
> >> +		return 0;
> >> +
> >> +	if (areq->info == NULL) {
> >> +		dev_err(ss->dev, "ERROR: Empty IV\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (areq->src == NULL || areq->dst == NULL) {
> >> +		dev_err(ss->dev, "ERROR: Some SGs are NULL\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	/*
> >> +	 * if we have only SGs with size multiple of 4,
> >> +	 * we can use the SS AES function
> >> +	 */
> >> +	while (in_sg != NULL && no_chunk == 1) {
> >> +		if ((in_sg->length % 4) != 0)
> >> +			no_chunk = 0;
> >> +		in_sg = sg_next(in_sg);
> >> +	}
> >> +	while (out_sg != NULL && no_chunk == 1) {
> >> +		if ((out_sg->length % 4) != 0)
> >> +			no_chunk = 0;
> >> +		out_sg = sg_next(out_sg);
> >> +	}
> >> +
> >> +	if (no_chunk == 1)
> >> +		return sun4i_ss_aes_poll(areq, mode);
> >> +
> >> +	/*
> >> +	 * if some SG are not multiple of 4bytes use a fallback
> >> +	 * it is much easy and clean
> >> +	 */
> > 
> > Hm, is this really the best solution. I mean, you can easily pack
> > values from non aligned sg buffers so that you have only a 4 byte
> > aligned buffers.
> > Moreover, by doing this you'll end up with a single
> > sun4i_ss_ablkcipher_poll function.
> > 
> > BTW, I wonder if there's anything preventing an AES crypto request to be
> > forged the same way DES/3DES requests are (sg entries not aligned on 4
> > bytes boundary).
> 
> There are two different problem: chunking and alignment.
> The correct alignment is handled by the crypto API with the alignmask, so the driver do not need to care about it.

Yes...

> The chunking is the fact that I can have a SG with a size that is non multiple of 4.

and I was takling about this specific aspect here.

> For DES/3DES I handle this problem by using a fallback since DES/3DES was not my priority. (but yes I will handle it in the future)
> For AES I have assumed that it cannot happen since no test in tcrypt check for it.

If that's something you're willing to address in a future version, then
I'm fine with that.

> Since all SG I get was always a multiple of 16 (AES BLOCK SIZE) it was a sort of confirmation.
> 
> Herbert ? does am I right or a chunking test is missing for cbc(aes) in testmgr.h

Okay, just sharing my vision of this thing (I'll let Herbert comment on
this aspect): I'd say that theoretically nothing prevents one from
splitting its sg list in chunks smaller than the block size, so I'd
say you should use the same trick for AES. 



[1]http://lxr.free-electrons.com/source/arch/arm/mm/highmem.c#L37

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
