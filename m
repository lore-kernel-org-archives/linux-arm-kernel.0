From: roger.pau@citrix.com (Roger Pau =?iso-8859-1?Q?Monn=E9?=)
Date: Mon, 23 Jan 2017 10:43:17 +0000
Subject: [Xen-devel] [RFC] Device memory mappings for Dom0 on ARM64 ACPI
 systems
In-Reply-To: <alpine.DEB.2.10.1701201445210.10192@sstabellini-ThinkPad-X260>
References: <20170118110243.ctqpperggim5k7dw@dhcp-3-221.uk.xensource.com>
 <alpine.DEB.2.10.1701181058110.10192@sstabellini-ThinkPad-X260>
 <20c89f12-cb0c-1145-99d0-320b2080b503@arm.com>
 <20170119154129.7dnjzvq23jop7oye@dhcp-3-221.uk.xensource.com>
 <alpine.DEB.2.10.1701191002330.10192@sstabellini-ThinkPad-X260>
 <94e89cb4-f40c-585e-b3e8-d9f8f58b53d9@arm.com>
 <20170120110114.2ajkmmhxhhbc6acl@dhcp-3-221.uk.xensource.com>
 <a40dda2b-e6f3-3222-9b56-9208d96ce5d0@arm.com>
 <20170120142426.eqs2n23ugrz2f6v5@dhcp-3-221.uk.xensource.com>
 <alpine.DEB.2.10.1701201445210.10192@sstabellini-ThinkPad-X260>
Message-ID: <20170123104317.6viptotrv3abztto@dhcp-3-221.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 02:53:34PM -0800, Stefano Stabellini wrote:
> On Fri, 20 Jan 2017, Roger Pau Monn? wrote:
> > > > > So you need DOM0 to tell the list of regions.
> > > > 
> > > > Yes, I agree that we need such hypercall ATM, although I think that we might be
> > > > able to get rid of it in the long term if we are able to parse the AML tables
> > > > from Xen.
> > > 
> > > Are you suggesting to bring a full AML parser in Xen? If so, it will be much
> > > bigger than Xen ARM itself. I would need a strong use case to accept a such
> > > thing.
> > 
> > It could be placed in the init section, and get rid of it after boot. Also, I
> > find it hard to believe that an AML parser is bigger than the whole Xen on ARM.
> > The OpenBSD folks have a DSDT parser in ~4000 lines of code [0], and that's
> > probably way more than what Xen actually needs.
> 
> Even if it were actually possible, 4 KLOC is a significant increase in
> code size, given that last time I counted Xen on ARM was under 90 KLOC.
> Regardless, some AML methods have side effects. I don't know if the plan
> of accessing some AML in Xen, then remapping tables and accessing them
> again in Dom0 is actually sound. I don't think the spec supports it.

Sure, Xen wouldn't be allowed to execute any AML method (so it's probably even
less than 4KLOC, if the code is ripped). But Xen would be able to discover
OperationRegions. In any case this is future work, and the hypercall route
seems the most sensible one right now, we could always return -EEXIST if Xen
starts mapping all this on behalf of the hardware domain at some point.

I just wanted to point this out because I think the claims that have been made
about AML parsers being bigger than Xen itself are not true, and discarding
them based on size only is not reasonable.

Roger.
