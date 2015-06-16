From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 16 Jun 2015 13:49:50 -0500
Subject: [PATCH Part1 v11 4/5] PCI: xgene: Use pci_scan_root_bus()
 instead of pci_create_root_bus()
In-Reply-To: <CACoXjcnZG9+oyc43G2NM1tvrZycMGiQFHm2E27+1Q_8_Vu9aEQ@mail.gmail.com>
References: <1430204499-19571-1-git-send-email-wangyijing@huawei.com>
 <1430204499-19571-5-git-send-email-wangyijing@huawei.com>
 <20150527154758.GU32152@google.com>
 <CACoXjcnZG9+oyc43G2NM1tvrZycMGiQFHm2E27+1Q_8_Vu9aEQ@mail.gmail.com>
Message-ID: <20150616184950.GA7710@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Duc, Loc]

On Wed, May 27, 2015 at 10:21:40AM -0700, Tanmay Inamdar wrote:
> On Wed, May 27, 2015 at 8:47 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > On Tue, Apr 28, 2015 at 03:01:38PM +0800, Yijing Wang wrote:
> >> Pci_bus_add_devices() was ripped out of pci_scan_root_bus().
> >> Now pci_scan_root_bus() == pci_create_root_bus() +
> >> pci_scan_child_bus() if busn resource is supplied.
> >> Xgene added the busn resource to resources list
> >> in of_pci_get_host_bridge_resources(). So it should be safe
> >> to use pci_scan_root_bus() instead.
> >>
> >> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> >> CC: Tanmay Inamdar <tinamdar@apm.com>
> >
> > Tanmay, any comments on this?
> >
> 
> Looks good to me.
> 
> Acked-by: Tanmay Inamdar <tinamdar@apm.com>

I had applied this, but dropped it because it conflicted with Duc's
MSI patch, which adds a call to xgene_pcie_msi_enable() between
pci_create_root_bus() and pci_scan_child_bus().

We should figure out a better way to do this, e.g., with
pci_host_bridge_ops, so we can use pci_scan_root_bus() on X-Gene.  But we
don't have that yet.

> >> ---
> >>  drivers/pci/host/pci-xgene.c |    3 +--
> >>  1 files changed, 1 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> >> index ee082c0..87e3962 100644
> >> --- a/drivers/pci/host/pci-xgene.c
> >> +++ b/drivers/pci/host/pci-xgene.c
> >> @@ -499,12 +499,11 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
> >>       if (ret)
> >>               return ret;
> >>
> >> -     bus = pci_create_root_bus(&pdev->dev, 0,
> >> +     bus = pci_scan_root_bus(&pdev->dev, 0,
> >>                                       &xgene_pcie_ops, port, &res);
> >>       if (!bus)
> >>               return -ENOMEM;
> >>
> >> -     pci_scan_child_bus(bus);
> >>       pci_assign_unassigned_bus_resources(bus);
> >>       pci_bus_add_devices(bus);
> >>
> >> --
> >> 1.7.1
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> >> the body of a message to majordomo at vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
