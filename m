From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 27 Dec 2010 00:36:09 +0800
Subject: S3C OTG udc driver isochronous support
Message-ID: <AANLkTi=ssBu9FQp3svPBk3i3dPZTd-Dd03h9EyrO0waH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,
After checking the S3C OTG udc drivers in drivers/usb/gadget, i didn't
find it can support isochronous endpoint. According to datasheet of
S3C6410, EPtype field of DIEPCTLn and DOEPCTLn is read-only. Current
S3C OTG udc driver list ep0~ep9, which are control endpoint and
bulk/int endpoint according to the source codes:
static struct s3c_udc memory = {
	.usb_address = 0,

	.gadget = {
		   .ops = &s3c_udc_ops,
		   .ep0 = &memory.ep[0].ep,
		   .name = driver_name,
		   .dev = {
			   .bus_id = "gadget",
			   .release = nop_release,
			   },
		   },

	/* control endpoint */
	.ep[0] = {
		  .ep = {
			 .name = ep0name,
			 .ops = &s3c_ep_ops,
			 .maxpacket = EP0_FIFO_SIZE,
			 },
		  .dev = &memory,

		  .bEndpointAddress = 0,
		  .bmAttributes = 0,

		  .ep_type = ep_control,
		  .fifo = (unsigned int) S3C_UDC_OTG_EP0_FIFO,
		  },

	/* first group of endpoints */
	.ep[1] = {
		  .ep = {
			 .name = "ep1-bulk",
			 .ops = &s3c_ep_ops,
			 .maxpacket = EP_FIFO_SIZE,
			 },
		  .dev = &memory,

		  .bEndpointAddress = USB_DIR_OUT | 1,
		  .bmAttributes = USB_ENDPOINT_XFER_BULK,

		  .ep_type = ep_bulk_out,
		  .fifo = (unsigned int) S3C_UDC_OTG_EP1_FIFO,
		  },

	.ep[2] = {
		  .ep = {
			 .name = "ep2-bulk",
			 .ops = &s3c_ep_ops,
			 .maxpacket = EP_FIFO_SIZE,
			 },
		  .dev = &memory,

		  .bEndpointAddress = USB_DIR_IN | 2,
		  .bmAttributes = USB_ENDPOINT_XFER_BULK,

		  .ep_type = ep_bulk_in,
		  .fifo = (unsigned int) S3C_UDC_OTG_EP2_FIFO,
		  },

	.ep[3] = {
		  .ep = {
			 .name = "ep3-int",
			 .ops = &s3c_ep_ops,
			 .maxpacket = EP_FIFO_SIZE,
			 },
		  .dev = &memory,

		  .bEndpointAddress = USB_DIR_IN | 3,
		  .bmAttributes = USB_ENDPOINT_XFER_INT,

		  .ep_type = ep_interrupt,
		  .fifo = (unsigned int) S3C_UDC_OTG_EP3_FIFO,
		  },
	.ep[4] = {
		  .ep = {
			 .name = "ep4-bulk",
			 .ops = &s3c_ep_ops,
			 .maxpacket = EP_FIFO_SIZE,
			 },
		  .dev = &memory,

		  .bEndpointAddress = USB_DIR_OUT | 4,
		  .bmAttributes = USB_ENDPOINT_XFER_BULK,

		  .ep_type = ep_bulk_out,
		  .fifo = (unsigned int) S3C_UDC_OTG_EP4_FIFO,
		  },
	.ep[5] = {
		  .ep = {
			 .name = "ep5-bulk",
			 .ops = &s3c_ep_ops,
			 .maxpacket = EP_FIFO_SIZE,
			 },
		  .dev = &memory,

		  .bEndpointAddress = USB_DIR_IN | 5,
		  .bmAttributes = USB_ENDPOINT_XFER_BULK,

		  .ep_type = ep_bulk_in,
		  .fifo = (unsigned int) S3C_UDC_OTG_EP5_FIFO,
		  },
	.ep[6] = {
		  .ep = {
			 .name = "ep6-int",
			 .ops = &s3c_ep_ops,
			 .maxpacket = EP_FIFO_SIZE,
			 },
		  .dev = &memory,

		  .bEndpointAddress = USB_DIR_IN | 6,
		  .bmAttributes = USB_ENDPOINT_XFER_INT,

		  .ep_type = ep_interrupt,
		  .fifo = (unsigned int) S3C_UDC_OTG_EP6_FIFO,
		  },
	.ep[7] = {
		  .ep = {
			 .name = "ep7-bulk",
			 .ops = &s3c_ep_ops,
			 .maxpacket = EP_FIFO_SIZE,
			 },
		  .dev = &memory,

		  .bEndpointAddress = USB_DIR_OUT | 7,
		  .bmAttributes = USB_ENDPOINT_XFER_BULK,

		  .ep_type = ep_bulk_out,
		  .fifo = (unsigned int) S3C_UDC_OTG_EP7_FIFO,
		  },
	.ep[8] = {
		  .ep = {
			 .name = "ep8-bulk",
			 .ops = &s3c_ep_ops,
			 .maxpacket = EP_FIFO_SIZE,
			 },
		  .dev = &memory,

		  .bEndpointAddress = USB_DIR_IN | 8,
		  .bmAttributes = USB_ENDPOINT_XFER_BULK,

		  .ep_type = ep_bulk_in,
		  .fifo = (unsigned int) S3C_UDC_OTG_EP8_FIFO,
		  },
	.ep[9] = {
		  .ep = {
			 .name = "ep9-int",
			 .ops = &s3c_ep_ops,
			 .maxpacket = EP_FIFO_SIZE,
			 },
		  .dev = &memory,

		  .bEndpointAddress = USB_DIR_IN | 9,
		  .bmAttributes = USB_ENDPOINT_XFER_INT,

		  .ep_type = ep_interrupt,
		  .fifo = (unsigned int) S3C_UDC_OTG_EP9_FIFO,
		  },
};
ep10~ep14 are not in the list. So is it possible ep10~ep14 are iso
endpoints? I guess only samsung engineers can answer this question.
And has anybody improved the udc driver to support ISO mode? Here i
want to use this mode to support g_webcam gadget.

Thanks
Barry
