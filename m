From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 15 Apr 2014 20:06:57 -0700
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140415.222423.744939892935802931.davem@davemloft.net>
References: <534D8AE6.3090609@linaro.org>
 <20140415.155330.2253279045572024595.davem@davemloft.net>
 <CAA3XUr0+u9YCDhRx5xZgKC3GH1Y0Xiwh2731QWkWn0rGu7T2Gg@mail.gmail.com>
 <20140415.222423.744939892935802931.davem@davemloft.net>
Message-ID: <CAA3XUr1JLq56x0VX+x5hnk9H4VjVUPSJOSUp2aEyoY99o+NbOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 April 2014 19:24, David Miller <davem@davemloft.net> wrote:
> From: Victor Kamensky <victor.kamensky@linaro.org>
> Date: Tue, 15 Apr 2014 18:42:39 -0700
>
>> +void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>> +                  void *src, unsigned long len)
>> +{
>> +    /* Initialize the slot */
>> +    copy_to_page(page, vaddr, src, len);
>> +
>> +    /*
>> +     * We probably need flush_icache_user_range() but it needs vma.
>> +     * This should work on most of architectures by default. If
>> +     * architecture needs to do something different it can define
>> +     * its own version of the function.
>> +     */
>> +    flush_dcache_page(page);
>> +}
>> +
>
> I would say that, if anything, flush_dcache_page() is unnecessary
> if you just copy straight to userspace.
> The default implementation should be copy_to_user(), and that's what
> every architecture can use if it needs no I-cache flushing.

OK, got it. I tried not to touch existing cases (x86 and ppc), but yes
it would benefit here as well.

But don't you think that writable and executable uprobes
xol page is show stopper for this approach?

Thanks,
Victor
