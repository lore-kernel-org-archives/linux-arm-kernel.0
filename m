From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 Jul 2014 08:11:15 +0100
Subject: [RFC PATCH] usb: dwc3: core: allow vendor drivers to check probe
 status
In-Reply-To: <20140717172045.GM10459@saruman.home>
References: <1405617213-27360-1-git-send-email-lee.jones@linaro.org>
 <20140717172045.GM10459@saruman.home>
Message-ID: <20140718071115.GH30888@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Jul 2014, Felipe Balbi wrote:

> Hi,
> 
> On Thu, Jul 17, 2014 at 06:13:33PM +0100, Lee Jones wrote:
> > This patch provides mechanism for subordinate devices to check
> > whether the DWC3 core probed successfully or otherwise.  Useful
> > if PHYs are required to configure controllers, but aren't yet
> > available.  The DWC3 core driver will defer probe if PHYs are
> > unavailable, however subordinate DWC3 drivers currently do not
> > have any visibility or means to check status - until now.
> 
> what's a subordinate DWC3 driver ?
> 
> > Another way to do this would be to *_phy_get*(), but if every
> > driver did this it would create a high level of code
> > duplication.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/usb/dwc3/core.c | 12 ++++++++++++
> >  drivers/usb/dwc3/core.h |  1 +
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index eb69eb9..171ca52 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -47,6 +47,14 @@
> >  
> >  /* -------------------------------------------------------------------------- */
> >  
> > +static bool is_enabled = false;
> > +
> > +int dwc3_is_enabled(void)
> > +{
> > +	return is_enabled;
> > +}
> > +EXPORT_SYMBOL(dwc3_is_enabled);
> 
> no, no, no, no. Let me try that again, hello no! You _do_ realise there
> are systems with more than one dwc3 instance, right ? And this is the
> most fragile possible way of doing this.
> 
> You never explained what's a dwc3 subordinate driver, you don't show any
> example of how this would be used and why/where does the PHY need to
> poke into DWC3. Why isn't probe defer enough for you ? Which platform
> are you working on ? what is the problem that you're trying to solve ?
> 
> From this patch, all I can is NAK this patch with no mercy, sorry.

That's okay, I knew this was going to happen hence the RFC status of
the patch.  In the DT case, I describe 'subordinate devices' as are
drivers which register the DWC3 core using of_platform_populate(), 
so, for now:

  drivers/usb/dwc3/dwc3-exynos.c
  drivers/usb/dwc3/dwc3-keystone.c
  drivers/usb/dwc3/dwc3-omap.c

We're attempting to use the same process; however, at the moment we are
suffering with a 'boot order' issue.  If the PHYs aren't up and we
attempt to configure through the glue-layer our board locks up.  
Presumably waiting for a read to return, forever.  Whist the core does
the correct thing i.e. -EPROBE_DEFER, we (dwc3-st.c) have no way of
checking the return status of dwc3_probe().  As mentioned in the
commit message, another way of ensuring the PHYs are available is to
request them, but this would mean an awful lot of code duplication.

In your opinion, what's the best way to handle this?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
