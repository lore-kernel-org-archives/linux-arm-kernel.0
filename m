From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 7 Apr 2014 17:04:52 +0100
Subject: [RFC] Extend zImage format to support notes
In-Reply-To: <5342AF59.3030405@linaro.org>
References: <5342AF59.3030405@linaro.org>
Message-ID: <20140407160452.GB14062@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 02:59:53PM +0100, Julien Grall wrote:
> Hello all,

Hi Julien,

> Currently ELF is supporting notes (see include/linux/elfnote.h) which
> is used by Xen to know the feature supported by the kernel.

What kind of features do you intend for Xen discover through this
mechanism on ARM?

Can support for these not be negotiated at run-time (how does this work
with other OSs under Xen)?

> On ARM world, the zImage format is mainly used by the distribution.
> Rather than ELF, it's currently not possible to add notes on it.
> 
> ==== Current zImage format ====
> 
> The header starts at offset 0x24:
>     uint32_t  magic      /* Magic number: 0x016f2818 */
>     uint32_t  start      /* absolute load/run zImage address */
>     uint32_t  end        /* zImage end address */
> 
> ==== Extension proposed to zImage format ===
> 
> The header stays compatible with the current format and starts at offset 0x24:
>     uint32_t  magic0     /* Magic number : 0x16f2818 */
>     uint32_t  start      /* absolute load/run zImage address */
>     uint32_t  end        /* zImage end address */
>     uint32_t  magic1     /* Magic number : "ARM\x32" */
>     uint32_t  note_start /* Notes section offset */
>     uint32_t  note_end   /* Notes sections end */

On arm64 we seem to have a notes section but no pointer to it in the
Image header. I assume you'd consider a notes section useful for 64-bit
too?

I have some patches extending the header for arm64 which I intend to
post shortly; if we're going to clash there and this is needed, perhaps
I can fold in a similar update.

Cheers,
Mark.
