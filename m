From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 18 Apr 2017 22:25:06 +0200 (CEST)
Subject: usb: dwc2: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 146s
In-Reply-To: <79b9b35b-0600-771f-4cd2-9e03c5ba3a25@i2se.com>
References: <1795308650.27171.9a53158f-312d-40ce-80ce-8bf792d8db34.open-xchange@email.1und1.de>
 <172093673.40121.1492427140661@email.1und1.de>
 <CAD=FV=WJBTUcMPw8OgQT_jhz0H8AsH=YqWMR7LtudUKrF5-XOA@mail.gmail.com>
 <79b9b35b-0600-771f-4cd2-9e03c5ba3a25@i2se.com>
Message-ID: <186569458.91967.1492547106553@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[add Johan]

> Stefan Wahren <stefan.wahren@i2se.com> hat am 18. April 2017 um 10:07 geschrieben:
> 
> 
> Am 18.04.2017 um 00:37 schrieb Doug Anderson:
> > Hi,
> >
> > On Mon, Apr 17, 2017 at 4:05 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> >> Hi,
> >>
> >>> Stefan Wahren <stefan.wahren@i2se.com> hat am 31. Oktober 2016 um 21:34 geschrieben:
> >>>
> >>>
> >>> I inspired by this issue [1] i build up a slightly modified setup with a
> >>> Raspberry Pi B (mainline kernel 4.9rc3), a powered 7 port USB hub and 5 Prolific
> >>> PL2303 USB to serial convertors. I modified the usb_test for dwc2 [2], which
> >>> only tries to open all ttyUSB devices one after the other.
> >>>
> >>> Unfortunately the complete system stuck after opening the first ttyUSB device (
> >>> heartbeat LED stop blinking, no reaction to debug UART). The only way to
> >>> reanimate the system is to powerdown the USB hub with the USB to serial
> >>> convertors.
> >>>
> >>> [1] - https://github.com/raspberrypi/linux/issues/1692
> >>> [2] - https://gist.github.com/lategoodbye/dd0d30af27b6f101b03d5923b279dbaa
> >> since this issue still exists with 4.11 (even without or with microframe scheduler enabled), i want to ask some additional questions:
> >>
> >> Is this issue reproducible with other dwc2 platforms than bcm2835?
> > +Edmund Szeto, who I seem to remember emailing me about similar
> > questions in the past.
> >
> >
> >> Does the soft lockup also occurs after opening the second serial convertor or later?
> > I don't have serial converters easily available to me, but back in the
> > day when I was stressing things out on rk3288 I never saw anything
> > this bad.  ...of course, on rk3288 we've got 4 A17 cores running
> > really fast, so possibly just being slower is what causes your
> > problems here?
> 
> The downstream kernel of the Raspberry Pi foundation with it's
> out-of-tree dwc_otg driver is able to handle 8 serial converter on a RPI
> B. I would be happy to get at least 2 or 3 working on mainline.
> 
> >
> > I will make the following observations:
> >
> > 1. With dwc2 you often end up in the situation where you need to
> > service an interrupt every 125 uS.  If servicing that interrupt takes
> > anywhere near 125 uS in the common case then you'll be in trouble.
> 
> I will try to measure this with a logic analyzer.
> 

i took GPIO17 to measure _dwc2_hcd_irq and GPIO18 to measure _dwc2_hcd_urb_enqueue (patch against 4.11rc1 below).

So i made my observations for 3 test cases:

1) no serial converter connected (idle)
2) 1 FTDI serial converter connected
3) 1 PL2303 serial converter connected

case   | ksoftirq cpu     | mean duration | max duration  | max duration | urb_enqueue  |
       |                  | hcd_irq       | hcd_irq       | urb_enqueue  | within 10 sec|
-------+------------------+---------------+---------------+--------------+--------------+
idle   | 0.0%             | 2 us          | 16.5 us       |     12 us    | 5            |
FTDI   | 25.0%            | 8.5 us        | 18.0 us       |  31000 us    | ~ 400        |
PL2303 | top doesn't work | 8.5 us        | 22.5 us       | 900000 us    | 4            |

