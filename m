From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 31 Jan 2017 18:30:34 +0000
Subject: [PATCH v2 0/4] crypto: time invariant AES for CCM (and GCM/CTR)
In-Reply-To: <1485646413-17491-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1485646413-17491-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu9GXmMzHiOZE57xQEwoH4ib1dq7LZFPia=nr27bj_pdkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 January 2017 at 23:33, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> This series is primarily directed at improving the performance and security
> of CCM on the Rasperry Pi 3. This involves splitting the MAC handling of
> CCM into a separate driver so that we can efficiently replace it by something
> else using the ordinary algo resolution machinery.
>
> Patch #1 adds some testcases for cbcmac(aes), which will be introduced later.
>
> Patch #2 replaces the open coded CBC MAC hashing routines in the CCM driver
> with calls to a cbcmac() hash, and implements a template for producing such
> transforms. This eliminates all the fuzzy scatterwalk code as well.
>
> Patch #3 implements cbcmac(aes) using NEON on arm64
>
> Patch #4 is an RFC patch that implements ctr(aes) and cbcmac(aes) in a way
> that is intended to eliminate observeable data dependent latencies in AES
> processing, by replacing the usual 16 KB of lookup tables with a single
> Sbox that is prefetched before processing each block. It is 50% slower than
> generic AES, but this may be acceptable in many cases.
>
> Changes since v1:
> - remove ilen, and add missing flags assignment (#2)
> - deal with zero cryptlen (#2)
> - use correctly sized dg[] array in desc ctx (#3, #4)
> - fix bug in update routine (#3)
> - various other tweaks
>
> Ard Biesheuvel (4):
>   crypto: testmgr - add test cases for cbcmac(aes)
>   crypto: ccm - switch to separate cbcmac driver
>   crypto: arm64/aes - add NEON and Crypto Extension CBC-MAC driver
>   crypto: aes - add generic time invariant AES for CTR/CCM/GCM
>

I have updated versions of these that make use of the alignment
agnostic crypto_xor(). I will respin these once that patch gets
discussed/merged/rejected/etc
