From: davem@davemloft.net (David Miller)
Date: Tue, 15 Apr 2014 22:24:23 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <CAA3XUr0+u9YCDhRx5xZgKC3GH1Y0Xiwh2731QWkWn0rGu7T2Gg@mail.gmail.com>
References: <534D8AE6.3090609@linaro.org>
 <20140415.155330.2253279045572024595.davem@davemloft.net>
 <CAA3XUr0+u9YCDhRx5xZgKC3GH1Y0Xiwh2731QWkWn0rGu7T2Gg@mail.gmail.com>
Message-ID: <20140415.222423.744939892935802931.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Kamensky <victor.kamensky@linaro.org>
Date: Tue, 15 Apr 2014 18:42:39 -0700

> +void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> +                  void *src, unsigned long len)
> +{
> +    /* Initialize the slot */
> +    copy_to_page(page, vaddr, src, len);
> +
> +    /*
> +     * We probably need flush_icache_user_range() but it needs vma.
> +     * This should work on most of architectures by default. If
> +     * architecture needs to do something different it can define
> +     * its own version of the function.
> +     */
> +    flush_dcache_page(page);
> +}
> +

I would say that, if anything, flush_dcache_page() is unnecessary
if you just copy straight to userspace.

The default implementation should be copy_to_user(), and that's what
every architecture can use if it needs no I-cache flushing.
