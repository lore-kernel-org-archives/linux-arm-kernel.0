From: mcuos.com@gmail.com (Wan ZongShun)
Date: Mon, 23 Nov 2009 02:34:46 +0800
Subject: [PATCH] Add GDMA API for w90p910 platform
In-Reply-To: <713d0d430911220122x68aecb28w1a1d804b4b9c765a@mail.gmail.com>
References: <713d0d430911220122x68aecb28w1a1d804b4b9c765a@mail.gmail.com>
Message-ID: <e68bb3470911221034o13d427c9ua6e2b5484b2f3876@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hu Ruihuan,

Thanks a lot for your submitting this DMA patch for NUC900 series platform.

2009/11/22 Hu Ruihuan <specter118@gmail.com>:
> Dear sir,
>
> GDMA controller provides a data transfer mechanism,it can move data
> from memory to memory or memory to external devices without cpu's
> action,Now it is a API PATCH to 910 platform.
>
> Add GDMA API for w90p910 platform

Hi, now our Winbond SOC platform named the form of 'NUC900', rather
than w90p910, maybe you can call the 910 to 'nuc900' instead. and I
very prefer this name.

> Signed-off-by: Hu Ruihuan<specter118@gmail.com>
> ----------------------
> diff -Naur linux-2.6.32-rc8/arch/arm/mach-w90x900/dma.c
> linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/dma.c
> --- linux-2.6.32-rc8/arch/arm/mach-w90x900/dma.c ? ? ? ?1970-01-01
> 08:00:00.000000000 +0800
> +++ linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/dma.c 2009-11-20
> 00:06:44.000000000 +0800
> @@ -0,0 +1,318 @@
> +/*
> + * arch/arm/mach-w90p910/dma.c
> + *
> + * Support functions for the w90p910 internal DMA channels.
> + *
> + * Wan Zongshun <mcuos.com@xxxxxxxxx>
> + * Hu Ruihuan ? ? ?<specter118@gmail.com>
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

Oh, why is my mail address missing and 'xxxxxxx' instead?
Whether do you copy my previous patch in website or not directly?

> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/spinlock.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +
> +#include <asm/system.h>
> +#include <asm/irq.h>
> +#include <asm/atomic.h>
> +#include <mach/hardware.h>
> +
> +#define W90P910_DMA_CHANNELS ? ? ? ? ? (2)
> +#define DMA_BASE ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (W90X900_VA_GDMA)
> +#define GDMA_INTCS ? ? ? ? ? ? ? ? ? ? ? ? ? ? (DMA_BASE + 0xa0)
> +
> +#define GDMA_GDGA ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(0x1c)
> +#define TC0F ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (0x01 << 8)
> +#define TC1F ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (0x01 << 10)
> +#define ENTC0F ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (0x01)
> +#define ENTC1F ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (0x01 << 2)
> +
> +#define GDMAEN ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (0x01)
> +#define GDMAMS ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (0x03 << 2)
> +#define DADIR ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(0x01 << 4)
> +#define SADIR ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(0x01 << 5)
> +#define DAFIX ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(0x01 << 6)
> +#define SAFIX ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(0x01 << 7)
> +#define D_INTS ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (0x01 << 10)
> +#define TWSMASK ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(0x03 << 12)
> +#define TWS ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(0x02 << 12)
> +
> +#define RUN ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(0x01 << 3)
> +#define NON_DSCRIP ? ? ? ? ? ? ? ? ? ? ? ? ? ? (0x01 << 2)
> +#define ORDEN ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(0x01 << 1)
> +#define RESET ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(0x01)
> +#define DSCRIPMASK ? ? ? ? ? ? ? ? ? ? ? ? ? ? (0x0F)
> +#define CMDINFOMASK ? ? ? ? ? ? ? ? ? ? ? ? ? ?(0x03FFF)
> +
> +#define COUTN_TRANSFER ? ? ? ? ? ? ? ? (0x1000)/*count[13:0]=1024*/
> +#define CHANNELINERV ? ? ? ? ? ? ? ? ? ? ? ? ? (0x20)
> +
> +typedef void (*dma_callback_t)(void *data);
> +
> +struct w90p910_dma_descp {
> + ? ? ? unsigned int next_descp;
> + ? ? ? unsigned int srcaddr;
> + ? ? ? unsigned int dstaddr;
> + ? ? ? unsigned int commandinfo;
> +};
> +
> +struct w90p910_dma_t {
> + ? ? ? const char *device; ? ? ? ? ? ? /* this channel device, 0 ?if unused */
> + ? ? ? dma_callback_t callback; ? ? ? ?/* to call when DMA completes */
> + ? ? ? void __iomem *dma_reg;
> + ? ? ? void *data; ? ? ? ? ? ? ? ? ? ? /* ... with private data ptr */
> + ? ? ? struct w90p910_dma_descp *descp;
> +};
> +
> +static struct w90p910_dma_t dma_chan[W90P910_DMA_CHANNELS];
> +static struct w90p910_dma_t *dmachan0, *dmachan1;
> +static atomic_t ?shared_irq_using;
> +static spinlock_t dma_chan_lock;
> +
> +
> +
> +static int register_dmachan_fromname(const char *dev_name,
> + ? ? ? ? ? ? ? ? ? ? ? struct w90p910_dma_t *dma, unsigned int *irq_request)
> +{
> + ? ? ? int err;
> +
> + ? ? ? BUG_ON(!dev_name);
> +
> + ? ? ? err = 0;
> +
> + ? ? ? if (!(dmachan0->device) && !(dmachan1->device)) {
> + ? ? ? ? ? ? ? dma = dmachan0;
> + ? ? ? ? ? ? ? *irq_request = 1;
> + ? ? ? } else if ((dmachan0->device) && !(dmachan1->device)) {
> + ? ? ? ? ? ? ? ? ? ? ? if (strcmp(dmachan0->device, dev_name) == 0)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? err = -EBUSY;
> + ? ? ? ? ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dma = dmachan1;
> + ? ? ? } else if ((dmachan1->device) && !(dmachan0->device)) {
> + ? ? ? ? ? ? ? ? ? ? ? if (strcmp(dmachan1->device, dev_name) == 0)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? err = -EBUSY;
> + ? ? ? ? ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dma = dmachan0;
> + ? ? ? } else
> + ? ? ? ? ? ? ? err = -EBUSY;
> +
> + ? ? ? return err;
> +
> +}
> +
> +static void match_dmachan_fromname(const char *dev_name,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct w90p910_dma_t *dma)
> +{
> + ? ? ? BUG_ON(!dev_name);
> +
> + ? ? ? if (dmachan1->device) {
> + ? ? ? ? ? ? ? if (strcmp(dmachan1->device, dev_name) == 0)
> + ? ? ? ? ? ? ? ? ? ? ? dma = dmachan1;
> + ? ? ? } else if (dmachan0->device) {
> + ? ? ? ? ? ? ? if (strcmp(dmachan0->device, dev_name) == 0)
> + ? ? ? ? ? ? ? ? ? ? ? dma = dmachan0;
> + ? ? ? }
> +}
> +
> +static irqreturn_t dma_irq_handler(int irq, void *dev_id)
> +{
> + ? ? ? int status;
> + ? ? ?local_irq_disable();
> + ? ? ? status = __raw_readl(GDMA_GDGA);
> +
> + ? ? ? if (status & (TC0F)) {
> + ? ? ? ? ? ? ? __raw_writel((~TC0F), GDMA_GDGA);
> + ? ? ? ? ? ? ?local_irq_enable();
> + ? ? ? ? ? ? ? dmachan0->callback(dmachan0->data);
> + ? ? ? }
> +
> + ? ? ? if (status & (TC1F)) {
> + ? ? ? ? ? ? ? __raw_writel((~TC1F), GDMA_GDGA);
> + ? ? ? ? ? ? ?local_irq_enable();
> + ? ? ? ? ? ? ? dmachan1->callback(dmachan1->data);
> + ? ? ? }
> +
> + ? ? ? return IRQ_HANDLED;
> +}
> +
> +int w90p910_request_dma(const char *dev_name, dma_callback_t callback,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? void *data)
> +{
> + ? ? ? struct w90p910_dma_t *dma = NULL;
> + ? ? ? int err, irq_request;
> +
> + ? ? ? err = 0;
> + ? ? ? irq_request = 0;
> + ? ? ?spin_lock(&dma_chan_lock);
> + ? ? ? err = register_dmachan_fromname(dev_name, dma, &irq_request);
> +
> + ? ? ? if (err < 0) {
> + ? ? ? ? ? ? ?spin_unlock(&dma_chan_lock);
> + ? ? ? ? ? ? ? return err;
> + ? ? ?}
> +
> + ? ? ? dma->device = dev_name;
> +
> + ? ? ? if (irq_request) {
> + ? ? ? ? ? ? ? err = request_irq(IRQ_GDMAGROUP, dma_irq_handler, IRQF_SHARED|
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? IRQF_DISABLED, NULL, NULL);
> + ? ? ? ? ? ? ? if (err) {
> + ? ? ? ? ? ? ? ? ? ? ? dma->device = NULL;
> + ? ? ? ? ? ? ? ? ? ? ?spin_unlock(&dma_chan_lock);
> + ? ? ? ? ? ? ? ? ? ? ? return err;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> +
> +
> + ? ? ?atomic_inc( &shared_irq_using);
> + ? ? ? dma->callback = callback;
> + ? ? ? dma->data = data;
> + ? ? ?spin_unlock(&dma_chan_lock);
> + ? ? ? return 0;
> +}
> +EXPORT_SYMBOL(w90p910_request_dma);
> +
> +int w90p910_free_dma(const char *dev_name)
> +{
> + ? ? ? struct w90p910_dma_t *dma = NULL;
> +
> + ? ? ? BUG_ON(!dev_name);
> + ? ? ? WARN_ON(shared_irq_using.counter == 0);
> + ? ? ?spin_lock(&dma_chan_lock);
> + ? ? ? match_dmachan_fromname(dev_name, dma);
> +
> + ? ? ? if (!dma)
> + ? ? ? ? ? ? ? return -ENXIO;
> +
> + ? ? ? dma->device = NULL;
> + ? ? ? spin_unlock(&dma_chan_lock);
> +
> + ? ? ?atomic_dec(&shared_irq_using);
> +
> +
> + ? ? ? if (!(shared_irq_using.counter))
> + ? ? ? ? ? ? ? free_irq(IRQ_GDMAGROUP, dma);
> +
> + ? ? ? kzfree(dma->descp);
> + ? ? ? return 0;
> +}
> +EXPORT_SYMBOL(w90p910_free_dma);
> +
> +static unsigned int set_start_cmd(unsigned int start)
> +{
> + ? ? ? unsigned int dscp_cmd;
> +
> + ? ? ? dscp_cmd = 0;
> +
> + ? ? ? if (start) {
> + ? ? ? ? ? ? ? dscp_cmd = (ORDEN|RUN);
> + ? ? ? ? ? ? ? dscp_cmd &= ~(NON_DSCRIP|RESET);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? dscp_cmd = (NON_DSCRIP);
> + ? ? ? }
> + ? ? ? ? ? ? ? dscp_cmd &= DSCRIPMASK;
> +
> + ? ? ? return dscp_cmd;
> +}
> +
> +static unsigned int set_cmd_info(unsigned int countsize)
> +{
> + ? ? ? unsigned int cmd_info;
> +
> + ? ? ? cmd_info = (countsize >> 2);
> +
> + ? ? ? cmd_info = (((cmd_info & CMDINFOMASK) << 18)|GDMAEN|D_INTS);
> + ? ? ? cmd_info &= ~(GDMAMS|DADIR|SADIR|DAFIX|SAFIX|TWSMASK);
> + ? ? ? cmd_info |= TWS;
> +
> + ? ? ? return cmd_info;
> +
> +}
> +
> +static unsigned int get_descplist_num(unsigned int size, unsigned int *leave)
> +{
> + ? ? ? unsigned int dscp_num, other_num;
> +
> + ? ? ? dscp_num = 0;
> + ? ? ? other_num = 0;
> +
> + ? ? ? dscp_num = size / COUTN_TRANSFER;
> + ? ? ? other_num = size % COUTN_TRANSFER;
> +
> + ? ? ? if (other_num)
> + ? ? ? ? ? ? ? dscp_num += 1;
> +
> + ? ? ? *leave = other_num;
> +
> + ? ? ? return dscp_num;
> +
> +}
> +
> +int w90p910_start_dma(const char *dev_name, dma_addr_t dma_src,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dma_addr_t dma_dst, unsigned int size)
> +{
> + ? ? ? struct w90p910_dma_descp *descp = NULL;
> + ? ? ? struct w90p910_dma_t *dma = NULL;
> + ? ? ? unsigned int i, dscp_num, other_num, val;
> +
> + ? ? ? BUG_ON((!size|!dev_name));
> +
> + ? ? ? match_dmachan_fromname(dev_name, dma);
> +
> + ? ? ? if (!dma)
> + ? ? ? ? ? ? ? return -ENXIO;
> +
> + ? ? ? dscp_num = get_descplist_num(size, &other_num);
> +
> + ? ? ? descp = kzalloc(dscp_num * sizeof(struct w90p910_dma_t), GFP_KERNEL);
> +
> + ? ? ? if (!descp)
> + ? ? ? ? ? ? ? return -ENOMEM;
> +
> + ? ? ? dma->descp = descp;
> +
> + ? ? ? for (i = 0; i < dscp_num; i++) {
> + ? ? ? ? ? ? ? descp->next_descp = set_start_cmd(1);
> + ? ? ? ? ? ? ? descp->srcaddr = dma_src + COUTN_TRANSFER * i;
> + ? ? ? ? ? ? ? descp->dstaddr = dma_dst + COUTN_TRANSFER * i;
> + ? ? ? ? ? ? ? descp->commandinfo = set_cmd_info(COUTN_TRANSFER);
> + ? ? ? ? ? ? ? descp++;
> + ? ? ? }
> + ? ? ? descp--;
> + ? ? ? descp->next_descp = set_start_cmd(0);
> + ? ? ? descp->commandinfo = set_cmd_info(other_num);
> +
> +
> + ? ? ? val = set_start_cmd(1);
> + ? ? ? val |= (unsigned int)(dma->descp);
> + ? ? ?local_irq_disable();
> + ? ? ? __raw_writel(val, dma->dma_reg + GDMA_GDGA);
> +
> + ? ? ? val = __raw_readl(GDMA_INTCS);
> + ? ? ? val |= (ENTC0F|ENTC1F);
> + ? ? ? __raw_writel(val, GDMA_INTCS);
> + ? ? ?local_irq_enable();
> +
> + ? ? ? return 0;
> +}
> +EXPORT_SYMBOL(w90p910_start_dma);
> +
> +void __init w90p910_init_dma(void)
> +{
> + ? ? ? unsigned ? ? ? ?i;
> + ? ? ? struct w90p910_dma_t *dma_channel;
> + ? ? ?spin_lock_init(&dma_chan_lock);
> + ? ? ? for (i = 0; i < W90P910_DMA_CHANNELS; i++) {
> + ? ? ? ? ? ? ? dma_channel = &dma_chan[i];
> + ? ? ? ? ? ? ? dma_channel->dma_reg = DMA_BASE + i * CHANNELINERV;
> + ? ? ? ? ? ? ? dma_channel->device = NULL;
> + ? ? ? }
> +
> + ? ? ? dmachan0 = &dma_chan[0];
> + ? ? ? dmachan1 = &dma_chan[1];
> +}
> diff -Naur linux-2.6.32-rc8/arch/arm/mach-w90x900/Makefile
> linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/Makefile
> --- linux-2.6.32-rc8/arch/arm/mach-w90x900/Makefile ? ? 2009-11-20
> 06:32:38.000000000 +0800
> +++ linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/Makefile ? ? ?2010-11-20
> 00:02:07.000000000 +0800
> @@ -5,7 +5,7 @@
> ?# Object file lists.
>
> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?:= irq.o time.o mfp.o gpio.o clock.o
> -obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= clksel.o dev.o cpu.o
> +obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= clksel.o dev.o cpu.o dma.o
> ?# W90X900 CPU support files
>
> ?obj-$(CONFIG_CPU_W90P910) ? ? ?+= nuc910.o
> diff -Naur linux-2.6.32-rc8/arch/arm/mach-w90x900/Makefile.orig
> linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/Makefile.orig
> --- linux-2.6.32-rc8/arch/arm/mach-w90x900/Makefile.orig ? ? ? ?1970-01-01
> 08:00:00.000000000 +0800
> +++ linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/Makefile.orig 2007-11-22
> 13:32:42.000000000 +0800

Why having this Makefile.orig?
I think you getting my previous DMA patch and when you patch it to
Linux-2.6.32-rc8, some errors can occur, so the Makefile.orig was
brought out.

I can give you the following advice:

Firstly, you can apply this patch to Linux-2.6.30 and obtain a correct
dma.c and Makefile.
secondly, refer to those files to try to add the dma driver for the
linux-2.6.32-rc8.
thirdly, please read carefully  SubmittingPatches and
SubmittingDrivers located in Linux/Documentation.

> @@ -0,0 +1,19 @@
> +#
> +# Makefile for the linux kernel.
> +#
> +
> +# Object file lists.
> +
> +obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?:= irq.o time.o mfp.o gpio.o clock.o
> +obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= clksel.o dev.o cpu.o
> +# W90X900 CPU support files
> +
> +obj-$(CONFIG_CPU_W90P910) ? ? ?+= nuc910.o
> +obj-$(CONFIG_CPU_NUC950) ? ? ? += nuc950.o
> +obj-$(CONFIG_CPU_NUC960) ? ? ? += nuc960.o
> +
> +# machine support
> +
> +obj-$(CONFIG_MACH_W90P910EVB) ?+= mach-nuc910evb.o
> +obj-$(CONFIG_MACH_W90P950EVB) ?+= mach-nuc950evb.o
> +obj-$(CONFIG_MACH_W90N960EVB) ?+= mach-nuc960evb.o
> diff -Naur linux-2.6.32-rc8/arch/arm/mach-w90x900/Makefile.rej
> linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/Makefile.rej
> --- linux-2.6.32-rc8/arch/arm/mach-w90x900/Makefile.rej 1970-01-01
> 08:00:00.000000000 +0800
> +++ linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/Makefile.rej ?2007-11-22
> 16:19:45.000000000 +0800
> @@ -0,0 +1,17 @@
> +***************
> +*** 5,11 ****
> + ?# Object file lists.
> +
> + ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?:= irq.o time.o mfp-w90p910.o gpio.o clock.o
> +-
> + ?# W90X900 CPU support files
> +
> + ?obj-$(CONFIG_CPU_W90P910) ? ?+= w90p910.o
> +--- 5,11 ----
> + ?# Object file lists.
> +
> + ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?:= irq.o time.o mfp-w90p910.o gpio.o clock.o
> ++ obj-y ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+= dma.o
> + ?# W90X900 CPU support files
> +
> + ?obj-$(CONFIG_CPU_W90P910) ? ?+= w90p910.o
> --
> 1.5.6.3
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
