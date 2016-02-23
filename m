From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 23 Feb 2016 13:18:12 +0100
Subject: [RFC PATCH 01/10] arm64: mm: move assignment of 'high_memory'
 before its first use
In-Reply-To: <20160223121435.GA4777@e104818-lin.cambridge.arm.com>
References: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456174472-30028-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160223121435.GA4777@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu9ceu3sBUCemq6DK7frYh7vKDOPGvHswQw4JCVOA6AvZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 February 2016 at 13:14, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Feb 22, 2016 at 09:54:23PM +0100, Ard Biesheuvel wrote:
>> The variable 'high_memory' ends up being referenced in the call to
>> dma_contiguous_reserve(). So move the assignment before that call.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Does this need cc stable? It looks like we've had this issue for a while
> and it ends up being used in cma_declare_contiguous(). So we either get
> a high enough value to not affect this function or we don't trigger this
> code path very often.
>

I would guess cc'ing stable would be appropriate, although I think
keeping it at 0x0 has no ill side effects, other than that the CMA
layer cannot figure out if the allocation is entirely above or
entirely below the highmem limit, and of course, that is kind of moot
on arm64

I haven't noticed any runtime changes with this fixed
