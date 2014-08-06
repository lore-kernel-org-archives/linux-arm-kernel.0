From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 6 Aug 2014 13:21:18 -0400 (EDT)
Subject: [PATCH v3 2/2] ARM : change fixmap mapping region to support 32
 CPUs
In-Reply-To: <CAGXu5jKxtm0YAojOLhd_O9AFUAX+xHgEwwB0W_fpN7Xy8wHphQ@mail.gmail.com>
References: <1397559967-26050-1-git-send-email-sdu.liu@huawei.com>
 <1397559967-26050-3-git-send-email-sdu.liu@huawei.com>
 <CAL_JsqKE-L2PN3mXHNdTPMEyTMR9ZtbgGB=O_V6nOXN0YC0a4A@mail.gmail.com>
 <alpine.LFD.2.11.1405301441210.17310@knanqh.ubzr>
 <CAGXu5j+ga5Enrsd8LuYarGh1Ozakmi3MNw+b9fZ7ubGUJFZY=w@mail.gmail.com>
 <53E1A3A3.8080706@huawei.com>
 <CAGXu5jKxtm0YAojOLhd_O9AFUAX+xHgEwwB0W_fpN7Xy8wHphQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1408061317590.6061@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Aug 2014, Kees Cook wrote:

> With the original code, there is (I think) a page table entry for the
> fixmap range. For the latter, there isn't. I see a NULL pgd entry
> fault when trying to use it, and noticed that this only exists under
> highmem:
> 
> static void __init kmap_init(void)
> {
> #ifdef CONFIG_HIGHMEM
>         pkmap_page_table = early_pte_alloc(pmd_off_k(PKMAP_BASE),
>                 PKMAP_BASE, _PAGE_KERNEL_TABLE);
> 
>         fixmap_page_table = early_pte_alloc(pmd_off_k(FIXADDR_START),
>                 FIXADDR_START, _PAGE_KERNEL_TABLE);
> #endif
> }

The above is wrong.  The fixmap PTEs must be allocated unconditionally 
irrespective of highmem.  So the #endif should be moved up by 3 lines.


Nicolas
