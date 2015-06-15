From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 15 Jun 2015 13:38:53 +0200
Subject: [RESEND PATCH v4 04/14] crypto: add a new driver for Marvell's
 CESA
In-Reply-To: <20150615094827.GA32073@gondor.apana.org.au>
References: <1434093366-14681-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434093366-14681-5-git-send-email-boris.brezillon@free-electrons.com>
 <20150615094827.GA32073@gondor.apana.org.au>
Message-ID: <20150615133853.57687ecf@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Jun 2015 17:48:27 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Fri, Jun 12, 2015 at 09:15:56AM +0200, Boris Brezillon wrote:
> >
> > +static void mv_cesa_dequeue_req_unlocked(struct mv_cesa_engine *engine)
> > +{
> > +	struct crypto_async_request *req;
> > +	struct mv_cesa_ctx *ctx;
> > +
> > +	spin_lock_bh(&cesa_dev->lock);
> > +	req = crypto_dequeue_request(&cesa_dev->queue);
> 
> Need to call crypto_get_backlog before this so you can do the
> backlog notification afterwards.

Oh right.
I still have trouble understanding the need for the backlog concept
(maybe you can give some insight): the backlog is just another list
where we put all the requests when the queue has exceeded the limit
fixed in crypto_queue_init, but the result is pretty much the same, the
request stored in the backlog will be handled at some point, so what's
the real point of this backlog.

Anyway, this question was just for my own understanding of this thing:
I'll fix the code to notify users that their request is in progress.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
