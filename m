From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 14 Sep 2012 16:29:30 +0100
Subject: [PATCH v4 14/24] xen/arm: initialize grant_table on ARM
In-Reply-To: <1347635324.24226.229.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
 <1347621207-11294-14-git-send-email-stefano.stabellini@eu.citrix.com>
 <20120914131033.GM25249@phenom.dumpdata.com>
 <alpine.DEB.2.02.1209141550080.29232@kaball.uk.xensource.com>
 <1347635324.24226.229.camel@zakaz.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1209141624570.29232@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Sep 2012, Ian Campbell wrote:
> On Fri, 2012-09-14 at 15:56 +0100, Stefano Stabellini wrote:
> > On Fri, 14 Sep 2012, Konrad Rzeszutek Wilk wrote:
> > > On Fri, Sep 14, 2012 at 12:13:16PM +0100, Stefano Stabellini wrote:
> > > > Initialize the grant table mapping at the address specified at index 0
> > > > in the DT under the /xen node.
> > > > After the grant table is initialized, call xenbus_probe (if not dom0).
> > > 
> > > So we don't really care about the grant's size then? The DT xen.txt
> > > talks about it..
> > 
> > I am assuming that the size of the memory region specified in the device
> > tree is sufficiently large to map the entire grant table, given that both
> > the device tree hypervisor entry and the grant table size comes from Xen.
> 
> Actually, the grant table can grow dynamically under the control of the
> guest, I think you just pass GNTTABOP_setup_table with some more frames.
> See drivers/xen/grant_table.c:gnttab_expand().

gnttab_expand can return error if the new size exceeds
gnttab_max_grant_frames(), that is implemented using
GNTTABOP_query_size.


> > The grant table size is currently queried to Xen directly via an
> > hypercall (GNTTABOP_query_size). Basically the size in the device tree
> > is redundant information.
> 
> This size is the size of the physical address space where the guest
> could chose map grant table frames. It could be either larger or smaller
> than the actual grant table. (smaller because the guest could use
> physical addresses not within this region, if it wanted to for some
> reason).

Right.

What I am saying is that I assume that the memory region specified in
the device tree is greater or equal than gnttab_max_grant_frames().
Maybe I should add this to the device tree doc.
