From: stefan@agner.ch (Stefan Agner)
Date: Fri, 10 Aug 2018 10:05:06 +0200
Subject: [PATCH v8 1/3] dmaengine: fsl-edma: extract common fsl-edma code
 (no changes in behavior intended)
In-Reply-To: <20180809223714.GA6467@jerusalem>
References: <20180803193244.12084-1-angelo@sysam.it>
 <326d1fd7010c34488af6a874011d5280@agner.ch>
 <CAJKOXPchX3H9JVf1VyA+m9waLz74DnWRb2xLBg4yp=YbrEGu0Q@mail.gmail.com>
 <fbf2faba97ca1d6f5887e0192139c6fa@agner.ch>
 <20180809223714.GA6467@jerusalem>
Message-ID: <459738df7f6c9d439d968e4db67b1cd0@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.08.2018 00:37, Angelo Dureghello wrote:
> Hi Stefan,
> 
> i am about to post a v9 in short.
> 
> On Tue, Aug 07, 2018 at 07:47:19PM +0200, Stefan Agner wrote:
>> On 07.08.2018 14:14, Krzysztof Kozlowski wrote:
>> > On 7 August 2018 at 10:08, Stefan Agner <stefan@agner.ch> wrote:
>> >> On 03.08.2018 21:32, Angelo Dureghello wrote:
>> >>> This patch adds a new fsl-edma-common module to allow new
>> >>> mcf-edma module code to use most of the fsl-edma code.
>> >>>
>> >>> Signed-off-by: Angelo Dureghello <angelo@sysam.it>
>> >>> ---
>> >>> Changes for v2:
>> >>> - patch splitted into 4
>> >>> - add mcf-edma as minimal different parts from fsl-edma
>> >>>
>> >>> Changes for v3:
>> >>> none
>> >>>
>> >>> Changes for v4:
>> >>> - patch simplified from 4/4 into 2/2
>> >>> - collecting all the mcf-edma-related changes
>> >>>
>> >>> Changes for v5:
>> >>> none
>> >>>
>> >>> Changes for v6:
>> >>> - adjusted comment header
>> >>> - fixed bit shift with BIT()
>> >>> - we need to free the interrupts at remove(), so removed all devm_
>> >>>   interrupt related calls
>> >>>
>> >>> Changes for v7:
>> >>> none
>> >>>
>> >>> Changes for v8:
>> >>> - patch rewritten from scratch, splitted into 3, common code isolated,
>> >>>   minimal changes from the original Freescale code have been done.
>> >>>   The patch has been tested with both Iris + Colibri Vybrid VF50 and
>> >>>   stmark2/mcf54415 Coldfire boards.
>> >>> ---
>> >>>  drivers/dma/Makefile          |   2 +-
>> >>>  drivers/dma/fsl-edma-common.c | 576 ++++++++++++++++++++++++++++
>> >>>  drivers/dma/fsl-edma-common.h | 196 ++++++++++
>> >>>  drivers/dma/fsl-edma.c        | 697 +---------------------------------
>> >>>  4 files changed, 774 insertions(+), 697 deletions(-)
>> >>>  create mode 100644 drivers/dma/fsl-edma-common.c
>> >>>  create mode 100644 drivers/dma/fsl-edma-common.h
>> >>>
>> >>> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
>> >>> index 203a99d68315..66022f59fca4 100644
>> >>> --- a/drivers/dma/Makefile
>> >>> +++ b/drivers/dma/Makefile
>> >>> @@ -31,7 +31,7 @@ obj-$(CONFIG_DW_AXI_DMAC) += dw-axi-dmac/
>> >>>  obj-$(CONFIG_DW_DMAC_CORE) += dw/
>> >>>  obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
>> >>>  obj-$(CONFIG_FSL_DMA) += fsldma.o
>> >>> -obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
>> >>> +obj-$(CONFIG_FSL_EDMA) += fsl-edma.o fsl-edma-common.o
>> >>>  obj-$(CONFIG_FSL_RAID) += fsl_raid.o
>> >>>  obj-$(CONFIG_HSU_DMA) += hsu/
>> >>>  obj-$(CONFIG_IMG_MDC_DMA) += img-mdc-dma.o
>> >>> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
>> >>> new file mode 100644
>> >>> index 000000000000..0ae7094f477a
>> >>> --- /dev/null
>> >>> +++ b/drivers/dma/fsl-edma-common.c
>> >>> @@ -0,0 +1,576 @@
>> >>> +// SPDX-License-Identifier: GPL-2.0
>> >>> +//
>> >>> +// Copyright (c) 2013-2014 Freescale Semiconductor, Inc
>> >>> +// Copyright (c) 2017 Sysam, Angelo Dureghello  <angelo@sysam.it>
>> >>> +
>> >>> +#include <linux/dmapool.h>
>> >>> +#include <linux/module.h>
>> >>> +#include <linux/slab.h>
>> >>> +
>> >>> +#include "fsl-edma-common.h"
>> >>> +
>> >>> +/*
>> >>> + * R/W functions for big- or little-endian registers:
>> >>> + * The eDMA controller's endian is independent of the CPU core's endian.
>> >>> + * For the big-endian IP module, the offset for 8-bit or 16-bit registers
>> >>> + * should also be swapped opposite to that in little-endian IP.
>> >>> + */
>> >>> +u32 edma_readl(struct fsl_edma_engine *edma, void __iomem *addr)
>> >>> +{
>> >>> +     if (edma->big_endian)
>> >>> +             return ioread32be(addr);
>> >>> +     else
>> >>> +             return ioread32(addr);
>> >>> +}
>> >>> +EXPORT_SYMBOL_GPL(edma_readl);
>> >>
>> >> In 3/3 you link the common object into the two modules individually:
>> >>
>> >> obj-$(CONFIG_FSL_EDMA) += fsl-edma.o fsl-edma-common.o
>> >> obj-$(CONFIG_MCF_EDMA) += mcf-edma.o fsl-edma-common.o
>> >>
>> >> Therefor you do not access those functions from another module (they are
>> >> within the module). No exporting should be necessary. Drop all those
>> >> exports.
>> >
>> > The fsl-edma-common will be its own module so the exports are
>> > necessary for proper linking/modpost.
>>
>> Hm, oh I see, I got that wrong.
>>
>> We could use
>> fsl-edma-all-y = fsl-edma.o fsl-edma-common.o
>> obj-$(CONFIG_FSL_EDMA) += fsl-edma-all.o
>> mcf-edma-all-y = mcf-edma.o fsl-edma-common.o
>> obj-$(CONFIG_MCF_EDMA) += mcf-edma-all.o
>>
>> to create two modules but that duplicates some code. It probably
>> wouldn't matter in practise since the two IPs are used on different
>> architecture...
>>
>> However, if we stay with the three modules approach, we should introduce
>> a hidden config symbol, e.g.
>>
>> config FSL_EDMA_COMMON
>> 	tristate
>>
>> In FSL_EDMA/MCF_EDMA use
>> 	select FSL_EDMA_COMMON
>>
>> And in the Makefile
>> obj-$(CONFIG_FSL_EDMA_COMMON) += fsl-edma-common.o
>> obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
>> obj-$(CONFIG_MCF_EDMA) += mcf-edma.o
>>
>>
> There was already a discussion with Vinod and Geert on this, and i 
> finally previously changed things in this way 
> 
> obj-$(CONFIG_FSL_EDMA) += fsl-edma.o fsl-edma-common.o
> 
> The idea was to simplify things avoiding to use an additional
> config symbol, as i did initially. It's a common pattern in 
> several Makefiles (e.g.drivers/net/ethernet/8390/Makefile and 
> drivers/scsi/Makefile).
> Also we have a single common code part since obj-y is a list, 
> and IIRC it's filtered for duplicates.
> So if can be ok for you too, i would not roll back again.
> 

