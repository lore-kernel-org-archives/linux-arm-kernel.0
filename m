From: Paul.Zimmerman@synopsys.com (Paul Zimmerman)
Date: Fri, 6 Dec 2013 22:23:39 +0000
Subject: [PATCH v2 1/5] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <52A24425.7030802@ti.com>
References: <1386187811-9596-1-git-send-email-w-kwok2@ti.com>
 <1386187811-9596-2-git-send-email-w-kwok2@ti.com>
 <20131206202844.GG21086@saruman.home> <52A24425.7030802@ti.com>
Message-ID: <A2CA0424C0A6F04399FB9E1CD98E030458E2F0D7@US01WEMBX2.internal.synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: linux-usb-owner at vger.kernel.org [mailto:linux-usb-owner at vger.kernel.org] On Behalf Of Santosh Shilimkar
> Sent: Friday, December 06, 2013 1:40 PM
> 
> On Friday 06 December 2013 03:28 PM, Felipe Balbi wrote:
> > Hi,
> >
> > On Wed, Dec 04, 2013 at 03:10:07PM -0500, WingMan Kwok wrote:
> >> Add Keystone platform specific glue layer to support
> >> USB3 Host mode.
> >>
> >> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> Cc: Felipe Balbi <balbi@ti.com>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> >> ---
> >>  drivers/usb/dwc3/Kconfig         |    7 ++
> >>  drivers/usb/dwc3/Makefile        |    1 +
> >>  drivers/usb/dwc3/dwc3-keystone.c |  210 ++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 218 insertions(+)
> >>  create mode 100644 drivers/usb/dwc3/dwc3-keystone.c
> 
> [..]
> 
> >> +static irqreturn_t dwc3_keystone_interrupt(int irq, void *_kdwc)
> >> +{
> >> +	struct dwc3_keystone	*kdwc = _kdwc;
> >> +
> >> +	spin_lock(&kdwc->lock);
> >
> > Isn't this lock unnecessary ? This handler will run with IRQs disabled
> > anyway.
> >
> Indeed.

Say what? AFAIK it's necessary to take the driver lock inside the interrupt
handler, because of SMP. Here is the equivalent routine from dwc3-omap.c:

static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
{
        struct dwc3_omap        *omap = _omap;
        u32                     reg;

        spin_lock(&omap->lock);

        ...
}

Has this now become unnecessary?

-- 
Paul
