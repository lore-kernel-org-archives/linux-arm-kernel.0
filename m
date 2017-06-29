From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 29 Jun 2017 15:05:58 +0300
Subject: [PATCH V2 2/2] dmaengine: dmatest: add support for memset test
In-Reply-To: <1498701116-9787-2-git-send-email-okaya@codeaurora.org>
References: <1498701116-9787-1-git-send-email-okaya@codeaurora.org>
 <1498701116-9787-2-git-send-email-okaya@codeaurora.org>
Message-ID: <CAHp75VfJ=nq4Ycd7SDiXbW4hXNZ3o_6VEiF7JM3J=vrwVcUnYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 4:51 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Introducing memset test into dmatest. It allows us to test memset capable
> HW using the dmatest suite. The new dmatest value is 2 and it is
> changeable through sysfs.
>
> Memset shares the same code path as the other dmatest code. The only
> difference is that the first value inside the source buffer is used
> to fill in the destination address space.
>
> Source/destination buffers are initialized with the 1 counter value
> prior to test so that we can do pattern check against a known expected
> value.
>
> An example run us as follows:
>
> echo dma0chan0 > /sys/module/dmatest/parameters/channel
> echo 2 >  /sys/module/dmatest/parameters/dmatest
> echo 2000 >  /sys/module/dmatest/parameters/timeout
> echo 10 >  /sys/module/dmatest/parameters/iterations
> echo 1 >  /sys/module/dmatest/parameters/run
>

See my comments below.
After addressing them,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> +static inline u8 gen_inv_idx(u8 index, bool is_memset)
> +{
> +       u8 val = is_memset ? PATTERN_MEMSET_IDX : index;
> +

> +       return (~val & PATTERN_COUNT_MASK);

Redundant parens.

> +}

> +                       buf[i] = gen_src_value(i, is_memset);
> +

Please, remove this new empty lines which doesn't belong to the patch.

> +                       buf[i] = gen_src_value(i, is_memset) | PATTERN_COPY;
> +

Ditto.

> +                       buf[i] = gen_dst_value(i, is_memset);
> +

Ditto.

> +                       buf[i] = gen_dst_value(i, is_memset) |
> +                                               PATTERN_OVERWRITE;
> +

Ditoo.

> +                               0, PATTERN_DST, false, is_memset);
> +

Ditto.

> +                               PATTERN_SRC | PATTERN_COPY, false, is_memset);
> +

Ditto.

> +       if (dma_has_cap(DMA_MEMSET, dma_dev->cap_mask)) {
> +               if (dmatest == 2) {

Double if is effectively && in this case. Though it looks like the
pattern already in use in the module.
So, for now we might leave it untouched.

> +                       cnt = dmatest_add_threads(info, dtc, DMA_MEMSET);
> +                       thread_count += cnt > 0 ? cnt : 0;
> +               }
> +       }

-- 
With Best Regards,
Andy Shevchenko
