From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Tue, 26 May 2015 17:12:39 +0300
Subject: [PATCH v2 5/5] arm64: add KASan support
In-Reply-To: <CACRpkda3Pe9L14_iyKEfeCx1F3XJSLbz_OVHLxX0Lzy9Gt9t9Q@mail.gmail.com>
References: <1431698344-28054-1-git-send-email-a.ryabinin@samsung.com>
 <1431698344-28054-6-git-send-email-a.ryabinin@samsung.com>
 <CACRpkda3Pe9L14_iyKEfeCx1F3XJSLbz_OVHLxX0Lzy9Gt9t9Q@mail.gmail.com>
Message-ID: <55647F57.8010008@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2015 04:35 PM, Linus Walleij wrote:
> On Fri, May 15, 2015 at 3:59 PM, Andrey Ryabinin <a.ryabinin@samsung.com> wrote:
> 
> And then at boot I just get this:
> 
> kasan test: kmalloc_oob_right out-of-bounds to right
> kasan test: kmalloc_oob_left out-of-bounds to left
> kasan test: kmalloc_node_oob_right kmalloc_node(): out-of-bounds to right
> kasan test: kmalloc_large_oob_rigth kmalloc large allocation:
> out-of-bounds to right
> kasan test: kmalloc_oob_krealloc_more out-of-bounds after krealloc more
> kasan test: kmalloc_oob_krealloc_less out-of-bounds after krealloc less
> kasan test: kmalloc_oob_16 kmalloc out-of-bounds for 16-bytes access
> kasan test: kmalloc_oob_in_memset out-of-bounds in memset
> kasan test: kmalloc_uaf use-after-free
> kasan test: kmalloc_uaf_memset use-after-free in memset
> kasan test: kmalloc_uaf2 use-after-free after another kmalloc
> kasan test: kmem_cache_oob out-of-bounds in kmem_cache_alloc
> kasan test: kasan_stack_oob out-of-bounds on stack
> kasan test: kasan_global_oob out-of-bounds global variable
> 
> W00t no nice KASan warnings (which is what I expect).
> 
> This is my compiler by the way:
> $ arm-linux-gnueabihf-gcc --version
> arm-linux-gnueabihf-gcc (crosstool-NG linaro-1.13.1-4.9-2014.09 -
> Linaro GCC 4.9-2014.09) 4.9.2 20140904 (prerelease)
> 
> I did the same exercise on the foundation model (FVP) and I guess
> that is what you developed the patch set on because there I got
> nice KASan dumps:
> 

That's not kasan dumps. That is slub debug output.
KASan warnings starts with
	"BUG: KASan: use after free/out of bounds access "
line.

> I wonder were the problem lies, any hints where to start looking
> to fix this?
> 

I suspect that your compiler lack -fsantize=kernel-address support.
It seems that GCC 4.9.2 doesn't supports -fsanitize=address/kernel-address on aarch64.

I tested this patchset on Cavium Thunder-x and on FVP also and didn't observe any problems.

> Yours,
> Linus Walleij
> 
