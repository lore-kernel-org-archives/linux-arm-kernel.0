From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Aug 2017 19:32:18 +0100
Subject: [PATCH 6/6] arm64: uaccess: Implement *_flushcache variants
In-Reply-To: <a82a48f72b8099c1ef6a32a63819619637797ef8.1500397441.git.robin.murphy@arm.com>
References: <cover.1500397441.git.robin.murphy@arm.com>
 <a82a48f72b8099c1ef6a32a63819619637797ef8.1500397441.git.robin.murphy@arm.com>
Message-ID: <20170807183217.GB29632@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 11:55:43AM +0100, Robin Murphy wrote:
> Implement the set of copy functions with guarantees of a clean cache
> upon completion necessary to support the pmem driver.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/Kconfig                  |  1 +
>  arch/arm64/include/asm/string.h     |  4 ++++
>  arch/arm64/include/asm/uaccess.h    | 12 ++++++++++
>  arch/arm64/lib/Makefile             |  2 ++
>  arch/arm64/lib/uaccess_flushcache.c | 47 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 66 insertions(+)
>  create mode 100644 arch/arm64/lib/uaccess_flushcache.c

[...]

> diff --git a/arch/arm64/lib/uaccess_flushcache.c b/arch/arm64/lib/uaccess_flushcache.c
> new file mode 100644
> index 000000000000..b6ceafdb8b72
> --- /dev/null
> +++ b/arch/arm64/lib/uaccess_flushcache.c
> @@ -0,0 +1,47 @@
> +/*
> + * Copyright (C) 2017 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/uaccess.h>
> +#include <asm/barrier.h>
> +#include <asm/cacheflush.h>
> +
> +void memcpy_flushcache(void *dst, const void *src, size_t cnt)
> +{
> +	/*
> +	 * We assume this should not be called with @dst pointing to
> +	 * non-cacheable memory, such that we don't need an explicit
> +	 * barrier to order the cache maintenance against the memcpy.
> +	 */
> +	memcpy(dst, src, cnt);
> +	__clean_dcache_area_pop(dst, cnt);
> +}
> +EXPORT_SYMBOL_GPL(memcpy_flushcache);
> +
> +void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
> +			    size_t len)
> +{
> +	memcpy_flushcache(to, page_address(page) + offset, len);
> +}
> +
> +unsigned long __copy_user_flushcache(void *to, const void __user *from,
> +				     unsigned long n)
> +{
> +	unsigned long rc = __arch_copy_from_user(to, from, n);

I'm a bit nervous calling the bare user accessor here without an access_ok
check beforehand. Can we rely on the caller having done the check for us? I
tried to follow the breadcrumbs back out, but I noticed that other iov
iterators (such as copy_from_iter) *do* do the bounds check, whereas the
pmem version (copy_from_iter_nocache) doesn't appear to check the address.

Is that right?

Will
