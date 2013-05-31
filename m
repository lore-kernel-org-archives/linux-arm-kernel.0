From: tom.leiming@gmail.com (Ming Lei)
Date: Fri, 31 May 2013 17:07:22 +0800
Subject: [PATCH V4] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
References: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <CACVXFVOo6HNXeZ95QqAXU64aAmXXrTVsHJ9TvgirWKOWmwnSfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 12, 2013 at 1:35 PM, Simon Baatz <gmbnomis@gmail.com> wrote:
> +void flush_kernel_dcache_page(struct page *page)
> +{
> +       if (cache_is_vivt() || cache_is_vipt_aliasing()) {
> +               struct address_space *mapping;
> +
> +               mapping = page_mapping(page);
> +
> +               if (!mapping || mapping_mapped(mapping))

It is better to replace mapping_mapped(mapping) with page_mapped(page).

> +                       __flush_kernel_dcache_page(page);

I am wondering if I-cache should be flushed here since the user mapping
on the page may be executable and I/D coherency should be maintained.


Thanks,
-- 
Ming Lei
