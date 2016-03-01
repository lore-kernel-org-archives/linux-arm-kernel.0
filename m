From: js1304@gmail.com (Joonsoo Kim)
Date: Tue, 1 Mar 2016 22:54:50 +0900
Subject: [PATCH] crypto/async_pq: use __free_page() instead of put_page()
In-Reply-To: <CAPcyv4jJzUieZ0i2jBqANwmYPUBVmQmhoDTPnr0KjPQXnoZqWQ@mail.gmail.com>
References: <1456738445-876239-1-git-send-email-arnd@arndb.de>
 <CAPcyv4jJzUieZ0i2jBqANwmYPUBVmQmhoDTPnr0KjPQXnoZqWQ@mail.gmail.com>
Message-ID: <CAAmzW4Nq8LiFGzyR4YjG8OPev-Pj1dUad+Bus2puSAk_tUcCsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-03-01 3:04 GMT+09:00 Dan Williams <dan.j.williams@intel.com>:
> On Mon, Feb 29, 2016 at 1:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> The addition of tracepoints to the page reference tracking had an
>> unfortunate side-effect in at least one driver that calls put_page
>> from its exit function, resulting in a link error:
>>
>> `.exit.text' referenced in section `__jump_table' of crypto/built-in.o: defined in discarded section `.exit.text' of crypto/built-in.o
>>
>> From a cursory look at that this driver, it seems that it may be
>> doing the wrong thing here anyway, as the page gets allocated
>> using 'alloc_page()', and should be freed using '__free_page()'
>> rather than 'put_page()'.
>>
>> With this patch, I no longer get any other build errors from the
>> page_ref patch, so hopefully we can assume that it's always wrong
>> to call any of those functions from __exit code, and that no other
>> driver does it.
>>
>> Fixes: 0f80830dd044 ("mm/page_ref: add tracepoint to track down page reference manipulation")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
>
> Vinod, will you take this one?

Problematic patch ("mm/page_ref: ~~~") is not yet merged one. It is on mmotm
and this fix should go together with it or before it. I think that
handling this fix by
Andrew is easier to all.

Thanks.
