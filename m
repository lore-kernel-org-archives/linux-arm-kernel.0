From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 28 Jun 2017 11:58:24 +0300
Subject: [PATCH 2/2] dmaengine: dmatest: add support for memset test
In-Reply-To: <1498610786-6090-2-git-send-email-okaya@codeaurora.org>
References: <1498610786-6090-1-git-send-email-okaya@codeaurora.org>
 <1498610786-6090-2-git-send-email-okaya@codeaurora.org>
Message-ID: <CAHp75Vdw2orpkx4C+O6CLHBWOUDrS8rWPuuDV0DzOCqu8kWkGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 3:46 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Introducing memset test into dmatest. This change allows us to test
> memset capable HW using the dmatest test procedure. The new dmatest
> value for memset is 2 and it is not the default value.
>
> Memset support patch shares the same code path as the other dmatest
> code to reuse as much as we can.
>
> The first value inside the source buffer is used as a pattern
> to fill in the destination buffer space.
>
> Prior to running the test, source/destination buffers are initialized
> in the current code.
>
> "The remaining bits are the inverse of a counter which increments by
>  one for each byte address."
>
> Memset test will fill in the upper bits of pattern with the inverse of
> fixed counter value 1 as opposed to an incrementing value in a loop.
>
> An example run is as follows:
>
> echo dma0chan0 > /sys/module/dmatest/parameters/channel
> echo 2 >  /sys/module/dmatest/parameters/dmatest
> echo 2000 >  /sys/module/dmatest/parameters/timeout
> echo 10 >  /sys/module/dmatest/parameters/iterations
> echo 1 >  /sys/module/dmatest/parameters/run

Good someone is developing tests!
My comments below.

>  static void dmatest_init_srcs(u8 **bufs, unsigned int start, unsigned int len,
> +               unsigned int buf_size, bool is_memset)
>  {
>         unsigned int i;
>         u8 *buf;
>
>         for (; (buf = *bufs); bufs++) {
> +               for (i = 0; i < start; i++) {

> +                       unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
> +
> +                       buf[i] = PATTERN_SRC | (~val & PATTERN_COUNT_MASK);

> +                       unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
> +
>                         buf[i] = PATTERN_SRC | PATTERN_COPY
> +                               | (~val & PATTERN_COUNT_MASK);

> +                       unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
> +
> +                       buf[i] = PATTERN_SRC | (~val & PATTERN_COUNT_MASK);

Looks like a candidate now for a helper function

static inline u8 gen_src_value(u8 index, bool is_memset)
{
    u8 val = is_memset ? PATTERN_MEMSET_IDX : i;
    return PATTERN_SRC | (~val & PATTERN_COUNT_MASK);
}

buf[i] = gen_src_value(i, is_memset);
buf[i] = gen_src_value(i, is_memset) | PATTERN_COPY;
buf[i] = gen_src_value(i, is_memset);

> +                       unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
> +
> +                       buf[i] = PATTERN_DST | (~val & PATTERN_COUNT_MASK);

> +                       unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
> +
>                         buf[i] = PATTERN_DST | PATTERN_OVERWRITE
> +                               | (~val & PATTERN_COUNT_MASK);

> +                       unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
> +
> +                       buf[i] = PATTERN_DST | (~val & PATTERN_COUNT_MASK);

Ditto for DST.

> +               unsigned int counter, bool is_srcbuf, bool is_memset)

This is a signal to replace it with

unsigned int flags

#define DMATEST_FL_SRCBUF BIT(0)
#define DMATEST_FL_MEMSET BIT(1)

or alike.

I'm not insisting, just consider an opportunity.

> +               bool is_srcbuf, bool is_memset)

Ditto.

>                 start = ktime_get();
> +
>                 pr_debug("%s: verifying source buffer...\n", current->comm);

The change doesn't belong to the patch.

> +
>                 error_count += dmatest_verify(thread->dsts, dst_off + len,

Ditto.

-- 
With Best Regards,
Andy Shevchenko
