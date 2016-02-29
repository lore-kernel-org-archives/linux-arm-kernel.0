From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 29 Feb 2016 10:04:38 -0800
Subject: [PATCH] crypto/async_pq: use __free_page() instead of put_page()
In-Reply-To: <1456738445-876239-1-git-send-email-arnd@arndb.de>
References: <1456738445-876239-1-git-send-email-arnd@arndb.de>
Message-ID: <CAPcyv4jJzUieZ0i2jBqANwmYPUBVmQmhoDTPnr0KjPQXnoZqWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 1:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The addition of tracepoints to the page reference tracking had an
> unfortunate side-effect in at least one driver that calls put_page
> from its exit function, resulting in a link error:
>
> `.exit.text' referenced in section `__jump_table' of crypto/built-in.o: defined in discarded section `.exit.text' of crypto/built-in.o
>
> From a cursory look at that this driver, it seems that it may be
> doing the wrong thing here anyway, as the page gets allocated
> using 'alloc_page()', and should be freed using '__free_page()'
> rather than 'put_page()'.
>
> With this patch, I no longer get any other build errors from the
> page_ref patch, so hopefully we can assume that it's always wrong
> to call any of those functions from __exit code, and that no other
> driver does it.
>
> Fixes: 0f80830dd044 ("mm/page_ref: add tracepoint to track down page reference manipulation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Dan Williams <dan.j.williams@intel.com>

Vinod, will you take this one?
