From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 31 Mar 2010 09:06:48 +0200
Subject: [PATCH] ARM: pcmcia: Adds nanoEngine PCMCIA support.
In-Reply-To: <1269972879-27400-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
References: <1269972879-27400-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
Message-ID: <20100331070648.GA23391@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcelo,

On Tue, Mar 30, 2010 at 03:14:39PM -0300, Marcelo Roberto Jimenez wrote:
> This patch adds nanoEngine PCMCIA support, with support for two sockets.
> 
> In order to have a fully functional pcmcia subsystem in a BSE nanoEngine board
> you should carefully read this:
> 
> http://cambuca.ldhs.cetuc.puc-rio.br/nanoengine/
> 
> Signed-off-by: Marcelo Roberto Jimenez <mroberto@cpti.cetuc.puc-rio.br>
> ---
>  arch/arm/mach-sa1100/include/mach/nanoengine.h |   30 ++++
>  arch/arm/mach-sa1100/nanoengine.c              |    2 +-
>  drivers/pcmcia/Makefile                        |    1 +
>  drivers/pcmcia/sa1100_generic.c                |    3 +
>  drivers/pcmcia/sa1100_generic.h                |    1 +
>  drivers/pcmcia/sa1100_nanoengine.c             |  218 ++++++++++++++++++++++++
>  6 files changed, 254 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-sa1100/include/mach/nanoengine.h
>  create mode 100644 drivers/pcmcia/sa1100_nanoengine.c
> 
> diff --git a/arch/arm/mach-sa1100/include/mach/nanoengine.h b/arch/arm/mach-sa1100/include/mach/nanoengine.h
> new file mode 100644
> index 0000000..0537766
> --- /dev/null
> +++ b/arch/arm/mach-sa1100/include/mach/nanoengine.h
> @@ -0,0 +1,30 @@
> +/*
> + * arch/arm/mach-sa1100/include/mach/nanoengine.h
> + *
> + * This file contains the hardware specific definitions for nanoEngine.
> + * Only include this file from SA1100-specific files.
> + *
> + * Copyright (C) 2010 Marcelo Roberto Jimenez <mroberto@cpti.cetuc.puc-rio.br>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +#ifndef __ASM_ARCH_NANOENGINE_H
> +#define __ASM_ARCH_NANOENGINE_H
> +
> +#define GPIO_PC_READY0	GPIO_GPIO(11) /* ready for socket 0 (active high)*/
> +#define GPIO_PC_READY1	GPIO_GPIO(12) /* ready for socket 1 (active high) */
> +#define GPIO_PC_CD0	GPIO_GPIO(13) /* detect for socket 0 (active low) */
> +#define GPIO_PC_CD1	GPIO_GPIO(14) /* detect for socket 1 (active low) */
> +#define GPIO_PC_RESET0	GPIO_GPIO(15) /* reset socket 0 */
> +#define GPIO_PC_RESET1	GPIO_GPIO(16) /* reset socket 1 */
> +
> +#define NANOENGINE_IRQ_GPIO_PC_READY0	IRQ_GPIO11
> +#define NANOENGINE_IRQ_GPIO_PC_READY1	IRQ_GPIO12
> +#define NANOENGINE_IRQ_GPIO_PC_CD0	IRQ_GPIO13
> +#define NANOENGINE_IRQ_GPIO_PC_CD1	IRQ_GPIO14
> +
> +#endif
> +
> diff --git a/arch/arm/mach-sa1100/nanoengine.c b/arch/arm/mach-sa1100/nanoengine.c
> index 73a7922..36cdc8a 100644
> --- a/arch/arm/mach-sa1100/nanoengine.c
> +++ b/arch/arm/mach-sa1100/nanoengine.c
> @@ -3,7 +3,7 @@
>   *
>   * Bright Star Engineering's nanoEngine board init code.
>   *
> - * Copyright (C) 2009 Marcelo Roberto Jimenez <mroberto@cpti.cetuc.puc-rio.br>
> + * Copyright (C) 2010 Marcelo Roberto Jimenez <mroberto@cpti.cetuc.puc-rio.br>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
> index 381b031..bb9fa64 100644
> --- a/drivers/pcmcia/Makefile
> +++ b/drivers/pcmcia/Makefile
> @@ -50,6 +50,7 @@ sa1100_cs-$(CONFIG_SA1100_ASSABET)		+= sa1100_assabet.o
>  sa1100_cs-$(CONFIG_SA1100_CERF)			+= sa1100_cerf.o
>  sa1100_cs-$(CONFIG_SA1100_COLLIE)              += pxa2xx_sharpsl.o
>  sa1100_cs-$(CONFIG_SA1100_H3600)		+= sa1100_h3600.o
> +sa1100_cs-$(CONFIG_SA1100_NANOENGINE)		+= sa1100_nanoengine.o
>  sa1100_cs-$(CONFIG_SA1100_SHANNON)		+= sa1100_shannon.o
>  sa1100_cs-$(CONFIG_SA1100_SIMPAD)		+= sa1100_simpad.o
>  
> diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
> index 5188962..a1fce5d 100644
> --- a/drivers/pcmcia/sa1100_generic.c
> +++ b/drivers/pcmcia/sa1100_generic.c
> @@ -54,6 +54,9 @@ static int (*sa11x0_pcmcia_hw_init[])(struct device *dev) = {
>  #if defined(CONFIG_SA1100_H3100) || defined(CONFIG_SA1100_H3600)
>  	pcmcia_h3600_init,
>  #endif
> +#ifdef CONFIG_SA1100_NANOENGINE
> +	pcmcia_nanoengine_init,
> +#endif
>  #ifdef CONFIG_SA1100_SHANNON
>  	pcmcia_shannon_init,
>  #endif
> diff --git a/drivers/pcmcia/sa1100_generic.h b/drivers/pcmcia/sa1100_generic.h
> index 794f96a..adb08db 100644
> --- a/drivers/pcmcia/sa1100_generic.h
> +++ b/drivers/pcmcia/sa1100_generic.h
> @@ -13,6 +13,7 @@ extern int pcmcia_freebird_init(struct device *);
>  extern int pcmcia_gcplus_init(struct device *);
>  extern int pcmcia_graphicsmaster_init(struct device *);
>  extern int pcmcia_h3600_init(struct device *);
> +extern int pcmcia_nanoengine_init(struct device *);
>  extern int pcmcia_pangolin_init(struct device *);
>  extern int pcmcia_pfs168_init(struct device *);
>  extern int pcmcia_shannon_init(struct device *);
> diff --git a/drivers/pcmcia/sa1100_nanoengine.c b/drivers/pcmcia/sa1100_nanoengine.c
> new file mode 100644
> index 0000000..2f164e6
> --- /dev/null
> +++ b/drivers/pcmcia/sa1100_nanoengine.c
> @@ -0,0 +1,218 @@
> +/*
> + * drivers/pcmcia/sa1100_nanoengine.c
> + *
> + * PCMCIA implementation routines for BSI nanoEngine.
> + *
> + * In order to have a fully functional pcmcia subsystem in a BSE nanoEngine
> + * board you should carefully read this:
> + * http://cambuca.ldhs.cetuc.puc-rio.br/nanoengine/
> + *
> + * Copyright (C) 2010 Marcelo Roberto Jimenez <mroberto@cpti.cetuc.puc-rio.br>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/signal.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/irq.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/nanoengine.h>
> +
> +#include "sa1100_generic.h"
> +
> +static struct pcmcia_irqs irqs_skt0[] = {
> +	/* socket, IRQ, name */
> +	{ 0, NANOENGINE_IRQ_GPIO_PC_CD0, "PC CD0" },
> +};
> +
> +static struct pcmcia_irqs irqs_skt1[] = {
> +	/* socket, IRQ, name */
> +	{ 1, NANOENGINE_IRQ_GPIO_PC_CD1, "PC CD1" },
> +};
> +
> +struct nanoengine_pins {
> +	unsigned input_pins;
> +	unsigned output_pins;
> +	unsigned clear_outputs;
> +	unsigned transition_pins;
> +	unsigned pci_irq;
> +	struct pcmcia_irqs *pcmcia_irqs;
> +	unsigned pcmcia_irqs_size;
> +};
> +
> +static struct nanoengine_pins nano_skts[] = {
> +	{
> +		.input_pins		= GPIO_PC_READY0 | GPIO_PC_CD0,
> +		.output_pins		= GPIO_PC_RESET0,
> +		.clear_outputs		= GPIO_PC_RESET0,
> +		.transition_pins	= NANOENGINE_IRQ_GPIO_PC_CD0,
> +		.pci_irq		= NANOENGINE_IRQ_GPIO_PC_READY0,
> +		.pcmcia_irqs		= irqs_skt0,
> +		.pcmcia_irqs_size	= ARRAY_SIZE(irqs_skt0)
> +	}, {
> +		.input_pins		= GPIO_PC_READY1 | GPIO_PC_CD1,
> +		.output_pins		= GPIO_PC_RESET1,
> +		.clear_outputs		= GPIO_PC_RESET1,
> +		.transition_pins	= NANOENGINE_IRQ_GPIO_PC_CD1,
> +		.pci_irq		= NANOENGINE_IRQ_GPIO_PC_READY1,
> +		.pcmcia_irqs		= irqs_skt1,
> +		.pcmcia_irqs_size	= ARRAY_SIZE(irqs_skt1)
> +	}
> +};
> +
> +unsigned num_nano_pcmcia_sockets = ARRAY_SIZE(nano_skts);
> +
> +static int nanoengine_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
> +{
> +	unsigned i = skt->nr;
> +
> +	if (i >= num_nano_pcmcia_sockets)
> +		return -ENXIO;
> +
> +	GPDR &= ~nano_skts[i].input_pins;
> +	GPDR |=  nano_skts[i].output_pins;
> +	GPCR =   nano_skts[i].clear_outputs;
> +	set_irq_type(nano_skts[i].transition_pins, IRQ_TYPE_EDGE_BOTH);
> +	skt->socket.pci_irq = nano_skts[i].pci_irq;
> +
> +	return soc_pcmcia_request_irqs(skt,
> +		nano_skts[i].pcmcia_irqs, nano_skts[i].pcmcia_irqs_size);
> +}
> +
> +/*
> + * Release all resources.
> + */
> +static void nanoengine_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
> +{
> +	unsigned i = skt->nr;
> +
> +	if (i >= num_nano_pcmcia_sockets)
> +		return;
> +
> +	soc_pcmcia_free_irqs(skt,
> +		nano_skts[i].pcmcia_irqs, nano_skts[i].pcmcia_irqs_size);
> +}
> +
> +static int nanoengine_pcmcia_configure_socket(
> +	struct soc_pcmcia_socket *skt, const socket_state_t *state)
> +{
> +	unsigned reset;
> +	unsigned i = skt->nr;
> +
> +	if (i >= num_nano_pcmcia_sockets)
> +		return -ENXIO;
> +
> +	switch (i) {
> +	case 0:
> +		reset = GPIO_PC_RESET0;
> +		break;
> +	case 1:
> +		reset = GPIO_PC_RESET1;
> +		break;
> +	default:
> +		return -ENXIO;
> +	}
> +
> +	if (state->flags & SS_RESET)
> +		GPSR = reset;
> +	else
> +		GPCR = reset;
> +
> +	return 0;
> +}
> +
> +static void nanoengine_pcmcia_socket_state(
> +	struct soc_pcmcia_socket *skt, struct pcmcia_state *state)
> +{
> +	unsigned long levels = GPLR;
> +	unsigned i = skt->nr;
> +
> +	if (i >= num_nano_pcmcia_sockets)
> +		return;
> +
> +	memset(state, 0, sizeof(struct pcmcia_state));
> +	switch (i) {
> +	case 0:
> +		state->ready	=  (levels & GPIO_PC_READY0)	? 1 : 0;
> +		state->detect	= !(levels & GPIO_PC_CD0)	? 1 : 0;

If lines are added at a later stage, all this indentation might have to be
redone. This breaks 'git blame'. Please just one space around operators as
suggested in CodingStyle, chapter 3.1.

> +		break;
> +	case 1:
> +		state->ready	=  (levels & GPIO_PC_READY1)	? 1 : 0;
> +		state->detect	= !(levels & GPIO_PC_CD1)	? 1 : 0;
> +		break;
> +	default:
> +		return;
> +	}
> +	state->bvd1	= 1;
> +	state->bvd2	= 1;
> +	state->wrprot	= 0; /* Not available */
> +	state->vs_3v	= 1; /* Can only apply 3.3V */
> +	state->vs_Xv	= 0;
> +}
> +
> +/*
> + * Enable card status IRQs on (re-)initialisation.  This can
> + * be called at initialisation, power management event, or
> + * pcmcia event.
> + */
> +static void nanoengine_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
> +{
> +	unsigned i = skt->nr;
> +
> +	if (i >= num_nano_pcmcia_sockets)
> +		return;
> +
> +	soc_pcmcia_enable_irqs(skt,
> +		nano_skts[i].pcmcia_irqs, nano_skts[i].pcmcia_irqs_size);
> +}
> +
> +/*
> + * Disable card status IRQs on suspend.
> + */
> +static void nanoengine_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
> +{
> +	unsigned i = skt->nr;
> +
> +	if (i >= num_nano_pcmcia_sockets)
> +		return;
> +
> +	soc_pcmcia_disable_irqs(skt,
> +		nano_skts[i].pcmcia_irqs, nano_skts[i].pcmcia_irqs_size);
> +}
> +
> +static struct pcmcia_low_level nanoengine_pcmcia_ops = {
> +	.owner			= THIS_MODULE,
> +
> +	.hw_init		= nanoengine_pcmcia_hw_init,
> +	.hw_shutdown		= nanoengine_pcmcia_hw_shutdown,
> +
> +	.configure_socket	= nanoengine_pcmcia_configure_socket,
> +	.socket_state		= nanoengine_pcmcia_socket_state,
> +	.socket_init		= nanoengine_pcmcia_socket_init,
> +	.socket_suspend		= nanoengine_pcmcia_socket_suspend,
> +};
> +
> +int pcmcia_nanoengine_init(struct device *dev)
> +{
> +	int ret = -ENODEV;
> +
> +	printk(KERN_INFO "BSE nanoEngine pcmcia support by "
> +		"Miguel Freitas & Marcelo Jimenez.\n");

Is this really necessary? Log would get quite messy if all drivers do this.
I haven't checked, can't you just use MODULE_AUTHOR here?

> +	if (machine_is_nanoengine())
> +		ret = sa11xx_drv_pcmcia_probe(
> +			dev, &nanoengine_pcmcia_ops, 0, 2);
> +
> +	return ret;
> +}
> +
> -- 
> 1.7.0.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100331/7f3b909b/attachment-0001.sig>
