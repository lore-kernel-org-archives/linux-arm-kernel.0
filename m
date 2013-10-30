From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Oct 2013 00:11:37 +0000
Subject: [PATCH v3 02/10] spmi: Linux driver framework for SPMI
In-Reply-To: <149bbfe89e37376cc176c3aeb6c1fab9e4fd2b91.1382985169.git.joshc@codeaurora.org>
References: <cover.1382985169.git.joshc@codeaurora.org>
 <149bbfe89e37376cc176c3aeb6c1fab9e4fd2b91.1382985169.git.joshc@codeaurora.org>
Message-ID: <20131030001137.GW16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 01:12:35PM -0500, Josh Cartwright wrote:
> From: Kenneth Heitke <kheitke@codeaurora.org>
> 
> System Power Management Interface (SPMI) is a specification
> developed by the MIPI (Mobile Industry Process Interface) Alliance
> optimized for the real time control of Power Management ICs (PMIC).
> 
> SPMI is a two-wire serial interface that supports up to 4 master
> devices and up to 16 logical slaves.
> 
> The framework supports message APIs, multiple busses (1 controller
> per bus) and multiple clients/slave devices per controller.

I haven't read this in depth, but... if you want to support runtime PM
for your spmi devices, then I suggest that you also include the fragments
to setup runtime PM in the bus-level probe handler and clean it up in
the bus-level remove handler.

What that means is doing what PCI, AMBA and similar buses do:

	pm_runtime_get_noresume(dev);
	pm_runtime_set_active(dev);
	pm_runtime_enable(dev);

	ret = driver->probe(dev);
	if (ret != 0) {
		pm_runtime_disable(dev);
		pm_runtime_set_suspended(dev);
		pm_runtime_put_noidle(dev);
	}

and:

	pm_runtime_get_sync(dev);
	ret = driver->remove(dev);
	pm_runtime_put_noidle(dev);

	pm_runtime_disable(dev);
	pm_runtime_set_suspended(dev);
	pm_runtime_put_noidle(dev);

What this means is that your devices get runtime enabled by default,
but they have to do a pm_runtime_put() or similar in their probe
function to benefit from it and a balancing pm_runtime_get() in
their remove method.

The set_active() call above may need to be conditional upon whether
the device really is in a powered up state at that point or not.

Others have made comments on various other issues so I won't repeat
those points here.
