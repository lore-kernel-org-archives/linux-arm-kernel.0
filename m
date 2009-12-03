From: mpm@selenic.com (Matt Mackall)
Date: Thu, 03 Dec 2009 13:50:17 -0600
Subject: [PATCH 1/2] arm nomadik: add hardware RNG driver
In-Reply-To: <defe399f8475d30be15ee694eadd45afa9cc64ca.1259840968.git.rubini@unipv.it>
References: <defe399f8475d30be15ee694eadd45afa9cc64ca.1259840968.git.rubini@unipv.it>
Message-ID: <1259869817.29740.1715.camel@calx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-12-03 at 13:04 +0100, Alessandro Rubini wrote:
> From: Alessandro Rubini <rubini@unipv.it>
> 
> The hardware random number generator by ST is used in both the Nomadik
> 8815 SoC and the U8500. It returns 16 bits every 400ns with automatic
> delay if a read is issued too early. It depends on PLAT_NOMADIK.


> +static int nmk_rng_read(struct hwrng *rng, u32 *buffer)
> +{
> +	void __iomem *base = (void __iomem *)rng->priv;
> +	/*
> +	 * We have the low 16 bits as random data. It takes 0.4us to read them
> +	 * so return only one 32-bit sample (minimum allowed).
> +	 * High bits are guaranteed to be 0.
> +	 */
> +	*buffer = __raw_readl(base + 8) << 16 | __raw_readl(base + 8);
> +	return 4;

Please adjust this to use the new read interface we just introduced:

http://git.kernel.org/?p=linux/kernel/git/herbert/cryptodev-2.6.git;a=blobdiff;f=include/linux/hw_random.h;h=9bede7633f745d7c5bd866d2f46df9a51021f92d;hp=7244456e7e6573466f0534857bef00b8b1dbdad7;hb=9996508b3353063f2d6c48c1a28a84543d72d70b;hpb=2f32bfd834d5d7eb230bcbf39aaacccd2a01d767

(sorry for the git URL awesomeness)

This will actually let us do 8 or 16-bit reads, so we can reduce latency
and even slightly simplify your code.

Otherwise, looks fine.

-- 
http://selenic.com : development and support for Mercurial and Linux
