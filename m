From: smueller@chronox.de (Stephan =?ISO-8859-1?Q?M=FCller?=)
Date: Sat, 25 Mar 2017 13:48:35 +0100
Subject: [PATCH v2 1/3] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <20170325073648.cbphcouvi6trmhcj@kozik-lap>
References: <20170324182606.23339-1-krzk@kernel.org>
 <4248691.8fGIDmasva@tauon.atsec.com>
 <20170325073648.cbphcouvi6trmhcj@kozik-lap>
Message-ID: <2198038.IahjPeE5Ux@positron.chronox.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 25. M?rz 2017, 08:36:48 CET schrieb Krzysztof Kozlowski:

Hi Krzysztof,

> On Fri, Mar 24, 2017 at 09:41:59PM +0100, Stephan M?ller wrote:
> > Am Freitag, 24. M?rz 2017, 19:26:04 CET schrieb Krzysztof Kozlowski:
> > 
> > Hi Krzysztof,
> > 
> > > +static unsigned int exynos_rng_copy_random(struct exynos_rng_dev *rng,
> > > +					   u8 *dst, unsigned int dlen)
> > > +{
> > > +	unsigned int cnt = 0;
> > > +	int i, j;
> > > +	u32 val;
> > > +
> > > +	for (j = 0; j < EXYNOS_RNG_SEED_REGS; j++) {
> > > +		val = exynos_rng_readl(rng, EXYNOS_RNG_OUT(j));
> > > +
> > > +		for (i = 0; i < 4; i++) {
> > > +			dst[cnt] = val & 0xff;
> > > +			val >>= 8;
> > > +			if (++cnt >= dlen)
> > > +				return cnt;
> > > +		}
> > > +		rng->seed_save[j] = val;
> > 
> > Just to clarify: is this call right? Shouldn't that be removed? Any RNG
> > that is given to a caller is tainted and should not serve as seed.
> 
> In that case I could either re-use RNGs not passed to the caller (like
> in the block quoted below) or generate another round of them just for
> purpose of next seeding.
> 
> With the first approach the problem is that I might wait for such unused
> numbers pretty long. If user is requesting large amount of data, then I
> will always give him all five output numbers. I will not have unused
> numbers.
> 
> The second approach seems safe, but requires additional engine run which
> will slow down some of the generate() calls.

Random numbers should never be used twice.
> 
> > > +	}
> > > +
> > > +	/*
> > > +	 * Engine filled all output registers, so read the remaining registers
> > > +	 * for storing data as future seed.
> > > +	 */
> > > +	for (; j < EXYNOS_RNG_SEED_REGS; j++)
> > > +		rng->seed_save[j] = exynos_rng_readl(rng, EXYNOS_RNG_OUT(j));
> > 
> > With this call, I guess the questioned line above could go away, right?
> 
> This is used in combination with the previous line so I will get five
> seeds (for five registers).
> 
> Best regards,
> Krzysztof


Ciao
Stephan
