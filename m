From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 28 Oct 2009 15:56:46 +0100
Subject: [01/02] pxa: add 2d graphics driver
In-Reply-To: <771cded00910280747j2de4984bv43d1ed658c581ce8@mail.gmail.com>
References: <771cded00910280747j2de4984bv43d1ed658c581ce8@mail.gmail.com>
Message-ID: <20091028145646.GH14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2009 at 10:47:04AM -0400, Haojian Zhuang wrote:
> From 907ebc5b5dacf1c7ecb4c04decf409469cbe9c74 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Sun, 18 Oct 2009 13:43:42 -0400
> Subject: [PATCH] pxa: add 2d graphics driver
> 
> PXA3xx series provides 2D graphics function. It supports line draw, chroma
> key, scale, alpha blending, and so on.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  arch/arm/mach-pxa/include/mach/pxa3xx-gcu.h |   69 ++
>  drivers/char/Kconfig                        |    6 +
>  drivers/char/Makefile                       |    1 +
>  drivers/char/pxa3xx-gcu.c                   | 1118 +++++++++++++++++++++++++++
>  4 files changed, 1194 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-pxa/include/mach/pxa3xx-gcu.h
>  create mode 100644 drivers/char/pxa3xx-gcu.c

Uh. What's that!? Another one? How is that driver supposed to be used?
Is there any userspace reference? And did you see the DirectFB supported
version of such a driver I submitted several times already?

Sigh. We sould really avoid to have two drivers for the same purpose.
Any idea how to solve this?

Daniel


