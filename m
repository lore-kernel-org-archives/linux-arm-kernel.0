From: petr.cvek@tul.cz (Petr Cvek)
Date: Wed, 8 Mar 2017 09:27:55 +0100
Subject: usb: gadget: pxa27x_udc: race condition with g_webcam
Message-ID: <7670be97-1199-3c5c-8959-4b982d0fb9cf@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

During the testing of the g_webcam on PXA27x (HTC Magician machine) I found a race condition. In the situations when the UDC receives a SETUP DATA packet sooner than it is "requested" by usb_ep_queue() it will block itself from the reading the FIFO.

Below I suggest the fix, but it is very dirty code (so just RFC) on a very buggy hardware (which I understand poorly even after reading comments [1] in the code :-D ). And I only repaired a path for the SETUP OUT packets. So any improvements are welcomed.

The call tree is:

	USB host generates a SETUP packet and sends it to the PXA27x UDC
	IRQ
	handle_ep0()
	handle_ep0_ctrl_req() - sets PXA UDC stage to OUT_DATA_STAGE
	uvc_function_setup()
	v4l2_event_queue() - event for userspace driver
	... userspace driver (uvc-gadget.c) can sleep, or just takes long to proceed

		... meanwhile USB host sends OUT packet
		IRQ
		handle_ep0()
		case OUT_DATA_STAGE:
			if (epout_has_pkt(ep) && req)
			//fails as there is no req queued yet (==NULL)
		interrupt gets masked

	ioctl UVCIOC_SEND_RESPONSE - if there is a data stage
	... switch to kernel
	uvc_send_response()
	usb_ep_queue()
	pxa_ep_queue()
	case OUT_DATA_STAGE:
		if ((length == 0) || !epout_has_pkt(ep))
		//fails, there is length, EP0 has a packet

Now there is an unreceived OUT packet stuck in the FIFO and the PXA UDC will never call usb_gadget_giveback_request() and the subsequent uvc_function_ep0_complete(). Which means the userspace will not get UVC_EVENT_DATA enqueued by v4l2_event_queue() and the host uvcvideo will timeout after a while.

I was able to make the g_webcam work after a few changes.

First, forcing the driver to read the packet, if there are data.

	pxa_ep_queue():
	case OUT_DATA_STAGE:
	-	if ((length == 0) || !epout_has_pkt(ep))
	+	if ((length == 0) || epout_has_pkt(ep))

... which is probably a bad idea in the long run. BTW why PXA UDC is trying to read empty FIFO? Or it is some clever call to handshake something (or some HW workaround, there is something here [1])?

This change caused an unwanted interrupt if there are multiple packet to be received (UVC SETUP can have like 26 bytes of data) which would mess the state machine, so I wrapped the condition inside an irq spinlock:

	case OUT_DATA_STAGE:
		spin_lock_irqsave(&ep->lock, flags);
		if ((length == 0) || epout_has_pkt(ep)){
			if (read_ep0_fifo(ep, req)) {
				ep0_end_out_req(ep, req, &flags); //must UNLOCK inside
			}
		}
		spin_unlock_irqrestore(&ep->lock, flags);
		break;

and in read_ep0_fifo() I've put a mask on the interrupt (UDC got a packet).

        while (epout_has_pkt(ep)) {
                count = read_packet(ep, req);
                ep_write_UDCCSR(ep, UDCCSR0_OPC);
+		udc_writel(ep->dev, UDCISR0, 1);
                inc_ep_stats_bytes(ep, count, !USB_DIR_IN);

Now the OUT packet can be read (bypassing IRQ handler), but the state machine can bite itself in the ass if a new SETUP packet is received:

	ep0_end_out_req()
	ep_end_out_req()
	req_done() - enabled interrupts
	usb_gadget_giveback_request()
	uvc_function_ep0_complete()
	v4l2_event_queue() - UVC_EVENT_DATA to userspace

if the interrupt is generated now it will be in the state OUT_STATUS_STAGE, because:

	static void ep0_end_out_req(...)
	{
		set_ep0state(ep->dev, OUT_STATUS_STAGE);
		ep_end_out_req(ep, req, pflags);
		ep0_idle(ep->dev);
	}
	
... this cause handle_ep0() to warn with:

	"should never get in OUT_STATUS_STAGE state here!!!"
	-> ep0_idle()

although this is just a warning it can be averted by just switching to WAIT_FOR_SETUP before usb_gadget_giveback_request().

With these changes I was able to send .jpg images with a modified (320x240, JPEG) g_webcam and with a modified uvc-gadget based on this commit [2].

P.S. This modification works with g_ether too.
P.P.S. I had to add g_webcam endpoints definitions too (first and second arguments depends on an actual configuration).
	/*g_webcam*/
	PXA_EP_IN_INT(7,    1, 3, 0, 0),
	PXA_EP_IN_ISO(8,    4, 3, 1, 1),

[1] http://elixir.free-electrons.com/source/drivers/usb/gadget/udc/pxa27x_udc.c?v=4.10#L2004
[2] https://github.com/madscientist42/uvc-gadget/commit/e127ec3a3022e1090b3b741b48f661670f5dade2

--
Regards,
Petr
