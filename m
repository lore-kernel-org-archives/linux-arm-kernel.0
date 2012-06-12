From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jun 2012 15:08:01 +0100
Subject: [linux-next] "clk: add non CONFIG_HAVE_CLK routines" commit
In-Reply-To: <CAOh2x=mFOPKbzuY__k0RVpFHTdPfa-iN1e3Lpa3iWt9iP6FzFw@mail.gmail.com>
References: <20120522234621.GA3610@windriver.com>
 <CAOh2x=mFOPKbzuY__k0RVpFHTdPfa-iN1e3Lpa3iWt9iP6FzFw@mail.gmail.com>
Message-ID: <20120612140801.GA7918@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 11:57:07AM +0100, viresh kumar wrote:
> struct clk *clk_get(struct device *dev, const char *id)
> {
> 	return dev && strcmp(dev_name(dev), "fb") == 0 ? NULL : ERR_PTR(-ENOENT);
> }
> 
> I can remove first four without any issues, but just can't remove the
> last one.  The dummy clk_get() always returns NULL, whereas this one
> returns NULL only for fb device.

This isn't a totally dummy clk implementation.  What it's doing is returning
a dummy clock for the framebuffer, and explicitly failing everything else
(because we have no need to support any other clocks.)

If we want to use the dummy clk stuff in its entirety, and just return the
dummy clock for all clk_get()s on this platform, then there isn't a problem.
If we want to keep this behaviour, we need to use clkdev with the dummy
clk implementation.
