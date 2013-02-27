From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 27 Feb 2013 10:22:03 +0800
Subject: [PATCH v9 8/9] usb: chipidea: tell platform layer the ci core
 probe's result
In-Reply-To: <20130226094234.GC26189@arwen.pp.htv.fi>
References: <1361093083-22940-1-git-send-email-peter.chen@freescale.com>
 <1361093083-22940-9-git-send-email-peter.chen@freescale.com>
 <20130226094234.GC26189@arwen.pp.htv.fi>
Message-ID: <20130227022202.GA20402@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 11:42:34AM +0200, Felipe Balbi wrote:
> On Sun, Feb 17, 2013 at 05:24:42PM +0800, Peter Chen wrote:
> > If the probe fails, the ci13xxx_add_device will not return error,
> > (bus_probe_device doesn't has return value)
> > therefore, the platform layer can't know whether core's probe
> > is successful or not, if platform layer goes on using core's struct
> > which is initialized at core's probe, the error will occur.
> > 
> > This error is showed when I only compile gadget, the host-only
> > controller reports "no supported roles", and fails probe, but imx
> > platform code doesn't know it, and goes on using core's private data.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> 
> this just tells you that platform code shouldn't be using the driver
> directly. passing probe_retval via platform_data is an abomination, fix
> the real problem instead, whatever it is.

So you suggest the platform glue layer should not use core driver's data
directly, eg, for your dwc3, the platform glue layer should not use
struct dwc3 *dwc directly? 
At dwc3-exynos.c,  it has code "exynos->dwc3    = dwc3;", so the exynos
platform code may will use struct dwc3 in future. Besides, if the dwc3
core driver's probe fails, the exynos platform code will not know it,
the usb clk will be on on the usb can't be used.

If you suggest like above, we may need to add lots of notify function at
core driver as there are many platform specific things, eg, special init/
shutdown, suspend/resume, board layer gpio setting for vbus control (used
at id switch), probe fail, etc.	

-- 

Best Regards,
Peter Chen
