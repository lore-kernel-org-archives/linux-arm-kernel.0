From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 14 Apr 2011 19:06:47 +0200
Subject: [PATCH v4 3/4] USB: Gadget: Add Samsung S3C24XX USB High-Speed
	controller driver
In-Reply-To: <20110414154748.GA1366@kroah.com>
References: <201104141111.33781.heiko@sntech.de>
	<Pine.LNX.4.44L0.1104141134260.2487-100000@iolanthe.rowland.org>
	<20110414154748.GA1366@kroah.com>
Message-ID: <201104141906.48156.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag 14 April 2011, 17:47:48 schrieb Greg KH:
> On Thu, Apr 14, 2011 at 11:35:43AM -0400, Alan Stern wrote:
> > On Thu, 14 Apr 2011, Heiko [iso-8859-1] St?bner wrote:
> > > From: Thomas Abraham <thomas.ab@samsung.com>
> > > 
> > > The Samsung's S3C2416, S3C2443 and S3C2450 includes a USB High-Speed
> > > device controller module. This driver enables support for USB
> > > high-speed gadget functionality for the Samsung S3C24xx SoC's that
> > > include this controller.
> > > 
> > > Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> > > Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> > > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > > Signed-off-by: Alexander Neumann <alexander@bumpern.de>
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > 
> > ...
> > 
> > > +static struct usb_ep_ops s3c_hsudc_ep_ops = {
> > > +	.enable = s3c_hsudc_ep_enable,
> > > +	.disable = s3c_hsudc_ep_disable,
> > > +	.alloc_request = s3c_hsudc_alloc_request,
> > > +	.free_request = s3c_hsudc_free_request,
> > > +	.queue = s3c_hsudc_queue,
> > > +	.dequeue = s3c_hsudc_dequeue,
> > > +	.set_halt = s3c_hsudc_set_halt,
> > > +};
> > 
> > There's no .set_wedge method.  Why do people always leave this out?
> 
> Does the code spit out a nasty warning if this isn't set?  If not, I
> would suggest adding it so that this doesn't keep happening.

>From what I gathered from gadget.h the usb_ep_set_wedge function checks if 
set_wedge is defined and uses set_halt if it's missing. The comments 
surrounding usb_ep_set_wedge and usb_ep_ops also don't indicate that set_wedge 
is a must. 
As it has a fallback [through set_halt] it might therefore lead to the 
impression of being optional.

>From Alan's response I gather that it isn't optional and the fallback is only 
there for older drivers.

Hopefully Thomas [the original author] reads this. He would probably be able 
to implement the set_wedge function in a tiny fraction of the time I would 
need :-), as I don't really understand the inner workings of this.


Heiko
