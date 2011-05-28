From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 May 2011 00:46:14 +0100
Subject: IrDA driver fails on PXA255
In-Reply-To: <alpine.DEB.2.00.1105281628480.9934@chino.kir.corp.google.com>
References: <20110528205701.GA1788@doriath.ww600.siemens.net>
	<alpine.DEB.2.00.1105281628480.9934@chino.kir.corp.google.com>
Message-ID: <20110528234614.GV24876@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 28, 2011 at 04:34:07PM -0700, David Rientjes wrote:
> The driver is attempting to allocate DMA memory and you have 
> CONFIG_ZONE_DMA disabled, which is the only reason you would get this 
> warning.  If the allocation did not fail as a result of a197b59ae6e8, the 
> page allocator may return any memory in a higher zone that the driver may 
> not be expecting.  If you had never noticed a problem before, it may be 
> possible that the driver doesn't actually have any zone restrictions and 
> GFP_DMA can be removed, but this code is pretty old.  Otherwise, it'll 
> need to depend on ZONE_DMA in the Kconfig.
> 
> Let's cc Nicolas and Russell as well.

Ouch.  We're probably going to have a pile of work to do to check that
the DMA masks on all our devices are correct for the unrestricted case
then.  That's probably going to be a very _big_ patch.
