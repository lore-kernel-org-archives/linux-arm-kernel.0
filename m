From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:23:36 +0000
Subject: [PATCH 19/19] PCMCIA: sa1111: rename sa1111 socket drivers to have
 sa1111_ prefix.
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBdA-0005ig-I0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/Makefile            |    8 +-
 drivers/pcmcia/pxa2xx_lubbock.c    |  236 ------------------------------------
 drivers/pcmcia/sa1100_badge4.c     |  166 -------------------------
 drivers/pcmcia/sa1100_jornada720.c |  114 -----------------
 drivers/pcmcia/sa1100_neponset.c   |  134 --------------------
 drivers/pcmcia/sa1111_badge4.c     |  166 +++++++++++++++++++++++++
 drivers/pcmcia/sa1111_jornada720.c |  114 +++++++++++++++++
 drivers/pcmcia/sa1111_lubbock.c    |  236 ++++++++++++++++++++++++++++++++++++
 drivers/pcmcia/sa1111_neponset.c   |  134 ++++++++++++++++++++
 9 files changed, 654 insertions(+), 654 deletions(-)
 delete mode 100644 drivers/pcmcia/pxa2xx_lubbock.c
 delete mode 100644 drivers/pcmcia/sa1100_badge4.c
 delete mode 100644 drivers/pcmcia/sa1100_jornada720.c
 delete mode 100644 drivers/pcmcia/sa1100_neponset.c
 create mode 100644 drivers/pcmcia/sa1111_badge4.c
 create mode 100644 drivers/pcmcia/sa1111_jornada720.c
 create mode 100644 drivers/pcmcia/sa1111_lubbock.c
 create mode 100644 drivers/pcmcia/sa1111_neponset.c

diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index 49d79f7..47525de 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -40,10 +40,10 @@ obj-$(CONFIG_ELECTRA_CF)			+= electra_cf.o
 obj-$(CONFIG_PCMCIA_ALCHEMY_DEVBOARD)		+= db1xxx_ss.o
 
 sa1111_cs-y					+= sa1111_generic.o
-sa1111_cs-$(CONFIG_ASSABET_NEPONSET)		+= sa1100_neponset.o
-sa1111_cs-$(CONFIG_SA1100_BADGE4)		+= sa1100_badge4.o
-sa1111_cs-$(CONFIG_SA1100_JORNADA720)		+= sa1100_jornada720.o
-sa1111_cs-$(CONFIG_ARCH_LUBBOCK)		+= pxa2xx_lubbock.o
+sa1111_cs-$(CONFIG_ASSABET_NEPONSET)		+= sa1111_neponset.o
+sa1111_cs-$(CONFIG_SA1100_BADGE4)		+= sa1111_badge4.o
+sa1111_cs-$(CONFIG_SA1100_JORNADA720)		+= sa1111_jornada720.o
+sa1111_cs-$(CONFIG_ARCH_LUBBOCK)		+= sa1111_lubbock.o
 
 sa1100_cs-y					+= sa1100_generic.o
 sa1100_cs-$(CONFIG_SA1100_ASSABET)		+= sa1100_assabet.o
