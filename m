From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 01 Feb 2011 09:45:37 +1300
Subject: FW: [linux-cirrus] Fwd: Re: More about SD-Card problems
In-Reply-To: <0D753D10438DA54287A00B027084269764CEE3A4FE@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B027084269764CEE3A4FE@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4D471F71.4010806@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2011 05:45 AM, H Hartley Sweeten wrote:
> *From:* linux-cirrus-bounce at freelists.org
> [mailto:linux-cirrus-bounce at freelists.org] *On Behalf Of *Martin Guy
> *Sent:* Sunday, January 30, 2011 5:40 PM
> *To:* sim1 at googlegroups.com; linux-cirrus at freelists.org
> *Subject:* [linux-cirrus] Fwd: Re: More about SD-Card problems

The Cirrus mailing lists are effectively dead now. Can we please keep
EP93xx related discussions on the Linux ARM kernel list (Cc'ed).

> ---------- Messaggio inoltrato ----------
> Da: "Mika Westerberg" <mika.westerberg@iki.fi
> <mailto:mika.westerberg@iki.fi>>
> Data: 30/gen/2011 19.13
> Oggetto: Re: More about SD-Card problems
> A: "Martin Guy" <martinwguy at gmail.com <mailto:martinwguy@gmail.com>>
> 
> On Sat, Jan 29, 2011 at 01:15:24PM +0100, Martin Guy wrote:
>>
>> Just completed 3.3GB of data. Again, not a single error.
> 
> Sounds great! So basically we don't need to worry about the CRCs since it is
> extremely unlikely that we get corrupted data transfer.
> 
> ===
> 
> The M2M DMA patches are attached. Note that it is still in "hack" phase so
> error handling etc. are not finalized at all. M2M DMA currently only
> supports
> SPI but I'm going to add that memory-to-memory support and possibly IDE,
> let's
> see. It currently doesn't use double buffering but that is going to be
> added at
> some point.
> 
> I've been developing on .38-rc2 kernel but since these patches touch
> only ep93xx
> stuff I believe that they should apply pretty easily to .36.

It would be good to get these patches applied to mainline. Some comments
below. I also think we should look at integrating the EP93xx DMA into
the existing dmaengine framework if applicable. If not, is it at least
possible to reuse/combine some parts of the existing EP93xx M2P DMA code?

> Once you have applied the patches, you can enable the DMA support like:
> 
> diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
> index 0f44123..2d12f35 100644
> --- a/arch/arm/mach-ep93xx/simone.c
> +++ b/arch/arm/mach-ep93xx/simone.c
> @@ -161,6 +161,7 @@ static struct spi_board_info simone_spi_devices[]
> __initdata = {
> 
>  static struct ep93xx_spi_info simone_spi_info __initdata = {
>        .num_chipselect = ARRAY_SIZE(simone_spi_devices),
> +       .use_dma        = true,
>  };
> 
> After this, all the transfers should use DMA. I'm not sure if it is the
> best way
> since setting up the DMA channel for 1 byte transfer sounds like overkill. I
> think that we should probably use PIO for smaller transfers and DMA for the
> larger ones.
> 
> I have been testing this on Sim.One with mmc_spi and on TS-7260 attached
> to a
> SPI EEPROM (at25).
> 
> There are probably plenty of bugs lurking around so make sure that you have
> your data backed up ;-)
> 
> Regards,
> MW

> From 03681723ec6a203fcf9993fe4321bc2b065355e9 Mon Sep 17 00:00:00 2001
> From: Mika Westerberg <mika.westerberg@iki.fi>
> Date: Sun, 30 Jan 2011 11:21:34 +0200
> Subject: [PATCH 1/2] ep93xx: add memory-to-memory DMA support
> 
> This adds support for the 2 M2M DMA channels found in ep93xx chips.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> ---
>  arch/arm/mach-ep93xx/Makefile           |    2 +-
>  arch/arm/mach-ep93xx/dma-m2m.c          |  472 +++++++++++++++++++++++++++++++
>  arch/arm/mach-ep93xx/include/mach/dma.h |   57 ++++
>  3 files changed, 530 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-ep93xx/dma-m2m.c
> 
> diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
> index 33ee2c8..ea652c2 100644
> --- a/arch/arm/mach-ep93xx/Makefile
> +++ b/arch/arm/mach-ep93xx/Makefile
> @@ -1,7 +1,7 @@
>  #
>  # Makefile for the linux kernel.
>  #
> -obj-y			:= core.o clock.o dma-m2p.o gpio.o
> +obj-y			:= core.o clock.o dma-m2p.o dma-m2m.o gpio.o
>  obj-m			:=
>  obj-n			:=
>  obj-			:=
> diff --git a/arch/arm/mach-ep93xx/dma-m2m.c b/arch/arm/mach-ep93xx/dma-m2m.c
> new file mode 100644
> index 0000000..fabbde1
> --- /dev/null
> +++ b/arch/arm/mach-ep93xx/dma-m2m.c
> @@ -0,0 +1,472 @@
> +/*
> + * arch/arm/mach-ep93xx/dma-m2m.c
> + *
> + * M2M DMA handling for Cirrus EP93xx chips.
> + *
> + * Copyright (C) 2011 Mika Westerberg
> + *
> + * Based on dma-m2p with following copyrights:
> + *   Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> + *   Copyright (C) 2006 Applied Data Systems
> + *   Copyright (C) 2009 Ryan Mallon <ryan@bluewatersys.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or (at
> + * your option) any later version.
> + */
> +/*#define DEBUG*/
> +#define pr_fmt(fmt) "ep93xx " KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +
> +#include <mach/dma.h>
> +#include <mach/hardware.h>
> +
> +#define M2M_CONTROL			0x0000
> +#define M2M_CONTROL_STALLINT		BIT(0)
> +#define M2M_CONTROL_SCT			BIT(1)
> +#define M2M_CONTROL_DONEINT		BIT(2)
> +#define M2M_CONTROL_ENABLE		BIT(3)
> +#define M2M_CONTROL_START		BIT(4)
> +#define M2M_CONTROL_DAH			BIT(11)
> +#define M2M_CONTROL_SAH			BIT(12)
> +#define M2M_CONTROL_PW_SHIFT		9
> +#define M2M_CONTROL_PW_8		(0 << M2M_CONTROL_PW_SHIFT)
> +#define M2M_CONTROL_PW_16		(1 << M2M_CONTROL_PW_SHIFT)
> +#define M2M_CONTROL_PW_32		(2 << M2M_CONTROL_PW_SHIFT)
> +#define M2M_CONTROL_TM_SHIFT		13
> +#define M2M_CONTROL_TM_MEMORY		(0 << M2M_CONTROL_TM_SHIFT)
> +#define M2M_CONTROL_TM_TX		(1 << M2M_CONTROL_TM_SHIFT)
> +#define M2M_CONTROL_TM_RX		(2 << M2M_CONTROL_TM_SHIFT)
> +#define M2M_CONTROL_NFBINT		BIT(21)
> +#define M2M_CONTROL_RSS_SHIFT		22
> +#define M2M_CONTROL_RSS_EXT_DREQ	(0 << M2M_CONTROL_RSS_SHIFT)
> +#define M2M_CONTROL_RSS_SSPRX 		(1 << M2M_CONTROL_RSS_SHIFT)
> +#define M2M_CONTROL_RSS_SSPTX 		(2 << M2M_CONTROL_RSS_SHIFT)
> +#define M2M_CONTROL_RSS_IDE 		(3 << M2M_CONTROL_RSS_SHIFT)
> +#define M2M_CONTROL_NO_HDSK		BIT(24)
> +#define M2M_CONTROL_PWSC_SHIFT		25
> +
> +#define M2M_INTERRUPT			0x0004
> +#define M2M_INTERRUPT_STALLINT		BIT(0)
> +#define M2M_INTERRUPT_DONEINT		BIT(1)
> +#define M2M_INTERRUPT_NFBINT		BIT(2)
> +
> +#define M2M_STATUS			0x000c
> +#define M2M_STATUS_STALL		BIT(0)
> +#define M2M_STATUS_DONE			BIT(6)
> +#define M2M_STATUS_NFB			BIT(11)
> +
> +#define M2M_BCR0			0x0010
> +#define M2M_BCR1			0x0014
> +#define M2M_SAR_BASE0			0x0018
> +#define M2M_SAR_BASE1			0x001c
> +#define M2M_SAR_CURRENT0		0x0024
> +#define M2M_SAR_CURRENT1		0x0024
> +#define M2M_DAR_BASE0			0x002c
> +#define M2M_DAR_BASE1			0x0030
> +#define M2M_DAR_CURRENT0		0x0034
> +#define M2M_DAR_CURRENT1		0x003c
> +
> +/**
> + * struct m2m_channel - DMA Memory-to-memory channel information
> + */
> +struct m2m_channel {
> +	spinlock_t			lock;
> +	char				*name;
> +	void __iomem			*base;
> +	int				irq;
> +	u32				addr;
> +	struct clk			*clk;
> +	struct ep93xx_dma_m2m_client 	*client;
> +	struct ep93xx_dma_m2m_buffer	*buffer;
> +	struct list_head		buffers_pending;
> +};
> +
> +static struct m2m_channel m2m_channels[] = {
> +	{
> +		.name = "m2m0",
> +		.base = EP93XX_DMA_BASE + 0x0100,
> +		.irq 	= IRQ_EP93XX_DMAM2M0,
> +	},
> +	{
> +		.name = "m2m1",
> +		.base = EP93XX_DMA_BASE + 0x0140,
> +		.irq 	= IRQ_EP93XX_DMAM2M1,
> +	},
> +};
> +
> +#ifdef DEBUG
> +static void m2m_dump_channel(struct m2m_channel *ch, const char *msg)
> +{

This should ideally be done in debugfs. Possibly maintain statistics
about interrupts etc?

> +	int others;
> +	u32 v;
> +
> +	pr_debug("%s channel %s: <%s>\n",
> +		(ch->client->dir == DMA_TO_DEVICE) ? "TX" : "RX",
> +		ch->name, msg);
> +
> +	v = readl(ch->base + M2M_CONTROL);
> +	others = 0;
> +	pr_debug("  CONTROL     : %x [", v);
> +	if (v & M2M_CONTROL_STALLINT)
> +		pr_cont("%sSTALLINT", others++ ? "|" : "");
> +	if (v & M2M_CONTROL_SCT)
> +		pr_cont("%sSCT", others++ ? "|" : "");
> +	if (v & M2M_CONTROL_DONEINT)
> +		pr_cont("%sDONEINT", others++ ? "|" : "");
> +	if (v & M2M_CONTROL_DAH)
> +		pr_cont("%sDAH", others++ ? "|" : "");
> +	if (v & M2M_CONTROL_SAH)
> +		pr_cont("%sSAH", others++ ? "|" : "");
> +	if (v & M2M_CONTROL_NO_HDSK)
> +		pr_cont("%sNO_HDSK", others++ ? "|" : "");
> +	pr_cont("]\n");

Having others++ in each case is a bit ugly and error prone. I think it
is cleaner to do the increment once at the end of the block.

> +
> +	pr_debug("  INTERRUPT   : %x\n", readl(ch->base + M2M_INTERRUPT));
> +
> +	v = readl(ch->base + M2M_STATUS);
> +	others = 0;
> +	pr_debug("  STATUS      : %x [", v);
> +	if (v & M2M_STATUS_STALL)
> +		pr_cont("%sSTALL", others++ ? "|" : "");
> +	if (v & M2M_STATUS_DONE)
> +		pr_cont("%sDONE", others++ ? "|" : "");
> +	if (v & M2M_STATUS_NFB)
> +		pr_cont("%sNFB", others++ ? "|" : "");
> +	pr_cont("]\n");
> +
> +	pr_debug("  BCR0        : %d\n", readl(ch->base + M2M_BCR0));
> +	pr_debug("  SAR_BASE0   : %x\n", readl(ch->base + M2M_SAR_BASE0));
> +	pr_debug("  SAR_CURRENT0: %x\n", readl(ch->base + M2M_SAR_CURRENT0));
> +	pr_debug("  DAR_BASE0   : %x\n", readl(ch->base + M2M_DAR_BASE0));
> +	pr_debug("  DAR_CURRENT0: %x\n", readl(ch->base + M2M_DAR_CURRENT0));
> +}
> +#else
> +static inline void m2m_dump_channel(struct m2m_channel *ch, const char *msg)
> +{
> +}
> +#endif
> +
> +static inline void m2m_set_control(struct m2m_channel *ch, u32 v)
> +{
> +	/*
> +	 * There's a rule for M2P CONTROL register that it should be
> +	 * read immediately after being written. Altough not required

Typo 'Altough'.

> +	 * for M2M, we will do it anyway.
> +	 */
> +	writel(v, ch->base + M2M_CONTROL);
> +	readl(ch->base + M2M_CONTROL);
> +}
> +
> +static void m2m_feed_buf(struct m2m_channel *ch,
> +			 struct ep93xx_dma_m2m_buffer *buf)
> +{
> +	writel(buf->src_addr, ch->base + M2M_SAR_BASE0);
> +	writel(buf->dst_addr, ch->base + M2M_DAR_BASE0);
> +	writel(buf->size, ch->base + M2M_BCR0);
> +}
> +
> +static int m2m_channel_init(struct m2m_channel *ch)
> +{
> +	ch->clk = clk_get(NULL, ch->name);
> +	if (IS_ERR(ch->clk))
> +		return PTR_ERR(ch->clk);
> +
> +	spin_lock_init(&ch->lock);
> +	ch->client = NULL;
> +	return 0;
> +}
> +
> +static void m2m_channel_finish(struct m2m_channel *ch)
> +{
> +	if (!IS_ERR(ch->clk))
> +		clk_put(ch->clk);

Can we finish a channel without a clock? Surely we want to BUG or warn
in this case?

> +}
> +
> +static void m2m_channel_enable(struct m2m_channel *ch)
> +{
> +	u32 v = readl(ch->base + M2M_CONTROL);

Nitpick: Blank line between variable declarations and code.

> +	v |= M2M_CONTROL_ENABLE;
> +	m2m_set_control(ch, v);
> +}
> +
> +static void m2m_channel_disable(struct m2m_channel *ch)
> +{
> +	u32 v = readl(ch->base + M2M_CONTROL);
> +
> +	v &= ~(M2M_CONTROL_DONEINT | M2M_CONTROL_NFBINT);
> +	m2m_set_control(ch, v);
> +
> +	/* REVISIT should we wait here while the channel empties? */
> +
> +	v &= ~M2M_CONTROL_ENABLE;
> +	m2m_set_control(ch, v);
> +}
> +
> +static void m2m_channel_configure(struct m2m_channel *ch)
> +{
> +	struct ep93xx_dma_m2m_client *cl = ch->client;
> +	u32 control = readl(ch->base + M2M_CONTROL);
> +
> +	switch (cl->request) {
> +	case EP93XX_DMA_M2M_REQ_SSP:
> +		if (cl->dir == DMA_TO_DEVICE) {
> +			control |= M2M_CONTROL_DAH;
> +			control |= M2M_CONTROL_TM_TX;
> +			control |= M2M_CONTROL_RSS_SSPTX;
> +		} else {
> +			control |= M2M_CONTROL_SAH;
> +			control |= M2M_CONTROL_TM_RX;
> +			control |= M2M_CONTROL_RSS_SSPRX;
> +		}
> +
> +		control |= M2M_CONTROL_NO_HDSK;
> +		/*
> +		 * This is found via experimenting. Anything less than 5 causes
> +		 * the channel perform only a partial transfer which leads to
> +		 * problems since we don't get DONE int.
> +		 */
> +		control |= (5 << M2M_CONTROL_PWSC_SHIFT);
> +
> +		break;
> +
> +	default:
> +		/*
> +		 * TODO: implement rest of the M2M requests.
> +		 */
> +		BUG();

The SPI support is probably all we need for now anyway unless somebody
wants to implement DMA memcpy. We don't have an IDE driver so that
support is unneeded. I think this should just return EINVAL for the
request though rather than doing a BUG.

> +	}
> +
> +	m2m_set_control(ch, control);
> +}
> +
> +static irqreturn_t m2m_interrupt(int irq, void *dev_id)
> +{
> +	struct m2m_channel *ch = dev_id;
> +	struct ep93xx_dma_m2m_client *cl = ch->client;
> +	u32 irq_status;
> +
> +	spin_lock(&ch->lock);
> +
> +	m2m_dump_channel(ch, "interrupt");
> +
> +	irq_status = readl(ch->base + M2M_INTERRUPT);
> +	if (irq_status & M2M_INTERRUPT_DONEINT) {
> +		/* Clear the DONE interrupt */
> +		writel(0, ch->base + M2M_INTERRUPT);
> +
> +		m2m_channel_disable(ch);
> +
> +		cl->callback(cl->cookie);
> +		ch->buffer = NULL;
> +	}
> +
> +	spin_unlock(&ch->lock);
> +	return IRQ_HANDLED;

Should we return IRQ_NONE if we didn't do anything?

> +}
> +
> +int ep93xx_dma_m2m_client_register(struct ep93xx_dma_m2m_client *cl)
> +{
> +	struct m2m_channel *ch = NULL;
> +	int i, err;
> +
> +	switch (cl->request) {
> +	case EP93XX_DMA_M2M_REQ_MEMORY:
> +	case EP93XX_DMA_M2M_REQ_IDE:
> +	case EP93XX_DMA_M2M_REQ_SSP:
> +		for (i = 0; i < ARRAY_SIZE(m2m_channels); i++) {
> +			if (!m2m_channels[i].client) {
> +				ch = &m2m_channels[i];
> +				break;
> +			}
> +		}
> +		break;
> +
> +	/*
> +	 * External DREQs have predefined channels and we cannot
> +	 * configure otherwise.
> +	 */
> +	case EP93XX_DMA_M2M_REQ_EXT_DREQ0:
> +		ch = &m2m_channels[0];
> +		break;
> +
> +	case EP93XX_DMA_M2M_REQ_EXT_DREQ1:
> +		ch = &m2m_channels[1];
> +		break;
> +
> +	default:
> +		pr_err("invalid DMA channel request %d\n", cl->request);
> +		return -EINVAL;
> +	}
> +
> +	if (!ch || ch->client)
> +		return -EBUSY;
> +
> +	spin_lock_irq(&ch->lock);
> +	ch->client = cl;
> +	ch->buffer = NULL;
> +	INIT_LIST_HEAD(&ch->buffers_pending);
> +	spin_unlock_irq(&ch->lock);

Do we need to use spin_lock_irq here? We haven't yet registered an
interrupt handler for this channel.

> +
> +	cl->channel = ch;
> +
> +	err = request_irq(ch->irq, m2m_interrupt, 0, cl->name ? : "dma-m2m", ch);
> +	if (err)
> +		return err;

We should set ch->client/cl->channel to NULL here or the channel will
remain busy forever right?

> +
> +	err = clk_enable(ch->clk);
> +	if (err) {
> +		free_irq(ch->irq, ch);
> +		return err;

Same here. Set ch->client/cl->channel to NULL.

> +	}
> +
> +	m2m_set_control(ch, 0);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ep93xx_dma_m2m_client_register);
> +
> +void ep93xx_dma_m2m_client_unregister(struct ep93xx_dma_m2m_client *cl)
> +{
> +	struct m2m_channel *ch = cl->channel;
> +
> +	spin_lock_irq(&ch->lock);
> +	m2m_set_control(ch, 0);
> +	clk_disable(ch->clk);
> +	free_irq(ch->irq, ch);
> +	ch->client = NULL;
> +	spin_unlock_irq(&ch->lock);
> +
> +	cl->channel = NULL;
> +}
> +EXPORT_SYMBOL_GPL(ep93xx_dma_m2m_client_unregister);
> +
> +int ep93xx_dma_m2m_config(struct ep93xx_dma_m2m_client *cl,
> +			  enum ep93xx_dma_m2m_parameter param,
> +			  unsigned value)
> +{
> +	struct m2m_channel *ch = cl->channel;
> +	unsigned long flags;
> +	int ret = 0;
> +	u32 control;
> +
> +	spin_lock_irqsave(&ch->lock, flags);
> +	if (ch->buffer) {
> +		spin_unlock_irqrestore(&ch->lock, flags);
> +		return -EBUSY;
> +	}
> +
> +	control = readl(ch->base + M2M_CONTROL);
> +
> +	switch (param) {
> +	case EP93XX_DMA_M2M_DAH:
> +		if (value)
> +			control |= M2M_CONTROL_DAH;
> +		else
> +			control &= ~M2M_CONTROL_DAH;
> +		break;
> +
> +	case EP93XX_DMA_M2M_SAH:
> +		if (value)
> +			control |= M2M_CONTROL_SAH;
> +		else
> +			control &= ~M2M_CONTROL_SAH;
> +		break;
> +
> +	case EP93XX_DMA_M2M_PW:
> +		if (cl->request == EP93XX_DMA_M2M_REQ_MEMORY) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		control &= ~(M2M_CONTROL_PW_16 | M2M_CONTROL_PW_32);
> +
> +		switch (value) {
> +		case 8:
> +			break;
> +		case 16:
> +			control |= M2M_CONTROL_PW_16;
> +			break;
> +		case 32:
> +			control |= M2M_CONTROL_PW_32;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	if (ret == 0)
> +		m2m_set_control(ch, control);
> +
> +	spin_unlock_irqrestore(&ch->lock, flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ep93xx_dma_m2m_config);
> +
> +void ep93xx_dma_m2m_submit(struct ep93xx_dma_m2m_client *cl,
> +			   struct ep93xx_dma_m2m_buffer *buf)
> +{
> +	struct m2m_channel *ch = cl->channel;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ch->lock, flags);
> +	if (!ch->buffer) {
> +		u32 control;
> +
> +		m2m_channel_configure(ch);
> +
> +		ch->buffer = buf;
> +		m2m_feed_buf(ch, buf);
> +
> +		control = readl(ch->base + M2M_CONTROL);
> +		control |= M2M_CONTROL_DONEINT;
> +		m2m_set_control(ch, control);
> +
> +		m2m_dump_channel(ch, "submit");
> +
> +		m2m_channel_enable(ch);
> +	} else {
> +		list_add_tail(&buf->list, &ch->buffers_pending);
> +	}
> +	spin_unlock_irqrestore(&ch->lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(ep93xx_dma_m2m_submit);
> +
> +static int __init ep93xx_dma_m2m_init(void)
> +{
> +	int i, err;
> +
> +	for (i = 0; i < ARRAY_SIZE(m2m_channels); i++) {
> +		struct m2m_channel *ch = &m2m_channels[i];
> +
> +		err = m2m_channel_init(ch);
> +		if (err) {
> +			pr_err("failed to initialize channel %s\n",
> +				ch->name);
> +			goto fail;
> +		}
> +	}
> +
> +	pr_info("M2M DMA subsystem initialized\n");
> +	return 0;
> +
> +fail:
> +	for (--i; i >= 0; i--)
> +		m2m_channel_finish(&m2m_channels[i]);
> +
> +	return err;
> +}
> +arch_initcall(ep93xx_dma_m2m_init);
> diff --git a/arch/arm/mach-ep93xx/include/mach/dma.h b/arch/arm/mach-ep93xx/include/mach/dma.h
> index 5e31b2b..8e3f650 100644
> --- a/arch/arm/mach-ep93xx/include/mach/dma.h
> +++ b/arch/arm/mach-ep93xx/include/mach/dma.h
> @@ -15,6 +15,7 @@
>  
>  #include <linux/list.h>
>  #include <linux/types.h>
> +#include <linux/dma-mapping.h>
>  
>  /**
>   * struct ep93xx_dma_buffer - Information about a buffer to be transferred
> @@ -146,4 +147,60 @@ void ep93xx_dma_m2p_submit_recursive(struct ep93xx_dma_m2p_client *m2p,
>   */
>  void ep93xx_dma_m2p_flush(struct ep93xx_dma_m2p_client *m2p);
>  
> +/*
> + * M2M DMA supports five hardware requests: 2 for external
> + * peripherials that follow the handshake protocol and 3
> + * simple requests from IDE, SSPRx and SSPTx.
> + */
> +enum ep93xx_dma_m2m_request {
> +	EP93XX_DMA_M2M_REQ_MEMORY,
> +	EP93XX_DMA_M2M_REQ_IDE,
> +	EP93XX_DMA_M2M_REQ_SSP,
> +	EP93XX_DMA_M2M_REQ_EXT_DREQ0,
> +	EP93XX_DMA_M2M_REQ_EXT_DREQ1,
> +};
> +
> +/**
> + * Parameters that the client can configure.
> + */
> +enum ep93xx_dma_m2m_parameter {
> +	EP93XX_DMA_M2M_PW,
> +	EP93XX_DMA_M2M_SAH,
> +	EP93XX_DMA_M2M_DAH,
> +	EP93XX_DMA_M2M_SCT,
> +};
> +
> +struct ep93xx_dma_m2m_buffer {
> +	struct list_head	list;
> +	dma_addr_t		src_addr;
> +	dma_addr_t		dst_addr;
> +	size_t			size;
> +};
> +
> +/**
> + * struct ep93xx_dma_m2m_client - Information about a DMA M2M client
> + * @name: name for this client
> + * @request: one of the 5 requests supported by the DMA M2M
> + *           controller
> + * @dir: direction of the data flow
> + * @cookie: user data to pass to callback functions
> + * @callback: callback called when the buffer is finished
> + */
> +struct ep93xx_dma_m2m_client {
> +	const char 			*name;
> +	enum ep93xx_dma_m2m_request	request;
> +	enum dma_data_direction		dir;
> +	void 				*cookie;
> +	void				(*callback)(void *);
> +	void				*channel;
> +};
> +
> +int ep93xx_dma_m2m_client_register(struct ep93xx_dma_m2m_client *cl);
> +void ep93xx_dma_m2m_client_unregister(struct ep93xx_dma_m2m_client *cl);
> +int ep93xx_dma_m2m_config(struct ep93xx_dma_m2m_client *cl,
> +			  enum ep93xx_dma_m2m_parameter, unsigned value);
> +void ep93xx_dma_m2m_submit(struct ep93xx_dma_m2m_client *cl,
> +			   struct ep93xx_dma_m2m_buffer *buf);
> +void ep93xx_dma_m2m_flush(struct ep93xx_dma_m2m_client *cl);
> +
>  #endif /* __ASM_ARCH_DMA_H */
> -- 
> 1.7.2.3

Mostly this looks good. I would like to know if it can be integrated
with existing code though, either dmaengine or the EP93xx DMA M2P code.

Thanks,
~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
