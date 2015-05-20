From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 20 May 2015 17:30:14 +0200
Subject: [PATCH] crypto: allow to assign gfp_t for __crypto_alloc_tfm
In-Reply-To: <20150520145901.GI2871@thunk.org>
References: <20150519054945.GA28060@gondor.apana.org.au>
 <20150519062430.GA39588@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519063211.GA28347@gondor.apana.org.au>
 <20150519065812.GA40012@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519065929.GA28610@gondor.apana.org.au>
 <20150519071317.GB40012@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519071521.GA28862@gondor.apana.org.au>
 <20150519141430.GD20421@thunk.org>
 <20150519142755.GB32663@gondor.apana.org.au>
 <20150520072118.GN8928@secunet.com>
 <20150520145901.GI2871@thunk.org>
Message-ID: <CAKv+Gu_TDwaftr=f8yG8Vna8e+PcKGXD-uggP2oB-2Tq7DWMtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 May 2015 at 16:59, Theodore Ts'o <tytso@mit.edu> wrote:
> On Wed, May 20, 2015 at 09:21:20AM +0200, Steffen Klassert wrote:
>> The current pcrypt version is used just for IPsec because it supports
>> only AEAD type algorithms and does not support request backlog. But
>> I have patches to support ablkcipher algorithms and request backlog.
>> I could provide them if there is interest in it.
>
> I don't know the crypto layer well enough, and I certainly don't know
> how to deal with things like ARM CPU's with "big-little" architectures
> to understand what we might need to do to power optimize things for
> mobile handsets.  But if someone has time to look at this, that would
> be great.
>

I'd be interested in getting involved: I'm fairly intimate with the
crypto layer and the ARM/arm64 architectures, since I wrote a big
chunk of the ARM/arm64 CPU based crypto drivers.

However, it's quite a can of worms you're opening here. Speed is
easily quantified, and it may even be feasible to introduce some kind
of boottime benchmark to select the fastest implementation available
(like already exists for xor and raid6, for instance).
@Herbert: was something like this ever proposed? And would you
consider merging it if it were implemented adequately?

Power efficiency is *much* harder, since you're not only dealing with
big.LITTLE, but also NEON versus ALU (i.e., SIMD math versus integer
math) and CPU versus hw accelerator based crypto. (We have the NEON
based bit sliced AES as an example: we know it does fundamentally more
work by calculating values that the table based AES implementation
reads from a lookup table, so while it is a lot faster on most NEON
implementations, it is most likely not as power efficient) Even if it
were possible to quantify the power efficiency in the first place,
whether the most power efficient implementation should be preferred
over the fastest one is a policy decision which does not really belong
inside the kernel.

Are there any background materials or other references you can share
that shed a bit more light on this?
