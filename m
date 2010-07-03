From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 04 Jul 2010 01:48:57 +0200
Subject: pxa27x_udc: Oops on probe with usb cable connected.
In-Reply-To: <20100703221022.27df1a2e.ospite@studenti.unina.it> (Antonio
	Ospite's message of "Sat\, 3 Jul 2010 22\:10\:22 +0200")
References: <20100630115310.bcf967c1.ospite@studenti.unina.it>
	<877hld7np5.fsf@free.fr>
	<20100703221022.27df1a2e.ospite@studenti.unina.it>
Message-ID: <87r5jkxh1y.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antonio Ospite <ospite@studenti.unina.it> writes:

> Done that as well this time. See
> http://people.openezx.org/ao2/tmp/pxa27x-udc_BUG/
> I replaced the old files with the new ones as per your instructions.
>
> Thanks,
>    Antonio

Nice.

Now, would you test the patch attached in this mail to see if :
 - it fixes your Oops
 - the UDC is usable after you attach a gadget driver to pxa27x_udc

Cheers.

--
Robert

---
diff --git a/drivers/usb/gadget/pxa27x_udc.c b/drivers/usb/gadget/pxa27x_udc.c
index 85b0d89..d76d9ee 100644
--- a/drivers/usb/gadget/pxa27x_udc.c
+++ b/drivers/usb/gadget/pxa27x_udc.c
@@ -1938,6 +1938,9 @@ static void handle_ep0_ctrl_req(struct pxa_udc *udc,
 	nuke(ep, -EPROTO);
 	spin_lock_irqsave(&ep->lock, flags);
 
+	if (!udc->driver)
+		goto stall;
+
 	/*
 	 * In the PXA320 manual, in the section about Back-to-Back setup
 	 * packets, it describes this situation.  The solution is to set OPC to

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: patch.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100704/0c0b80fc/attachment.txt>
