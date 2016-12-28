From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 28 Dec 2016 19:50:44 +0000
Subject: [PATCH] crypto: arm/aes-neonbs - process 8 blocks in parallel if
 we can
In-Reply-To: <20161228092328.GA12494@gondor.apana.org.au>
References: <1481291246-20216-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161227085745.GA10121@gondor.apana.org.au>
 <CAKv+Gu8OkOR3Xzx=XEOWyFpo6sLiq=WQrq0SauaY0V57uYetCQ@mail.gmail.com>
 <20161228091020.GE11904@gondor.apana.org.au>
 <B32240B5-953F-42A2-A010-6FF64AC45859@linaro.org>
 <20161228092328.GA12494@gondor.apana.org.au>
Message-ID: <CAKv+Gu__722s0JkpTzqDu7MmrzSMQ9jJQn=RYnxgSyV+P6MZRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 December 2016 at 09:23, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Wed, Dec 28, 2016 at 09:19:32AM +0000, Ard Biesheuvel wrote:
>>
>> Ok, so that implies a field in the skcipher algo struct then, rather than some definition internal to the driver?
>
> Oh yes it should definitely be visible to other crypto API drivers
> and algorithms.  It's just that we don't want to export it outside
> of the crypto API, e.g., to IPsec or algif.
>

Understood.

So about this chunksize, is it ever expected to assume other values
than 1 (for stream ciphers) or the block size (for block ciphers)?
Having block size, IV size *and* chunk size fields may be confusing to
some already, so if the purpose of chunk size can be fulfilled by a
single 'stream cipher' flag, perhaps we should change that first.
