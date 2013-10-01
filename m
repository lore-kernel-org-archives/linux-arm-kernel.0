From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Oct 2013 13:09:18 -0400
Subject: [PATCH v2] bus: mvebu-mbus: Fix optional pcie-mem/io-aperture
 properties
In-Reply-To: <20131001165045.GB23874@obsidianresearch.com>
References: <20130917201104.GA5209@obsidianresearch.com>
 <20131001164409.GC31178@titan.lakedaemon.net>
 <20131001165045.GB23874@obsidianresearch.com>
Message-ID: <20131001170918.GF31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 10:50:45AM -0600, Jason Gunthorpe wrote:
> On Tue, Oct 01, 2013 at 12:44:09PM -0400, Jason Cooper wrote:
> > On Tue, Sep 17, 2013 at 02:11:04PM -0600, Jason Gunthorpe wrote:
> > > If the property was not specified then then the returned resource
> > > had a resource_size(..) == 1, rather than 0. The PCI-E driver checks
> > > for 0 so it blindly continues on with a corrupted resource.
> > > 
> > > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > >  drivers/bus/mvebu-mbus.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > Applied to mvebu/drivers since you didn't mention a specific regression.
> > If there is one, please let me know shortly and I'll try to queue it up
> > for v3.12 instead.
> 
> If the DT is not formed exactly how the driver expects it goes
> sideways. The kernel DT's are all OK.
> 
> Was the PCI driver new in 3.12?
> 
> If so it should probably be fixed in 3.12 as well, since this
> sequence in the PCI driver:
> 
>    mvebu_mbus_get_pcie_io_aperture(&pcie->io);
>    if (resource_size(&pcie->io) == 0) {
>       dev_err(&pdev->dev, "invalid I/O aperture size\n");
>       return -EINVAL;
>    }
> 
> Doesn't work.

Ok, I've moved it over the mvebu/fixes and amended the commit as
follows:

"""
    bus: mvebu-mbus: Fix optional pcie-mem/io-aperture properties
    
    If the property was not specified then the returned resource had a
    resource_size(..) == 1, rather than 0. The PCI-E driver checks for 0 so it
    blindly continues on with a corrupted resource.
    
    The regression was introduced into v3.12 by:
    
      11be654 PCI: mvebu: Adapt to the new device tree layout
    
"""

> This patch is a necessary precondition to applying:
> 
> https://github.com/jgunthorpe/linux/commit/ef90b0bf7d8552dc7dfaad82d964446f6a9b6a3b
> PCI: mvebu - Support a bridge with no IO port window

I don't see this one in my stack, have you submitted it yet?  When you
do, please add a note mentioning the dependency on this commit in
mvebu/fixes.

thx,

Jason.
