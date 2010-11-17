From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 17 Nov 2010 10:55:41 -0500 (EST)
Subject: [PATCH 9/9] ARM: pxa: add iwmmx support for PJ4
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C05986C77F4@SC-VEXCH1.marvell.com>
References: <1289991823-24677-1-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-2-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-3-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-4-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-5-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-6-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-7-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-8-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-9-git-send-email-haojian.zhuang@marvell.com>
	<25B60CDC2F704E4E9D88FFD52780CB4C05986C77F4@SC-VEXCH1.marvell.com>
Message-ID: <alpine.LFD.2.00.1011171047150.6448@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Nov 2010, Haojian Zhuang wrote:

> 
> 
> >-----Original Message-----
> >From: Haojian Zhuang [mailto:haojian.zhuang at marvell.com]
> >Sent: 2010?11?17? 7:04 PM
> >To: linux-arm-kernel at lists.infradead.org
> >Cc: Haojian Zhuang; Zhou Zhu; Eric Miao; Nicolas Pitre
> >Subject: [PATCH 9/9] ARM: pxa: add iwmmx support for PJ4
> >
> >iwmmxt is used in XScale, XScale3, Mohawk and PJ4 core. But the instructions
> >of accessing CP0 and CP1 is changed in PJ4. Append more files to support
> >iwmmxt in PJ4 core.
> >
> >Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
> >Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> >Cc: Eric Miao <eric.y.miao@gmail.com>
> >Cc: Nicolas Pitre <nico@fluxnic.net>
> >---
> > arch/arm/Kconfig         |    4 +-
> > arch/arm/kernel/Makefile |    1 +
> > arch/arm/kernel/iwmmxt.S |   55 +++++++++++++++++++++++++++++++++++-------
> >----
> > 3 files changed, 45 insertions(+), 15 deletions(-)
> >
> 
> Changelog:
> 1. Append missing pj4-cp0.c.

OK... some more comments there:

+static int __init pj4_cp0_init(void)
+{
+       u32 cp_access;
+
+       cp_access = pj4_cp_access_read() & ~0xf;
+       pj4_cp_access_write(cp_access | 0xf);

You clear all first 4 bits just to set them all again.  Isn't the first 
mask redundant?

+       printk(KERN_INFO "XScale iWMMXt coprocessor detected.\n");

You are not really detecting anything here, and this is not for XScale 
either.  What about ""PJ4 iWMMXt coprocessor enabled.\n" instead?

+       elf_hwcap |= HWCAP_IWMMXT;
+       thread_register_notifier(&iwmmxt_notifier_block);
+
+       pj4_cp_access_write(cp_access);

And here you are clearing access to the coprocessor.  There is nothing 
that required access to it from the moment it was set at the beginning 
of the function, so maybe you should have only cleared it at the 
beginning instead.


Nicolas
