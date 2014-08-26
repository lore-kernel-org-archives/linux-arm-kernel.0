From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Aug 2014 12:24:05 +0200
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <20140826101107.GC32315@leverpostej>
References: <20140821140211.GD19293@ulmo.nvidia.com>
 <53F64624.5000403@ahsoftware.de>
 <20140822131919.GX21734@leverpostej> <20140825093931.GB2399@ulmo>
 <E1XLu15-0002DP-6o@jdl.com> <20140825133714.GH4163@ulmo.nvidia.com>
 <20140826084208.AE5F0C40989@trevor.secretlab.ca>
 <20140826084922.GG17263@ulmo> <53FC566C.30904@ahsoftware.de>
 <20140826101107.GC32315@leverpostej>
Message-ID: <20140826102404.GB31124@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 11:11:07AM +0100, Mark Rutland wrote:
> On Tue, Aug 26, 2014 at 10:42:04AM +0100, Alexander Holler wrote:
> > Am 26.08.2014 10:49, schrieb Thierry Reding:
> > > On Tue, Aug 26, 2014 at 09:42:08AM +0100, Grant Likely wrote:
> > >> On Mon, 25 Aug 2014 15:37:16 +0200, Thierry Reding <thierry.reding@gmail.com> wrote:
> > > [...]
> > >>> There are somewhat standardized bindings for the above and especially
> > >>> for bindings of the type that clocks implement this is trivial. We can
> > >>> simply iterate over each (phandle, specifier) tuple and check that the
> > >>> corresponding clock provider can be resolved (which typically means that
> > >>> it's been registered with the common clock framework).
> > >>>
> > >>> For regulators (and regulator-like bindings) the problem is somewhat
> > >>> more difficult because they property names are not standardized. One way
> > >>> to solve this would be to look for property names with a -supply suffix,
> > >>> but that could obviously lead to false positives. One alternative that I
> > >>> think could eliminate this would be to explicitly list dependencies in
> > >>> drivers. This would allow core code to step through such a list and
> > >>> resolve the (phandle, specifier) tuples.
> > >>
> > >> False positives and negatives may not actually be a problem. It is
> > >> suboptimal, certainly, but it shouldn't outright break the kernel.
> > >
> > > There could be cases where some random integer in a cell could be
> > > interpreted as a phandle and resolve to a struct device_node. I suppose
> > > it might be unlikely, but not impossible, that the device_node could
> > > even match a device in the correct subsystem and you'd get a wrong
> > > dependency. Granted, a wrong dependency may not be catastrophic in that
> > > it won't lead to a crash, but it could lead to various kinds of
> > > weirdness and hard to diagnose problems.
> > 
> > You need either the type information in the DTB (that's why I've add 
> > those "dependencies" to identify phandles), or you need to know every 
> > binding (at "dependency-resolve-time" to identify phandles.
> 
> While having type information in the DTB would be fantastic, it's not
> something we can expect from the systems already in the wild, and I
> worry how it would interact with bootloaders that modify the DTB (I
> don't know if any modify properties with phandles).
> 
> > The latter is impracticable to implement in a generic way (for use
> > with every possible binding).
> 
> I don't think we necessarily need dependency information for every
> binding and driver. We only need dependency information where a device
> has a dependency on another device and we don't currently have an
> explicit probe ordering guaranteed by Linux.
> 
> Where a device driver lacks dependency information and fails to probe,
> we can fall back to the current deferred probing.
> 
> Do we have any worst case example systems / drivers / dts?

Cc'ing St?phane who's brought this up not long ago. There seem to be
cases where display initialization can be delayed up to 5-6 seconds due
to deferred probing (where the system would otherwise take 5-6 seconds
to boot).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/7ca6c75a/attachment-0001.sig>
