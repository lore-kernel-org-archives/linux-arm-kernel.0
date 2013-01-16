From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 16 Jan 2013 09:48:57 +0800
Subject: [PATCH v2 1/4] ARM i.MX6: use reserved bit for mxs phy clock gate
In-Reply-To: <20130116011845.GB16514@nchen-desktop>
References: <1358230117-19443-1-git-send-email-peter.chen@freescale.com>
 <20130115113313.GB32113@S2101-09.ap.freescale.net>
 <20130116011845.GB16514@nchen-desktop>
Message-ID: <20130116014855.GA8118@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 09:18:46AM +0800, Peter Chen wrote:
> On Tue, Jan 15, 2013 at 07:33:16PM +0800, Shawn Guo wrote:
> > On Tue, Jan 15, 2013 at 02:08:34PM +0800, Peter Chen wrote:
> > > For mxs-phy user i.mx6q, the PHY's clock is controlled by
> > > hardware automatically, the software only needs to enable it
> > > at probe, disable it at remove. During the runtime,
> > > we don't need to control it. So for the usbphy clk policy:
> > > 
> > > - Keep refcount for usbphy as clk framework needs to know if
> > > it is off or on.
> > 
> > Just checked the reference manual, it seems that not only bit 6
> > (EN_USB_CLKS) but also bit 12 (POWER) are controlled by USB hardware.
> > If this is true, I think that PLL3 and PLL7 are really designed for
> > USB PHY use only.  Do you actually see other real users of these two
> > PLLs on imx6q besides USB PHY?  If not, we can just provide a dummy
> > clock to mxs-phy driver on imx6q, and keep real clocks usbphy1 and
> > usbphy2 there for platform init function to enable them if USB support
> > is built in.  Then, we can save all these dirty hacks.  Thoughts?
> It was my v1 patch did.
> 
I thought it might be okay to access anatop for enabling the clock in
usb driver.  But I found it's just too ugly to do that when I look at
the code a little bit closer.  I prefer to keep clock driver unchanged
and just call clk_prepare_enable() at platform level to enable the
clock.  I really dislike the code accessing anatop for enabling the
clock.  That's the part different from you v1 patch.

> I send the v2 patch due to below reasons,
> There are other PLL3 users, it is better keep refcount
> to all its children, or the user will be confused when the
> PLL3 goes to disable, but the usb otg part is still used
> 
This is the part I'm not sure how it works.  You said, the PLL will be
managed by hardware during USB suspend/resume.  I assume that it means
the PLL will be powered off when USB suspends and be powered on when
USB resumes.  If that's the case, how other users of the PLL work when
PLL is powered off by USB hardware.

Shawn

> For PLL7, we can do it, and let the PLL7 be out of clock framework
> management.
> 
> But I still think keep usbphy as PLL child is better solution,
> in that case, the clock maintainer can know the real clock usage.
> 