> diff --git a/arch/arm/mach-pxa/include/mach/pxa3xx-gcu.h
> b/arch/arm/mach-pxa/include/mach/pxa3xx-gcu.h
> new file mode 100644
> index 0000000..14e6b0a
> --- /dev/null
> +++ b/arch/arm/mach-pxa/include/mach/pxa3xx-gcu.h
> @@ -0,0 +1,69 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef _PXA3xx_GCU_H
> +#define _PXA3xx_GCU_H
> +
> +#define MAX_DEVICE_GMEM_SIZE		(16*1024*1024)
> +#define MAX_CONTEXT_GMEM_SIZE		(16*1024*1024)
> +
> +#define GCU_RINGBUF_SIZE		(16384)
> +#define GCU_SCRATCHREG_NR		(8)
> +
> +#include <asm/ioctl.h>
> +
> +#define PXA3xx_GCU_IO_SUBMIT		_IOW('2',  1, struct iovec *)
> +#define PXA3xx_GCU_IO_SYNC		_IOW('2',  2, int)
> +
> +#define PXA3xx_GCU_IO_REQUEST_MEM	_IOW('2', 10, struct
> pxa3xx_gcu_mem_request *)
> +#define PXA3xx_GCU_IO_RELEASE_MEM	_IOW('2', 11, unsigned long)
> +#define PXA3xx_GCU_IO_FLUSH_MEM		_IOW('2', 12, unsigned long)
> +
> +#define PXA3xx_GCU_IO_GET_BUS_ADDR	_IOW('2', 20, unsigned long)
> +
> +/* #define PXA3xx_GCU_IO_QUERY_GCU	_IOR('2', 20, struct m2d_gcu_stat *) */
> +
> +#define PXA3xx_GCU_GRAPHICS_MEM	0
> +#define PXA3xx_GCU_FRAME_BUFFER	1
> +#define PXA3xx_GCU_REGISTERS		2
> +#define PXA3xx_GCU_RING_BUFFER		3
> +
> +#define PXA3xx_GCU_ATTR_COHERENT	0x00
> +#define PXA3xx_GCU_ATTR_WRITECOMBINE	0x10
> +#define PXA3xx_GCU_ATTR_CACHEABLE	0x20
> +
> +#define PXA3xx_GCU_MEM_REQ_TYPE(f)		(f & 0x0f)
> +#define PXA3xx_GCU_MEM_REQ_ATTR(f)		(f & 0xf0)
> +
> +struct pxa3xx_gcu_mem_req {
> +	unsigned int	req_type;
> +	unsigned int	req_size;
> +	unsigned long	phys_addr;
> +	unsigned long	mmap_addr;
> +	unsigned long	mmap_size;
> +};
> +
> +#define PXA3xx_GCU_SUBMIT_MODE_NDELAY	(1 << 0)
> +#define PXA3xx_GCU_SUBMIT_MODE_SYNC	(1 << 1)
> +
> +struct pxa3xx_gcu_submit_req {
> +	unsigned int	mode;
> +	void		*base;
> +	size_t		len;
> +};
> +
> +#endif
> +
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 08a6f50..a7c468c 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -431,6 +431,12 @@ config SGI_MBCS
>           If you have an SGI Altix with an attached SABrick
>           say Y or M here, otherwise say N.
> 
> +config PXA3xx_GCU
> +	bool "PXA3xx Processor 2D Graphics Controller Driver"
> +	depends on PXA3xx
> +	help
> +	  Enable graphics support on PXA3xx Processor series.
> +
>  source "drivers/serial/Kconfig"
> 
>  config UNIX98_PTYS
> diff --git a/drivers/char/Makefile b/drivers/char/Makefile
> index 19a79dd..b0beced 100644
> --- a/drivers/char/Makefile
> +++ b/drivers/char/Makefile
> @@ -108,6 +108,7 @@ obj-$(CONFIG_HANGCHECK_TIMER)	+= hangcheck-timer.o
>  obj-$(CONFIG_TCG_TPM)		+= tpm/
> 
>  obj-$(CONFIG_PS3_FLASH)		+= ps3flash.o
> +obj-$(CONFIG_PXA3xx_GCU)	+= pxa3xx-gcu.o
> 
>  obj-$(CONFIG_JS_RTC)		+= js-rtc.o
>  js-rtc-y = rtc.o
> diff --git a/drivers/char/pxa3xx-gcu.c b/drivers/char/pxa3xx-gcu.c
> new file mode 100644
> index 0000000..81c7f11
> --- /dev/null
> +++ b/drivers/char/pxa3xx-gcu.c
> @@ -0,0 +1,1118 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> +
> + *(C) Copyright 2006 Marvell International Ltd.
> + * All Rights Reserved
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/fs.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/completion.h>
> +#include <linux/miscdevice.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <asm/uaccess.h>
> +#include <asm/dma-mapping.h>
> +#include <asm/cacheflush.h>
> +
> +#include <mach/pxa3xx-gcu.h>
> +
> +enum {
> +	/* Miscellaneous Control and Interrupt Information */
> +	GCCR 		= 0x000, /* Configuration Register */
> +	GCISCR		= 0x004, /* Interrupt Status Control Register */
> +	GCIECR		= 0x008, /* Interrupt Enable Control Register */
> +	GCNOPID		= 0x00C, /* NOP ID From Instruction Stream Register */
> +	GCALPHASET	= 0x010, /* Default Alpha value Control Register */
> +	GCTSET		= 0x014, /* Default Transparecy Value Control Register */
> +	GCFLAGS		= 0x018, /* ALU Operations Flags Status Control Register */
> +
> +	
> +	/* Ring Buffer Information */
> +	GCRBBR		= 0x020, /* Ring Buffer Base Address Register */
> +	GCRBLR		= 0x024, /* Ring Buffer Length Register */
> +	GCRBHR		= 0x028, /* Ring Buffer Head Register */
> +	GCRBTR		= 0x02C, /* Ring Buffer Tail Register */
> +	GCRBEXHR	= 0x030, /* Ring Buffer Execution Head Register */
> +
> +	/* Batch Buffer Information */
> +	GCBBBR		= 0x040, /* Batch Buffer Base Address Register */
> +	GCBBHR		= 0x044, /* Batch Buffer Head Register */
> +	GCBBEXHR	= 0x048, /* Batch Buffer Execution Head Register */
> +
> +	/* Destination 0 Information */
> +	GCD0BR		= 0x060, /* Destination 0 Base Address Register */
> +	GCD0STP		= 0x064, /* Destination 0 Step Size Register */
> +	GCD0STR		= 0x068, /* Destination 0 Stride Size Register */
> +	GCD0PF		= 0x06C, /* Destination 0 Pixel Type Register */
> +
> +	/* Destination 1 Information */
> +	GCD1BR		= 0x070, /* Destination 1 Base Address Register */
> +	GCD1STP		= 0x074, /* Destination 1 Step Size Register */
> +	GCD1STR		= 0x078, /* Destination 1 Stride Size Register */
> +	GCD1PF		= 0x07C, /* Destination 1 Pixel Type Register */
> +
> +	/* Destination 2 Information */
> +	GCD2BR		= 0x080, /* Destination 2 Base Address Register */
> +	GCD2STP		= 0x084, /* Destination 2 Step Size Register */
> +	GCD2STR		= 0x088, /* Destination 2 Stride Size Register */
> +	GCD2PF		= 0x08C, /* Destination 2 Pixel Type Register */
> +
> +	/* Source 0 Information */
> +	GCS0BR		= 0x0E0, /* Source 0 Base Address Register */
> +	GCS0STP		= 0x0E4, /* Source 0 Step Size Register */
> +	GCS0STR		= 0x0E8, /* Source 0 Stride Size Register */
> +	GCS0PF		= 0x0EC, /* Source 0 Pixel Type Register */
> +
> +	/* Source 1 Information */
> +	GCS1BR		= 0x0F0, /* Source 1 Base Address Register */
> +	GCS1STP		= 0x0F4, /* Source 1 Step Size Register */
> +	GCS1STR		= 0x0F8, /* Source 1 Stride Size Register */
> +	GCS1PF		= 0x0FC, /* Source 1 Pixel Type Register */
> +
> +	/* Pixel ALU Scratch Registers */
> +	GCSC0WD0	= 0x160, /* Pixel ALU Scratch Register 0 Word 0 */
> +	GCSC0WD1	= 0x164, /* Pixel ALU Scratch Register 0 Word 1 */
> +	GCSC1WD0	= 0x168, /* Pixel ALU Scratch Register 1 Word 0 */
> +	GCSC1WD1	= 0x16C, /* Pixel ALU Scratch Register 1 Word 1 */
> +	GCSC2WD0	= 0x170, /* Pixel ALU Scratch Register 2 Word 0 */
> +	GCSC2WD1	= 0x174, /* Pixel ALU Scratch Register 2 Word 1 */
> +	GCSC3WD0	= 0x178, /* Pixel ALU Scratch Register 3 Word 0 */
> +	GCSC3WD1	= 0x17C, /* Pixel ALU Scratch Register 3 Word 1 */
> +	GCSC4WD0	= 0x180, /* Pixel ALU Scratch Register 4 Word 0 */
> +	GCSC4WD1	= 0x184, /* Pixel ALU Scratch Register 5 Word 1 */
> +	GCSC5WD0	= 0x188, /* Pixel ALU Scratch Register 5 Word 0 */
> +	GCSC5WD1	= 0x18C, /* Pixel ALU Scratch Register 5 Word 1 */
> +	GCSC6WD0	= 0x190, /* Pixel ALU Scratch Register 6 Word 0 */
> +	GCSC6WD1	= 0x194, /* Pixel ALU Scratch Register 6 Word 1 */
> +	GCSC7WD0	= 0x198, /* Pixel ALU Scratch Register 7 Word 0 */
> +	GCSC7WD1	= 0x19C, /* Pixel ALU Scratch Register 7 Word 1 */
> +
> +	/* Abort Bad Address Storage Registers */
> +	GCCABADDR	= 0x1E0, /* Illegal Access Bad Address Register */
> +	GCTABADDR	= 0x1E4, /* Target Abort Access Register */
> +	GCMABADDR	= 0x1E8, /* Master Abort Access Register */
> +
> +	GCU_MAX_REG	= 0x200,
> +};
> +
> +#define GCCR_STOP		(1 << 4)
> +#define GCCR_ABORT		(1 << 6)
> +#define GCCR_BP_RST		(1 << 8)
> +#define GCCR_SYNC_CLR		(1 << 9)
> +#define GCCR_MASK		(0x000007FF)
> +
> +#define GCIECR_EOB_INTEN	(1 << 0)
> +#define GCIECR_IN_INTEN		(1 << 1)
> +#define GCIECR_BF_INTEN		(1 << 2)
> +#define GCIECR_IOP_INTEN	(1 << 3)
> +#define GCIECR_IIN_INTEN	(1 << 4)
> +#define GCIECR_EEOB_INTEN	(1 << 5)
> +#define GCIECR_PF_INTEN		(1 << 6)
> +#define GCIECR_STOP_INTEN	(1 << 7)
> +#define GCIECR_FLAG_INTEN	(1 << 8)
> +#define GCIECR_MASK		(0x000001FF)
> +
> +#define GCISCR_EOB_INTST	(1 << 0)
> +#define GCISCR_IN_INTST		(1 << 1)
> +#define GCISCR_BF_INTST		(1 << 2)
> +#define GCISCR_IOP_INTST	(1 << 3)
> +#define GCISCR_IIN_INTST	(1 << 4)
> +#define GCISCR_EEOB_INTST	(1 << 5)
> +#define GCISCR_PF_INTST		(1 << 6)
> +#define GCISCR_STOP_INTST	(1 << 7)
> +#define GCISCR_FLAG_INTST	(1 << 8)
> +#define GCISCR_MASK		(0x000001FF)
> +
> +#define GCU_TIMEOUT		(10)	/* jiffies unit */
> +
> +struct pxa3xx_gcu_context;
> +
> +struct pxa3xx_gcu_info {
> +	struct device		*dev;
> +	struct platform_device	*pdev;
> +	unsigned int		irq;
> +	void __iomem		*mmio_base;
> +	struct completion	done;
> +	struct mutex		lock;
> +
> +	struct list_head	list;		/* context list */
> +	unsigned long		count;		/* counter of context */
> +	struct pxa3xx_gcu_context	*last;
> +
> +	struct semaphore	submit_sem;
> +
> +	unsigned long		*ring_addr;
> +	unsigned long		ring_size;
> +	unsigned long		ring_addr_dma;
> +	unsigned long		ring_tail_dma;
> +
> +	unsigned long		total_gmem_size;
> +};
> +
> +struct pxa3xx_gcu_gmem {
> +	struct pxa3xx_gcu_info	*info;
> +	struct list_head	list;
> +	atomic_t		gmem_count;
> +	struct page		*gmem_pages;
> +	size_t			gmem_size;
> +	unsigned long		gmem_virt_addr;
> +	unsigned long		gmem_phys_addr;
> +	unsigned long		gmem_uaddr;
> +	unsigned long		gmem_type;
> +};
> +
> +struct pxa3xx_gcu_buf {
> +	unsigned long		base;
> +	unsigned long		stride;
> +	unsigned long		step;
> +	unsigned long		format;
> +};
> +
> +struct pxa3xx_gcu_context {
> +	struct pxa3xx_gcu_info	*info;
> +	struct task_struct	*task;
> +	struct list_head	list;	/* to struct pxa3xx_gcu_context */
> +	//struct pxa3xx_gcu_gmem	*gmem;
> +	struct list_head	mlist;	/* to struct pxa3xx_gcu_gmem */
> +
> +	unsigned long		total_gmem_size;
> +	unsigned int		err_iin;
> +	unsigned int		err_iop;
> +	unsigned int		err_ipf;
> +
> +	/*
> +	 * Graphics memory that is allocated for application usage will be mapped
> +	 * into user space. Application and GCU can allocate buffers from
> +	 * this area.
> +	 */
> +	struct pxa3xx_gcu_buf	srcbuf0;
> +	struct pxa3xx_gcu_buf	srcbuf1;
> +	struct pxa3xx_gcu_buf	dstbuf0;
> +	struct pxa3xx_gcu_buf	dstbuf1;
> +	struct pxa3xx_gcu_buf	dstbuf2;
> +	unsigned long		alpha_set;
> +	unsigned long		trans_set;
> +	unsigned long		buffer_mode;
> +};
> +
> +static int pxa3xx_gcu_reset(struct pxa3xx_gcu_info *info);
> +
> +static struct pxa3xx_gcu_info *priv_info = NULL;
> +
> +static irqreturn_t pxa3xx_gcu_irq(int irq, void *devid)
> +{
> +	struct pxa3xx_gcu_info *info = (struct pxa3xx_gcu_info *)devid;
> +	struct pxa3xx_gcu_context *context = info->last;
> +	unsigned long status, gciscr, gciecr, gcrbexhr, gcrbtr;
> +
> +	gciscr = __raw_readl(info->mmio_base + GCISCR);
> +	gciecr = __raw_readl(info->mmio_base + GCIECR);
> +	status = gciscr & gciecr;
> +
> +	gciscr &= GCISCR_MASK;
> +	__raw_writel(gciscr, info->mmio_base + GCISCR);
> +
> +	if (status & (GCISCR_PF_INTST | GCISCR_IIN_INTST | GCISCR_IOP_INTST)) {
> +		if (context != NULL) {
> +			/* illegal pixel format */
> +			if (gciscr & GCISCR_PF_INTST)
> +				context->err_ipf++;
> +			/* illegal instruction */
> +			if (gciscr & GCISCR_IIN_INTST) {
> +				context->err_iin++;
> +				goto fail;
> +			}
> +			/* illegal operation */
> +			if (gciscr & GCISCR_IOP_INTST) {
> +				context->err_iop++;
> +				goto fail;
> +			}
> +			dev_dbg(info->dev, "COUNT ipf:%d, iin:%d, iop:%d\n",
> +				context->err_ipf, context->err_iin,
> +				context->err_iop);
> +		} else
> +			dev_dbg(info->dev, "ipf:%d, iin:%d, iop:%d\n",
> +				(gciscr & GCISCR_PF_INTST) ? 1 : 0,
> +				(gciscr & GCISCR_IIN_INTST) ? 1 : 0,
> +				(gciscr & GCISCR_IOP_INTST) ? 1 : 0);
> +	}
> +	if (status & GCISCR_EEOB_INTST) {
> +		gciecr &= ~GCIECR_EEOB_INTEN & GCIECR_MASK;
> +		__raw_writel(gciecr, info->mmio_base + GCIECR);
> +
> +		gcrbexhr = __raw_readl(info->mmio_base + GCRBEXHR);
> +		gcrbtr = __raw_readl(info->mmio_base + GCRBTR);
> +		if (gcrbexhr != gcrbtr)
> +			dev_err(info->dev, "EEOB: exhead:0x%lx, tail:0x%lx\n",
> +				gcrbexhr, gcrbtr);
> +		complete(&info->done);
> +	}
> +	return IRQ_HANDLED;
> +fail:
> +	send_sig(SIGILL, context->task, 0);
> +	pxa3xx_gcu_reset(info);
> +	return IRQ_HANDLED;
> +}
> +
> +static void __save_context(struct pxa3xx_gcu_context *context)
> +{
> +	struct pxa3xx_gcu_info *info = context->info;
> +
> +	context->srcbuf0.base = __raw_readl(info->mmio_base + GCS0BR);
> +	context->srcbuf0.step = __raw_readl(info->mmio_base + GCS0STP);
> +	context->srcbuf0.stride = __raw_readl(info->mmio_base + GCS0STR);
> +	context->srcbuf0.format = __raw_readl(info->mmio_base + GCS0PF);
> +
> +	context->srcbuf1.base = __raw_readl(info->mmio_base + GCS1BR);
> +	context->srcbuf1.step = __raw_readl(info->mmio_base + GCS1STP);
> +	context->srcbuf1.stride = __raw_readl(info->mmio_base + GCS1STR);
> +	context->srcbuf1.format = __raw_readl(info->mmio_base + GCS1PF);
> +
> +	context->dstbuf0.base = __raw_readl(info->mmio_base + GCD0BR);
> +	context->dstbuf0.step = __raw_readl(info->mmio_base + GCD0STP);
> +	context->dstbuf0.stride = __raw_readl(info->mmio_base + GCD0STR);
> +	context->dstbuf0.format = __raw_readl(info->mmio_base + GCD0PF);
> +
> +	context->dstbuf1.base = __raw_readl(info->mmio_base + GCD1BR);
> +	context->dstbuf1.step = __raw_readl(info->mmio_base + GCD1STP);
> +	context->dstbuf1.stride = __raw_readl(info->mmio_base + GCD1STR);
> +	context->dstbuf1.format = __raw_readl(info->mmio_base + GCD1PF);
> +
> +	context->dstbuf2.base = __raw_readl(info->mmio_base + GCD2BR);
> +	context->dstbuf2.step = __raw_readl(info->mmio_base + GCD2STP);
> +	context->dstbuf2.stride = __raw_readl(info->mmio_base + GCD2STR);
> +	context->dstbuf2.format = __raw_readl(info->mmio_base + GCD2PF);
> +
> +	context->buffer_mode = __raw_readl(info->mmio_base + GCCR) & 0x0f;
> +	context->alpha_set = __raw_readl(info->mmio_base + GCALPHASET);
> +	context->trans_set = __raw_readl(info->mmio_base + GCTSET);
> +}
> +
> +static void __restore_context(struct pxa3xx_gcu_context *context)
> +{
> +	struct pxa3xx_gcu_info *info = context->info;
> +	unsigned long gccr;
> +
> +	__raw_writel(context->srcbuf0.base, info->mmio_base + GCS0BR);
> +	__raw_writel(context->srcbuf0.step, info->mmio_base + GCS0STP);
> +	__raw_writel(context->srcbuf0.stride, info->mmio_base + GCS0STR);
> +	__raw_writel(context->srcbuf0.format, info->mmio_base + GCS0PF);
> +
> +	__raw_writel(context->srcbuf1.base, info->mmio_base + GCS1BR);
> +	__raw_writel(context->srcbuf1.step, info->mmio_base + GCS1STP);
> +	__raw_writel(context->srcbuf1.stride, info->mmio_base + GCS1STR);
> +	__raw_writel(context->srcbuf1.format, info->mmio_base + GCS1PF);
> +
> +	__raw_writel(context->dstbuf0.base, info->mmio_base + GCD0BR);
> +	__raw_writel(context->dstbuf0.step, info->mmio_base + GCD0STP);
> +	__raw_writel(context->dstbuf0.stride, info->mmio_base + GCD0STR);
> +	__raw_writel(context->dstbuf0.format, info->mmio_base + GCD0PF);
> +
> +	__raw_writel(context->dstbuf1.base, info->mmio_base + GCD1BR);
> +	__raw_writel(context->dstbuf1.step, info->mmio_base + GCD1STP);
> +	__raw_writel(context->dstbuf1.stride, info->mmio_base + GCD1STR);
> +	__raw_writel(context->dstbuf1.format, info->mmio_base + GCD1PF);
> +
> +	__raw_writel(context->dstbuf2.base, info->mmio_base + GCD2BR);
> +	__raw_writel(context->dstbuf2.step, info->mmio_base + GCD2STP);
> +	__raw_writel(context->dstbuf2.stride, info->mmio_base + GCD2STR);
> +	__raw_writel(context->dstbuf2.format, info->mmio_base + GCD2PF);
> +
> +	gccr = __raw_readl(info->mmio_base + GCCR);
> +	gccr = (gccr & ~0xf) | context->buffer_mode;
> +	__raw_writel(gccr, info->mmio_base + GCCR);
> +	__raw_writel(context->alpha_set, info->mmio_base + GCALPHASET);
> +	__raw_writel(context->trans_set, info->mmio_base + GCTSET);
> +}
> +
> +static int pxa3xx_gcu_append(struct pxa3xx_gcu_info *info, void *usrbuf,
> +			     size_t len)
> +{
> +	unsigned int tail_room, head_room;
> +	unsigned long exhead;
> +	unsigned long tail = info->ring_tail_dma;
> +	unsigned long base = info->ring_addr_dma;
> +	unsigned long size = info->ring_size;
> +	unsigned char *ring_addr = (unsigned char *)info->ring_addr;
> +
> +	exhead = __raw_readl(info->mmio_base + GCRBEXHR);
> +	if (tail >= exhead) {
> +		tail_room = size - (tail - base);
> +		head_room = exhead - base;
> +	} else {
> +		tail_room = exhead - tail;
> +		head_room = 0;
> +	}
> +	dev_dbg(info->dev, "base:%lx, exhead:%lx, tail:%lx, head_room:%x,"
> +		" tail_room:%x\n", base, exhead, tail, head_room, tail_room);
> +	dev_dbg(info->dev, "base:%x, head:%x, exhead:%x, tail:%x, length:%x\n",
> +		__raw_readl(info->mmio_base + GCRBBR),
> +		__raw_readl(info->mmio_base + GCRBHR),
> +		__raw_readl(info->mmio_base + GCRBEXHR),
> +		__raw_readl(info->mmio_base + GCRBTR),
> +		__raw_readl(info->mmio_base + GCRBLR));
> +
> +	if (tail_room >= len) {
> +		if (copy_from_user(ring_addr + (tail - base), usrbuf, len))
> +			return -EFAULT;
> +		tail += len;
> +	} else if (head_room + tail_room >= len) {
> +		if (copy_from_user(ring_addr + (tail - base), usrbuf,
> +			tail_room))
> +			return -EFAULT;
> +		usrbuf += tail_room;
> +		len -= tail_room;
> +
> +		if (copy_from_user(ring_addr, usrbuf, len))
> +			return -EFAULT;
> +		tail = info->ring_addr_dma + len;
> +	} else
> +		return -ENOSPC;
> +
> +	if (tail - base == size)
> +		tail = base;
> +	info->ring_tail_dma = tail;
> +	__raw_writel(tail, info->mmio_base + GCRBTR);
> +	dev_dbg(info->dev, "tail:%lx, size:%ld\n", tail, size);
> +	return 0;
> +}
> +
> +static void pxa3xx_gcu_wait_for_eeob(struct pxa3xx_gcu_info *info)
> +{
> +	unsigned long gciscr, gciecr, gcrbexhr, gcrbtr;
> +
> +	gciscr = __raw_readl(info->mmio_base + GCISCR);
> +	__raw_writel(gciscr | GCISCR_EEOB_INTST, info->mmio_base + GCISCR);
> +	gciecr = __raw_readl(info->mmio_base + GCIECR);
> +	__raw_writel(gciecr | GCIECR_EEOB_INTEN, info->mmio_base + GCIECR);
> +
> +	for (;;) {
> +		gcrbexhr = __raw_readl(info->mmio_base + GCRBEXHR);
> +		gcrbtr = __raw_readl(info->mmio_base + GCRBTR);
> +		if (gcrbexhr == gcrbtr)
> +			return;
> +		wait_for_completion_timeout(&info->done, GCU_TIMEOUT);
> +	}
> +}
> +
> +static int pxa3xx_gcu_kick(struct pxa3xx_gcu_info *info, int sync)
> +{
> +	unsigned long gccr;
> +
> +	gccr = __raw_readl(info->mmio_base + GCCR);
> +	gccr &= ~GCCR_STOP & GCCR_MASK;
> +	__raw_writel(gccr, info->mmio_base + GCCR);
> +
> +	if (sync)
> +		pxa3xx_gcu_wait_for_eeob(info);
> +	return 0;
> +}
> +
> +/*
> + * pxa3xx_gcu_sync is used to ensure that submitted instructions are
> + * completely finished or an error occured.
> + */
> +static int pxa3xx_gcu_sync(struct pxa3xx_gcu_context *context)
> +{
> +	struct pxa3xx_gcu_info *info = context->info;
> +
> +	if (info->last != context)
> +		return -EINVAL;
> +	pxa3xx_gcu_wait_for_eeob(info);
> +	return 0;
> +}
> +
> +/*
> + * pxa3xx_gcu_switch_context should be called only when no operation on current
> + * context.
> + */
> +static void pxa3xx_gcu_switch_context(struct pxa3xx_gcu_context *context)
> +{
> +	struct pxa3xx_gcu_info *info = context->info;
> +
> +	mutex_lock(&info->lock);
> +	if (info->last)
> +		__save_context(info->last);
> +	if (context)
> +		__restore_context(context);
> +	info->last = context;
> +	mutex_unlock(&info->lock);
> +}
> +
> +/*
> + * pxa3xx_gcu_submit will try to copy the instructions from a user supplied
> + * buffer to the GCU Ring Buffer for execution. This function will return
> + * immediately once the copy is done and the GCU is started. Synchronization
> + * is done by calling pxa3xx_gcu_sync() to ensure that instructions submitted
> + * are completely executed or until error occurs.
> + *
> + * This function will block if the device is current serving another context,
> + * unless non-delay mode is set.
> + */
> +static int pxa3xx_gcu_submit(struct pxa3xx_gcu_context *context,
> +			     struct pxa3xx_gcu_submit_req *req)
> +{
> +	void __user *usrbuf = (void *)req->base;
> +	struct pxa3xx_gcu_info *info = NULL;
> +	int ndelay, sync, ret;
> +	size_t size = req->len;
> +
> +	if (context == NULL || context->info == NULL)
> +		return -ENODEV;
> +	info = context->info;
> +
> +	if ((size >= GCU_RINGBUF_SIZE) || (size % 4))
> +		return -EINVAL;
> +	if (!access_ok(VERIFY_READ, usrbuf, size))
> +		return -EFAULT;
> +
> +	if (context != info->last) {
> +		pxa3xx_gcu_wait_for_eeob(info);
> +		pxa3xx_gcu_switch_context(context);
> +	}
> +
> +	ndelay = req->mode & PXA3xx_GCU_SUBMIT_MODE_NDELAY;
> +	sync = req->mode & PXA3xx_GCU_SUBMIT_MODE_SYNC;
> +
> +submit:
> +	if (ndelay) {
> +		if (down_trylock(&info->submit_sem))
> +			return -EAGAIN;
> +	} else {
> +		if (down_interruptible(&info->submit_sem))
> +			return -ERESTARTSYS;
> +	}
> +
> +	ret = pxa3xx_gcu_append(info, usrbuf, size);
> +	if (ret == -ENOSPC) {
> +		if (ndelay) {
> +			up(&info->submit_sem);
> +			pxa3xx_gcu_wait_for_eeob(info);
> +			goto submit;
> +		}
> +	}
> +
> +	if (ret == 0)
> +		ret = pxa3xx_gcu_kick(info, sync);
> +	up(&info->submit_sem);
> +	return ret;
> +}
> +
> +static int pxa3xx_gcu_reset(struct pxa3xx_gcu_info *info)
> +{
> +	unsigned int gccr, gciscr, gciecr;
> +
> +	info->ring_tail_dma = info->ring_addr_dma;
> +	gccr = __raw_readl(info->mmio_base + GCCR) & 0x0F;
> +	__raw_writel(gccr | GCCR_ABORT, info->mmio_base + GCCR);
> +	udelay(10);
> +	gccr = __raw_readl(info->mmio_base + GCCR) & 0x0F;
> +	__raw_writel(gccr | GCCR_STOP, info->mmio_base + GCCR);
> +
> +	__raw_writel(0, info->mmio_base + GCRBLR);
> +	__raw_writel(info->ring_addr_dma, info->mmio_base + GCRBBR);
> +	__raw_writel(info->ring_tail_dma, info->mmio_base + GCRBTR);
> +	__raw_writel(info->ring_size, info->mmio_base + GCRBLR);
> +	dev_dbg(info->dev, "ring head:%lx, ring tail:%lx, ring size:%lx\n",
> +		info->ring_addr_dma, info->ring_tail_dma, info->ring_size);
> +	dev_dbg(info->dev, "base:%x, head:%x, exhead:%x, tail:%x, length:%x\n",
> +		__raw_readl(info->mmio_base + GCRBBR),
> +		__raw_readl(info->mmio_base + GCRBHR),
> +		__raw_readl(info->mmio_base + GCRBEXHR),
> +		__raw_readl(info->mmio_base + GCRBTR),
> +		__raw_readl(info->mmio_base + GCRBLR));
> +
> +	gciscr = __raw_readl(info->mmio_base + GCISCR);
> +	__raw_writel(gciscr | GCISCR_MASK, info->mmio_base + GCISCR);
> +	gciecr = __raw_readl(info->mmio_base + GCIECR);
> +	gciecr &= ~GCIECR_MASK;
> +	gciecr |= GCIECR_PF_INTEN | GCIECR_IIN_INTEN | GCIECR_IOP_INTEN;
> +	__raw_writel(gciecr, info->mmio_base + GCIECR);
> +
> +	__raw_writel(0, info->mmio_base + GCNOPID);
> +	__raw_writel(0, info->mmio_base + GCTABADDR);
> +	__raw_writel(0, info->mmio_base + GCMABADDR);
> +	return 0;
> +}
> +
> +static int dump_gmem(struct pxa3xx_gcu_context *context)
> +{
> +	struct pxa3xx_gcu_info *info = context->info;
> +	struct pxa3xx_gcu_gmem *gmem = NULL, *n = NULL;
> +
> +	list_for_each_entry_safe(gmem, n, &context->mlist, list) {
> +		dev_dbg(info->dev, "virt addr:0x%lx, phys addr:0x%lx,"
> +			" size:0x%x, usr addr:0x%lx\n", gmem->gmem_virt_addr,
> +			gmem->gmem_phys_addr, gmem->gmem_size,
> +			gmem->gmem_uaddr);
> +	}
> +	return 0;
> +}
> +
> +static struct pxa3xx_gcu_gmem *__alloc_gmem(struct pxa3xx_gcu_context *context,
> +					    size_t size)
> +{
> +	struct pxa3xx_gcu_info *info = context->info;
> +	struct page *page, *end;
> +	struct pxa3xx_gcu_gmem *gmem;
> +	unsigned long order, addr;
> +
> +	if (info == NULL)
> +		goto out;
> +	if (info->total_gmem_size + size > MAX_DEVICE_GMEM_SIZE)
> +		goto out;
> +	if (context->total_gmem_size + size > MAX_CONTEXT_GMEM_SIZE)
> +		goto out;
> +
> +	gmem = kzalloc(sizeof(struct pxa3xx_gcu_gmem), GFP_KERNEL);
> +	if (gmem == NULL)
> +		goto out;
> +
> +	size = PAGE_ALIGN(size);
> +	order = get_order(size);
> +	page = alloc_pages(GFP_KERNEL | GFP_DMA, order);
> +	if (page == NULL)
> +		goto out_mem;
> +	addr = (unsigned long)page_address(page);
> +	end = page + (1 << order);
> +	dma_cache_maint((void *)addr, size, DMA_FROM_DEVICE);
> +
> +	gmem->gmem_size = size;
> +	gmem->gmem_pages = page;
> +	gmem->gmem_virt_addr = addr;
> +	gmem->gmem_phys_addr = virt_to_phys((void *)addr);
> +
> +	context->total_gmem_size += size;
> +	info->total_gmem_size += size;
> +
> +	do {
> +		SetPageReserved(page);
> +		page++;
> +	} while (size -= PAGE_SIZE);
> +
> +	/* free the unused pages */
> +	while (page < end)
> +		__free_page(page++);
> +
> +	atomic_set(&gmem->gmem_count, 1);
> +	return gmem;
> +out_mem:
> +	kfree(gmem);
> +out:
> +	return NULL;
> +}
> +
> +static void __free_gmem(struct pxa3xx_gcu_context *context,
> +			struct pxa3xx_gcu_gmem *gmem)
> +{
> +	struct pxa3xx_gcu_info *info = context->info;
> +	struct page *page = gmem->gmem_pages;
> +	size_t size = gmem->gmem_size;
> +	unsigned long addr;
> +
> +	if (!atomic_dec_and_test(&gmem->gmem_count))
> +		return;
> +	context->total_gmem_size -= size;
> +	info->total_gmem_size -= size;
> +
> +	addr = (unsigned long)page_address(page);
> +	dma_cache_maint((void *)addr, size, DMA_FROM_DEVICE);
> +	for (; size > 0; size -= PAGE_SIZE, page++) {
> +		ClearPageReserved(page);
> +		__free_page(page);
> +	}
> +
> +	mutex_lock(&info->lock);
> +	list_del(&gmem->list);
> +	mutex_unlock(&info->lock);
> +	kfree(gmem);
> +}
> +
> +static int __request_mem(struct pxa3xx_gcu_context *context,
> +			 struct pxa3xx_gcu_mem_req *req)
> +{
> +	struct pxa3xx_gcu_info *info = context->info;
> +	struct pxa3xx_gcu_gmem *gmem = NULL;
> +	int ret;
> +
> +	switch (PXA3xx_GCU_MEM_REQ_TYPE(req->req_type)) {
> +	case PXA3xx_GCU_GRAPHICS_MEM:
> +		if (req->req_size == 0) {
> +			ret = req->req_type;
> +			memset(req, 0, sizeof(struct pxa3xx_gcu_mem_req));
> +			req->req_type = ret;
> +			return 0;
> +		}
> +
> +		gmem = __alloc_gmem(context, req->req_size);
> +		if (gmem == NULL)
> +			return -ENOMEM;
> +
> +		gmem->gmem_type = req->req_type;
> +
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&info->lock);
> +	list_add(&gmem->list, &context->mlist);
> +	mutex_unlock(&info->lock);
> +
> +	req->mmap_addr = (unsigned long)gmem->gmem_virt_addr;
> +	req->mmap_size = gmem->gmem_size;
> +	req->phys_addr = gmem->gmem_phys_addr;
> +	dump_gmem(context);
> +	return 0;
> +}
> +
> +static int __release_mem(struct pxa3xx_gcu_context *context,
> +			 unsigned long addr)
> +{
> +	struct pxa3xx_gcu_gmem *gmem = NULL, *n = NULL;
> +
> +	if (addr == 0) {
> +		/* release all allocated memory for this context */
> +		list_for_each_entry_safe(gmem, n, &context->mlist, list)
> +			__free_gmem(context, gmem);
> +	} else {
> +		list_for_each_entry_safe(gmem, n, &context->mlist, list) {
> +			if (gmem->gmem_virt_addr == addr)
> +				__free_gmem(context, gmem);
> +		}
> +	}
> +	gmem = NULL;
> +	n = NULL;
> +	return 0;
> +}
> +
> +static struct pxa3xx_gcu_context *__create_context(struct
> pxa3xx_gcu_info *info)
> +{
> +	struct pxa3xx_gcu_context *context;
> +
> +	if (info == NULL)
> +		return NULL;
> +
> +	context = kzalloc(sizeof(struct pxa3xx_gcu_context), GFP_KERNEL);
> +	if (context == NULL)
> +		return NULL;
> +
> +	context->info = info;
> +	context->task = current;
> +	context->alpha_set = 0;
> +	context->trans_set = 0;
> +	context->buffer_mode = 0x08;
> +
> +	INIT_LIST_HEAD(&context->mlist);
> +
> +	mutex_lock(&info->lock);
> +	list_add_tail(&context->list, &info->list);
> +	info->count++;
> +	mutex_unlock(&info->lock);
> +
> +	return context;
> +}
> +
> +static void __free_context(struct pxa3xx_gcu_context *context)
> +{
> +	struct pxa3xx_gcu_info *info;
> +
> +	if (context == NULL || context->info == NULL)
> +		return;
> +
> +	info = context->info;
> +	__release_mem(context, 0);
> +	mutex_lock(&info->lock);
> +	list_del(&context->list);
> +	info->count--;
> +	if (info->last == context)
> +		info->last = NULL;
> +	mutex_unlock(&info->lock);
> +	kfree(context);
> +}
> +
> +#ifdef CONFIG_PM
> +static int pxa3xx_gcu_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct pxa3xx_gcu_info *info = platform_get_drvdata(pdev);
> +
> +	pxa3xx_gcu_wait_for_eeob(info);
> +	if (info->last) {
> +		mutex_lock(&info->lock);
> +		__save_context(info->last);
> +		mutex_unlock(&info->lock);
> +	}
> +	return 0;
> +}
> +
> +static int pxa3xx_gcu_resume(struct platform_device *pdev)
> +{
> +	struct pxa3xx_gcu_info *info = platform_get_drvdata(pdev);
> +
> +	pxa3xx_gcu_reset(info);
> +	if (info->last) {
> +		mutex_lock(&info->lock);
> +		__restore_context(info->last);
> +		mutex_unlock(&info->lock);
> +	}
> +	return 0;
> +}
> +#endif
> +
> +static int pxa3xx_gcu_open(struct inode *inode, struct file *file)
> +{
> +	struct pxa3xx_gcu_context *context = file->private_data;
> +
> +	if (context == NULL) {
> +		if (priv_info == NULL)
> +			return -EFAULT;
> +		context = __create_context(priv_info);
> +		if (context == NULL)
> +			return -ENOMEM;
> +		file->private_data = context;
> +	}
> +	return 0;
> +}
> +
> +static int pxa3xx_gcu_release(struct inode *inode, struct file *file)
> +{
> +	struct pxa3xx_gcu_context *context = file->private_data;
> +
> +	pxa3xx_gcu_wait_for_eeob(context->info);
> +	__free_context(context);
> +	return 0;
> +}
> +
> +static int pxa3xx_gcu_ioctl(struct inode *inode, struct file *file,
> +			    unsigned int cmd, unsigned long arg)
> +{
> +	struct pxa3xx_gcu_context *context = file->private_data;
> +	struct pxa3xx_gcu_info *info = (struct pxa3xx_gcu_info *)context->info;
> +	struct pxa3xx_gcu_gmem *gmem = NULL;
> +	struct pxa3xx_gcu_submit_req submit_req;
> +	struct pxa3xx_gcu_mem_req mem_req;
> +	struct vm_area_struct *vma = NULL;
> +	void __user *uarg = (void *)arg;
> +	int ret = 0;
> +
> +	if (info == NULL)
> +		return -ENODEV;
> +
> +	switch (cmd) {
> +	case PXA3xx_GCU_IO_REQUEST_MEM:
> +		if (copy_from_user(&mem_req, uarg,
> +			sizeof(struct pxa3xx_gcu_mem_req))) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		ret = __request_mem(context, &mem_req);
> +		if (ret < 0)
> +			goto out;
> +		if (copy_to_user(uarg, &mem_req,
> +			sizeof(struct pxa3xx_gcu_mem_req))) {
> +			__release_mem(context, mem_req.mmap_addr);
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		break;
> +	case PXA3xx_GCU_IO_RELEASE_MEM:
> +		__release_mem(context, arg);
> +		break;
> +	case PXA3xx_GCU_IO_FLUSH_MEM:
> +		list_for_each_entry(gmem, &context->mlist, list) {
> +			if (gmem->gmem_uaddr == arg) {
> +				dmac_flush_range((void *)arg, (void *)arg
> +						+ gmem->gmem_size);
> +				outer_flush_range(gmem->gmem_phys_addr,
> +						gmem->gmem_phys_addr
> +						+ gmem->gmem_size);
> +			}
> +		}
> +		break;
> +	case PXA3xx_GCU_IO_SUBMIT:
> +		if (copy_from_user(&submit_req, uarg,
> +			sizeof(struct pxa3xx_gcu_submit_req))) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		ret = pxa3xx_gcu_submit(context, &submit_req);
> +		break;
> +	case PXA3xx_GCU_IO_SYNC:
> +		ret = pxa3xx_gcu_sync(context);
> +		break;
> +	case PXA3xx_GCU_IO_GET_BUS_ADDR:
> +		/* assume user provided virtual memory are physical continous */
> +		memset(&mem_req, 0, sizeof(struct pxa3xx_gcu_mem_req));
> +		if (copy_from_user(&mem_req.mmap_addr, uarg,
> +			sizeof(unsigned long))) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		vma = find_vma(current->mm, mem_req.mmap_addr);
> +		if (vma == NULL) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		mem_req.phys_addr = (vma->vm_pgoff << PAGE_SHIFT)
> +				+ (mem_req.mmap_addr % PAGE_SIZE);
> +		if (copy_to_user(uarg, &mem_req.phys_addr,
> +			sizeof(unsigned long))) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +out:
> +	dev_dbg(info->dev, "%s, return value: %d\n", __func__, ret);
> +	return ret;
> +}
> +
> +static int pxa3xx_gcu_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct pxa3xx_gcu_context *context = file->private_data;
> +	struct pxa3xx_gcu_gmem *gmem = NULL, *n = NULL;
> +	unsigned long pg_off;
> +	pgprot_t pgprot;
> +
> +	if (context == NULL)
> +		return -ENODEV;
> +
> +	/* mmap() specifies the physical address as offset parameter */
> +	list_for_each_entry_safe(gmem, n, &context->mlist, list) {
> +		pg_off = gmem->gmem_phys_addr >> PAGE_SHIFT;
> +		if (pg_off == vma->vm_pgoff)
> +			break;
> +	}
> +	if (gmem == NULL)
> +		return -ENOMEM;
> +
> +	switch (PXA3xx_GCU_MEM_REQ_ATTR(gmem->gmem_type)) {
> +	case PXA3xx_GCU_ATTR_COHERENT:
> +		pgprot = pgprot_noncached(vma->vm_page_prot);
> +		break;
> +	case PXA3xx_GCU_ATTR_WRITECOMBINE:
> +		pgprot = pgprot_writecombine(vma->vm_page_prot);
> +		break;
> +	case PXA3xx_GCU_ATTR_CACHEABLE:
> +	default:
> +		pgprot = vma->vm_page_prot;
> +		break;
> +	}
> +	vma->vm_page_prot = pgprot | PAGE_SHARED;
> +	vma->vm_flags |= (VM_IO | VM_RESERVED);
> +	if (remap_pfn_range(vma, vma->vm_start,
> +			    gmem->gmem_phys_addr >> PAGE_SHIFT,
> +			    vma->vm_end - vma->vm_start,
> +			    vma->vm_page_prot))
> +		return -EAGAIN;
> +	gmem->gmem_uaddr = vma->vm_start;
> +	dump_gmem(context);
> +	dma_cache_maint((void *)gmem->gmem_virt_addr,
> +			vma->vm_end - vma->vm_start,
> +			DMA_BIDIRECTIONAL);
> +	return 0;
> +}
> +
> +static int pxa3xx_gcu_fsync(struct file *file, struct dentry *dentry,
> +			    int datasync)
> +{
> +	struct pxa3xx_gcu_context *context = file->private_data;
> +
> +	return pxa3xx_gcu_sync(context);
> +}
> +
> +static struct file_operations pxa3xx_gcu_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= pxa3xx_gcu_open,
> +	.release	= pxa3xx_gcu_release,
> +	.ioctl		= pxa3xx_gcu_ioctl,
> +	.mmap		= pxa3xx_gcu_mmap,
> +	.fsync		= pxa3xx_gcu_fsync,
> +};
> +
> +static struct miscdevice pxa3xx_gcu_miscdev = {
> +	.minor		= MISC_DYNAMIC_MINOR,
> +	.name		= "m2d",
> +	.fops		= &pxa3xx_gcu_fops,
> +};
> +
> +static int pxa3xx_gcu_probe(struct platform_device *pdev)
> +{
> +	struct pxa3xx_gcu_info *info;
> +	struct resource *res;
> +	int ret, size;
> +
> +	ret = misc_register(&pxa3xx_gcu_miscdev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "unable to register device /dev/m2d\n");
> +		return ret;
> +	}
> +
> +	info = kzalloc(sizeof(struct pxa3xx_gcu_info), GFP_KERNEL);
> +	if (info == NULL) {
> +		dev_err(&pdev->dev, "failed to allocate memory\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	info->pdev = pdev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res == NULL) {
> +		dev_err(&pdev->dev, "no resource definied for MEM\n");
> +		ret = -ENXIO;
> +		goto err_res;
> +	}
> +
> +	res = request_mem_region(res->start, GCU_MAX_REG, pdev->name);
> +	if (res == NULL) {
> +		dev_err(&pdev->dev, "failed to request memory resource\n");
> +		ret = -EBUSY;
> +		goto err_res;
> +	}
> +
> +	info->mmio_base = ioremap(res->start, GCU_MAX_REG);
> +	if (info->mmio_base == NULL) {
> +		dev_err(&pdev->dev, "failed to ioremap register\n");
> +		ret = -ENOMEM;
> +		goto err_map;
> +	}
> +
> +	info->irq = platform_get_irq(pdev, 0);
> +	if (info->irq < 0) {
> +		dev_err(&pdev->dev, "failed to get IRQ\n");
> +		ret = -ENXIO;
> +		goto err_irq;
> +	}
> +	ret = request_irq(info->irq, pxa3xx_gcu_irq, IRQF_DISABLED,
> +			  pdev->name, info);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request GCU IRQ\n");
> +		ret = -EBUSY;
> +		goto err_irq;
> +	}
> +
> +	info->ring_addr = dma_alloc_coherent(info->dev,
> +				GCU_RINGBUF_SIZE + 256,
> +				(dma_addr_t *)&info->ring_addr_dma,
> +				GFP_KERNEL);
> +	if (info->ring_addr == NULL) {
> +		dev_err(&pdev->dev, "failed to allocate ring buffer\n");
> +		ret = -ENOMEM;
> +		goto err_mem;
> +	}
> +	size = ALIGN(info->ring_addr_dma, 256) - info->ring_addr_dma;
> +	if (size > 0) {
> +		info->ring_addr_dma += size;
> +		info->ring_addr += size;
> +	}
> +	info->ring_tail_dma = info->ring_addr_dma;
> +	info->ring_size = ALIGN(info->ring_addr_dma + GCU_RINGBUF_SIZE, 256)
> +				- info->ring_addr_dma;
> +	info->dev = &pdev->dev;
> +
> +	pxa3xx_gcu_reset(info);
> +
> +	mutex_init(&info->lock);
> +	init_MUTEX(&info->submit_sem);
> +	init_completion(&info->done);
> +	INIT_LIST_HEAD(&info->list);
> +
> +	priv_info = info;
> +
> +	platform_set_drvdata(pdev, info);
> +
> +	dev_info(&pdev->dev, "2D Graphics Driver for PXA3xx\n");
> +
> +	return 0;
> +err_mem:
> +	free_irq(info->irq, info);
> +err_irq:
> +	iounmap(info->mmio_base);
> +err_map:
> +	release_mem_region(res->start, GCU_MAX_REG);
> +err_res:
> +	kfree(info);
> +err:
> +	misc_deregister(&pxa3xx_gcu_miscdev);
> +	return ret;
> +}
> +
> +static int pxa3xx_gcu_remove(struct platform_device *pdev)
> +{
> +	struct pxa3xx_gcu_info *info = platform_get_drvdata(pdev);
> +	unsigned int gccr;
> +
> +	/* Stop the graphics controller */
> +	gccr = __raw_readl(info->mmio_base + GCCR);
> +	if ((gccr & GCCR_STOP) == 0) {
> +		gccr &= GCCR_MASK;
> +		gccr |= GCCR_STOP;
> +	}
> +	__raw_writel(gccr, info->mmio_base + GCCR);
> +
> +	__raw_writel(0, info->mmio_base + GCRBLR);
> +	__raw_writel(0, info->mmio_base + GCRBBR);
> +	__raw_writel(0, info->mmio_base + GCRBTR);
> +	dma_free_coherent(info->dev, info->ring_size, info->ring_addr,
> +			(dma_addr_t)info->ring_addr_dma);
> +	free_irq(info->irq, info);
> +
> +	misc_deregister(&pxa3xx_gcu_miscdev);
> +
> +	priv_info = NULL;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver pxa3xx_gcu_driver = {
> +	.driver = {
> +		.name	= "pxa3xx-gcu",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= pxa3xx_gcu_probe,
> +	.remove		= pxa3xx_gcu_remove,
> +#ifdef CONFIG_PM
> +	.suspend	= pxa3xx_gcu_suspend,
> +	.resume		= pxa3xx_gcu_resume,
> +#endif
> +};
> +
> +static int __devinit pxa3xx_gcu_init(void)
> +{
> +	platform_driver_register(&pxa3xx_gcu_driver);
> +
> +	return 0;
> +}
> +
> +static void __exit pxa3xx_gcu_exit(void)
> +{
> +	platform_driver_unregister(&pxa3xx_gcu_driver);
> +}
> +
> +module_init(pxa3xx_gcu_init);
> +module_exit(pxa3xx_gcu_exit);
> +MODULE_LICENSE("GPL");
> +
> -- 
> 1.5.6.5
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
