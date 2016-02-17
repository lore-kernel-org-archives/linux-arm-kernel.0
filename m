From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Feb 2016 17:00:15 +0100
Subject: [PATCH 1/7] usb: gadget: pxa25x_udc: move register definitions
 from arch
In-Reply-To: <87oabfgys4.fsf@ti.com>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-1-git-send-email-arnd@arndb.de> <87oabfgys4.fsf@ti.com>
Message-ID: <16402463.pdHgaqhrJe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 February 2016 17:08:27 Felipe Balbi wrote:
> 
> Hi,
> 
> Arnd Bergmann <arnd@arndb.de> writes:
> > ixp4xx and pxa25x both use this driver and provide a slightly
> > different set of register definitions for it. Aside from that,
> > the definition in the ixp4xx-regs.h header conflicts with the
> > on in the pxa27x device driver when compile-testing that:
> >
> > In file included from ../drivers/usb/gadget/udc/pxa27x_udc.c:37:0:
> > ../drivers/usb/gadget/udc/pxa27x_udc.h:26:0: warning: "UDCCR" redefined
> >  #define UDCCR  0x0000  /* UDC Control Register */
> >  ^
> > In file included from ../arch/arm/mach-ixp4xx/include/mach/hardware.h:27:0,
> >                  from ../arch/arm/mach-ixp4xx/include/mach/io.h:18,
> >                  from ../arch/arm/include/asm/io.h:194,
> >                  from ../include/linux/io.h:25,
> >                  from ../include/linux/irq.h:24,
> >                  from ../drivers/usb/gadget/udc/pxa27x_udc.c:23:
> > ../arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h:415:0: note: this is the location of the previous definition
> >  #define UDCCR  IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0000)
> >
> > This addresses both issues by moving all the definitions into the
> > pxa25x_udc driver itself. It turns out the only difference between
> > them was 'UDCCS_IO_ROF', and that could well be a mistake when it
> > was incorrectly copied from pxa25x to ixp4xx.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> FYI, this series now sits in my testing/next. If you could just check
> that I didn't mess anything up, I'd be glad.
> 

Thank you for merging this and my other patches!

After the latest discussion with Krzysztof, I think it would be good
to include the patch below, either on top or folded into the last
patch of the series (whichever fits your workflow).

	Arnd
 
8<----
>From 3feea5e42eae444e122f3ad51fef9e08d758fc27 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Feb 2016 16:51:40 +0100
Subject: [PATCH] usb: gadget: pxa25x_udc: document endianess better
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When I wrote the cleanup patch series, it was not clear how
exactly big-endian mode works on ixp4xx, and whether the driver
was doing this correctly. After discussing with Krzysztof Ha?asa,
this has been clarified, so I can update the comment let pxa25x
big-endian (which we don't support) work the same way as ixp4xx.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index ca7abdc0eca9..33b7fb84f4fb 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -289,14 +289,14 @@ static void pullup_on(void)
 		mach->udc_command(PXA2XX_UDC_CMD_CONNECT);
 }
 
-#if defined(CONFIG_ARCH_IXP4XX) && defined(CONFIG_CPU_BIG_ENDIAN)
+#if defined(CONFIG_CPU_BIG_ENDIAN)
 /*
- * not sure if this is the correct behavior on ixp4xx in both
- * bit-endian and little-endian modes, but it's what the driver
- * has always done using direct pointer dereferences:
- * We assume that there is a byteswap done in hardware at the
- * MMIO register that matches what the CPU setting is, so we
- * never swap in software.
+ * IXP4xx has its buses wired up in a way that relies on never doing any
+ * byte swaps, independent of whether it runs in big-endian or little-endian
+ * mode, as explained by Krzysztof Ha?asa.
+ *
+ * We only support pxa25x in little-endian mode, but it is very likely
+ * that it works the same way.
  */
 static inline void udc_set_reg(struct pxa25x_udc *dev, u32 reg, u32 val)
 {
