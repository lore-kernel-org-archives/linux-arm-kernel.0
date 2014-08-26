From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Aug 2014 16:17:16 +0200
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <E1XMHGc-0008TS-CQ@jdl.com>
References: <20140826084208.AE5F0C40989@trevor.secretlab.ca>
 <20140826084922.GG17263@ulmo> <53FC566C.30904@ahsoftware.de>
 <20140826102503.GC31124@ulmo> <53FC6513.5040800@ahsoftware.de>
 <20140826110827.GA31350@ulmo> <53FC6E4A.6030407@ahsoftware.de>
 <20140826114718.GB641@ulmo> <53FC76E8.5050009@ahsoftware.de>
 <E1XMHGc-0008TS-CQ@jdl.com>
Message-ID: <20140826141714.GA3027@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 08:58:34AM -0500, Jon Loeliger wrote:
> > >>
> > >> Drivers don't provide that information (dependencies) in any usable way. And
> > >> as you said yourself, it's already contained in phandles. So what we are
> > >> discussing here about? The proposal to use phandles for that is already on
> > >> the table since several month. ;)
> > >>
> > >> Sorry, but I don't understand what you want to propose.
> > >
> > > In many cases we simply don't know where phandles are stored since we
> > > don't have the type information in DT. But drivers already know the type
> > > of a specific phandle and where to get it from, so the proposal is to
> > > make that knowledge more generally useful so that it can be used for
> > > dependency resolution.
> > 
> > How?
> 
> Is the issue around which we are dancing here the timing of
> topsort and the probing?  When the driver is probed, sure, it
> touches and resolves a bunch of phandles and references other
> nodes and devices.  But that is at probe time, and it only has
> the context of itself then.
> 
> I think we need to do the complete topsort *before* we attempt
> to do any probing.  So three steps:
> 
>     1) Graph Construction
>         Add a new "emit dependencies" function to driver bindings.
>         Iterate over known devices or nodes in the DT in any order.
> 	    Call the "emit dependencies" function.  It adds all
> 	    dependency edges to a global graph by knowing what
> 	    phandles or other pieces it will need.
> 	    A driver with no "emit dependencies" function can be
> 	    added to the graph anywhere without loss of generality.
>         Add any additional edges for whatever reason.
> 
>     2) Topsort the generated driver graph
> 
>     3) Call probe for real in topsort order

Yes, I think that makes a lot of sense. We need to provide a way to make
the dependency information available before probe time, otherwise we
don't gain anything. Whether we provide that in a form of a function
call or a table is an implementation detail.

I do think that requiring drivers to provide a function is going to make
things more complicated than necessary since that "emit dependencies"
function would need to copy a lot of the things that .probe() does
already. Sharing this information in a table sounds like a good idea. An
"emit dependencies" function in the core can use that data to resolve
dependencies whereas the driver core can equally use that information to
request the devices so that the drivers don't have to do so.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/24b5d790/attachment.sig>
