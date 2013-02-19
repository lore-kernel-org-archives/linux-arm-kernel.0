From: balbi@ti.com (Felipe Balbi)
Date: Tue, 19 Feb 2013 21:32:37 +0200
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
In-Reply-To: <87ppzww1ux.fsf@linaro.org>
References: <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130214222247.GE11362@atomide.com>
 <alpine.DEB.2.00.1302191516150.32069@utopia.booyaka.com>
 <20130219163820.GF5724@atomide.com> <87ppzww1ux.fsf@linaro.org>
Message-ID: <20130219193237.GA8978@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 19, 2013 at 11:16:38AM -0800, Kevin Hilman wrote:

[ ... ]

> The other problem is the where reset is need during runtime.  Again,
> what are the specific examples here?  The one I can think of off the top
> of my head is I2C, where it's needed in certain error recovery
> scenarios.

right, I still have a theory that it's not needed in that case either,
though I haven't had time to try that out.

> Here, we need a way for the driver itself to initiate a full reset.
> Maybe a new runtime PM hook like ->runtime_reset() as Felipe has
> suggested (though I'm not yet sure runtime PM is the right place for
> this, since it's not strictly related to runtime PM).  Or, if these are

right, I agree with you but I couldn't think of a better place. Maybe we
need a reset hook in struct device itself (as I suggested on another
mail) but I'm not sure Greg would take it, unless we have a damn good
reason.

> mostly corner-case, error recovery scenarios, maybe a a way force the
> driver to remove itself and re-probe (which would trigger the
> bus-notifier based reset) as Tony has suggested is the better approach.

I don't think so. We certainly don't need to go through all memory
allocations again. That will just cause unnecessary memory
fragmentation.

> The OMAP I2C driver is doing a reset and fully re-initializing itself,
> so it seems the forced remove/probe is the right approach there.  Any

I must disagree here. Doing a reprobe of I2C every time there's an error
condition is overkill. It means freeing struct omap_i2c_dev, freeing its
IRQ, freeing the ioremapped area, changing mux configuration (due to
pinctrl calls) just to do it all over again. Besides omap_i2c_probe()
calls omap_i2c_init() which will do the full IP reset anyway.

The difference is that calling omap_i2c_init() directly doesn't force us
to free and reallocate all resources all over again.

> one have the other use cases handy?

dwc3 gets reset during probe() too, but that has an IP specific reset
which doesn't need SYSCONFIG register for that.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130219/4311af94/attachment.sig>
