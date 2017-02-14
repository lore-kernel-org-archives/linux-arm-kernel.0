From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 14 Feb 2017 15:46 +0200
Subject: [BUG] usb: gadget: Kernel oops with UVC USB gadget and configfs
In-Reply-To: <87r331zy73.fsf@belgarion.home>
References: <497c3c61-31f0-4d40-9bab-5a0aa793e5e9@tul.cz>
 <840f1745-8792-9d7b-9f43-961614b6938d@tul.cz> <87r331zy73.fsf@belgarion.home>
Message-ID: <2813264.gunpljLm9f@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On Monday 13 Feb 2017 20:29:36 Robert Jarzmik wrote:
> Petr Cvek <petr.cvek@tul.cz> writes:
> > Dne 12.2.2017 v 13:02 Robert Jarzmik napsal(a):
> > That's weird I even removed pxa_set_udc_info() from magician machine init
> > and it still fails. Host cable and/or actual camera is not required. It
> > fails without them.
> > 
> > So you binded pxa27x-udc as UDC controller (= activated it) and then
> > rmmoded it and nobody complained?
> 
> No, that usecase actually fails. I think you could submit a proper patch
> with the diff in [1], with which the pxa27x-udc unloading will work.
> 
> But it's not _your_ testcase, as per your provided callstack :
> [ 2152.826529] [<bf4a1914>] (udc_bind_to_driver [udc_core]) from
> [<bf4a1b08>] (usb_add_gadget_udc_release+0x138/0x21c [udc_core]) [
> 2152.826731] [<bf4a1b08>] (usb_add_gadget_udc_release [udc_core]) from
> [<bf4db838>] (pxa_udc_probe+0x290/0x2fc [pxa27x_udc]) [ 2152.833554]
> [<bf4db838>] (pxa_udc_probe [pxa27x_udc]) from [<c02522d0>]
> (platform_drv_probe+0x38/0x84) [ 2152.833602] [<c02522d0>]
> (platform_drv_probe) from [<c0250784>] (driver_probe_device+0x1e0/0x3f4)
> 
> Your problem seems in the pxa_udc_probe(), which I would presume you're
> doing for a second time, ie. after modprobe pxa27x_udc + bind UDC
> controller + rmmod pxa27x_udc + modprobe pxa27x_udc.
> 
> I suspect that in this case, the problem is that the rmmod works while udc
> is still bound to the composite. The lsmod seems to prove that the refcount
> is still 0 while usb_f_uvc is is bound to pxa27x_udc.
> 
> [@Felipe and @Laurent]
> I have no knowledge of usb_f_uvc, so would you tell me if binding usb_f_uvc
> to pxa27_udc should have incremented the module refcount of pxa27x_udc or
> not ?

I'm not familiar with how modules refcount is handled in the USB gadget 
framework, that's more a question for Felipe. I don't think the problem is 
specific to usb_f_uvc, all gadget drivers should behave the same way (and if 
they don't that should be fixed).

> > Can you try v4.10? Or send me exact commit on what you tested it so I can
> > test it too.
> 
> My top commit (not counting yours) is : 61c04572de40 ("Merge branch 'for-rc'
> of git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux")

-- 
Regards,

Laurent Pinchart
