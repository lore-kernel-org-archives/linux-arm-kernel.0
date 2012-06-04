From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Mon, 04 Jun 2012 13:30:24 +0200
Subject: [PATCH v2] usb: fsl_udc: errata - postpone freeing current dTD
In-Reply-To: <20120521190450.GA27492@arwen.pp.htv.fi>
References: <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <20120513225126.GA3683@lovely.krouter> <20120514042142.GD9750@kroah.com>
 <20120520231724.GA7941@mars>
 <F281D0F91ED19E4D8E63A7504E8A649803BB1E25@039-SN2MPN1-023.039d.mgd.msft.net>
 <1337583221.3394.21.camel@mars> <20120521065722.GA4363@mars>
 <20120521190450.GA27492@arwen.pp.htv.fi>
Message-ID: <1338809424.3371.20.camel@mars>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2012-05-21 at 22:04 +0300, Felipe Balbi wrote:
> On Mon, May 21, 2012 at 08:57:22AM +0200, Christoph Fritz wrote:
> > USB controller may access a wrong address for the dTD (endpoint transfer
> > descriptor) and then hang. This happens a lot when doing tests with
> > g_ether module and iperf, a tool for measuring maximum TCP and UDP
> > bandwidth.
> > 
> > This hardware bug is explained in detail by errata number 2858 for i.MX23:
> > http://cache.freescale.com/files/dsp/doc/errata/IMX23CE.pdf
> > 
> > All (?) SOCs with an IP from chipidea suffer from this problem.
> > mv_udc_core fixes this bug by commit daec765.  There still may be
> > unfixed drivers.
> > 
> > Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> > Signed-off-by: Christian Hemp <c.hemp@phytec.de>
> > ---
> >  drivers/usb/gadget/fsl_udc_core.c |   15 ++++++++++++++-
> >  1 files changed, 14 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
> > index 55abfb6..72f2139 100644
> > --- a/drivers/usb/gadget/fsl_udc_core.c
> > +++ b/drivers/usb/gadget/fsl_udc_core.c
> > @@ -65,6 +65,8 @@ static struct usb_sys_interface *usb_sys_regs;
> >  /* it is initialized in probe()  */
> >  static struct fsl_udc *udc_controller = NULL;
> >  
> > +static struct ep_td_struct *last_free_td;
> 
> I don't want to see global variables anymore. In fact, please convert
> this to the new udc_start()/udc_stop() calls and use the generic
> map/unmap routines.
> 
> That'll help you get rid of a bunch of useless code on the driver. After
> that you should remove all <asm/*> header includes and drop the ARCH
> dependency.
> 
> You can also drop the big-/little-endian helpers as you can make use of
> generic writel()/readl() routines.
> 
> Please make sure these series comes in with enough time to reach v3.6
> merge window in about 3 months.
> 
> You can put this fix together on that series after you drop the global.

Before I came to do the proposed changes, I stumbled upon this:

In file included from drivers/usb/gadget/fsl_udc_core.c:49:
drivers/usb/gadget/fsl_usb2_udc.h: In function ?get_qh_by_ep?:
drivers/usb/gadget/fsl_usb2_udc.h:585: error: ?struct fsl_ep? has no member named ?desc?
drivers/usb/gadget/fsl_udc_core.c: In function ?done?:
drivers/usb/gadget/fsl_udc_core.c:187: error: ?struct fsl_ep? has no member named ?desc?
drivers/usb/gadget/fsl_udc_core.c:187: error: ?struct fsl_ep? has no member named ?desc?
<snip>

my proposed regression patch:
---
From: Christoph Fritz <chf.fritz@googlemail.com>
Date: Mon, 4 Jun 2012 12:58:21 +0200
Subject: [PATCH] usb: gadget: regression fix - useage of usb_ep

This patch removes redundant pointer to struct usb_endpoint_descriptor which
were missed in commit 79149b8:

 usb: gadget: Update fsl_udc_core to use usb_endpoint_descriptor inside the
 struct usb_ep

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/usb/gadget/fsl_udc_core.c |    2 +-
 drivers/usb/gadget/fsl_usb2_udc.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 2831685..678ec4d 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -2575,7 +2575,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 	/* for ep0: the desc defined here;
 	 * for other eps, gadget layer called ep_enable with defined desc
 	 */
-	udc_controller->eps[0].desc = &fsl_ep0_desc;
+	udc_controller->eps[0].ep.desc = &fsl_ep0_desc;
 	udc_controller->eps[0].ep.maxpacket = USB_MAX_CTRL_PAYLOAD;
 
 	/* setup the udc->eps[] for non-control endpoints and link
diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
index 5cd7b7e..f61a967 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/fsl_usb2_udc.h
@@ -568,10 +568,10 @@ static void dump_msg(const char *label, const u8 * buf, unsigned int length)
 /*
  * ### internal used help routines.
  */
-#define ep_index(EP)		((EP)->desc->bEndpointAddress&0xF)
+#define ep_index(EP)		((EP)->ep.desc->bEndpointAddress&0xF)
 #define ep_maxpacket(EP)	((EP)->ep.maxpacket)
 #define ep_is_in(EP)	( (ep_index(EP) == 0) ? (EP->udc->ep0_dir == \
-			USB_DIR_IN ):((EP)->desc->bEndpointAddress \
+			USB_DIR_IN) : ((EP)->ep.desc->bEndpointAddress \
 			& USB_DIR_IN)==USB_DIR_IN)
 #define get_ep_by_pipe(udc, pipe)	((pipe == 1)? &udc->eps[0]: \
 					&udc->eps[pipe])
-- 
1.7.2.5
