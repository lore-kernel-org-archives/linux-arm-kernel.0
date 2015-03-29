From: stockhausen@collogia.de (Markus Stockhausen)
Date: Sun, 29 Mar 2015 16:05:57 +0000
Subject: AW: [RFC PATCH 1/6] crypto: sha512: implement base layer for SHA-512
In-Reply-To: <CAKv+Gu9kMPM2t5r8pgdw=Cc5juGTxCeJJc1L-yBy6AS_A2UUAA@mail.gmail.com>
References: <1427580628-7128-1-git-send-email-ard.biesheuvel@linaro.org>
 <1427580628-7128-2-git-send-email-ard.biesheuvel@linaro.org>
 <12EF8D94C6F8734FB2FF37B9FBEDD1735FC8A1E8@EXCHANGE.collogia.de>,
 <CAKv+Gu9kMPM2t5r8pgdw=Cc5juGTxCeJJc1L-yBy6AS_A2UUAA@mail.gmail.com>
Message-ID: <12EF8D94C6F8734FB2FF37B9FBEDD1735FC8A36E@EXCHANGE.collogia.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Von: Ard Biesheuvel [ard.biesheuvel at linaro.org]
> Gesendet: Sonntag, 29. M?rz 2015 12:38
> An: Markus Stockhausen
> Cc: linux-arm-kernel at lists.infradead.org; linux-crypto at vger.kernel.org; samitolvanen at google.com; herbert at gondor.apana.org.au; jussi.kivilinna at iki.fi
> Betreff: Re: [RFC PATCH 1/6] crypto: sha512: implement base layer for SHA-512
> 
>>> ...
>>> +int sha512_base_do_update(struct shash_desc *desc, const u8 *data,
>>> +                         unsigned int len, sha512_block_fn *block_fn, void *p)
>>> +{
>>> +       struct sha512_state *sctx = shash_desc_ctx(desc);
>>> +       unsigned int partial = sctx->count[0] % SHA512_BLOCK_SIZE;
>>> +
>>> +       sctx->count[0] += len;
>>> +       if (sctx->count[0] < len)
>>> +               sctx->count[1]++;
>>>
>> You should check if early kick out at this point if the buffer won't be filled up
>> is faster than first taking care about big data. That can improve performance
>> for small blocks while large blocks might be unaffected.
>>
>>> +
>>> +       if ((partial + len) >= SHA512_BLOCK_SIZE) {
>
>Isn't this early kickout? The if is only entered if there is enough
>data to run the block function, otherwise it is a straight memcpy. I
>could add an unlikely() here to favor the small data case

I did my tests only on low end hardware. 32bit PPC e500 single core 800MHz
256K cache. Maybe it prefers early return statements. 

Additionally I ended up clearing the context in the finish function with a 
simple inlined 32bit writes loop. Everything else (e.g. memzero) resulted in 
slower processing. Don't know what your clearing syntax will produce after
compilation.

Markus
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: InterScan_Disclaimer.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150329/a78a9aaf/attachment.txt>