diff --git a/drivers/pcmcia/pxa2xx_lubbock.c b/drivers/pcmcia/pxa2xx_lubbock.c
deleted file mode 100644
index c5caf57..0000000
--- a/drivers/pcmcia/pxa2xx_lubbock.c
+++ /dev/null
@@ -1,236 +0,0 @@
-/*
- * linux/drivers/pcmcia/pxa2xx_lubbock.c
- *
- * Author:	George Davis
- * Created:	Jan 10, 2002
- * Copyright:	MontaVista Software Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Originally based upon linux/drivers/pcmcia/sa1100_neponset.c
- *
- * Lubbock PCMCIA specific routines.
- *
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-
-#include <mach/hardware.h>
-#include <asm/hardware/sa1111.h>
-#include <asm/mach-types.h>
-#include <mach/lubbock.h>
-
-#include "sa1111_generic.h"
-
-static int
-lubbock_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
-				const socket_state_t *state)
-{
-	struct sa1111_pcmcia_socket *s = to_skt(skt);
-	unsigned int pa_dwr_mask, pa_dwr_set, misc_mask, misc_set;
-	int ret = 0;
-
-	pa_dwr_mask = pa_dwr_set = misc_mask = misc_set = 0;
-
-	/* Lubbock uses the Maxim MAX1602, with the following connections:
-	 *
-	 * Socket 0 (PCMCIA):
-	 *	MAX1602	Lubbock		Register
-	 *	Pin	Signal
-	 *	-----	-------		----------------------
-	 *	A0VPP	S0_PWR0		SA-1111 GPIO A<0>
-	 *	A1VPP	S0_PWR1		SA-1111 GPIO A<1>
-	 *	A0VCC	S0_PWR2		SA-1111 GPIO A<2>
-	 *	A1VCC	S0_PWR3		SA-1111 GPIO A<3>
-	 *	VX	VCC
-	 *	VY	+3.3V
-	 *	12IN	+12V
-	 *	CODE	+3.3V		Cirrus  Code, CODE = High (VY)
-	 *
-	 * Socket 1 (CF):
-	 *	MAX1602	Lubbock		Register
-	 *	Pin	Signal
-	 *	-----	-------		----------------------
-	 *	A0VPP	GND		VPP is not connected
-	 *	A1VPP	GND		VPP is not connected
-	 *	A0VCC	S1_PWR0		MISC_WR<14>
-	 *	A1VCC	S1_PWR1		MISC_WR<15>
-	 *	VX	VCC
-	 *	VY	+3.3V
-	 *	12IN	GND		VPP is not connected
-	 *	CODE	+3.3V		Cirrus  Code, CODE = High (VY)
-	 *
-	 */
-
- again:
-	switch (skt->nr) {
-	case 0:
-		pa_dwr_mask = GPIO_A0 | GPIO_A1 | GPIO_A2 | GPIO_A3;
-
-		switch (state->Vcc) {
-		case 0: /* Hi-Z */
-			break;
-
-		case 33: /* VY */
-			pa_dwr_set |= GPIO_A3;
-			break;
-
-		case 50: /* VX */
-			pa_dwr_set |= GPIO_A2;
-			break;
-
-		default:
-			printk(KERN_ERR "%s(): unrecognized Vcc %u\n",
-			       __func__, state->Vcc);
-			ret = -1;
-		}
-
-		switch (state->Vpp) {
-		case 0: /* Hi-Z */
-			break;
-
-		case 120: /* 12IN */
-			pa_dwr_set |= GPIO_A1;
-			break;
-
-		default: /* VCC */
-			if (state->Vpp == state->Vcc)
-				pa_dwr_set |= GPIO_A0;
-			else {
-				printk(KERN_ERR "%s(): unrecognized Vpp %u\n",
-				       __func__, state->Vpp);
-				ret = -1;
-				break;
-			}
-		}
-		break;
-
-	case 1:
-		misc_mask = (1 << 15) | (1 << 14);
-
-		switch (state->Vcc) {
-		case 0: /* Hi-Z */
-			break;
-
-		case 33: /* VY */
-			misc_set |= 1 << 15;
-			break;
-
-		case 50: /* VX */
-			misc_set |= 1 << 14;
-			break;
-
-		default:
-			printk(KERN_ERR "%s(): unrecognized Vcc %u\n",
-			       __func__, state->Vcc);
-			ret = -1;
-			break;
-		}
-
-		if (state->Vpp != state->Vcc && state->Vpp != 0) {
-			printk(KERN_ERR "%s(): CF slot cannot support Vpp %u\n",
-			       __func__, state->Vpp);
-			ret = -1;
-			break;
-		}
-		break;
-
-	default:
-		ret = -1;
-	}
-
-	if (ret == 0)
-		ret = sa1111_pcmcia_configure_socket(skt, state);
-
-	if (ret == 0) {
-		lubbock_set_misc_wr(misc_mask, misc_set);
-		sa1111_set_io(s->dev, pa_dwr_mask, pa_dwr_set);
-	}
-
-#if 1
-	if (ret == 0 && state->Vcc == 33) {
-		struct pcmcia_state new_state;
-
-		/*
-		 * HACK ALERT:
-		 * We can't sense the voltage properly on Lubbock before
-		 * actually applying some power to the socket (catch 22).
-		 * Resense the socket Voltage Sense pins after applying
-		 * socket power.
-		 *
-		 * Note: It takes about 2.5ms for the MAX1602 VCC output
-		 * to rise.
-		 */
-		mdelay(3);
-
-		sa1111_pcmcia_socket_state(skt, &new_state);
-
-		if (!new_state.vs_3v && !new_state.vs_Xv) {
-			/*
-			 * Switch to 5V,  Configure socket with 5V voltage
-			 */
-			lubbock_set_misc_wr(misc_mask, 0);
-			sa1111_set_io(s->dev, pa_dwr_mask, 0);
-
-			/*
-			 * It takes about 100ms to turn off Vcc.
-			 */
-			mdelay(100);
-
-			/*
-			 * We need to hack around the const qualifier as
-			 * well to keep this ugly workaround localized and
-			 * not force it to the rest of the code. Barf bags
-			 * available in the seat pocket in front of you!
-			 */
-			((socket_state_t *)state)->Vcc = 50;
-			((socket_state_t *)state)->Vpp = 50;
-			goto again;
-		}
-	}
-#endif
-
-	return ret;
-}
-
-static struct pcmcia_low_level lubbock_pcmcia_ops = {
-	.owner			= THIS_MODULE,
-	.configure_socket	= lubbock_pcmcia_configure_socket,
-	.first			= 0,
-	.nr			= 2,
-};
-
-#include "pxa2xx_base.h"
-
-int pcmcia_lubbock_init(struct sa1111_dev *sadev)
-{
-	int ret = -ENODEV;
-
-	if (machine_is_lubbock()) {
-		/*
-		 * Set GPIO_A<3:0> to be outputs for the MAX1600,
-		 * and switch to standby mode.
-		 */
-		sa1111_set_io_dir(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0, 0);
-		sa1111_set_io(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
-		sa1111_set_sleep_io(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
-
-		/* Set CF Socket 1 power to standby mode. */
-		lubbock_set_misc_wr((1 << 15) | (1 << 14), 0);
-
-		pxa2xx_drv_pcmcia_ops(&lubbock_pcmcia_ops);
-		pxa2xx_configure_sockets(&sadev->dev);
-		ret = sa1111_pcmcia_add(sadev, &lubbock_pcmcia_ops,
-				pxa2xx_drv_pcmcia_add_one);
-	}
-
-	return ret;
-}
-
-MODULE_LICENSE("GPL");
diff --git a/drivers/pcmcia/sa1100_badge4.c b/drivers/pcmcia/sa1100_badge4.c
deleted file mode 100644
index 4d206f4..0000000
--- a/drivers/pcmcia/sa1100_badge4.c
+++ /dev/null
@@ -1,166 +0,0 @@
-/*
- * linux/drivers/pcmcia/sa1100_badge4.c
- *
- * BadgePAD 4 PCMCIA specific routines
- *
- *   Christopher Hoover <ch@hpl.hp.com>
- *
- * Copyright (C) 2002 Hewlett-Packard Company
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-
-#include <mach/hardware.h>
-#include <asm/mach-types.h>
-#include <mach/badge4.h>
-#include <asm/hardware/sa1111.h>
-
-#include "sa1111_generic.h"
-
-/*
- * BadgePAD 4 Details
- *
- * PCM Vcc:
- *
- *  PCM Vcc on BadgePAD 4 can be jumpered for 3v3 (short pins 1 and 3
- *  on JP6) or 5v0 (short pins 3 and 5 on JP6).
- *
- * PCM Vpp:
- *
- *  PCM Vpp on BadgePAD 4 can be jumpered for 12v0 (short pins 4 and 6
- *  on JP6) or tied to PCM Vcc (short pins 2 and 4 on JP6).  N.B.,
- *  12v0 operation requires that the power supply actually supply 12v0
- *  via pin 7 of JP7.
- *
- * CF Vcc:
- *
- *  CF Vcc on BadgePAD 4 can be jumpered either for 3v3 (short pins 1
- *  and 2 on JP10) or 5v0 (short pins 2 and 3 on JP10).
- *
- * Unfortunately there's no way programmatically to determine how a
- * given board is jumpered.  This code assumes a default jumpering
- * as described below.
- *
- * If the defaults aren't correct, you may override them with a pcmv
- * setup argument: pcmv=<pcm vcc>,<pcm vpp>,<cf vcc>.  The units are
- * tenths of volts; e.g. pcmv=33,120,50 indicates 3v3 PCM Vcc, 12v0
- * PCM Vpp, and 5v0 CF Vcc.
- *
- */
-
-static int badge4_pcmvcc = 50;  /* pins 3 and 5 jumpered on JP6 */
-static int badge4_pcmvpp = 50;  /* pins 2 and 4 jumpered on JP6 */
-static int badge4_cfvcc = 33;   /* pins 1 and 2 jumpered on JP10 */
-
-static void complain_about_jumpering(const char *whom,
-				     const char *supply,
-				     int given, int wanted)
-{
-	printk(KERN_ERR
-	 "%s: %s %d.%dV wanted but board is jumpered for %s %d.%dV operation"
-	 "; re-jumper the board and/or use pcmv=xx,xx,xx\n",
-	       whom, supply,
-	       wanted / 10, wanted % 10,
-	       supply,
-	       given / 10, given % 10);
-}
-
-static int
-badge4_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state_t *state)
-{
-	int ret;
-
-	switch (skt->nr) {
-	case 0:
-		if ((state->Vcc != 0) &&
-		    (state->Vcc != badge4_pcmvcc)) {
-			complain_about_jumpering(__func__, "pcmvcc",
-						 badge4_pcmvcc, state->Vcc);
-			// Apply power regardless of the jumpering.
-			// return -1;
-		}
-		if ((state->Vpp != 0) &&
-		    (state->Vpp != badge4_pcmvpp)) {
-			complain_about_jumpering(__func__, "pcmvpp",
-						 badge4_pcmvpp, state->Vpp);
-			return -1;
-		}
-		break;
-
-	case 1:
-		if ((state->Vcc != 0) &&
-		    (state->Vcc != badge4_cfvcc)) {
-			complain_about_jumpering(__func__, "cfvcc",
-						 badge4_cfvcc, state->Vcc);
-			return -1;
-		}
-		break;
-
-	default:
-		return -1;
-	}
-
-	ret = sa1111_pcmcia_configure_socket(skt, state);
-	if (ret == 0) {
-		unsigned long flags;
-		int need5V;
-
-		local_irq_save(flags);
-
-		need5V = ((state->Vcc == 50) || (state->Vpp == 50));
-
-		badge4_set_5V(BADGE4_5V_PCMCIA_SOCK(skt->nr), need5V);
-
-		local_irq_restore(flags);
-	}
-
-	return ret;
-}
-
-static struct pcmcia_low_level badge4_pcmcia_ops = {
-	.owner			= THIS_MODULE,
-	.configure_socket	= badge4_pcmcia_configure_socket,
-	.first			= 0,
-	.nr			= 2,
-};
-
-int pcmcia_badge4_init(struct device *dev)
-{
-	int ret = -ENODEV;
-
-	if (machine_is_badge4()) {
-		printk(KERN_INFO
-		       "%s: badge4_pcmvcc=%d, badge4_pcmvpp=%d, badge4_cfvcc=%d\n",
-		       __func__,
-		       badge4_pcmvcc, badge4_pcmvpp, badge4_cfvcc);
-
-		sa11xx_drv_pcmcia_ops(&badge4_pcmcia_ops);
-		ret = sa1111_pcmcia_add(dev, &badge4_pcmcia_ops,
-				sa11xx_drv_pcmcia_add_one);
-	}
-
-	return ret;
-}
-
-static int __init pcmv_setup(char *s)
-{
-	int v[4];
-
-	s = get_options(s, ARRAY_SIZE(v), v);
-
-	if (v[0] >= 1) badge4_pcmvcc = v[1];
-	if (v[0] >= 2) badge4_pcmvpp = v[2];
-	if (v[0] >= 3) badge4_cfvcc = v[3];
-
-	return 1;
-}
-
-__setup("pcmv=", pcmv_setup);
diff --git a/drivers/pcmcia/sa1100_jornada720.c b/drivers/pcmcia/sa1100_jornada720.c
deleted file mode 100644
index 69428d1..0000000
--- a/drivers/pcmcia/sa1100_jornada720.c
+++ /dev/null
@@ -1,114 +0,0 @@
-/*
- * drivers/pcmcia/sa1100_jornada720.c
- *
- * Jornada720 PCMCIA specific routines
- *
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-
-#include <mach/hardware.h>
-#include <asm/hardware/sa1111.h>
-#include <asm/mach-types.h>
-
-#include "sa1111_generic.h"
-
-/* Does SOCKET1_3V actually do anything? */
-#define SOCKET0_POWER	GPIO_GPIO0
-#define SOCKET0_3V	GPIO_GPIO2
-#define SOCKET1_POWER	(GPIO_GPIO1 | GPIO_GPIO3)
-#define SOCKET1_3V	GPIO_GPIO3
-
-static int
-jornada720_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state_t *state)
-{
-	struct sa1111_pcmcia_socket *s = to_skt(skt);
-	unsigned int pa_dwr_mask, pa_dwr_set;
-	int ret;
-
-	printk(KERN_INFO "%s(): config socket %d vcc %d vpp %d\n", __func__,
-		skt->nr, state->Vcc, state->Vpp);
-
-	switch (skt->nr) {
-	case 0:
-		pa_dwr_mask = SOCKET0_POWER | SOCKET0_3V;
-
-		switch (state->Vcc) {
-		default:
-		case  0:
-			pa_dwr_set = 0;
-			break;
-		case 33:
-			pa_dwr_set = SOCKET0_POWER | SOCKET0_3V;
-			break;
-		case 50:
-			pa_dwr_set = SOCKET0_POWER;
-			break;
-		}
-		break;
-
-	case 1:
-		pa_dwr_mask = SOCKET1_POWER;
-
-		switch (state->Vcc) {
-		default:
-		case 0:
-			pa_dwr_set = 0;
-			break;
-		case 33:
-			pa_dwr_set = SOCKET1_POWER;
-			break;
-		case 50:
-			pa_dwr_set = SOCKET1_POWER;
-			break;
-		}
-		break;
-
-	default:
-		return -1;
-	}
-
-	if (state->Vpp != state->Vcc && state->Vpp != 0) {
-		printk(KERN_ERR "%s(): slot cannot support VPP %u\n",
-			__func__, state->Vpp);
-		return -EPERM;
-	}
-
-	ret = sa1111_pcmcia_configure_socket(skt, state);
-	if (ret == 0)
-		sa1111_set_io(s->dev, pa_dwr_mask, pa_dwr_set);
-
-	return ret;
-}
-
-static struct pcmcia_low_level jornada720_pcmcia_ops = {
-	.owner			= THIS_MODULE,
-	.configure_socket	= jornada720_pcmcia_configure_socket,
-	.first			= 0,
-	.nr			= 2,
-};
-
-int __devinit pcmcia_jornada720_init(struct device *dev)
-{
-	int ret = -ENODEV;
-
-	if (machine_is_jornada720()) {
-		unsigned int pin = GPIO_A0 | GPIO_A1 | GPIO_A2 | GPIO_A3;
-
-		GRER |= 0x00000002;
-
-		/* Set GPIO_A<3:1> to be outputs for PCMCIA/CF power controller: */
-		sa1111_set_io_dir(dev, pin, 0, 0);
-		sa1111_set_io(dev, pin, 0);
-		sa1111_set_sleep_io(dev, pin, 0);
-
-		sa11xx_drv_pcmcia_ops(&jornada720_pcmcia_ops);
-		ret = sa1111_pcmcia_add(dev, &jornada720_pcmcia_ops,
-				sa11xx_drv_pcmcia_add_one);
-	}
-
-	return ret;
-}
diff --git a/drivers/pcmcia/sa1100_neponset.c b/drivers/pcmcia/sa1100_neponset.c
deleted file mode 100644
index 50f297d..0000000
--- a/drivers/pcmcia/sa1100_neponset.c
+++ /dev/null
@@ -1,134 +0,0 @@
-/*
- * linux/drivers/pcmcia/sa1100_neponset.c
- *
- * Neponset PCMCIA specific routines
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-
-#include <mach/hardware.h>
-#include <asm/mach-types.h>
-#include <mach/neponset.h>
-#include <asm/hardware/sa1111.h>
-
-#include "sa1111_generic.h"
-
-/*
- * Neponset uses the Maxim MAX1600, with the following connections:
- *
- *   MAX1600      Neponset
- *
- *    A0VCC        SA-1111 GPIO A<1>
- *    A1VCC        SA-1111 GPIO A<0>
- *    A0VPP        CPLD NCR A0VPP
- *    A1VPP        CPLD NCR A1VPP
- *    B0VCC        SA-1111 GPIO A<2>
- *    B1VCC        SA-1111 GPIO A<3>
- *    B0VPP        ground (slot B is CF)
- *    B1VPP        ground (slot B is CF)
- *
- *     VX          VCC (5V)
- *     VY          VCC3_3 (3.3V)
- *     12INA       12V
- *     12INB       ground (slot B is CF)
- *
- * The MAX1600 CODE pin is tied to ground, placing the device in 
- * "Standard Intel code" mode. Refer to the Maxim data sheet for
- * the corresponding truth table.
- */
-
-static int
-neponset_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state_t *state)
-{
-	struct sa1111_pcmcia_socket *s = to_skt(skt);
-	unsigned int ncr_mask, ncr_set, pa_dwr_mask, pa_dwr_set;
-	int ret;
-
-	switch (skt->nr) {
-	case 0:
-		pa_dwr_mask = GPIO_A0 | GPIO_A1;
-		ncr_mask = NCR_A0VPP | NCR_A1VPP;
-
-		if (state->Vpp == 0)
-			ncr_set = 0;
-		else if (state->Vpp == 120)
-			ncr_set = NCR_A1VPP;
-		else if (state->Vpp == state->Vcc)
-			ncr_set = NCR_A0VPP;
-		else {
-			printk(KERN_ERR "%s(): unrecognized VPP %u\n",
-			       __func__, state->Vpp);
-			return -1;
-		}
-		break;
-
-	case 1:
-		pa_dwr_mask = GPIO_A2 | GPIO_A3;
-		ncr_mask = 0;
-		ncr_set = 0;
-
-		if (state->Vpp != state->Vcc && state->Vpp != 0) {
-			printk(KERN_ERR "%s(): CF slot cannot support VPP %u\n",
-			       __func__, state->Vpp);
-			return -1;
-		}
-		break;
-
-	default:
-		return -1;
-	}
-
-	/*
-	 * pa_dwr_set is the mask for selecting Vcc on both sockets.
-	 * pa_dwr_mask selects which bits (and therefore socket) we change.
-	 */
-	switch (state->Vcc) {
-	default:
-	case 0:  pa_dwr_set = 0;		break;
-	case 33: pa_dwr_set = GPIO_A1|GPIO_A2;	break;
-	case 50: pa_dwr_set = GPIO_A0|GPIO_A3;	break;
-	}
-
-	ret = sa1111_pcmcia_configure_socket(skt, state);
-	if (ret == 0) {
-		unsigned long flags;
-
-		local_irq_save(flags);
-		NCR_0 = (NCR_0 & ~ncr_mask) | ncr_set;
-
-		local_irq_restore(flags);
-		sa1111_set_io(s->dev, pa_dwr_mask, pa_dwr_set);
-	}
-
-	return ret;
-}
-
-static struct pcmcia_low_level neponset_pcmcia_ops = {
-	.owner			= THIS_MODULE,
-	.configure_socket	= neponset_pcmcia_configure_socket,
-	.first			= 0,
-	.nr			= 2,
-};
-
-int pcmcia_neponset_init(struct sa1111_dev *sadev)
-{
-	int ret = -ENODEV;
-
-	if (machine_is_assabet()) {
-		/*
-		 * Set GPIO_A<3:0> to be outputs for the MAX1600,
-		 * and switch to standby mode.
-		 */
-		sa1111_set_io_dir(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0, 0);
-		sa1111_set_io(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
-		sa1111_set_sleep_io(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
-		sa11xx_drv_pcmcia_ops(&neponset_pcmcia_ops);
-		ret = sa1111_pcmcia_add(sadev, &neponset_pcmcia_ops,
-				sa11xx_drv_pcmcia_add_one);
-	}
-
-	return ret;
-}
diff --git a/drivers/pcmcia/sa1111_badge4.c b/drivers/pcmcia/sa1111_badge4.c
new file mode 100644
index 0000000..4d206f4
--- /dev/null
+++ b/drivers/pcmcia/sa1111_badge4.c
@@ -0,0 +1,166 @@
+/*
+ * linux/drivers/pcmcia/sa1100_badge4.c
+ *
+ * BadgePAD 4 PCMCIA specific routines
+ *
+ *   Christopher Hoover <ch@hpl.hp.com>
+ *
+ * Copyright (C) 2002 Hewlett-Packard Company
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <mach/badge4.h>
+#include <asm/hardware/sa1111.h>
+
+#include "sa1111_generic.h"
+
+/*
+ * BadgePAD 4 Details
+ *
+ * PCM Vcc:
+ *
+ *  PCM Vcc on BadgePAD 4 can be jumpered for 3v3 (short pins 1 and 3
+ *  on JP6) or 5v0 (short pins 3 and 5 on JP6).
+ *
+ * PCM Vpp:
+ *
+ *  PCM Vpp on BadgePAD 4 can be jumpered for 12v0 (short pins 4 and 6
+ *  on JP6) or tied to PCM Vcc (short pins 2 and 4 on JP6).  N.B.,
+ *  12v0 operation requires that the power supply actually supply 12v0
+ *  via pin 7 of JP7.
+ *
+ * CF Vcc:
+ *
+ *  CF Vcc on BadgePAD 4 can be jumpered either for 3v3 (short pins 1
+ *  and 2 on JP10) or 5v0 (short pins 2 and 3 on JP10).
+ *
+ * Unfortunately there's no way programmatically to determine how a
+ * given board is jumpered.  This code assumes a default jumpering
+ * as described below.
+ *
+ * If the defaults aren't correct, you may override them with a pcmv
+ * setup argument: pcmv=<pcm vcc>,<pcm vpp>,<cf vcc>.  The units are
+ * tenths of volts; e.g. pcmv=33,120,50 indicates 3v3 PCM Vcc, 12v0
+ * PCM Vpp, and 5v0 CF Vcc.
+ *
+ */
+
+static int badge4_pcmvcc = 50;  /* pins 3 and 5 jumpered on JP6 */
+static int badge4_pcmvpp = 50;  /* pins 2 and 4 jumpered on JP6 */
+static int badge4_cfvcc = 33;   /* pins 1 and 2 jumpered on JP10 */
+
+static void complain_about_jumpering(const char *whom,
+				     const char *supply,
+				     int given, int wanted)
+{
+	printk(KERN_ERR
+	 "%s: %s %d.%dV wanted but board is jumpered for %s %d.%dV operation"
+	 "; re-jumper the board and/or use pcmv=xx,xx,xx\n",
+	       whom, supply,
+	       wanted / 10, wanted % 10,
+	       supply,
+	       given / 10, given % 10);
+}
+
+static int
+badge4_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state_t *state)
+{
+	int ret;
+
+	switch (skt->nr) {
+	case 0:
+		if ((state->Vcc != 0) &&
+		    (state->Vcc != badge4_pcmvcc)) {
+			complain_about_jumpering(__func__, "pcmvcc",
+						 badge4_pcmvcc, state->Vcc);
+			// Apply power regardless of the jumpering.
+			// return -1;
+		}
+		if ((state->Vpp != 0) &&
+		    (state->Vpp != badge4_pcmvpp)) {
+			complain_about_jumpering(__func__, "pcmvpp",
+						 badge4_pcmvpp, state->Vpp);
+			return -1;
+		}
+		break;
+
+	case 1:
+		if ((state->Vcc != 0) &&
+		    (state->Vcc != badge4_cfvcc)) {
+			complain_about_jumpering(__func__, "cfvcc",
+						 badge4_cfvcc, state->Vcc);
+			return -1;
+		}
+		break;
+
+	default:
+		return -1;
+	}
+
+	ret = sa1111_pcmcia_configure_socket(skt, state);
+	if (ret == 0) {
+		unsigned long flags;
+		int need5V;
+
+		local_irq_save(flags);
+
+		need5V = ((state->Vcc == 50) || (state->Vpp == 50));
+
+		badge4_set_5V(BADGE4_5V_PCMCIA_SOCK(skt->nr), need5V);
+
+		local_irq_restore(flags);
+	}
+
+	return ret;
+}
+
+static struct pcmcia_low_level badge4_pcmcia_ops = {
+	.owner			= THIS_MODULE,
+	.configure_socket	= badge4_pcmcia_configure_socket,
+	.first			= 0,
+	.nr			= 2,
+};
+
+int pcmcia_badge4_init(struct device *dev)
+{
+	int ret = -ENODEV;
+
+	if (machine_is_badge4()) {
+		printk(KERN_INFO
+		       "%s: badge4_pcmvcc=%d, badge4_pcmvpp=%d, badge4_cfvcc=%d\n",
+		       __func__,
+		       badge4_pcmvcc, badge4_pcmvpp, badge4_cfvcc);
+
+		sa11xx_drv_pcmcia_ops(&badge4_pcmcia_ops);
+		ret = sa1111_pcmcia_add(dev, &badge4_pcmcia_ops,
+				sa11xx_drv_pcmcia_add_one);
+	}
+
+	return ret;
+}
+
+static int __init pcmv_setup(char *s)
+{
+	int v[4];
+
+	s = get_options(s, ARRAY_SIZE(v), v);
+
+	if (v[0] >= 1) badge4_pcmvcc = v[1];
+	if (v[0] >= 2) badge4_pcmvpp = v[2];
+	if (v[0] >= 3) badge4_cfvcc = v[3];
+
+	return 1;
+}
+
+__setup("pcmv=", pcmv_setup);
diff --git a/drivers/pcmcia/sa1111_jornada720.c b/drivers/pcmcia/sa1111_jornada720.c
new file mode 100644
index 0000000..69428d1
--- /dev/null
+++ b/drivers/pcmcia/sa1111_jornada720.c
@@ -0,0 +1,114 @@
+/*
+ * drivers/pcmcia/sa1100_jornada720.c
+ *
+ * Jornada720 PCMCIA specific routines
+ *
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+
+#include <mach/hardware.h>
+#include <asm/hardware/sa1111.h>
+#include <asm/mach-types.h>
+
+#include "sa1111_generic.h"
+
+/* Does SOCKET1_3V actually do anything? */
+#define SOCKET0_POWER	GPIO_GPIO0
+#define SOCKET0_3V	GPIO_GPIO2
+#define SOCKET1_POWER	(GPIO_GPIO1 | GPIO_GPIO3)
+#define SOCKET1_3V	GPIO_GPIO3
+
+static int
+jornada720_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state_t *state)
+{
+	struct sa1111_pcmcia_socket *s = to_skt(skt);
+	unsigned int pa_dwr_mask, pa_dwr_set;
+	int ret;
+
+	printk(KERN_INFO "%s(): config socket %d vcc %d vpp %d\n", __func__,
+		skt->nr, state->Vcc, state->Vpp);
+
+	switch (skt->nr) {
+	case 0:
+		pa_dwr_mask = SOCKET0_POWER | SOCKET0_3V;
+
+		switch (state->Vcc) {
+		default:
+		case  0:
+			pa_dwr_set = 0;
+			break;
+		case 33:
+			pa_dwr_set = SOCKET0_POWER | SOCKET0_3V;
+			break;
+		case 50:
+			pa_dwr_set = SOCKET0_POWER;
+			break;
+		}
+		break;
+
+	case 1:
+		pa_dwr_mask = SOCKET1_POWER;
+
+		switch (state->Vcc) {
+		default:
+		case 0:
+			pa_dwr_set = 0;
+			break;
+		case 33:
+			pa_dwr_set = SOCKET1_POWER;
+			break;
+		case 50:
+			pa_dwr_set = SOCKET1_POWER;
+			break;
+		}
+		break;
+
+	default:
+		return -1;
+	}
+
+	if (state->Vpp != state->Vcc && state->Vpp != 0) {
+		printk(KERN_ERR "%s(): slot cannot support VPP %u\n",
+			__func__, state->Vpp);
+		return -EPERM;
+	}
+
+	ret = sa1111_pcmcia_configure_socket(skt, state);
+	if (ret == 0)
+		sa1111_set_io(s->dev, pa_dwr_mask, pa_dwr_set);
+
+	return ret;
+}
+
+static struct pcmcia_low_level jornada720_pcmcia_ops = {
+	.owner			= THIS_MODULE,
+	.configure_socket	= jornada720_pcmcia_configure_socket,
+	.first			= 0,
+	.nr			= 2,
+};
+
+int __devinit pcmcia_jornada720_init(struct device *dev)
+{
+	int ret = -ENODEV;
+
+	if (machine_is_jornada720()) {
+		unsigned int pin = GPIO_A0 | GPIO_A1 | GPIO_A2 | GPIO_A3;
+
+		GRER |= 0x00000002;
+
+		/* Set GPIO_A<3:1> to be outputs for PCMCIA/CF power controller: */
+		sa1111_set_io_dir(dev, pin, 0, 0);
+		sa1111_set_io(dev, pin, 0);
+		sa1111_set_sleep_io(dev, pin, 0);
+
+		sa11xx_drv_pcmcia_ops(&jornada720_pcmcia_ops);
+		ret = sa1111_pcmcia_add(dev, &jornada720_pcmcia_ops,
+				sa11xx_drv_pcmcia_add_one);
+	}
+
+	return ret;
+}
diff --git a/drivers/pcmcia/sa1111_lubbock.c b/drivers/pcmcia/sa1111_lubbock.c
new file mode 100644
index 0000000..c5caf57
--- /dev/null
+++ b/drivers/pcmcia/sa1111_lubbock.c
@@ -0,0 +1,236 @@
+/*
+ * linux/drivers/pcmcia/pxa2xx_lubbock.c
+ *
+ * Author:	George Davis
+ * Created:	Jan 10, 2002
+ * Copyright:	MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Originally based upon linux/drivers/pcmcia/sa1100_neponset.c
+ *
+ * Lubbock PCMCIA specific routines.
+ *
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+
+#include <mach/hardware.h>
+#include <asm/hardware/sa1111.h>
+#include <asm/mach-types.h>
+#include <mach/lubbock.h>
+
+#include "sa1111_generic.h"
+
+static int
+lubbock_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
+				const socket_state_t *state)
+{
+	struct sa1111_pcmcia_socket *s = to_skt(skt);
+	unsigned int pa_dwr_mask, pa_dwr_set, misc_mask, misc_set;
+	int ret = 0;
+
+	pa_dwr_mask = pa_dwr_set = misc_mask = misc_set = 0;
+
+	/* Lubbock uses the Maxim MAX1602, with the following connections:
+	 *
+	 * Socket 0 (PCMCIA):
+	 *	MAX1602	Lubbock		Register
+	 *	Pin	Signal
+	 *	-----	-------		----------------------
+	 *	A0VPP	S0_PWR0		SA-1111 GPIO A<0>
+	 *	A1VPP	S0_PWR1		SA-1111 GPIO A<1>
+	 *	A0VCC	S0_PWR2		SA-1111 GPIO A<2>
+	 *	A1VCC	S0_PWR3		SA-1111 GPIO A<3>
+	 *	VX	VCC
+	 *	VY	+3.3V
+	 *	12IN	+12V
+	 *	CODE	+3.3V		Cirrus  Code, CODE = High (VY)
+	 *
+	 * Socket 1 (CF):
+	 *	MAX1602	Lubbock		Register
+	 *	Pin	Signal
+	 *	-----	-------		----------------------
+	 *	A0VPP	GND		VPP is not connected
+	 *	A1VPP	GND		VPP is not connected
+	 *	A0VCC	S1_PWR0		MISC_WR<14>
+	 *	A1VCC	S1_PWR1		MISC_WR<15>
+	 *	VX	VCC
+	 *	VY	+3.3V
+	 *	12IN	GND		VPP is not connected
+	 *	CODE	+3.3V		Cirrus  Code, CODE = High (VY)
+	 *
+	 */
+
+ again:
+	switch (skt->nr) {
+	case 0:
+		pa_dwr_mask = GPIO_A0 | GPIO_A1 | GPIO_A2 | GPIO_A3;
+
+		switch (state->Vcc) {
+		case 0: /* Hi-Z */
+			break;
+
+		case 33: /* VY */
+			pa_dwr_set |= GPIO_A3;
+			break;
+
+		case 50: /* VX */
+			pa_dwr_set |= GPIO_A2;
+			break;
+
+		default:
+			printk(KERN_ERR "%s(): unrecognized Vcc %u\n",
+			       __func__, state->Vcc);
+			ret = -1;
+		}
+
+		switch (state->Vpp) {
+		case 0: /* Hi-Z */
+			break;
+
+		case 120: /* 12IN */
+			pa_dwr_set |= GPIO_A1;
+			break;
+
+		default: /* VCC */
+			if (state->Vpp == state->Vcc)
+				pa_dwr_set |= GPIO_A0;
+			else {
+				printk(KERN_ERR "%s(): unrecognized Vpp %u\n",
+				       __func__, state->Vpp);
+				ret = -1;
+				break;
+			}
+		}
+		break;
+
+	case 1:
+		misc_mask = (1 << 15) | (1 << 14);
+
+		switch (state->Vcc) {
+		case 0: /* Hi-Z */
+			break;
+
+		case 33: /* VY */
+			misc_set |= 1 << 15;
+			break;
+
+		case 50: /* VX */
+			misc_set |= 1 << 14;
+			break;
+
+		default:
+			printk(KERN_ERR "%s(): unrecognized Vcc %u\n",
+			       __func__, state->Vcc);
+			ret = -1;
+			break;
+		}
+
+		if (state->Vpp != state->Vcc && state->Vpp != 0) {
+			printk(KERN_ERR "%s(): CF slot cannot support Vpp %u\n",
+			       __func__, state->Vpp);
+			ret = -1;
+			break;
+		}
+		break;
+
+	default:
+		ret = -1;
+	}
+
+	if (ret == 0)
+		ret = sa1111_pcmcia_configure_socket(skt, state);
+
+	if (ret == 0) {
+		lubbock_set_misc_wr(misc_mask, misc_set);
+		sa1111_set_io(s->dev, pa_dwr_mask, pa_dwr_set);
+	}
+
+#if 1
+	if (ret == 0 && state->Vcc == 33) {
+		struct pcmcia_state new_state;
+
+		/*
+		 * HACK ALERT:
+		 * We can't sense the voltage properly on Lubbock before
+		 * actually applying some power to the socket (catch 22).
+		 * Resense the socket Voltage Sense pins after applying
+		 * socket power.
+		 *
+		 * Note: It takes about 2.5ms for the MAX1602 VCC output
+		 * to rise.
+		 */
+		mdelay(3);
+
+		sa1111_pcmcia_socket_state(skt, &new_state);
+
+		if (!new_state.vs_3v && !new_state.vs_Xv) {
+			/*
+			 * Switch to 5V,  Configure socket with 5V voltage
+			 */
+			lubbock_set_misc_wr(misc_mask, 0);
+			sa1111_set_io(s->dev, pa_dwr_mask, 0);
+
+			/*
+			 * It takes about 100ms to turn off Vcc.
+			 */
+			mdelay(100);
+
+			/*
+			 * We need to hack around the const qualifier as
+			 * well to keep this ugly workaround localized and
+			 * not force it to the rest of the code. Barf bags
+			 * available in the seat pocket in front of you!
+			 */
+			((socket_state_t *)state)->Vcc = 50;
+			((socket_state_t *)state)->Vpp = 50;
+			goto again;
+		}
+	}
+#endif
+
+	return ret;
+}
+
+static struct pcmcia_low_level lubbock_pcmcia_ops = {
+	.owner			= THIS_MODULE,
+	.configure_socket	= lubbock_pcmcia_configure_socket,
+	.first			= 0,
+	.nr			= 2,
+};
+
+#include "pxa2xx_base.h"
+
+int pcmcia_lubbock_init(struct sa1111_dev *sadev)
+{
+	int ret = -ENODEV;
+
+	if (machine_is_lubbock()) {
+		/*
+		 * Set GPIO_A<3:0> to be outputs for the MAX1600,
+		 * and switch to standby mode.
+		 */
+		sa1111_set_io_dir(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0, 0);
+		sa1111_set_io(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
+		sa1111_set_sleep_io(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
+
+		/* Set CF Socket 1 power to standby mode. */
+		lubbock_set_misc_wr((1 << 15) | (1 << 14), 0);
+
+		pxa2xx_drv_pcmcia_ops(&lubbock_pcmcia_ops);
+		pxa2xx_configure_sockets(&sadev->dev);
+		ret = sa1111_pcmcia_add(sadev, &lubbock_pcmcia_ops,
+				pxa2xx_drv_pcmcia_add_one);
+	}
+
+	return ret;
+}
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/pcmcia/sa1111_neponset.c b/drivers/pcmcia/sa1111_neponset.c
new file mode 100644
index 0000000..50f297d
--- /dev/null
+++ b/drivers/pcmcia/sa1111_neponset.c
@@ -0,0 +1,134 @@
+/*
+ * linux/drivers/pcmcia/sa1100_neponset.c
+ *
+ * Neponset PCMCIA specific routines
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <mach/neponset.h>
+#include <asm/hardware/sa1111.h>
+
+#include "sa1111_generic.h"
+
+/*
+ * Neponset uses the Maxim MAX1600, with the following connections:
+ *
+ *   MAX1600      Neponset
+ *
+ *    A0VCC        SA-1111 GPIO A<1>
+ *    A1VCC        SA-1111 GPIO A<0>
+ *    A0VPP        CPLD NCR A0VPP
+ *    A1VPP        CPLD NCR A1VPP
+ *    B0VCC        SA-1111 GPIO A<2>
+ *    B1VCC        SA-1111 GPIO A<3>
+ *    B0VPP        ground (slot B is CF)
+ *    B1VPP        ground (slot B is CF)
+ *
+ *     VX          VCC (5V)
+ *     VY          VCC3_3 (3.3V)
+ *     12INA       12V
+ *     12INB       ground (slot B is CF)
+ *
+ * The MAX1600 CODE pin is tied to ground, placing the device in 
+ * "Standard Intel code" mode. Refer to the Maxim data sheet for
+ * the corresponding truth table.
+ */
+
+static int
+neponset_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state_t *state)
+{
+	struct sa1111_pcmcia_socket *s = to_skt(skt);
+	unsigned int ncr_mask, ncr_set, pa_dwr_mask, pa_dwr_set;
+	int ret;
+
+	switch (skt->nr) {
+	case 0:
+		pa_dwr_mask = GPIO_A0 | GPIO_A1;
+		ncr_mask = NCR_A0VPP | NCR_A1VPP;
+
+		if (state->Vpp == 0)
+			ncr_set = 0;
+		else if (state->Vpp == 120)
+			ncr_set = NCR_A1VPP;
+		else if (state->Vpp == state->Vcc)
+			ncr_set = NCR_A0VPP;
+		else {
+			printk(KERN_ERR "%s(): unrecognized VPP %u\n",
+			       __func__, state->Vpp);
+			return -1;
+		}
+		break;
+
+	case 1:
+		pa_dwr_mask = GPIO_A2 | GPIO_A3;
+		ncr_mask = 0;
+		ncr_set = 0;
+
+		if (state->Vpp != state->Vcc && state->Vpp != 0) {
+			printk(KERN_ERR "%s(): CF slot cannot support VPP %u\n",
+			       __func__, state->Vpp);
+			return -1;
+		}
+		break;
+
+	default:
+		return -1;
+	}
+
+	/*
+	 * pa_dwr_set is the mask for selecting Vcc on both sockets.
+	 * pa_dwr_mask selects which bits (and therefore socket) we change.
+	 */
+	switch (state->Vcc) {
+	default:
+	case 0:  pa_dwr_set = 0;		break;
+	case 33: pa_dwr_set = GPIO_A1|GPIO_A2;	break;
+	case 50: pa_dwr_set = GPIO_A0|GPIO_A3;	break;
+	}
+
+	ret = sa1111_pcmcia_configure_socket(skt, state);
+	if (ret == 0) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		NCR_0 = (NCR_0 & ~ncr_mask) | ncr_set;
+
+		local_irq_restore(flags);
+		sa1111_set_io(s->dev, pa_dwr_mask, pa_dwr_set);
+	}
+
+	return ret;
+}
+
+static struct pcmcia_low_level neponset_pcmcia_ops = {
+	.owner			= THIS_MODULE,
+	.configure_socket	= neponset_pcmcia_configure_socket,
+	.first			= 0,
+	.nr			= 2,
+};
+
+int pcmcia_neponset_init(struct sa1111_dev *sadev)
+{
+	int ret = -ENODEV;
+
+	if (machine_is_assabet()) {
+		/*
+		 * Set GPIO_A<3:0> to be outputs for the MAX1600,
+		 * and switch to standby mode.
+		 */
+		sa1111_set_io_dir(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0, 0);
+		sa1111_set_io(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
+		sa1111_set_sleep_io(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
+		sa11xx_drv_pcmcia_ops(&neponset_pcmcia_ops);
+		ret = sa1111_pcmcia_add(sadev, &neponset_pcmcia_ops,
+				sa11xx_drv_pcmcia_add_one);
+	}
+
+	return ret;
+}
-- 
1.7.4.4
