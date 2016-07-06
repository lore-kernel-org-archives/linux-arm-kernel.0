From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 Jul 2016 14:48:58 +0100
Subject: [PATCH v2] xen/arm: register clocks used by the hypervisor
In-Reply-To: <alpine.DEB.2.10.1607061412370.26575@sstabellini-ThinkPad-X260>
References: <1467282752-14053-1-git-send-email-dirk.behme@de.bosch.com>
 <146776885213.35356.11565744417822933094@resonance>
 <577D035C.7090504@arm.com>
 <alpine.DEB.2.10.1607061412370.26575@sstabellini-ThinkPad-X260>
Message-ID: <20160706134858.GA475@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2016 at 02:16:18PM +0100, Stefano Stabellini wrote:
> On Wed, 6 Jul 2016, Julien Grall wrote:
> > On 06/07/16 02:34, Michael Turquette wrote:
> > > Hi!
> > 
> > Hello Michael,
> > 
> > > Quoting Dirk Behme (2016-06-30 03:32:32)
> > > > Some clocks might be used by the Xen hypervisor and not by the Linux
> > > > kernel. If these are not registered by the Linux kernel, they might be
> > > > disabled by clk_disable_unused() as the kernel doesn't know that they
> > > > are used. The clock of the serial console handled by Xen is one
> > > > example for this. It might be disabled by clk_disable_unused() which
> > > > stops the whole serial output, even from Xen, then.
> > > 
> > > This whole thread had me confused until I realized that it all boiled
> > > down to some nomenclature issues (for me).
> > > 
> > > This code does not _register_ any clocks. It simply gets them and
> > > enables them, which is what every other clk consumer in the Linux kernel
> > > does. More details below.
> > > 
> > > > 
> > > > Up to now, the workaround for this has been to use the Linux kernel
> > > > command line parameter 'clk_ignore_unused'. See Xen bug
> > > > 
> > > > http://bugs.xenproject.org/xen/bug/45
> > > 
> > > clk_ignore_unused is a band-aid, not a proper medical solution. Setting
> > > that flag will not turn clocks on for you, nor will it guarantee that
> > > those clocks are never turned off in the future. It looks like you
> > > figured this out correctly in the patch below but it is worth repeating.
> > > 
> > > Also the new CLK_IS_CRITICAL flag might be of interest to you, but that
> > > flag only exists as a way to enable clocks that must be enabled for the
> > > system to function (hence, "critical") AND when those same clocks do not
> > > have an accompanying Linux driver to consume them and enable them.
> > 
> > I don't think we want the kernel to enable the clock for the hypervisor. We
> > want to tell the kernel "don't touch at all to this clock, it does not belong
> > to you".
> 
> Right, and that's why I was suggesting that another way to do this would
> be to set the "status" to "disabled" in Xen: so that Linux would leave
> the clock alone. But in that case Linux would not be happy to see
> disabled clocks which are actually supposed to be used by some devices.

If you were to do that, that would cover the entire clock-controller,
not necessarily for the individual clock line (as this does not
necessarily have a node of its own). So you'd prevent the use of other
clocks owned by that controller.

That's also not sufficient, as you'd have to do the same for resources
required to keep that clock active (parent clocks from different
controllers, regulators, GPIOs, etc).

I don't think that will work other than in very basic cases.

Thanks,
Mark.
