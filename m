From: stephen.neuendorffer@xilinx.com (Stephen Neuendorffer)
Date: Tue, 17 May 2011 17:05:12 -0700
Subject: device_tree binding for "amba bus"
In-Reply-To: <20110517224134.GC2266@n2100.arm.linux.org.uk>
References: <f9ae780a-2747-427f-826a-e0b510ca8afb@VA3EHSMHS001.ehs.local>
	<20110517224134.GC2266@n2100.arm.linux.org.uk>
Message-ID: <64ff6672-0ce3-475b-b1c7-dc18bf2c2658@VA3EHSMHS005.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Tuesday, May 17, 2011 3:42 PM
> To: Stephen Neuendorffer
> Cc: grant.likely at secretlab.ca; devicetree-discuss at lists.ozlabs.org;
linux-arm-
> kernel at lists.infradead.org
> Subject: Re: device_tree binding for "amba bus"
> 
> On Tue, May 17, 2011 at 01:28:33PM -0700, Stephen Neuendorffer wrote:
> > None of this seems terribly interesting enough to justify a bus that
has
> > a small number of users:
> 
> However, without this infrastructure, drivers have to start doing
those
> three points you bring up themselves, manually, with additional code,
> which makes for additional bugs.  No thanks.  Let's keep the bus
> abstraction there as it serves to ensure that the right things happen
> at the right time.
>
> > And at the very least the hardcoded nature of the names seems,
well...
> > hardcoded.
> 
> What hardcoded names?  Driver names no matter what bus are part of the
> _userspace_ API - remember that almost everything in the device model
> is exported to userspace and is therefore part of the kernel's
userspace
> API.  So logically the driver names do want to be stable.

In drivers/amba/bus.c:

