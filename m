From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 30 Dec 2012 00:23:01 +0000
Subject: Kirkwood issues with 3.8-rc1 - Ooops and hang on reboot
In-Reply-To: <CAMW5UfaPv=Rq64MVtJNsdt8L4+0bq=cvbw5nqFBEcjY_+3cHZA@mail.gmail.com>
References: <20121228171749.GA6152@lunn.ch>
 <20121228173818.GD24604@n2100.arm.linux.org.uk>
 <CAMW5UfaPv=Rq64MVtJNsdt8L4+0bq=cvbw5nqFBEcjY_+3cHZA@mail.gmail.com>
Message-ID: <20121230002301.GA2631@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 29, 2012 at 06:31:37PM -0500, Josh Coombs wrote:
> Bah, didn't send to everyone last time...
> 
> Building with CONFIG_DEBUG_SECTION_MISMATCH enabled, the only warning
> I get is for drivers/w1/masters/w1-gpio.o.
> 
> WARNING: drivers/w1/masters/w1-gpio.o(.data+0x0): Section mismatch in
> reference from the variable w1_gpio_driver to the function
> .init.text:w1_gpio_probe()
> The variable w1_gpio_driver references
> the function __init w1_gpio_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> Shouldn't I be seeing a warning for
> drivers/clk/mvebu/clk-gating-ctrl.o at this point as well?

Unfortunately not.  mvebu_clk_gating_get_src() is referenced by another
__init function, which is registering the pointer to
mvebu_clk_gating_get_src() into other code.  That reference (obviously
from the oops dump) persists past the point where the __init sections
are freed.

Hence why no section mismatch warning issued from the static tools;
they're not infallible.

> Josh C
> 
> On Fri, Dec 28, 2012 at 12:38 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Dec 28, 2012 at 06:17:49PM +0100, Andrew Lunn wrote:
> >> Hi Josh
> >>
> >> What compiler version are you using to get the opps?
> >
> > It's a section mismatch warning.  Just look at the code line and compare
> > it with the disassembly.  Oh, the code line indicates that the code is
> > no longer present.  Why would that be?
> >
> > static struct clk __init *mvebu_clk_gating_get_src(
> >                   ^^^^^^
> >         struct of_phandle_args *clkspec, void *data)
> > {
> >         struct mvebu_gating_ctrl *ctrl = (struct mvebu_gating_ctrl *)data;
> >
> > maybe?
