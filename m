From: jgq516@gmail.com (xiao jiang)
Date: Thu, 14 Oct 2010 05:26:29 -0400
Subject: mx35pdk lan911x support
In-Reply-To: <AANLkTikDp1NQaZ+dJk=pKSC29BokKVw-_82=m9QDQC14@mail.gmail.com>
References: <AANLkTi=aTdbj8bjo3i1wRxG03rbh=kUwLTYPvTESLqpT@mail.gmail.com>
	<20101014063001.GA6747@pengutronix.de>
	<AANLkTikDp1NQaZ+dJk=pKSC29BokKVw-_82=m9QDQC14@mail.gmail.com>
Message-ID: <AANLkTimjHUFC4TtKdWEQ7RepZVCmLjyYhEdiFELU5HgS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe & Fabio

2010/10/14 Fabio Estevam <festevam@gmail.com>

> Hi Xiao Jiang,
>
> 2010/10/14 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hello Xiao (hoping this is the part of your name corresponding to your
> > first name),
> >
> > On Thu, Oct 14, 2010 at 12:06:25AM -0400, xiao jiang wrote:
> >> I saw the mach-mx35_3ds.c  are come from you, so  I think you are the
> right
> >> person to answer my queston, :).
> > It was me, who renamed the file and touched it a few times when cleaning
> > up and reorganising things for the i.MX machines.  Initially it was
> > Fabio Estevam who brought the machine into mainline.
>
> I suggest you to look at MX51 3stack board or MX31 3stack boards, as
> they have support for LAN9217 controller.
>
> Thanks for your help, I can boot the kernel thru lan9217 now, only a few
lines added.

diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c
b/arch/arm/mach-mx3/mach-mx35_3ds.c
index 1c30d72..7e30a4e 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -35,6 +35,7 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx35.h>
+#include <mach/3ds_debugboard.h>

 #include "devices-imx35.h"
 #include "devices.h"
@@ -86,6 +87,7 @@ static struct fsl_usb2_platform_data usb_pdata = {
 /*
  * Board specific initialization.
  */
+#define EXPIO_PARENT_INT 65
 static void __init mxc_board_init(void)
 {
        mxc_iomux_v3_setup_multiple_pads(mx35pdk_pads,
ARRAY_SIZE(mx35pdk_pads));
@@ -95,6 +97,10 @@ static void __init mxc_board_init(void)
        imx35_add_imx_uart0(&uart_pdata);

        mxc_register_device(&mxc_otg_udc_device, &usb_pdata);
+
+       if (!mxc_expio_init(MX35_CS5_BASE_ADDR, EXPIO_PARENT_INT))
+               printk(KERN_WARNING "Init of the debugboard failed, all "
+                       "devices on the board are unusable.\n");
 }

 static void __init mx35pdk_timer_init(void)

BRs,
Xiao Jiang

> Regards,
>
> Fabio Estevam
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101014/b6f67d02/attachment-0001.html>
