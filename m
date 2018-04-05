From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Apr 2018 09:00:08 +0200
Subject: [PATCH v3 1/5] io: define several IO & PIO barrier types for the
 asm-generic version
In-Reply-To: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
References: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
Message-ID: <CAK8P3a0Noun+8AaRUcMdOX09KXxFXZxfcyUgJnezPkS2gVkg6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2018 at 1:58 AM, Sinan Kaya <okaya@codeaurora.org> wrote:

Looks good, but I'd change the comments to ones that document exactly
what those barriers are for:

> +#ifndef __io_ar
> +#ifdef rmb
> +/* prefer rmb() as the default implementation of __io_ar() if supported */
> +#define __io_ar()      rmb()

/*
 * prevent prefetching of coherent DMA data ahead of a dma-complete */

> +#ifndef __io_bw
> +#ifdef wmb
> +/* prefer wmb() as the default implementation of __io_bw() if supported */
> +#define __io_bw()      wmb()
> +#else

/* flush writes to coherent DMA data before possibly triggering a DMA read */

> +#ifndef __io_aw
> +#define __io_aw()      barrier()
> +#endif

/* serialize device access against a spin_unlock, usually handled there */

The other four patches look perfect already.  What's the timing we need for
these patches? Are they 4.18 material, or do we need them in 4.17 and
stable kernels to work around known bugs?

      Arnd
