From: smueller@chronox.de (Stephan =?ISO-8859-1?Q?M=FCller?=)
Date: Sun, 26 Mar 2017 19:11:28 +0200
Subject: [PATCH v3 1/3] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <20170325162654.3827-2-krzk@kernel.org>
References: <20170325162654.3827-1-krzk@kernel.org>
 <20170325162654.3827-2-krzk@kernel.org>
Message-ID: <2736911.EcZSki4vB1@positron.chronox.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 25. M?rz 2017, 17:26:52 CEST schrieb Krzysztof Kozlowski:

Hi Krzysztof,

> +static int exynos_rng_set_seed(struct exynos_rng_dev *rng,
> +			       const u8 *seed, unsigned int slen)
> +{
> +	u32 val;
> +	int i;
> +
> +	dev_dbg(rng->dev, "Seeding with %u bytes\n", slen);
> +
> +	if (slen < EXYNOS_RNG_SEED_SIZE) {
> +		dev_warn(rng->dev, "Seed too short (only %u bytes)\n", slen);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0 ; i < EXYNOS_RNG_SEED_REGS ; i++) {
> +		val = seed[i * 4] << 24;
> +		val |= seed[i * 4 + 1] << 16;
> +		val |= seed[i * 4 + 2] << 8;
> +		val |= seed[i * 4 + 3] << 0;
> +
> +		exynos_rng_writel(rng, val, EXYNOS_RNG_SEED(i));
> +	}

Would it make sense to add another outer loop here to allow all of slen to be 
injected into the DRNG? Note, in some cases, a user wants to add more seed 
into the DRNG than the actual seed size. In this case, the DRNG acts as a 
compression operation of entropy. This is used when the entropy-to-data ratio 
is not 1:1. In a lot of cases, users have a seed which has less entropy in 
bits per data bit.

Ciao
Stephan