So it seems the serial USB driver has also an impact. In the analyzer trace the FTDI triggers many smaller urb_enqueue calls in the opposite to the PL2303 which only has few but huge calls.

Additional notes:
After closing the serial connection to the FTDI the system is usable as before. In case of PL2303 i need to disconnect the converter in order to get a usable system.

Why do they behave so differently?
Are these results of a overload?
Doug, can you point me to your timing patch?

Thanks
Stefan

PS: My hacky patches for measuring

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 1a7e830..aa490c3 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -930,6 +930,9 @@ struct dwc2_hsotg {
 	struct dentry *debug_root;
 	struct debugfs_regset32 *regset;
 
+	int gpio_17;
+	int gpio_18;
+
 	/* DWC OTG HW Release versions */
 #define DWC2_CORE_REV_2_71a	0x4f54271a
 #define DWC2_CORE_REV_2_90a	0x4f54290a
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index a73722e..97271c8 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -45,6 +45,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
@@ -4595,13 +4596,17 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 	bool qh_allocated = false;
 	struct dwc2_qtd *qtd;
 
+	gpio_set_value(hsotg->gpio_18, 1);
+
 	if (dbg_urb(urb)) {
 		dev_vdbg(hsotg->dev, "DWC OTG HCD URB Enqueue\n");
 		dwc2_dump_urb_info(hcd, urb, "urb_enqueue");
 	}
 
-	if (!ep)
+	if (!ep) {
+		gpio_set_value(hsotg->gpio_18, 0);
 		return -EINVAL;
+	}
 
 	if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS ||
 	    usb_pipetype(urb->pipe) == PIPE_INTERRUPT) {
@@ -4628,8 +4633,10 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 
 	dwc2_urb = dwc2_hcd_urb_alloc(hsotg, urb->number_of_packets,
 				      mem_flags);
-	if (!dwc2_urb)
+	if (!dwc2_urb) {
+		gpio_set_value(hsotg->gpio_18, 0);
 		return -ENOMEM;
+	}
 
 	dwc2_hcd_urb_set_pipeinfo(hsotg, dwc2_urb, usb_pipedevice(urb->pipe),
 				  usb_pipeendpoint(urb->pipe), ep_type,
@@ -4705,6 +4712,8 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
+	gpio_set_value(hsotg->gpio_18, 0);
+
 	return 0;
 
 fail3:
@@ -4732,6 +4741,8 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 fail0:
 	kfree(dwc2_urb);
 
+	gpio_set_value(hsotg->gpio_18, 0);
+
 	return retval;
 }
 
@@ -4825,8 +4836,15 @@ static void _dwc2_hcd_endpoint_reset(struct usb_hcd *hcd,
 static irqreturn_t _dwc2_hcd_irq(struct usb_hcd *hcd)
 {
 	struct dwc2_hsotg *hsotg = dwc2_hcd_to_hsotg(hcd);
+	irqreturn_t ret;
 
-	return dwc2_handle_hcd_intr(hsotg);
+	gpio_set_value(hsotg->gpio_17, 1);
+
+	ret = dwc2_handle_hcd_intr(hsotg);
+
+	gpio_set_value(hsotg->gpio_17, 0);
+
+	return ret;
 }
 
 /*
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 9564bc7..e3f8a8a 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -35,6 +35,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
@@ -404,6 +405,16 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		return hsotg->irq;
 	}
 
+	hsotg->gpio_17 = 475;
+	retval = devm_gpio_request_one(hsotg->dev, hsotg->gpio_17,  GPIOF_OUT_INIT_LOW, "gpio_17");
+	if (retval)
+		pr_warn("Unable to request GPIO17: %d\n", retval);
+	
+	hsotg->gpio_18 = 476;
+	retval = devm_gpio_request_one(hsotg->dev, hsotg->gpio_18,  GPIOF_OUT_INIT_LOW, "gpio_18");
+	if (retval)
+		pr_warn("Unable to request GPIO18: %d\n", retval);
+
 	dev_dbg(hsotg->dev, "registering common handler for irq%d\n",
 		hsotg->irq);
 	retval = devm_request_irq(hsotg->dev, hsotg->irq,
