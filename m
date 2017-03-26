From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 26 Mar 2017 21:00:12 +0300
Subject: [PATCH v3 1/3] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <2736911.EcZSki4vB1@positron.chronox.de>
References: <20170325162654.3827-1-krzk@kernel.org>
 <20170325162654.3827-2-krzk@kernel.org>
 <2736911.EcZSki4vB1@positron.chronox.de>
Message-ID: <20170326180012.3eic4bt2p6h6u3nh@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 26, 2017 at 07:11:28PM +0200, Stephan M?ller wrote:
> Am Samstag, 25. M?rz 2017, 17:26:52 CEST schrieb Krzysztof Kozlowski:
> > +static int exynos_rng_set_seed(struct exynos_rng_dev *rng,
> > +			       const u8 *seed, unsigned int slen)
> > +{
> > +	u32 val;
> > +	int i;
> > +
> > +	dev_dbg(rng->dev, "Seeding with %u bytes\n", slen);
> > +
> > +	if (slen < EXYNOS_RNG_SEED_SIZE) {
> > +		dev_warn(rng->dev, "Seed too short (only %u bytes)\n", slen);
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i = 0 ; i < EXYNOS_RNG_SEED_REGS ; i++) {
> > +		val = seed[i * 4] << 24;
> > +		val |= seed[i * 4 + 1] << 16;
> > +		val |= seed[i * 4 + 2] << 8;
> > +		val |= seed[i * 4 + 3] << 0;
> > +
> > +		exynos_rng_writel(rng, val, EXYNOS_RNG_SEED(i));
> > +	}
> 
> Would it make sense to add another outer loop here to allow all of slen to be 
> injected into the DRNG? Note, in some cases, a user wants to add more seed 
> into the DRNG than the actual seed size. In this case, the DRNG acts as a 
> compression operation of entropy. This is used when the entropy-to-data ratio 
> is not 1:1. In a lot of cases, users have a seed which has less entropy in 
> bits per data bit.

Hi,

I do not know whether this would have any benefit on hardware. The
datasheet is not describing too much here. It is actually saying only:
1. Write SEED to each register (five in total).
2. Confirm that STATUS register says seeding done.
3. Start RNG engine.
4. Wait for engine finish (another bit in STATUS - clear it then).
5. Read the randoms.

I would guess that the hardware will ignore all previously written seeds
and use the last one. Maybe the hardware will use all of the seeds
written as you imply. It is just a guessing.

Best regards,
Krzysztof