I see, you refer to this discussion:
https://www.spinics.net/lists/dmaengine/msg15863.html

Should have followed up on those discussions, sorry. Leave it as is
then.

>> However, I do not like that the compiler can no longer inline simple
>> acesors like edma_(readl|writel). So if we stay with the three modules
>> approach then move at least the accesors and
>> to_fsl_edma_chan/to_fsl_edma_desc as inline functions to the header
>> file.
>>
> I agree too, my initial patch was a single separate driver. But it
> resulted in too much duplicated code, so a common module has been
> required. Btw, seems i cannot inline those functions. fsl-edma-common.h 
> is included from both fsl-edma-common.c and mcf/fsl-edma.c resulting
> in multiple definitions linking error.

I agree, we should introduce the common module and share as much as
possible.

Just those small accessors typically get inlined by the compiler, and
often collapse completely in optimization phases (e.g. a function call
has more overhead than just inlining them, making resulting code smaller
and faster).

Just define them as static inline, then it won't lead to linking errors.

I tried with this change in fsl-edma-common.h (and remove them from
fsl-edma-common.c):

-u32 edma_readl(struct fsl_edma_engine *edma, void __iomem *addr);
-void edma_writeb(struct fsl_edma_engine *edma, u8 val, void __iomem
*addr);
-void edma_writew(struct fsl_edma_engine *edma, u16 val, void __iomem
*addr);
-void edma_writel(struct fsl_edma_engine *edma, u32 val, void __iomem
*addr);
-
-struct fsl_edma_chan *to_fsl_edma_chan(struct dma_chan *chan);
-struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd);
+/*
+ * R/W functions for big- or little-endian registers:
+ * The eDMA controller's endian is independent of the CPU core's
endian.
+ * For the big-endian IP module, the offset for 8-bit or 16-bit
registers
+ * should also be swapped opposite to that in little-endian IP.
+ */
+static inline u32 edma_readl(struct fsl_edma_engine *edma, void __iomem
*addr)
+{
+       if (edma->big_endian)
+               return ioread32be(addr);
+       else
+               return ioread32(addr);
+}
+
+static inline void edma_writeb(struct fsl_edma_engine *edma, u8 val,
void __iomem *addr)
+{
+       /* swap the reg offset for these in big-endian mode */
+       if (edma->big_endian)
+               iowrite8(val, (void __iomem *)((unsigned long)addr ^
0x3));
+       else
+               iowrite8(val, addr);
+}
+
+static inline void edma_writew(struct fsl_edma_engine *edma, u16 val,
void __iomem *addr)
+{
+       /* swap the reg offset for these in big-endian mode */
+       if (edma->big_endian)
+               iowrite16be(val, (void __iomem *)((unsigned long)addr ^
0x2));
+       else
+               iowrite16(val, addr);
+}
+
+static inline void edma_writel(struct fsl_edma_engine *edma, u32 val,
void __iomem *addr)
+{
+       if (edma->big_endian)
+               iowrite32be(val, addr);
+       else
+               iowrite32(val, addr);
+}
+
+static inline struct fsl_edma_chan *to_fsl_edma_chan(struct dma_chan
*chan)
+{
+       return container_of(chan, struct fsl_edma_chan, vchan.chan);
+}
+
+static inline struct fsl_edma_desc *to_fsl_edma_desc(struct
virt_dma_desc *vd)
+{
+       return container_of(vd, struct fsl_edma_desc, vdesc);
+}


