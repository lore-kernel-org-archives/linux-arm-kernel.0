From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 26 Sep 2014 09:31:27 +0200
Subject: [PATCH v5 00/11] PM / Domains: Generic OF-based support
In-Reply-To: <7hppej8glk.fsf@deeprootsystems.com>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <20140925112122.GA22753@ulmo> <7hppej8glk.fsf@deeprootsystems.com>
Message-ID: <20140926073125.GB31106@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 03:45:11PM -0700, Kevin Hilman wrote:
> Thierry Reding <thierry.reding@gmail.com> writes:
> 
> > I just noticed these patches because they conflicted with some of the
> > local patches I had to add a very similar framework. One of the reasons
> > why I hadn't posted these publicly yet is because the platform where I
> > want to use this (Tegra) is somewhat quirky when it comes to power
> > domains.
> >
> > On Tegra these domains are called power gates and they currently have
> > their own API. We've been looking at migrating things over to some
> > generic framework for some time and PM domains do seem like a good fit.
> > However one of the quirks regarding these domains on Tegra is that a
> > fixed sequence exists that needs to be respected when enabling or
> > disabling a power partition. The exact sequence can be found in the
> > drivers/soc/tegra/pmc.c driver's tegra_powergate_sequence_power_up()
> > function. Essentially we need to call into the clock and reset drivers
> > at very specific moments during the operations that the PMC does.
> >
> > One solution to this would be to make the needed clocks and resets
> > available to the power domain driver via DT, but then we have the
> > problem that two drivers would be controlling the same resources. For
> > example drivers could still want to disable the clock for more fine-
> > grained power management. 
> 
> I think you're on the right path here.  You can get rid of this conflict
> by removing the direct/manual clock management from the drivers, and
> using runtime PM instead: s/clk_enable/pm_runtime_get_sync/,
> s/clk_disable/pm_runtime_put_sync/.  When using runtime PM, those calls
> trickle down through the power domain driver, which can manage the
> device clocks, as well as any additional clocks and resets needed for
> power gating.

Okay. The DT part of it is going to be pretty nasty (as usual) because
we currently have the clocks and resets within the device's device tree
node (which I think is where they really belong).

So one possibility would be to move the clocks and resets to the power
domain controller's node, like so:

	pmc at ... {
		power-domains {
			...

			sata at ... {
				clocks = <&tegra_car 124>;
				resets = <&tegra_car 124>;
			};
		};
	};

An alternative would be to make the power-domain controller look up the
clock within the user's device tree node. That could be problematic,
because while the module clock is always the first clock in current
device trees, there aren't ordering guarantees, so we'd have to rely on
the clock name.

> > Furthermore for some devices it may turn out that turning the domain
> > off and on introduces too much latency to be useful.
> 
> In these cases, you should use the per-device PM QoS framework to set
> per-device latencies.  Then your power-domain can look up these
> latencies and decide whether or not to actually power gate or not.

Does this allow fine-grained control over what parts of the "power
domain" get disabled? For example some drivers may want to only turn off
the clock under some circumstances, which would keep the hardware state,
whereas in other situations or drivers it might be fine to completely
turn off the power partition and reset the hardware block (loosing all
hardware state).

Keeping a reference to the clock in the power domain will prevent that
from working since the driver itself won't be able to disable the
hardware clock.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/a664e87a/attachment.sig>
