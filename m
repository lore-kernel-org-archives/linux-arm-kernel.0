From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Feb 2013 14:12:38 +0200
Subject: [PATCH v9 8/9] usb: chipidea: tell platform layer the ci core
 probe's result
In-Reply-To: <20130227022202.GA20402@nchen-desktop>
References: <1361093083-22940-1-git-send-email-peter.chen@freescale.com>
 <1361093083-22940-9-git-send-email-peter.chen@freescale.com>
 <20130226094234.GC26189@arwen.pp.htv.fi>
 <20130227022202.GA20402@nchen-desktop>
Message-ID: <20130227121238.GE8016@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 27, 2013 at 10:22:03AM +0800, Peter Chen wrote:
> On Tue, Feb 26, 2013 at 11:42:34AM +0200, Felipe Balbi wrote:
> > On Sun, Feb 17, 2013 at 05:24:42PM +0800, Peter Chen wrote:
> > > If the probe fails, the ci13xxx_add_device will not return error,
> > > (bus_probe_device doesn't has return value)
> > > therefore, the platform layer can't know whether core's probe
> > > is successful or not, if platform layer goes on using core's struct
> > > which is initialized at core's probe, the error will occur.
> > > 
> > > This error is showed when I only compile gadget, the host-only
> > > controller reports "no supported roles", and fails probe, but imx
> > > platform code doesn't know it, and goes on using core's private data.
> > > 
> > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > 
> > this just tells you that platform code shouldn't be using the driver
> > directly. passing probe_retval via platform_data is an abomination, fix
> > the real problem instead, whatever it is.
> 
> So you suggest the platform glue layer should not use core driver's data
> directly, eg, for your dwc3, the platform glue layer should not use
> struct dwc3 *dwc directly? 

yes, and it doesn't. Ever.

> At dwc3-exynos.c,  it has code "exynos->dwc3    = dwc3;", so the exynos
> platform code may will use struct dwc3 in future. Besides, if the dwc3

nonsense. That's a structure platform_device which was created by the
glue, it has nothing to do with struct dwc3. struct platform_device
belongs to the glue, but there's an easy way to prevent that by using
device_for_each_child() on your ->remove() method.

> core driver's probe fails, the exynos platform code will not know it,
> the usb clk will be on on the usb can't be used.

so ? If the clock belongs to the glue, then the glue should enable it in
order to have access to its registers; if the clock belongs to the dwc3
core, then the glue is buggy; if the clock is shared between glue and
dwc3 core, then that's another bug, since nobody added clk handling code
to dwc3.

> If you suggest like above, we may need to add lots of notify function at

wrong. There's no need for any notification at all. A driver failing to
probe is just normal life. DWC3 is releasing all resources it allocated,
but the glue still needs the clock, then that's just the way it is.

There are many error messages which will tell the user that e.g. dwc3
failed to probe and user will just try again. If clocks are left
enabled, that's a bug in either core driver or glue layer which needs
fixing.

> core driver as there are many platform specific things, eg, special init/
> shutdown, suspend/resume, board layer gpio setting for vbus control (used

gpio handling should be done at board-file, that's a bug. You need to
add a fixed regulator which is toggled by a GPIO.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/a5bfa1e1/attachment.sig>
