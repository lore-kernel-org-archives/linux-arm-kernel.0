From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Feb 2013 15:42:19 +0200
Subject: [PATCH 1/9] USB otg: use try_module_get in all usb_get_phy
 functions and add missing module_put
In-Reply-To: <512E0247.8070808@pengutronix.de>
References: <1361968035-18644-1-git-send-email-mkl@pengutronix.de>
 <1361968035-18644-2-git-send-email-mkl@pengutronix.de>
 <20130227123132.GM8016@arwen.pp.htv.fi>
 <512DFED3.7070701@pengutronix.de>
 <20130227124333.GQ8016@arwen.pp.htv.fi>
 <512E001D.6060004@pengutronix.de>
 <20130227124739.GR8016@arwen.pp.htv.fi>
 <512E0247.8070808@pengutronix.de>
Message-ID: <20130227134219.GC23652@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 27, 2013 at 01:55:35PM +0100, Marc Kleine-Budde wrote:
> On 02/27/2013 01:47 PM, Felipe Balbi wrote:
> > On Wed, Feb 27, 2013 at 01:46:21PM +0100, Marc Kleine-Budde wrote:
> >> On 02/27/2013 01:43 PM, Felipe Balbi wrote:
> >>> Hi,
> >>>
> >>> On Wed, Feb 27, 2013 at 01:40:51PM +0100, Marc Kleine-Budde wrote:
> >>>> On 02/27/2013 01:31 PM, Felipe Balbi wrote:
> >>>>> On Wed, Feb 27, 2013 at 01:27:07PM +0100, Marc Kleine-Budde wrote:
> >>>>>> In patch "5d3c28b usb: otg: add device tree support to otg library"
> >>>>>> devm_usb_get_phy_by_phandle() was added. It uses try_module_get() to lock the
> >>>>>> phy driver in memory. The corresponding module_put() is missing in that patch.
> >>>>>>
> >>>>>> This patch adds try_module_get() to usb_get_phy() and usb_get_phy_dev().
> >>>>>> Further the missing module_put() is added to usb_put_phy().
> >>>>>>
> >>>>>> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>>>>> Acked-by: Felipe Balbi <balbi@ti.com>
> >>>>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >>>>>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >>>>>
> >>>>> this one doesn't apply to my tree. What did you use as a base ?
> >>>>
> >>>> As stated in the cover letter: Greg's usb-next.
> >>>>
> >>>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
> >>>>
> >>>> I'd really appreciate if this series goes into a single tree. So that
> >>>> other chipidea developers can base their work on this.
> >>>
> >>> it eventually will all go through Greg's queue, but drivers/usb/phy and
> >>> drivers/usb/otg/ needs to go through my tree so we avoid conflicts
> >>> later, sorry.
> >>
> >> Oh - this is going to be complicated. I'll rip the series into 3 parts
> >> and repost.
> > 
> > let's try like this:
> > 
> > drivers/usb/otg and drivers/usb/phy which don't create dependencies for
> > chipidea and other patches which create dependencies.
> > 
> > Then we can figure out how to handle the dependencies.
> > 
> 
> That'll be these 3 branches then:
> 
> otg-for-v3.9 (bugfix for v3.9):
> 6bef020 USB otg: use try_module_get in all usb_get_phy functions and add missing module_put
> 
> otg-for-v3.10 (depends on otg-for-v3.9):
> a0e17f5 USB: move bulk of otg/otg.c to phy/phy.c
> a6fc0d1 USB: add devicetree helpers for determining dr_mode and phy_type
> 8a4c9f8 USB mxs-phy: Register phy with framework
> 
> chipidea-for-v3.10 (most patches depend on otg-for-v3.10):
> 15c930e USB chipidea: ci13xxx-imx: create dynamic platformdata
> 9466e85 USB chipidea: add PTW and PTS handling
> ad2cc0d USB chipidea: introduce dual role mode pdata flags
> 8e7f1bb USB chipidea i.MX: introduce dr_mode property
> 5d83722 USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get phy

sounds good to me, please make sure to always split your series like
this. You can't expect me (or any maintainer for that matter) to pick
patches to proper branches based on your commit logs alone.

remeber that every single maintainer needs to handle hundreds of emails
a week (if not a day) and if patches are properly split and cleanly
mention if it's a bugfix or not, things will go wrong.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/f12178d2/attachment.sig>
