From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 1 Mar 2016 16:43:46 +0100
Subject: [PATCH v2 5/9] arm64: mm: move vmemmap region right below the
 linear region
In-Reply-To: <20160301153957.GA22107@localhost.localdomain>
References: <1456757084-1078-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456757084-1078-6-git-send-email-ard.biesheuvel@linaro.org>
 <20160301153957.GA22107@localhost.localdomain>
Message-ID: <CAKv+Gu9q-Z2mXtvPQUA2du_VhAwLGp04-5E8cGtyk1zVbGjZEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 March 2016 at 16:39, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Feb 29, 2016 at 03:44:40PM +0100, Ard Biesheuvel wrote:
>> @@ -404,6 +404,12 @@ void __init mem_init(void)
>>       BUILD_BUG_ON(TASK_SIZE_32                       > TASK_SIZE_64);
>>  #endif
>>
>> +     /*
>> +      * Make sure we chose the upper bound of sizeof(struct page)
>> +      * correctly.
>> +      */
>> +     BUILD_BUG_ON(sizeof(struct page) > (1 << STRUCT_PAGE_MAX_SHIFT));
>
> Since with the vmemmap fix you already assume that PAGE_OFFSET is half
> of the VA space, we should add another check on PAGE_OFFSET !=
> UL(0xffffffffffffffff) << (VA_BITS - 1), just in case someone thinks
> they could map a bit of extra RAM without going for a larger VA.
>

Indeed. The __pa() check only checks a single bit, so it must be split
exactly in half, unless we want to revisit that in the future (if
__pa() is no longer on a hot path after changes like these).
