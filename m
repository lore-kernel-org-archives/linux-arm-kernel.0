From: balbi@ti.com (Felipe Balbi)
Date: Wed, 13 Mar 2013 10:43:36 +0200
Subject: [RFC PATCH 2/3] usb: udc: delete the vbus indicator at
 individual driver
In-Reply-To: <20130313074918.GB18168@nchen-desktop>
References: <1363078999-7361-1-git-send-email-peter.chen@freescale.com>
 <1363078999-7361-2-git-send-email-peter.chen@freescale.com>
 <20130312094649.GC15163@arwen.pp.htv.fi>
 <20130313031042.GA18168@nchen-desktop>
 <20130313074409.GE5374@arwen.pp.htv.fi>
 <20130313074918.GB18168@nchen-desktop>
Message-ID: <20130313084336.GD6270@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 03:49:19PM +0800, Peter Chen wrote:
> On Wed, Mar 13, 2013 at 09:44:09AM +0200, Felipe Balbi wrote:
> > On Wed, Mar 13, 2013 at 11:10:43AM +0800, Peter Chen wrote:
> > > On Tue, Mar 12, 2013 at 11:46:49AM +0200, Felipe Balbi wrote:
> > > > On Tue, Mar 12, 2013 at 05:03:18PM +0800, Peter Chen wrote:
> > > > > Let the common struct usb_gadget own it.
> > > > > 
> > > > > CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > > > CC: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > > > > CC: Li Yang <leoli@freescale.com>
> > > > > CC: Roland Stigge <stigge@antcom.de>
> > > > > CC: Yu Xu <yuxu@marvell.com>
> > > > > CC: Chao Xie <chao.xie@marvell.com>
> > > > > CC: Eric Miao <eric.y.miao@gmail.com>
> > > > > CC: Ben Dooks <ben-linux@fluff.org>
> > > > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > > 
> > > > you need to split this patch, should be something like below:
> > > > 
> > > > for_each_driver() {
> > > > 	initialize gadget->vbus_active (don't remove private method)
> > > > }
> > > > 
> > > > add vbus_active support to udc-core
> > > > 
> > > > for_each_driver() {
> > > > 	remove driver's private vbus_active method
> > > > }
> > > > 
> > > > you need one patch per driver so it's easy to review and ack.
> > > 
> > > Eg, If I changed 10 udc drivers, I need
> > > 1(add vbus_active to struct usb_gadget) + 10 + 1 + 10 = 22 patches?
> > 
> > in order to keep possible regressions localized to a single driver.
> > Imagine if you cause a regression on omap_udc, then we decide to revert
> > your patch. All other drivers, which can be correct will loose the
> > change as well.
> 
> I agree, why we can't merge below two steps into one step, if there
> are problems for single driver, we also need to revert one patch.

indeed, that might be doable and might look better.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130313/a8ac6a15/attachment.sig>
