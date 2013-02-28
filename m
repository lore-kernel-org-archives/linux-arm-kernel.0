From: balbi@ti.com (Felipe Balbi)
Date: Thu, 28 Feb 2013 12:45:59 +0200
Subject: [PATCH v9 8/9] usb: chipidea: tell platform layer the ci core
 probe's result
In-Reply-To: <20130228100654.GC19516@nchen-desktop>
References: <1361093083-22940-9-git-send-email-peter.chen@freescale.com>
 <20130226094234.GC26189@arwen.pp.htv.fi>
 <20130227022202.GA20402@nchen-desktop>
 <20130227121238.GE8016@arwen.pp.htv.fi>
 <20130228031118.GA19387@nchen-desktop>
 <20130228072617.GB6154@arwen.pp.htv.fi>
 <20130228083143.GB19516@nchen-desktop>
 <20130228084933.GG6544@arwen.pp.htv.fi>
 <871uc0yeau.fsf@ashishki-desk.ger.corp.intel.com>
 <20130228100654.GC19516@nchen-desktop>
Message-ID: <20130228104559.GB22736@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 28, 2013 at 06:06:55PM +0800, Peter Chen wrote:
> > >> > > > > > > If the probe fails, the ci13xxx_add_device will not return error,
> > >> > > > > > > (bus_probe_device doesn't has return value)
> > >> > > > > > > therefore, the platform layer can't know whether core's probe
> > >> > > > > > > is successful or not, if platform layer goes on using core's struct
> > >> > > > > > > which is initialized at core's probe, the error will occur.
> > >> > > > > > > 
> > >> > > > > > > This error is showed when I only compile gadget, the host-only
> > >> > > > > > > controller reports "no supported roles", and fails probe, but imx
> > >> > > > > > > platform code doesn't know it, and goes on using core's private data.
> > >> > > > > > > 
> > >> > > > > > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > >> > > > > > 
> > >> > > > > > this just tells you that platform code shouldn't be using the driver
> > >> > > > > > directly. passing probe_retval via platform_data is an abomination, fix
> > >> > > > > > the real problem instead, whatever it is.
> > >> > > > > 
> > >> > > > > So you suggest the platform glue layer should not use core driver's data
> > >> > > > > directly, eg, for your dwc3, the platform glue layer should not use
> > >> > > > > struct dwc3 *dwc directly? 
> > >> > > > 
> > >> > > > yes, and it doesn't. Ever.
> > >> > > > 
> > >> > > 
> > >> > > If the dwc3 core fails to probe, but controller core clk is still on, is it
> > >> > > a valid case?
> > >> > 
> > >> > of course not, but then again, core clk shouldn't be handled by glue
> > >> > layer. You need to figure out who owns the clock, if it feeds DWC3 why
> > >> > would you clk_get() and clk_prepare_enable() from glue ? Makes no sense.
> > >> > 
> > >> 
> > >> Sorry? I can't find clk_prepare_enable at dwc3/core.c, but at dwc3 core, it
> > >> try to access register at probe, unless platform layer open the clock, how
> > >> can the core visit the core register.
> > >
> > > Is it really this difficult to figure out ? Fair enough, below are all
> > > the details:
> > >
> > > To understand the reason why dwc3/core.c doesn't know about struct clk,
> > > you need to consider where the driver was originally written; it was
> > > written on an OMAP platform (actually first on a virtual model OMAP -
> > > somewhat like QEMU -, than on a PCIe FPGA prototype of the IP, then
> > > ARM-based FPGA prototype, then OMAP5, none of which needed explicit
> > > clock control, see below).
> > >
> > > OMAP's PM is written in such a way that a pm_runtime_get() will enable
> > > the device the all clocks necessary to be usable. Since OMAP would never
> > > need to use clocks directly and I would never be able to test that code,
> > > I decided not to add it.
> > >
> > > Now, if dwc3-exynos needs it, the sane thing to do would be add struct
> > > clk knowledge to dwc3/core.c but make it optional. If there are no
> > > clocks available, don't bail out.
> > 
> > I'm not too familiar with the multitudes of platforms out there, but my
> > simple question is: why can't we have pm runtime take care of
> > enabling/disabling the clocks so that we don't have to do it in drivers?
> > Seems obvious that a platform/SoC/board should know about it's clock
> > tree structure, so why doesn't the platform code then take care of all
> > the dirty details?
> 
> I agree, clock stuffs should be handled at platform layer.
> For this corner case (core probe fails), if all of us
> agree with clock needs to be closed, we may need add some
> special handling.
> For runtime pm enabled, it is easy. we can set runtime pm active at
> fail path, as platform is parent of core, it will call
> platform's runtime suspend to do low power handling.

if core probe fails, we should still call pm_runtime_put_sync() and
pm_runtime_disable() and that should be enough to trigger your
->pm_domain->runtime_suspend() which can be used to turn off unnecessary
clocks.

> For runtime pm disabled, we may had to add some ugly things, like
> notify core probe fail, and platform layer needs to handle this failed
> notify.

Please stop talking about about "notify core probe fail" that will never
happen. Not today, not ever. Forget that idea.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130228/d2a08220/attachment.sig>
