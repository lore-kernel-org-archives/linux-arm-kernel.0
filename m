From: tony@atomide.com (Tony Lindgren)
Date: Sun, 4 Aug 2013 23:36:55 -0700
Subject: [Ksummit-2013-discuss] [ATTEND] [ARM ATTEND] kernel data bloat
 and how to avoid it
In-Reply-To: <20130802195730.6450.84988@quantum>
References: <20130731073802.GT7656@atomide.com>
 <20130731123351.GA30474@kroah.com>
 <20130802075352.GY7656@atomide.com>
 <20130802195730.6450.84988@quantum>
Message-ID: <20130805063654.GM7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mike Turquette <mturquette@linaro.org> [130802 13:04]:
> Quoting Tony Lindgren (2013-08-02 00:53:53)
> > People are unnecessarily defining registers in kernel for similar devices
> > over and over again for each new SoC at the arch level and now more and
> > more at the driver level.
> > 
> > One example of that are device tree based drivers that don't describe
> > the actual hardware, but instead have a binding that points to an index
> > of defined registers in the driver.
> 
> Apologies for possibly hijacking this thread, but this issue keeps me up
> at night. People use DT for different things and have different ideas
> about its Purpose In The World.
> 
> Tony wants to move data out of the kernel, which was the impetus behind
> the OMAP DT clock patches that describes every single clock in a DT node
> (around 250 clocks). This create very large dts, but reduces the clock
> drivers to pure logic, no data.

Yes that should eventually allow "booting new hardware with old
kernels".. But ideally with clocks we should support any combination of
DT defined clocks and /lib/firmware defined clocks should be allowed to
avoid bloating the DT files. We should be able to boot to user space
with a pretty minimal set of clocks, and deal with the PM related settings
based on SoC specific data from /lib/firmware.
 
> Other folks are motivated only to get rid of board files and platform
> data hacks. They keep all of the clock data in the clock driver and
> instead use DT only as a way to hook up clocks to devices via a simple
> mapping, thus describing how individual boards or SoC variants are set
> up outside of the kernel source. dts remains small, essentially just an
> array to map bindings but all of the clock data remains in the kernel.

Right, that just moves the real problem to drivers and then it will
eventually suck up all your maintainer time with constant churn to patch
that data for various SoC revisions :)
 
> Both approaches have their merits and drawbacks. Is it possible to
> gather consensus on selecting a single approach? For the clock subsystem
> I've accepted drivers and DT bindings which do either. I simply do not
> have the DT experience or sensibilities to draw a line in the sand...
> and maybe I should not draw a line in the sand and just let people pick
> whichever approach they prefer (which maintains the status quo).
> 
> If the ARM Summit figures out all the answers then please let me know
> what they are :-)

Well I think it's been discussed many times earlier and it should be
clear that Linus wants this kind of data out of the kernel. So maybe
we could establish some kind of set of standards for the maintainers
to follow.

Regards,

Tony
