From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 15 Jun 2016 22:48:12 +0200
Subject: [PATCH 3/7] crypto: marvell: Copy IV vectors by DMA transfers
 for acipher requests
In-Reply-To: <1466018134-10779-4-git-send-email-romain.perier@free-electrons.com>
References: <1466018134-10779-1-git-send-email-romain.perier@free-electrons.com>
 <1466018134-10779-4-git-send-email-romain.perier@free-electrons.com>
Message-ID: <20160615224812.206eb472@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jun 2016 21:15:30 +0200
Romain Perier <romain.perier@free-electrons.com> wrote:

> @@ -135,23 +140,23 @@ static int mv_cesa_ablkcipher_process(struct crypto_async_request *req,
>  {
>  	struct ablkcipher_request *ablkreq = ablkcipher_request_cast(req);
>  	struct mv_cesa_ablkcipher_req *creq = ablkcipher_request_ctx(ablkreq);
> -	struct mv_cesa_ablkcipher_std_req *sreq = &creq->req.std;
> -	struct mv_cesa_engine *engine = sreq->base.engine;
> -	int ret;
>  
> -	if (creq->req.base.type == CESA_DMA_REQ)
> +	if (creq->req.base.type == CESA_DMA_REQ) {
> +		int ret;
> +		struct mv_cesa_tdma_req *dreq;
> +		unsigned int ivsize;
> +
>  		ret = mv_cesa_dma_process(&creq->req.dma, status);
> -	else
> -		ret = mv_cesa_ablkcipher_std_process(ablkreq, status);
> +		if (ret)
> +			return ret;
>  
> -	if (ret)
> +		dreq = &creq->req.dma;
> +		ivsize = crypto_ablkcipher_ivsize(
> +					     crypto_ablkcipher_reqtfm(ablkreq));
> +		memcpy_fromio(ablkreq->info, dreq->chain.last->data, ivsize);

Just use memcpy() here: you're not copying from an iomem region here.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
