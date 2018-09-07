From: oss@buserror.net (Scott Wood)
Date: Fri, 07 Sep 2018 15:00:40 -0500
Subject: [PATCH 2/5] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
 linux/setbits.h
In-Reply-To: <1536349307-20714-3-git-send-email-clabbe@baylibre.com>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
 <1536349307-20714-3-git-send-email-clabbe@baylibre.com>
Message-ID: <8bfa1740800ca494028350addd7c874a8b4804bb.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-09-07 at 19:41 +0000, Corentin Labbe wrote:
> This patch adds setbits32/clrbits32/clrsetbits32 and
> setbits64/clrbits64/clrsetbits64 in linux/setbits.h header.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  include/linux/setbits.h | 55
> +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 include/linux/setbits.h
> 
> diff --git a/include/linux/setbits.h b/include/linux/setbits.h
> new file mode 100644
> index 000000000000..3e1e273551bb
> --- /dev/null
> +++ b/include/linux/setbits.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_SETBITS_H
> +#define __LINUX_SETBITS_H
> +
> +#include <linux/io.h>
> +
> +#define __setbits(readfunction, writefunction, addr, set) \
> +	writefunction((readfunction(addr) | (set)), addr)
> +#define __clrbits(readfunction, writefunction, addr, mask) \
> +	writefunction((readfunction(addr) & ~(mask)), addr)
> +#define __clrsetbits(readfunction, writefunction, addr, mask, set) \
> +	writefunction(((readfunction(addr) & ~(mask)) | (set)), addr)
> +#define __setclrbits(readfunction, writefunction, addr, mask, set) \
> +	writefunction(((readfunction(addr) | (seti)) & ~(mask)), addr)
> +
> +#define setbits32(addr, set) __setbits(readl, writel, addr, set)
> +#define setbits32_relaxed(addr, set) __setbits(readl_relaxed,
> writel_relaxed, \
> +					       addr, set)
> +
> +#define clrbits32(addr, mask) __clrbits(readl, writel, addr, mask)
> +#define clrbits32_relaxed(addr, mask) __clrbits(readl_relaxed,
> writel_relaxed, \
> +						addr, mask)

So now setbits32/clrbits32 is implicitly little-endian?  Introducing new
implicit-endian accessors is probably a bad thing in general, but doing it
with a name that until this patchset was implicitly big-endian (at least on
powerpc) seems worse.  Why not setbits32_le()?


> +
> +#define clrsetbits32(addr, mask, set) __clrsetbits(readl, writel, addr,
> mask, set)
> +#define clrsetbits32_relaxed(addr, mask, set) __clrsetbits(readl_relaxed, \
> +							   writel_relaxed,
> \
> +							   addr, mask, set)
> +
> +#define setclrbits32(addr, mask, set) __setclrbits(readl, writel, addr,
> mask, set)
> +#define setclrbits32_relaxed(addr, mask, set) __setclrbits(readl_relaxed, \
> +							   writel_relaxed,
> \
> +							   addr, mask, set)

What's the use case for setclrbits?  I don't see it used anywhere in this
patchset (not even in the coccinelle patterns), it doesn't seem like it would
be a common pattern, and it could easily get confused with clrsetbits.

-Scott
