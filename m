From: clabbe@baylibre.com (LABBE Corentin)
Date: Thu, 27 Sep 2018 07:35:08 +0200
Subject: [PATCH v2 2/7] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
 linux/setbits.h
In-Reply-To: <4a63152f-9eca-f7d9-8fe6-59caaab33666@c-s.fr>
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-3-git-send-email-clabbe@baylibre.com>
 <4a63152f-9eca-f7d9-8fe6-59caaab33666@c-s.fr>
Message-ID: <20180927053508.GB27637@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 07:05:00AM +0200, Christophe LEROY wrote:
> 
> 
> Le 24/09/2018 ? 21:04, Corentin Labbe a ?crit?:
> > This patch adds setbits32/clrbits32/clrsetbits32 and
> > setbits64/clrbits64/clrsetbits64 in linux/setbits.h header.
> 
> Fix the patch subject and description.
> 
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >   include/linux/setbits.h | 88 +++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 88 insertions(+)
> >   create mode 100644 include/linux/setbits.h
> > 
> > diff --git a/include/linux/setbits.h b/include/linux/setbits.h
> > new file mode 100644
> > index 000000000000..6e7e257134ae
> > --- /dev/null
> > +++ b/include/linux/setbits.h
> > @@ -0,0 +1,88 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __LINUX_SETBITS_H
> > +#define __LINUX_SETBITS_H
> > +
> > +#include <linux/io.h>
> > +
> > +#define __setbits(readfunction, writefunction, addr, set) \
> > +	writefunction((readfunction(addr) | (set)), addr)
> 
> You don't need so long names for parameters in a 2 lines macro (See 
> Linux Kernel Codying style ?4 Naming).
> 
> A single line macro would be feasible with only 3 chars names:
> 
> #define __setbits(rfn, wfn, addr, set) wfn((rfn(addr) | (set)), addr)
> 

Thanks I will fix all reported problem.

> > +#define __clrbits(readfunction, writefunction, addr, mask) \
> > +	writefunction((readfunction(addr) & ~(mask)), addr)
> > +#define __clrsetbits(readfunction, writefunction, addr, mask, set) \
> > +	writefunction(((readfunction(addr) & ~(mask)) | (set)), addr)
> > +#define __setclrbits(readfunction, writefunction, addr, mask, set) \
> > +	writefunction(((readfunction(addr) | (set)) & ~(mask)), addr)
> > +
> > +#ifndef setbits_le32
> > +#define setbits_le32(addr, set) __setbits(readl, writel, addr, set)
> > +#endif
> > +#ifndef setbits_le32_relaxed
> > +#define setbits_le32_relaxed(addr, set) __setbits(readl_relaxed, writel_relaxed, \
> > +					       addr, set)
> > +#endif
> > +
> > +#ifndef clrbits_le32
> > +#define clrbits_le32(addr, mask) __clrbits(readl, writel, addr, mask)
> > +#endif
> > +#ifndef clrbits_le32_relaxed
> > +#define clrbits_le32_relaxed(addr, mask) __clrbits(readl_relaxed, writel_relaxed, \
> > +						addr, mask)
> > +#endif
> > +
> > +#ifndef clrsetbits_le32
> > +#define clrsetbits_le32(addr, mask, set) __clrsetbits(readl, writel, addr, mask, set)
> > +#endif
> > +#ifndef clrsetbits_le32_relaxed
> > +#define clrsetbits_le32_relaxed(addr, mask, set) __clrsetbits(readl_relaxed, \
> > +							   writel_relaxed, \
> > +							   addr, mask, set)
> > +#endif
> > +
> > +#ifndef setclrbits_le32
> > +#define setclrbits_le32(addr, mask, set) __setclrbits(readl, writel, addr, mask, set)
> > +#endif
> > +#ifndef setclrbits_le32_relaxed
> > +#define setclrbits_le32_relaxed(addr, mask, set) __setclrbits(readl_relaxed, \
> > +							   writel_relaxed, \
> > +							   addr, mask, set)
> > +#endif
> > +
> > +/* We cannot use CONFIG_64BIT as some x86 drivers use non-atomicwriteq() */
> > +#if defined(writeq) && defined(readq)
> 
> Take care. At least Alpha Arch defines it as a static inline without
> redefining it as a #define. (see arch/alpha/kernel/io.c)

In fact, it does in arch/alpha/include/asm/io.h along with a gentle comment.
But fixing their comment will be another interesting patch serie.

Regards
Corentin Labbe
