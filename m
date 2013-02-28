From: balbi@ti.com (Felipe Balbi)
Date: Thu, 28 Feb 2013 09:26:17 +0200
Subject: [PATCH v9 8/9] usb: chipidea: tell platform layer the ci core
 probe's result
In-Reply-To: <20130228031118.GA19387@nchen-desktop>
References: <1361093083-22940-1-git-send-email-peter.chen@freescale.com>
 <1361093083-22940-9-git-send-email-peter.chen@freescale.com>
 <20130226094234.GC26189@arwen.pp.htv.fi>
 <20130227022202.GA20402@nchen-desktop>
 <20130227121238.GE8016@arwen.pp.htv.fi>
 <20130228031118.GA19387@nchen-desktop>
Message-ID: <20130228072617.GB6154@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 28, 2013 at 11:11:20AM +0800, Peter Chen wrote:
> On Wed, Feb 27, 2013 at 02:12:38PM +0200, Felipe Balbi wrote:
> > Hi,
> > 
> > On Wed, Feb 27, 2013 at 10:22:03AM +0800, Peter Chen wrote:
> > > On Tue, Feb 26, 2013 at 11:42:34AM +0200, Felipe Balbi wrote:
> > > > On Sun, Feb 17, 2013 at 05:24:42PM +0800, Peter Chen wrote:
> > > > > If the probe fails, the ci13xxx_add_device will not return error,
> > > > > (bus_probe_device doesn't has return value)
> > > > > therefore, the platform layer can't know whether core's probe
> > > > > is successful or not, if platform layer goes on using core's struct
> > > > > which is initialized at core's probe, the error will occur.
> > > > > 
> > > > > This error is showed when I only compile gadget, the host-only
> > > > > controller reports "no supported roles", and fails probe, but imx
> > > > > platform code doesn't know it, and goes on using core's private data.
> > > > > 
> > > > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > > 
> > > > this just tells you that platform code shouldn't be using the driver
> > > > directly. passing probe_retval via platform_data is an abomination, fix
> > > > the real problem instead, whatever it is.
> > > 
> > > So you suggest the platform glue layer should not use core driver's data
> > > directly, eg, for your dwc3, the platform glue layer should not use
> > > struct dwc3 *dwc directly? 
> > 
> > yes, and it doesn't. Ever.
> > 
> > > At dwc3-exynos.c,  it has code "exynos->dwc3    = dwc3;", so the exynos
> > > platform code may will use struct dwc3 in future. Besides, if the dwc3
> > 
> > nonsense. That's a structure platform_device which was created by the
> > glue, it has nothing to do with struct dwc3. struct platform_device
> > belongs to the glue, but there's an easy way to prevent that by using
> > device_for_each_child() on your ->remove() method.
> 
> Sorry, I just thought it may use platform_get_drvdata(exynos->dwc3) to
> get core data if exynos has special suspend/resume routine, and need
> to visit dwc3 register.

that would be utterly wrong and has caused many issues before (see
MUSB). Glue shouldn't know anything about the core IP.

> > There are many error messages which will tell the user that e.g. dwc3
> > failed to probe and user will just try again. If clocks are left
> > enabled, that's a bug in either core driver or glue layer which needs
> > fixing.
> > 
> 
> If the dwc3 core fails to probe, but controller core clk is still on, is it
> a valid case?

of course not, but then again, core clk shouldn't be handled by glue
layer. You need to figure out who owns the clock, if it feeds DWC3 why
would you clk_get() and clk_prepare_enable() from glue ? Makes no sense.

> > > core driver as there are many platform specific things, eg, special init/
> > > shutdown, suspend/resume, board layer gpio setting for vbus control (used
> > 
> > gpio handling should be done at board-file, that's a bug. You need to

I mean "shouldn't"

> > add a fixed regulator which is toggled by a GPIO.
> 
> I think I need to move vbus regulator from platform code to core code as we have
> struct otg at core data, and vbus operation is common operation.

right

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130228/45becb7a/attachment.sig>
