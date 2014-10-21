From: clabbe.montjoie@gmail.com (Corentin LABBE)
Date: Tue, 21 Oct 2014 18:39:40 +0200
Subject: [PATCH v5 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <1413849173.5407.6.camel@perches.com>
References: <1413728182-13569-1-git-send-email-clabbe.montjoie@gmail.com>	
 <1413728182-13569-5-git-send-email-clabbe.montjoie@gmail.com>	
 <54459AA5.2030705@mleia.com> <1413849173.5407.6.camel@perches.com>
Message-ID: <54468C4C.3030204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 21/10/2014 01:52, Joe Perches a ?crit :
> On Tue, 2014-10-21 at 02:28 +0300, Vladimir Zapolskiy wrote:
>> On 19.10.2014 17:16, LABBE Corentin wrote:
>>> Add support for the Security System included in Allwinner SoC A20.
>>> The Security System is a hardware cryptographic accelerator that support AES/MD5/SHA1/DES/3DES/PRNG algorithms.
> []
>>> diff --git a/drivers/crypto/sunxi-ss/sunxi-ss-core.c b/drivers/crypto/sunxi-ss/sunxi-ss-core.c
> []
>>> +	cr = clk_get_rate(ss->busclk);
>>> +	if (cr >= cr_ahb)
>>> +		dev_dbg(&pdev->dev, "Clock bus %lu (%lu MHz) (must be >= %lu)\n",
>>> +				cr, cr / 1000000, cr_ahb);
>>> +	else
>>> +		dev_warn(&pdev->dev, "Clock bus %lu (%lu MHz) (must be >= %lu)\n",
>>> +				cr, cr / 1000000, cr_ahb);
>>
>> See next comment.
>>
>>> +	cr = clk_get_rate(ss->ssclk);
>>> +	if (cr <= cr_mod)
>>> +		if (cr < cr_mod)
>>> +			dev_info(&pdev->dev, "Clock ss %lu (%lu MHz) (must be <= %lu)\n",
>>> +					cr, cr / 1000000, cr_mod);
>>> +		else
>>> +			dev_dbg(&pdev->dev, "Clock ss %lu (%lu MHz) (must be <= %lu)\n",
>>> +					cr, cr / 1000000, cr_mod);
>>> +	else
>>> +		dev_warn(&pdev->dev, "Clock ss is at %lu (%lu MHz) (must be <= %lu)\n",
>>> +				cr, cr / 1000000, cr_mod);
>>
>> The management of kernel log levels looks pretty strange. As far as I
>> understand there is no error on any clock rate, I'd recommend to keep
>> only one information message.
> 
> And if not, please add some braces.
> 
>> hash_init: initialize request context */
>>> +int sunxi_hash_init(struct ahash_request *areq)
>>> +{
>>> +	const char *hash_type;
>>> +	struct sunxi_req_ctx *op = ahash_request_ctx(areq);
>>> +
>>> +	memset(op, 0, sizeof(struct sunxi_req_ctx));
>>> +
>>> +	hash_type = crypto_tfm_alg_name(areq->base.tfm);
>>> +
>>> +	if (strcmp(hash_type, "sha1") == 0)
>>> +		op->mode = SS_OP_SHA1;
>>> +	if (strcmp(hash_type, "md5") == 0)
>>> +		op->mode = SS_OP_MD5;
> 
> else if ?
> 
>>> +	if (op->mode == 0)
>>> +		return -EINVAL;
> 
> maybe this?
> 
> 	if (!strcmp(hash_type, "sha1"))
> 		op->mode = SS_OP_SHA1;
> 	else if (!strcmp(hash_type, "md5"))
> 		op->mode = SH_OP_MD5;
> 	else
> 		return -EINVAL;
> 

Ok it is better

>>> +
>>> +	return 0;
>>> +}
> []
>>> +int sunxi_hash_update(struct ahash_request *areq)
>>> +{
> []
>>> +	dev_dbg(ss->dev, "%s %s bc=%llu len=%u mode=%x bw=%u ww=%u",
>>> +			__func__, crypto_tfm_alg_name(areq->base.tfm),
>>> +			op->byte_count, areq->nbytes, op->mode,
>>> +			op->nbw, op->nwait);
> 
> dev_dbg statements generally don't need __func__ as
> dynamic_debug can add it.
> 
> If you want to keep it, the most common output form for
> __func__ is '"%s: ...", __func__'
> 

It is a big debug that I forgot to remove but I fixed that in other dev_dbg

thanks
