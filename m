From: siccegge@cs.fau.de (Christoph Egger)
Date: Wed, 30 Jun 2010 15:57:26 +0000
Subject: [PATCH] Removing dead OMAP_DSP
Message-ID: <mailman.63.1278318071.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP_DSP doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
[tony at atomide.com: updated to apply on top of already queued patches]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index c9e9e37..5a7b638 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -242,138 +242,6 @@ static inline void nokia770_mmc_init(void)
 }
 #endif
 
-#if	defined(CONFIG_OMAP_DSP)
-/*
- * audio power control
- */
-#define	HEADPHONE_GPIO		14
-#define	AMPLIFIER_CTRL_GPIO	58
-
-static struct clk *dspxor_ck;
-static DEFINE_MUTEX(audio_pwr_lock);
-/*
- * audio_pwr_state
- * +--+-------------------------+---------------------------------------+
- * |-1|down			|power-up request -> 0			|
- * +--+-------------------------+---------------------------------------+
- * | 0|up			|power-down(1) request -> 1		|
- * |  |				|power-down(2) request -> (ignore)	|
- * +--+-------------------------+---------------------------------------+
- * | 1|up,			|power-up request -> 0			|
- * |  |received down(1) request	|power-down(2) request -> -1		|
- * +--+-------------------------+---------------------------------------+
- */
-static int audio_pwr_state = -1;
-
-static inline void aic23_power_up(void)
-{
-}
-static inline void aic23_power_down(void)
-{
-}
-
-/*
- * audio_pwr_up / down should be called under audio_pwr_lock
- */
-static void nokia770_audio_pwr_up(void)
-{
-	clk_enable(dspxor_ck);
-
-	/* Turn on codec */
-	aic23_power_up();
-
-	if (gpio_get_value(HEADPHONE_GPIO))
-		/* HP not connected, turn on amplifier */
-		gpio_set_value(AMPLIFIER_CTRL_GPIO, 1);
-	else
-		/* HP connected, do not turn on amplifier */
-		printk("HP connected\n");
-}
-
-static void codec_delayed_power_down(struct work_struct *work)
-{
-	mutex_lock(&audio_pwr_lock);
-	if (audio_pwr_state == -1)
-		aic23_power_down();
-	clk_disable(dspxor_ck);
-	mutex_unlock(&audio_pwr_lock);
-}
-
-static DECLARE_DELAYED_WORK(codec_power_down_work, codec_delayed_power_down);
-
-static void nokia770_audio_pwr_down(void)
-{
-	/* Turn off amplifier */
-	gpio_set_value(AMPLIFIER_CTRL_GPIO, 0);
-
-	/* Turn off codec: schedule delayed work */
-	schedule_delayed_work(&codec_power_down_work, HZ / 20);	/* 50ms */
-}
-
-static int
-nokia770_audio_pwr_up_request(struct dsp_kfunc_device *kdev, int stage)
-{
-	mutex_lock(&audio_pwr_lock);
-	if (audio_pwr_state == -1)
-		nokia770_audio_pwr_up();
-	/* force audio_pwr_state = 0, even if it was 1. */
-	audio_pwr_state = 0;
-	mutex_unlock(&audio_pwr_lock);
-	return 0;
-}
-
-static int
-nokia770_audio_pwr_down_request(struct dsp_kfunc_device *kdev, int stage)
-{
-	mutex_lock(&audio_pwr_lock);
-	switch (stage) {
-	case 1:
-		if (audio_pwr_state == 0)
-			audio_pwr_state = 1;
-		break;
-	case 2:
-		if (audio_pwr_state == 1) {
-			nokia770_audio_pwr_down();
-			audio_pwr_state = -1;
-		}
-		break;
-	}
-	mutex_unlock(&audio_pwr_lock);
-	return 0;
-}
-
-static struct dsp_kfunc_device nokia770_audio_device = {
-	.name	 = "audio",
-	.type	 = DSP_KFUNC_DEV_TYPE_AUDIO,
-	.enable  = nokia770_audio_pwr_up_request,
-	.disable = nokia770_audio_pwr_down_request,
-};
-
-static __init int omap_dsp_init(void)
-{
-	int ret;
-
-	dspxor_ck = clk_get(0, "dspxor_ck");
-	if (IS_ERR(dspxor_ck)) {
-		printk(KERN_ERR "couldn't acquire dspxor_ck\n");
-		return PTR_ERR(dspxor_ck);
-	}
-
-	ret = dsp_kfunc_device_register(&nokia770_audio_device);
-	if (ret) {
-		printk(KERN_ERR
-		       "KFUNC device registration faild: %s\n",
-		       nokia770_audio_device.name);
-		goto out;
-	}
-	return 0;
- out:
-	return ret;
-}
-#else
-#define omap_dsp_init()		do {} while (0)
-#endif	/* CONFIG_OMAP_DSP */
-
 static void __init omap_nokia770_init(void)
 {
 	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 379100c..c00d602 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -63,44 +63,7 @@ static void omap_init_rtc(void)
 static inline void omap_init_rtc(void) {}
 #endif
 
-#if defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
-
-#if defined(CONFIG_ARCH_OMAP15XX)
-#  define OMAP1_MBOX_SIZE	0x23
-#  define INT_DSP_MAILBOX1	INT_1510_DSP_MAILBOX1
-#elif defined(CONFIG_ARCH_OMAP16XX)
-#  define OMAP1_MBOX_SIZE	0x2f
-#  define INT_DSP_MAILBOX1	INT_1610_DSP_MAILBOX1
-#endif
-
-#define OMAP1_MBOX_BASE		OMAP16XX_MAILBOX_BASE
-
-static struct resource mbox_resources[] = {
-	{
-		.start		= OMAP1_MBOX_BASE,
-		.end		= OMAP1_MBOX_BASE + OMAP1_MBOX_SIZE,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= INT_DSP_MAILBOX1,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device mbox_device = {
-	.name		= "omap1-mailbox",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(mbox_resources),
-	.resource	= mbox_resources,
-};
-
-static inline void omap_init_mbox(void)
-{
-	platform_device_register(&mbox_device);
-}
-#else
 static inline void omap_init_mbox(void) { }
-#endif
 
 /*-------------------------------------------------------------------------*/
 
diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index e9bdff1..b3a796a 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -23,7 +23,6 @@
 #include <plat/mux.h>
 #include <plat/cpu.h>
 #include <plat/mcbsp.h>
-#include <plat/dsp_common.h>
 
 #define DPS_RSTCT2_PER_EN	(1 << 0)
 #define DSP_RSTCT2_WD_PER_EN	(1 << 1)
@@ -46,7 +45,6 @@ static void omap1_mcbsp_request(unsigned int id)
 				clk_enable(api_clk);
 				clk_enable(dsp_clk);
 
-				omap_dsp_request_mem();
 				/*
 				 * DSP external peripheral reset
 				 * FIXME: This should be moved to dsp code
@@ -62,7 +60,6 @@ static void omap1_mcbsp_free(unsigned int id)
 {
 	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3) {
 		if (--dsp_use == 0) {
-			omap_dsp_release_mem();
 			if (!IS_ERR(api_clk)) {
 				clk_disable(api_clk);
 				clk_put(api_clk);
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index ca5b229..9d5466d 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -30,67 +30,6 @@
 #include <plat/dsp_common.h>
 #include <plat/omap44xx.h>
 
-#if	defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
-
-static struct dsp_platform_data dsp_pdata = {
-	.kdev_list = LIST_HEAD_INIT(dsp_pdata.kdev_list),
-};
-
-static struct resource omap_dsp_resources[] = {
-	{
-		.name	= "dsp_mmu",
-		.start	= -1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device omap_dsp_device = {
-	.name		= "dsp",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(omap_dsp_resources),
-	.resource	= omap_dsp_resources,
-	.dev = {
-		.platform_data = &dsp_pdata,
-	},
-};
-
-static inline void omap_init_dsp(void)
-{
-	struct resource *res;
-	int irq;
-
-	if (cpu_is_omap15xx())
-		irq = INT_1510_DSP_MMU;
-	else if (cpu_is_omap16xx())
-		irq = INT_1610_DSP_MMU;
-	else if (cpu_is_omap24xx())
-		irq = INT_24XX_DSP_MMU;
-
-	res = platform_get_resource_byname(&omap_dsp_device,
-					   IORESOURCE_IRQ, "dsp_mmu");
-	res->start = irq;
-
-	platform_device_register(&omap_dsp_device);
-}
-
-int dsp_kfunc_device_register(struct dsp_kfunc_device *kdev)
-{
-	static DEFINE_MUTEX(dsp_pdata_lock);
-
-	spin_lock_init(&kdev->lock);
-
-	mutex_lock(&dsp_pdata_lock);
-	list_add_tail(&kdev->entry, &dsp_pdata.kdev_list);
-	mutex_unlock(&dsp_pdata_lock);
-
-	return 0;
-}
-EXPORT_SYMBOL(dsp_kfunc_device_register);
-
-#else
-static inline void omap_init_dsp(void) { }
-#endif	/* CONFIG_OMAP_DSP */
-
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_OMAP_MCBSP) || defined(CONFIG_OMAP_MCBSP_MODULE)
@@ -359,7 +298,6 @@ static int __init omap_init_devices(void)
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
-	omap_init_dsp();
 	omap_init_rng();
 	omap_init_mcpdm();
 	omap_init_uwire();
diff --git a/arch/arm/plat-omap/include/plat/dsp_common.h b/arch/arm/plat-omap/include/plat/dsp_common.h
deleted file mode 100644
index da97736..0000000
--- a/arch/arm/plat-omap/include/plat/dsp_common.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2004-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifndef ASM_ARCH_DSP_COMMON_H
-#define ASM_ARCH_DSP_COMMON_H
-
-#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_OMAP_MMU_FWK)
-extern void omap_dsp_request_mpui(void);
-extern void omap_dsp_release_mpui(void);
-extern int omap_dsp_request_mem(void);
-extern int omap_dsp_release_mem(void);
-#else
-static inline int omap_dsp_request_mem(void)
-{
-	return 0;
-}
-#define omap_dsp_release_mem()	do {} while (0)
-#endif
-
-#endif /* ASM_ARCH_DSP_COMMON_H */

--wzJLGUyc3ArbnUjN--


>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.67.1278928723.27306.linux-arm-kernel@lists.infradead.org>

SMDKC110 # bdinfo
arch_number =3D 0x00000891
env_t       =3D 0x00000000
boot_params =3D 0x20000100
DRAM bank   =3D 0x00000000
-> start    =3D 0x20000000
-> size     =3D 0x05000000
DRAM bank   =3D 0x00000001
-> start    =3D 0x40000000
-> size     =3D 0x10000000
DRAM bank   =3D 0x00000002
-> start    =3D 0x50000000
-> size     =3D 0x08000000


>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.68.1278928723.27306.linux-arm-kernel@lists.infradead.org>

SMDKC110 # bootm c0008000
Boot with zImage

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.35-rc4-00008-g98c749c (kgene at starstone) (gcc version =
4.4.1
(Sourcery G++ Lite 2009q3-67) ) #1 PREEMPT Mon Jul 12 18:47:04 KST 2010
CPU: ARMv7 Processor [412fc082] revision 2 (ARMv7), cr=3D10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: SMDKC110
...
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 80MB 256MB 128MB =3D 464MB total
Memory: 459616k/459616k available, 15520k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xff000000 - 0xffe00000   (  14 MB)
    vmalloc : 0xb8800000 - 0xe0000000   ( 632 MB)
    lowmem  : 0x80000000 - 0xb8000000   ( 896 MB)
    modules : 0x7f000000 - 0x80000000   (  16 MB)
      .init : 0x80008000 - 0x8001e000   (  88 kB)
      .text : 0x8001e000 - 0x801be000   (1664 kB)
      .data : 0x801ce000 - 0x801e6600   (  98 kB)
SLUB: Genslabs=3D9, HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D1, =
Nodes=3D1
Hierarchical RCU implementation.
        RCU-based detection of stalled CPUs is disabled.
        Verbose stalled-CPUs detection is disabled.
...

And SECTION_SIZE_BITS is 28, not 27.

> Thank you,
> Kyungmin Park
>=20
> On Mon, Jul 12, 2010 at 5:32 PM, Kukjin Kim <kgene.kim@samsung.com> =
wrote:
> > Russell,
> >
> > Hi,
> >
> > Kukjin Kim wrote:
> >> Russell wrote:
> >> > So, memory starts at 0x20000000 and finishes at 0x25000000. =
=A0That's
> > fine.
> >> > That doesn't mean the section size is 16MB.
> >> >
> >> > As I've already said, the section size has _nothing_ what so ever =
to
do
> >> > with the size of memory, or the granularity of the size of =
memory.
=A0By
> >> > way of illustration, it is perfectly legal to have a section size =
of
> >> > 256MB but only have 1MB in a section and this is perfectly legal. =
=A0So
> >> > sections do not have to be completely filled.
> >> >
> >> Actually, as you know, the hole's area of mem_map is freed from =
bootmem
if
> > a
> >> section has a hole when initializing sparse memory.
> >>
> >> I identified that a section doesn't need to be a contiguous area of
> > physical
> >> memory when reading your comment with the fact that the mem_map of =
a
> > section
> >> can be smaller than the size of a section.
> >>
> >> I found, however, the kernel panics when modifying min_free_kbytes =
file
in
> >> the proc filesystem if a section has a hole.
> >>
> >> While processing the change of min_free_kbytes in the kernel, page
> >> descriptors in a hole of an online section is accessed.
> >
> > As I said, following error happens.
> > It would be helpful to me if any opinions or comments.
> >
> > ---


(snip)


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
