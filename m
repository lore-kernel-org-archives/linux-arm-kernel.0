From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Tue, 17 Jan 2017 22:21:12 +0100
Subject: usb: gadget: Kernel panic (NULL pointer dereference) when using
 fsl_udc2_core on i.MX31 PDK
Message-ID: <f984e50b-0e64-88ef-2f53-b8da2a62daf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I tried the fsl_udc_core gadget driver on the i.MX31 PDK board and got a 
kernel panic (NULL pointer dereference) when connecting the USB cable. I 
had the g_serial module loaded as well.

The NULL pointer panic comes from gadget/udc/core.c 
usb_gadget_giveback_request() which calls req->complete() and in some 
cases req->complete is NULL.

Commit 304f7e5e1d08 ("usb: gadget: Refactor request completion") changed 
fsl_udc2_core.c (and several other files) and in fsl_udc2_core.c a check 
that req->complete is non-NULL was removed:

--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -197,10 +197,8 @@ __acquires(ep->udc->lock)
         ep->stopped = 1;

         spin_unlock(&ep->udc->lock);
-       /* complete() is from gadget layer,
-        * eg fsg->bulk_in_complete() */
-       if (req->req.complete)
-               req->req.complete(&ep->ep, &req->req);
+
+       usb_gadget_giveback_request(&ep->ep, &req->req);

         spin_lock(&ep->udc->lock);
         ep->stopped = stopped;

If I re-introduce the check (either in fsl_udc_core.c or core.c) at 
least USB gadget operation using g_serial seems to work just fine.

I don't know the logic in detail to understand whether this is a proper 
fix or if there is some other more problem with the fls_udc_core driver. 
Does anyone have input in this matter?

I can produce a proper patch that fixes this problem by re-introducing 
the check (in either fsl_udc_core.c or core.c) if that is a proper 
solution and I can also assist in testing other fixes to the problem.

Thanks, Magnus
