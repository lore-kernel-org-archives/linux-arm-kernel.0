From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 28 Feb 2013 16:31:44 +0800
Subject: [PATCH v9 8/9] usb: chipidea: tell platform layer the ci core
 probe's result
In-Reply-To: <20130228072617.GB6154@arwen.pp.htv.fi>
References: <1361093083-22940-1-git-send-email-peter.chen@freescale.com>
 <1361093083-22940-9-git-send-email-peter.chen@freescale.com>
 <20130226094234.GC26189@arwen.pp.htv.fi>
 <20130227022202.GA20402@nchen-desktop>
 <20130227121238.GE8016@arwen.pp.htv.fi>
 <20130228031118.GA19387@nchen-desktop>
 <20130228072617.GB6154@arwen.pp.htv.fi>
Message-ID: <20130228083143.GB19516@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 09:26:17AM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Feb 28, 2013 at 11:11:20AM +0800, Peter Chen wrote:
> > On Wed, Feb 27, 2013 at 02:12:38PM +0200, Felipe Balbi wrote:
> > > Hi,
> > > 
> > > On Wed, Feb 27, 2013 at 10:22:03AM +0800, Peter Chen wrote:
> > > > On Tue, Feb 26, 2013 at 11:42:34AM +0200, Felipe Balbi wrote:
> > > > > On Sun, Feb 17, 2013 at 05:24:42PM +0800, Peter Chen wrote:
> > > > > > If the probe fails, the ci13xxx_add_device will not return error,
> > > > > > (bus_probe_device doesn't has return value)
> > > > > > therefore, the platform layer can't know whether core's probe
> > > > > > is successful or not, if platform layer goes on using core's struct
> > > > > > which is initialized at core's probe, the error will occur.
> > > > > > 
> > > > > > This error is showed when I only compile gadget, the host-only
> > > > > > controller reports "no supported roles", and fails probe, but imx
> > > > > > platform code doesn't know it, and goes on using core's private data.
> > > > > > 
> > > > > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > > > 
> > > > > this just tells you that platform code shouldn't be using the driver
> > > > > directly. passing probe_retval via platform_data is an abomination, fix
> > > > > the real problem instead, whatever it is.
> > > > 
> > > > So you suggest the platform glue layer should not use core driver's data
> > > > directly, eg, for your dwc3, the platform glue layer should not use
> > > > struct dwc3 *dwc directly? 
> > > 
> > > yes, and it doesn't. Ever.
> > > 
> > 
> > If the dwc3 core fails to probe, but controller core clk is still on, is it
> > a valid case?
> 
> of course not, but then again, core clk shouldn't be handled by glue
> layer. You need to figure out who owns the clock, if it feeds DWC3 why
> would you clk_get() and clk_prepare_enable() from glue ? Makes no sense.
> 

Sorry? I can't find clk_prepare_enable at dwc3/core.c, but at dwc3 core, it
try to access register at probe, unless platform layer open the clock, how
can the core visit the core register.


-- 

Best Regards,
Peter Chen
