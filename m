From: drake@endlessm.com (Daniel Drake)
Date: Wed, 25 Feb 2015 07:58:00 -0600
Subject: [PATCH] ARM: dma-mapping: support non-consistent DMA attribute
In-Reply-To: <16874142.jSTJ8OZePS@wuerfel>
References: <1424810703-20382-1-git-send-email-drake@endlessm.com>
 <16874142.jSTJ8OZePS@wuerfel>
Message-ID: <CAD8Lp46KOQZMJqiqudE_0nvpaHgYxpD0qCeM2r8ZOgfzJUo6dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 4:24 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 24 February 2015 14:45:03 Daniel Drake wrote:
>> Currently when arm_dma_mmap() is called, vm_page_prot is reset
>> according to DMA attributes. Currently, writecombine is the
>> only attribute supported; any other configuration will map uncached
>> memory.
>>
>> Add support for the non-consistent attribute so that cachable memory
>> can be mapped into userspace via the dma_mmap_attrs() API.
>>
>> Signed-off-by: Daniel Drake <drake@endlessm.com>
>>
>
> How does the user process enforce consistency then?

Hmm, good point.

The use case here is that we're mapping certain memory shared with the
Mali GPU into userspace, where we expect the CPU to be doing rendering
to it, and we've measured performance improvements from having the CPU
cache enabled. But Mali also comes alongside UMP (comparable to
dma-buf) which provides an ioctl-based API for userspace to
invalidate/flush caches, which we use heavily in this pipeline.

UMP's not going upstream, but I was wondering if this patch had any
value in the more general case. Thinking more, perhaps not, at least
until dma-buf grows some form of userspace cache control API.

Daniel
