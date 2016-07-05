From: sstabellini@kernel.org (Stefano Stabellini)
Date: Tue, 5 Jul 2016 15:04:40 +0100 (BST)
Subject: [PATCH v2] xen/arm: register clocks used by the hypervisor
In-Reply-To: <577BBC1A.8020209@arm.com>
References: <1467282752-14053-1-git-send-email-dirk.behme@de.bosch.com>
 <alpine.DEB.2.10.1607051449370.2575@sstabellini-ThinkPad-X260>
 <577BBC1A.8020209@arm.com>
Message-ID: <alpine.DEB.2.10.1607051456410.2575@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Jul 2016, Julien Grall wrote:
> On 05/07/16 14:53, Stefano Stabellini wrote:
> > On Thu, 30 Jun 2016, Dirk Behme wrote:
> > > +- clocks: one or more clocks to be registered.
> > > +  Xen hypervisor drivers might replace native drivers, resulting in
> > > +  clocks not registered by these native drivers. To avoid that these
> > > +  unregistered clocks are disabled, then, e.g. by clk_disable_unused(),
> > > +  register them in the hypervisor node.
> > > +  An example for this are the clocks of the serial driver. If the clocks
> > > +  used by the serial hardware interface are not registered by the serial
> > > +  driver the serial output might stop once clk_disable_unused() is
> > > called.
> > 
> > What if we use the "status" property of the clocks? Could we set it to
> > "disabled" in Xen? Would that be enough for Linux to leave them alone?
> 
> clocks could be shared between multiple devices. So it is not possible to
> disable the clock.

To clarify my suggestion: I am not saying we should disable the clock, I
am saying we should set the "status" property to "disabled" in Xen for
the clock used by the serial or passthrough devices (for which the
"status" property is already set to "disabled"). That should work for
cases where the clock is not shared among multiple devices.

If the clock is shared, then I don't think we would run into the issue
described by Dirk because I wouldn't imagine clk_disable_unused would
try to disable the clock anymore, because it would actually be in use
from Linux POV.
