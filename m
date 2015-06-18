From: noralf@tronnes.org (=?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?=)
Date: Thu, 18 Jun 2015 15:32:44 +0200
Subject: [PATCH] irqchip: bcm2835: Add FIQ support
In-Reply-To: <55822C71.2040409@wwwdotorg.org>
References: <1434130016-26574-1-git-send-email-noralf@tronnes.org>
 <55822C71.2040409@wwwdotorg.org>
Message-ID: <5582C87C.20008@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 18.06.2015 04:26, skrev Stephen Warren:
> On 06/12/2015 11:26 AM, Noralf Tr?nnes wrote:
>> Add a duplicate irq range with an offset on the hwirq's so the
>> driver can detect that enable_fiq() is used.
>> Tested with downstream dwc_otg USB controller driver.
> This basically looks OK, but a few comments/thoughts:
>
> a) Should the Kconfig change be a separate patch since it's a separate
> subsystem?

I can separate it out.

> b) Doesn't the driver need to refuse some operation (handler
> registration, IRQ setup, IRQ enable, ...?) for more than 1 IRQ in the
> FIQ range, since the FIQ control register only allows routing 1 IRQ to FIQ.

claim_fiq() protects the FIQ. See d) answer below.

> c) The DT binding needs updating to describe the extra IRQs:
>
>> Documentation/devicetree/bindings/interrupt-controller/brcm,bcm28armctrl-ic.txt

Ok.

> d) I wonder how the FIQ handler actually gets routed to this controller
> and hooked to its handler etc. I assume there's a separate patch for
> that coming?

set_fiq_handler() sets the handler and enable_fiq() enables it:

     if (claim_fiq(&fh))
         ERROR;
     set_fiq_handler(...)
     set_fiq_regs(&regs);
     enable_fiq(irq);
     local_fiq_enable();


Downstream dwc_otg
------------------

FIQ handler:
https://github.com/raspberrypi/linux/blob/rpi-4.0.y/drivers/usb/host/dwc_otg/dwc_otg_fiq_stub.S

FIQ is set up in hcd_init_fiq():
https://github.com/raspberrypi/linux/blob/rpi-4.0.y/drivers/usb/host/dwc_otg/dwc_otg_hcd_linux.c

This patch is also necessary:
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_driver.c 
b/drivers/usb/host/dwc_otg/dwc_otg_driver.c
index 53307f0..95edadf 100644
--- a/drivers/usb/host/dwc_otg/dwc_otg_driver.c
+++ b/drivers/usb/host/dwc_otg/dwc_otg_driver.c
@@ -723,6 +723,7 @@ static int dwc_otg_driver_probe(

      memset(dwc_otg_device, 0, sizeof(*dwc_otg_device));
      dwc_otg_device->os_dep.reg_offset = 0xFFFFFFFF;
+    dwc_otg_device->os_dep.platformdev = _dev;

      /*
       * Map the DWC_otg Core memory into virtual address space.
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c 
b/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
index 8a31562..2961985 100644
--- a/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
+++ b/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
@@ -36,10 +36,8 @@
  #include "dwc_otg_regs.h"

  #include <linux/jiffies.h>
-#include <mach/hardware.h>
  #include <asm/fiq.h>

-
  extern bool microframe_schedule;

  /** @file
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_hcd_linux.c 
b/drivers/usb/host/dwc_otg/dwc_otg_hcd_linux.c
index 6aad9c4..0440c66 100644
--- a/drivers/usb/host/dwc_otg/dwc_otg_hcd_linux.c
+++ b/drivers/usb/host/dwc_otg/dwc_otg_hcd_linux.c
@@ -445,7 +445,11 @@ static void hcd_init_fiq(void *cookie)
          DWC_WARN("MPHI periph has NOT been enabled");
  #endif
      // Enable FIQ interrupt from USB peripheral
+#ifdef CONFIG_ARCH_BCM2835
+    enable_fiq(platform_get_irq(otg_dev->os_dep.platformdev, 1));
+#else
      enable_fiq(INTERRUPT_VC_USB);
+#endif
      local_fiq_enable();
  }


DT node:
         usb: usb at 7e980000 {
             compatible = "brcm,bcm2708-usb";
             reg = <0x7e980000 0x10000>,
                   <0x7e006000 0x1000>;
             interrupts = <2 0>,
                      <1 9>;
         };
