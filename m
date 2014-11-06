From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 6 Nov 2014 22:13:58 +0800
Subject: [PATCH v5 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <1413728182-13569-5-git-send-email-clabbe.montjoie@gmail.com>
References: <1413728182-13569-1-git-send-email-clabbe.montjoie@gmail.com>
 <1413728182-13569-5-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20141106141358.GA3300@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 19, 2014 at 04:16:22PM +0200, LABBE Corentin wrote:
> Add support for the Security System included in Allwinner SoC A20.
> The Security System is a hardware cryptographic accelerator that support AES/MD5/SHA1/DES/3DES/PRNG algorithms.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

OK this is much better.  However it seems that export/import
is still missing?

> +	src_addr = kmap_atomic(sg_page(in_sg)) + in_sg->offset;
> +	if (src_addr == NULL) {
> +		dev_err(ss->dev, "kmap_atomic error for src SG\n");
> +		writel(0, ss->base + SS_CTL);
> +		mutex_unlock(&ss->lock);

I overlooked this the last time around.  You cannot use mutexes
here as you can be called from softirq context so you need spin
locks.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
