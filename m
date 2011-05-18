From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 May 2011 01:23:17 +0100
Subject: device_tree binding for "amba bus"
In-Reply-To: <64ff6672-0ce3-475b-b1c7-dc18bf2c2658@VA3EHSMHS005.ehs.local>
References: <f9ae780a-2747-427f-826a-e0b510ca8afb@VA3EHSMHS001.ehs.local>
	<20110517224134.GC2266@n2100.arm.linux.org.uk>
	<64ff6672-0ce3-475b-b1c7-dc18bf2c2658@VA3EHSMHS005.ehs.local>
Message-ID: <20110518002317.GE5913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2011 at 05:05:12PM -0700, Stephen Neuendorffer wrote:
> In drivers/amba/bus.c:
> 
> static int amba_get_enable_pclk(struct amba_device *pcdev)
> {
> 	struct clk *pclk = clk_get(&pcdev->dev, "apb_pclk");
> 
> static int amba_get_enable_vcore(struct amba_device *pcdev)
> {
> 	struct regulator *vcore = regulator_get(&pcdev->dev, "vcore");
> 
> So users of this bus have to have a clock and a regulator with those
> exact names.
> Is it your expectation that the clock/regulator names are standardized
> across arch/arm?

Let's fix one thing here.

The second argument to clk_get is *not* a unique clock name.  It is a
_connection_ name for the device, to distinguish between different
clocks on the same device.  It does not identify _any_ particular
clock on its own.

> And a little grepping suggests that almost all of the machines that
> possibly use this don't do anything useful with it (just implementing
> duplicated dummy code so that "apb_pclk" has something to refer to).

apb_pclk is the _bus_ clock for the device, which must be enabled for
any register access to the device, including the Primecell ID registers.
Most platforms do not have any facilities to control this clock, but
there are some which do.

One of those which does is the ST stuff:

> mach-u300/clock.c: * The MMCI apb_pclk is hardwired to the same terminal
> as the
> mach-u300/clock.c: * The SPI apb_pclk is hardwired to the same terminal
> as the
> mach-u300/clock.c:      DEF_LOOKUP_CON("intcon", "apb_pclk",
> &intcon_clk),
> mach-u300/clock.c:      DEF_LOOKUP_CON("pl172", "apb_pclk", &emif_clk),
> mach-u300/clock.c:      DEF_LOOKUP_CON("mmci", "apb_pclk", &mmcsd_clk),
> mach-u300/clock.c:      DEF_LOOKUP_CON("pl022", "apb_pclk", &spi_clk),
> mach-u300/clock.c:      DEF_LOOKUP_CON("uart1", "apb_pclk",
> &uart1_pclk),
> mach-u300/clock.c:      DEF_LOOKUP_CON("uart0", "apb_pclk",
> &uart0_pclk),

For these, they gate the bus clock along with the functional clock for the
device.  The side effect of that is using the clock enable points in the
driver-based code which are designed for the functional clock results in
the bus clock being turned off, and then the driver tries to access the
device registers - resulting in the device not being accessible.

So, we decided to separate out this bus clock, call it 'apb_pclk' (it's the
ARM Primecell Bus, PCLK input on the device) and allow platforms which have
this problem to deal with it _without_ having to add ifdefs or other shite
to all the drivers.

Note that you need to turn on this very clock to even read the IDs out of
the device, in order to match the driver.  So, it really doesn't make
sense for the driver to do it when the bus level code which understands
the extraction of the IDs needs to fiddle with it anyway.

I didn't want to go around _all_ the primecell drivers adding yet another
probe step, failure path in the probe function, and additional call in
their remove functions - every additional thing which needs to be done
in order is another thing that can get out of order or be forgotten in
the failure cleanup path.

The ST devices can alias the apb_pclk to the functional clock, thereby
ensuring that while the device needs to be accessible, both the device PCLK
and functional clock remain enabled.  Meanwhile others which don't allow
the PCLK to be turned on and off can control their functional clock as the
driver desires.

I hope this helps to understand what's going on here.

I think what we have today is an elegant solution to the problem
presented by some SoCs.