All three kernel modules end up being smaller (overall more than 1kB),
so the compiler really does its magic.

> 
> Mainly until v7 there was several discussions and a first approval, 
> if possible i would not change again heavily the patch structure for
> a bug that seemss already been fixed.
> 
> So i fixed all the possible points of this thread and organized next 
> patch as 
> 
> 1/4 dmaengine: fsl-edma: extract common fsl-edma code (no changes ..
> 2/4 dmaengine: fsl-edma: add edma version and configurable registers
> 3/4 dmaengine: fsl-edma: fix macros
> 4/4 dmaengine: fsl-edma: add ColdFire mcf5441x edma support

That seems sensible. One minor nit in Kconfig still:

--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -320,6 +320,17 @@ config LPC18XX_DMAMUX
       Enable support for DMA on NXP LPC18xx/43xx platforms
       with PL080 and multiplexed DMA request lines.
 
+config MCF_EDMA
+    tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
+    depends on M5441x

Can you add " || COMPILE_TEST" here, this helps for automated testing.

--
Stefan

> 
> Let me know if you have any other point or if can proceed.
> 
> Best regards,
> Angelo Dureghello
> 
>> --
>> Stefan
>>
>> >
>> > Best regards,
>> > Krzysztof
>> >
>> >> If possible I would prefer if you start with cleanup/conversions, then
>> >> split-up and finally add functionality.
>> >>
>> >> So ideally:
>> >> 1. Use macros for preprocessor defines (where you move to BIT/GENMASK)
>> >> 2. Split
>> >> 3. Add EDMA macros etc.
>> >> 4. Add ColdFire mcf5441x edma support
>> >>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