static int amba_get_enable_pclk(struct amba_device *pcdev)
{
	struct clk *pclk = clk_get(&pcdev->dev, "apb_pclk");

static int amba_get_enable_vcore(struct amba_device *pcdev)
{
	struct regulator *vcore = regulator_get(&pcdev->dev, "vcore");

So users of this bus have to have a clock and a regulator with those
exact names.
Is it your expectation that the clock/regulator names are standardized
across arch/arm?

And a little grepping suggests that almost all of the machines that
possibly use
this don't do anything useful with it (just implementing duplicated
dummy code
so that "apb_pclk" has something to refer to).

[stephenn at xsjfox4 arm]$ grep -r apb_pclk mach-*
mach-bcmring/core.c:static struct clk dummy_apb_pclk = {
mach-bcmring/core.c:            .con_id = "apb_pclk",
mach-bcmring/core.c:            .clk = &dummy_apb_pclk,
mach-ep93xx/clock.c:    INIT_CK(NULL,                   "apb_pclk",
&clk_p),
mach-integrator/core.c:static struct clk dummy_apb_pclk;
mach-integrator/core.c:         .con_id         = "apb_pclk",
mach-integrator/core.c:         .clk            = &dummy_apb_pclk,
mach-mxs/clock-mx23.c:  _REGISTER_CLOCK("duart", "apb_pclk", xbus_clk)
mach-mxs/clock-mx28.c:  _REGISTER_CLOCK("duart", "apb_pclk", xbus_clk)
mach-nomadik/clock.c:           .con_id         = "apb_pclk",
mach-omap2/clock3xxx_data.c:static struct clk dummy_apb_pclk = {
mach-omap2/clock3xxx_data.c:    .name           = "apb_pclk",
mach-omap2/clock3xxx_data.c:    CLK(NULL,       "apb_pclk",
&dummy_apb_pclk,        CK_3XXX),
mach-realview/core.c:static struct clk dummy_apb_pclk;
mach-realview/core.c:           .con_id         = "apb_pclk",
mach-realview/core.c:           .clk            = &dummy_apb_pclk,
mach-spear3xx/clock.c:static struct clk dummy_apb_pclk;
mach-spear3xx/clock.c:  { .con_id = "apb_pclk", .clk = &dummy_apb_pclk},
mach-spear6xx/clock.c:static struct clk dummy_apb_pclk;
mach-spear6xx/clock.c:  { .con_id = "apb_pclk", .clk = &dummy_apb_pclk},
mach-u300/clock.c: * The MMCI apb_pclk is hardwired to the same terminal
as the
mach-u300/clock.c: * The SPI apb_pclk is hardwired to the same terminal
as the
mach-u300/clock.c:      DEF_LOOKUP_CON("intcon", "apb_pclk",
&intcon_clk),
mach-u300/clock.c:      DEF_LOOKUP_CON("pl172", "apb_pclk", &emif_clk),
mach-u300/clock.c:      DEF_LOOKUP_CON("mmci", "apb_pclk", &mmcsd_clk),
mach-u300/clock.c:      DEF_LOOKUP_CON("pl022", "apb_pclk", &spi_clk),
mach-u300/clock.c:      DEF_LOOKUP_CON("uart1", "apb_pclk",
&uart1_pclk),
mach-u300/clock.c:      DEF_LOOKUP_CON("uart0", "apb_pclk",
&uart0_pclk),
mach-ux500/clock.c:static struct clk clk_dummy_apb_pclk = {
mach-ux500/clock.c:     .name = "apb_pclk",
mach-ux500/clock.c:     CLK(dummy_apb_pclk, NULL,       "apb_pclk"),
mach-versatile/core.c:static struct clk dummy_apb_pclk;
mach-versatile/core.c:          .con_id         = "apb_pclk",
mach-versatile/core.c:          .clk            = &dummy_apb_pclk,
mach-vexpress/v2m.c:static struct clk dummy_apb_pclk;
mach-vexpress/v2m.c:            .con_id         = "apb_pclk",
mach-vexpress/v2m.c:            .clk            = &dummy_apb_pclk,


My thinking (at least with respect to these) was that clock sources and
regulators could
be represented by nodes in the device tree and if a device required a
particular clock
source to be enabled that it would declare that in the device tree.
This would enable
reusing the existing etb driver (more or less) in a device tree platform
(mach-zynq).
Basically, it seems to me that if amba_bus does something useful, then
its utility should
be generalized into the generic platform_bus, which would enable it to
be used with
device trees, rather than building device tree specific code to enable
amba_bus.

Note that for arch/arm/kernel/etm.c, there is apparently another clock
that *isn't* handled by amba_bus
that it manages internally:

 	t->emu_clk = clk_get(&dev->dev, "emu_src_ck");
 	if (IS_ERR(t->emu_clk)) {
 		dev_dbg(&dev->dev, "Failed to obtain emu_src_ck.\n");
 		ret = -EFAULT;
		goto out;
 	}

This could be handled automatically by a more general abstraction of the
clock dependencies
of an arbitrary driver.

> > Any thoughts about how to abstract this in a device tree?
> > (My thoughts: devices need to reference a clock, devices need to
> > reference a regulator,
> > and it seems to me that the register check could be pulled out into
a
> > single call that the
> > devices that care about it can do themselves during probe() )
> 
> And another during their remove callback - and where do they store the
> data associated with that?  Will the drivers need to have a certain
> base driver_data structure?
>
> This all sounds like getting rather icky and prone to bugs.

I guess I was assuming that it would happen automatically in whatever
generic code would understand
the clocks and regulators in the first place?  (Note that I'm *NOT*
suggesting that the
driver be responsible for the things above, which seem to be
'fundamental infrastructure' 
things.)  I'm suggesting a way of reducing the amount of extra
machine-specific code,
while doing more or less what amba_bus does today.

The *other* thing that amba_bus does is validate the peripheral_id,
which seems to me to
be something that a driver could perhaps do for itself by calling a
validation function
in probe() rather than bothering to export it top amba_bus?

Forgive me if these are stupid questions, but I'm trying hard to figure
out to use the
driver code that is there without adding a bunch of new (duplicated, do
nothing)
machine-specific code to meet the assumptions of amba_bus.

Steve


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
