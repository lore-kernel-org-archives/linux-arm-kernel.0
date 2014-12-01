From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 1 Dec 2014 11:36:58 +0100
Subject: [PATCH v3 0/3] SoCFPGA: L3 NIC driver
In-Reply-To: <20141201100858.GA17070@leverpostej>
References: <1417292052-12974-1-git-send-email-s.trumtrar@pengutronix.de>
 <20141201100858.GA17070@leverpostej>
Message-ID: <20141201103658.GE6184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark!

On Mon, Dec 01, 2014 at 10:08:58AM +0000, Mark Rutland wrote:
> On Sat, Nov 29, 2014 at 08:14:09PM +0000, Steffen Trumtrar wrote:
> > Hi!
> 
> Hi Steffen,
> 
> > This series adds support for the SoCFPGA L3 NIC. As the memory range has
> > a lot of holes, where you can not read from, syscon can not be used for
> > this IP core. Instead add a new driver, that knows about all the allowed
> > ranges and guards the access via regmap.
> 
> I note that while this series plumbs in a set of accessors (via regmap),
> there are no users as part of this series. What exactly do you intend to
> use these for? What is going to (re)program the bus, and how?
>

The first thing I want to use this for are the AXI bridges on the SoCFPGA.
These bridges connect the FPGA to the SoC.
I need to setup the visibility of the bridges on the L3, so that all L3
masters can access them.
Other things that can be configured are e.g.
	"(...) issuing capability of the preceding switch arbitration
	 scheme to multiple or single outstanding transactions."
for the USB0 host. So, this would belong into the USB driver AFAIK.
Meaning: every L3 AXI slave or master can flip some bits in this register
space.

> I also note that you mention this L3/L4 bus hierarchy is composed of a
> number of NIC-301s, rather than being a single custom IP block. If
> that's the case, it would seem like there should be a binding for the
> NIC-301, and the hierarchy should be described.
> 

I didn't mean to say that. The NIC-301 is one single IP core AFAICT. See:
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0397f/index.html

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
