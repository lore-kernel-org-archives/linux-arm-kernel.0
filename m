From: stockhausen@collogia.de (Markus Stockhausen)
Date: Sun, 29 Mar 2015 08:29:39 +0000
Subject: AW: [RFC PATCH 1/6] crypto: sha512: implement base layer for SHA-512
In-Reply-To: <1427580628-7128-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1427580628-7128-1-git-send-email-ard.biesheuvel@linaro.org>,
 <1427580628-7128-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <12EF8D94C6F8734FB2FF37B9FBEDD1735FC8A1E8@EXCHANGE.collogia.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Von: linux-crypto-owner at vger.kernel.org [linux-crypto-owner at vger.kernel.org]&quot; im Auftrag von &quot;Ard Biesheuvel [ard.biesheuvel at linaro.org]
> Gesendet: Samstag, 28. M?rz 2015 23:10
> An: linux-arm-kernel at lists.infradead.org; linux-crypto at vger.kernel.org; samitolvanen at google.com; herbert at gondor.apana.org.au; jussi.kivilinna at iki.fi
> Cc: Ard Biesheuvel
> Betreff: [RFC PATCH 1/6] crypto: sha512: implement base layer for SHA-512
> 
> To reduce the number of copies of boilerplate code throughout
> the tree, this patch implements generic glue for the SHA-512
> algorithm. This allows a specific arch or hardware implementation
> to only implement the special handling that it needs.

Hi Ard,

Implementing a common layer is a very good idea - I didn't like to 
implement the glue code once again for some recently developed 
PPC crypto modules. From my very short crypto experience I was 
surprised that my optimized implementations degraded disproportional 
for small calculations in the <=256byte update scenarios in contrast to 
some very old basic implementations. Below you will find some hints, 
that might fit your implementation too. Thus all new implementations 
based on your framework could benefit immediately.

> ...
> +int sha384_base_init(struct shash_desc *desc)
> +{
> +       struct sha512_state *sctx = shash_desc_ctx(desc);
> +
> +       *sctx = (struct sha512_state){
> +               .state = {
> +                       SHA384_H0, SHA384_H1, SHA384_H2, SHA384_H3,
> +                       SHA384_H4, SHA384_H5, SHA384_H6, SHA384_H7,
> +               }
> +       };
> +       return 0;
> +}

IIRC the above code will initialize the whole context including the 64/128
byte buffer. Direct assignment of the 8 hashes was faster in my case. 

> ...
> +int sha512_base_do_update(struct shash_desc *desc, const u8 *data,
> +                         unsigned int len, sha512_block_fn *block_fn, void *p)
> +{
> +       struct sha512_state *sctx = shash_desc_ctx(desc);
> +       unsigned int partial = sctx->count[0] % SHA512_BLOCK_SIZE;
> +
> +       sctx->count[0] += len;
> +       if (sctx->count[0] < len)
> +               sctx->count[1]++;

You should check if early kick out at this point if the buffer won't be filled up
is faster than first taking care about big data. That can improve performance
for small blocks while large blocks might be unaffected.

> +
> +       if ((partial + len) >= SHA512_BLOCK_SIZE) {
> +               int blocks;
> +
> +               if (partial) {
> +                       int p = SHA512_BLOCK_SIZE - partial;
> +
> +                       memcpy(sctx->buf + partial, data, p);
> +                       data += p;
> +                       len -= p;
> +               }
> +
> +               blocks = len / SHA512_BLOCK_SIZE;
> +               len %= SHA512_BLOCK_SIZE;
> +
> +               block_fn(blocks, data, sctx->state,
> +                        partial ? sctx->buf : NULL, p);
> +               data += blocks * SHA512_BLOCK_SIZE;
> +               partial = 0;
> +       }
> +       if (len)
> +               memcpy(sctx->buf + partial, data, len);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(sha512_base_do_update);
> +
> +int sha512_base_do_finalize(struct shash_desc *desc, sha512_block_fn *block_fn,
> +                           void *p)
> +{
> +       static const u8 padding[SHA512_BLOCK_SIZE] = { 0x80, };
> +
> +       struct sha512_state *sctx = shash_desc_ctx(desc);
> +       unsigned int padlen;
> +       __be64 bits[2];
> +
> +       padlen = SHA512_BLOCK_SIZE -
> +                (sctx->count[0] + sizeof(bits)) % SHA512_BLOCK_SIZE;
> +
> +       bits[0] = cpu_to_be64(sctx->count[1] << 3 |
> +                             sctx->count[0] >> 61);
> +       bits[1] = cpu_to_be64(sctx->count[0] << 3);
> +
> +       sha512_base_do_update(desc, padding, padlen, block_fn, p);

I know that this is the most intuitive and straight implementation for handling
finalization. Nevertheless the maybe a little obscure generic md5 algorithm
gives best in class performance for hash finalization of small input data. 

For comparison: From the raw numbers the sha1-ppc-spe assembler module 
written by me is only 10% faster than the old sha1-popwerpc assembler module. 
Both are simple assembler algorithms without hardware acceleration. For large 
blocks I gain another 8% by avoding function calls because the core module 
may process several blocks. But for small single block updates the above glue 
code optimizations gave

16byte block single update: +24%
64byte block single update: +16%
256byte block single update +12%

Considering CPU assisted SHA calculations that percentage may be even higher.

Maybe worth the effort ... 

Markus
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: InterScan_Disclaimer.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150329/1fc3f995/attachment-0001.txt>
