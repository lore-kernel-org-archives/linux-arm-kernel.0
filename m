From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 25 Aug 2014 16:41:28 +0200
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <E1XLv1z-0002Jv-VN@jdl.com>
References: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>
 <20140514141914.446F7C4153D@trevor.secretlab.ca>
 <20140821140211.GD19293@ulmo.nvidia.com>
 <53F64624.5000403@ahsoftware.de>
 <20140822131919.GX21734@leverpostej> <20140825093931.GB2399@ulmo>
 <E1XLu15-0002DP-6o@jdl.com> <20140825133714.GH4163@ulmo.nvidia.com>
 <E1XLv1z-0002Jv-VN@jdl.com>
Message-ID: <20140825144125.GB14763@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 09:13:59AM -0500, Jon Loeliger wrote:
> > 
> > 
> > > I believe some of the issues that need to be resolved are:
> > >
> > >     1) What constitutes a dependency?
> > >     2) How is that dependency expressed?
> > >     3) How do we add missing dependencies?
> > >     4) Backward compatability problems.
> > >
> > > There are other questions, of course.  Is it a topsort
> > > per bus?  Are there required "early devices"?  Should
> > > the inter-node dependencies be expressed at each node,
> > > or in a separate hierarchy within the DTS?  Others.
> > 
> > I think Grant already objected to the idea of explicitly adding
> > dependency information into the device tree sources.
> 
> Clearly, the reason to object to the introdcution of such
> an artificial dependency implies that it would be trying
> to express something that doesn't actually describe an
> existing hardware requirement.  That is, it wouldn't be
> "describing hardware".  That's fine.
> 
> But the inverse should also be true.  That is, we should
> ensure that where there *is* a hardware dependency that
> is currently not expressed, we should introduce that
> relationship.

Agreed. Any dependency currently not expressed probably indicates that
the device tree isn't complete yet and is a result of us coming up with
device trees as we go.

Using phandles to describe dependencies makes a lot of sense. As I
understand it the original intent was for OpenFirmware to use phandle to
resolve a "service provider" and call functions that it provided. That's
exactly what we need in Linux, too. Deferred probe is usually triggered
when one device's driver needs to access services provided by a device
that hasn't been registered yet. The way to find such a service provider
is by looking up the phandle (really the struct device_node representing
the referenced node) in a subsystem-specific registry.

Therefore it should be possible to resolve all dependencies at boot time
using nothing but the phandles.

> > For regulators (and regulator-like bindings) the problem is somewhat
> > more difficult because they property names are not standardized. One way
> > to solve this would be to look for property names with a -supply suffix,
> > but that could obviously lead to false positives. One alternative that I
> > think could eliminate this would be to explicitly list dependencies in
> > drivers. This would allow core code to step through such a list and
> > resolve the (phandle, specifier) tuples.
> 
> So, express the "additional SW dependencies" in the SW?

Well, not really. They aren't additional dependencies. The problem is
that if we want to use only phandle references to resolve dependencies
(which is a requirement if we don't want to rely on DT to provide extra
metadata), then we need to know what exactly is a phandle. Since the
final DTB will only have a u32 where a phandle was once referenced, we
need to provide the driver core with some way to recover that lost
information. And the best place to do that really is the driver, because
it implements the binding, hence knows exactly what property and cell in
that property contains a phandle value.

So what we'd be expressing in software is hints as to where to find the
list of dependencies.

In addition to that, a lot of boiler-plate code could be eliminated in
drivers by using that same metadata to automatically request the
resources.

> > Clocks are usually not a problem with deferred probing since they often
> > are registered early anyway.
> 
> Ah, but how are they known to be needed early?  A toposort should sort
> them into that position.  That's not currently done.  And I doubt the
> set of nodes and expressed dependencies would cause them to be done
> early enough by today's standards.

They aren't really regular device drivers but rather registered using an
explicit initcall. Clock providers are even initialized before initcalls
are run. The reason is that they are often required for things like SMP
or by other non-driver code that needs to run very early.

> > Regulators on the other hand seem to be a fairly common trigger,
> > though, so they seem like a good candidate to focus on.
> 
> Yeah.  And I've seen some debatable IRQ-PHY-PCIe interaction too.

There are probably a couple of these that can be easily identified and
would eliminate a large percentage of deferred probe triggers already.
I found a link to Arnd's original proposal[0] for the devm_probe()
infrastructure and I think that could serve as a useful basis for this.

I would imagine that embedding a pointer to the devm_probe structure
into a struct device_driver and extending it with a way to resolve the
dependencies could work well.

Thierry

[0]: http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/209031.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140825/acd38f90/attachment.sig>
