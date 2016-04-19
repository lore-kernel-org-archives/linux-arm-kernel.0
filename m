From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 19 Apr 2016 15:08:27 +0200
Subject: [PATCH] arm64: mm: take CWG into account in __inval_cache_range()
In-Reply-To: <20160419125615.GA20991@leverpostej>
References: <1461061773-19571-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160419125615.GA20991@leverpostej>
Message-ID: <CAKv+Gu91hFkn5k0s=xVmJ+z0vEYMNe6h6UD6z9Qb0fxe7ba0Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 April 2016 at 14:56, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Tue, Apr 19, 2016 at 12:29:33PM +0200, Ard Biesheuvel wrote:
>> Currently, the arm64 implementation of __inval_cache_range() [aka
>> __dma_inv_range()] takes CTR_EL0.Dminline into account for two purposes:
>> - the stride to use for doing by-VA cache maintenance,
>> - to check whether the start and end arguments are unaligned with respect
>>   to the cache line size, in which case the unaligned extremes need to be
>>   cleaned before being invalidated, to avoid corrupting adjacent unrelated
>>   memory contents.
>>
>> In the second case, the use of Dminline is incorrect, and should use the
>> CWG field instead, since an invalidate operation could result in cache
>> lines that are larger than Dminline to be evicted at any level of the
>> cache hierarchy.
>
> Have you seen this in practice, or was this found by inspection?
>

Amusingly, I spotted it when a Huawei engineer proposing driver code
for Tianocore questioned my demand to take CWG into account when doing
cache invalidation, because the kernel does not do it either.

> I agree that we need to round addresses to CWG boundaries when
> performing maintenance to the PoC to prevent subsequent asynchronous
> writebacks of data falling in the same CWG, which could clobber data at
> the PoC.
>
> However, if we have unrelated data in the same CWG, surely we have no
> guarantee that said data will not be dirtied in caches by other kernel
> code, and thus we may still have issues with asynchronous writebacks?
>

Indeed.

> Is sharing a CWG broken by design, or is there some caveat I'm missing
> that prevents/prohibits unrelated data from being dirtied?
>

I think sharing a CWG window is broken by design, now that I think of
it. The invalidate is part of the dma_unmap() code path, which means
the cleaning we do on the edges of the buffer may clobber data in
memory written by the device, and not cleaning isn't an option either.
