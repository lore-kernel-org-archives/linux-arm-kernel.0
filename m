From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 2 Mar 2015 21:24:12 -0600
Subject: [PATCH v4 22/30] PCI/Parisc: Use pci_scan_root_bus() for
 simplicity
In-Reply-To: <1424938344-4017-23-git-send-email-wangyijing@huawei.com>
References: <1424938344-4017-1-git-send-email-wangyijing@huawei.com>
 <1424938344-4017-23-git-send-email-wangyijing@huawei.com>
Message-ID: <20150303032412.GK11978@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 04:12:16PM +0800, Yijing Wang wrote:
> From: Yijing Wang <wangyijing0307@gmail.com>

When you write subject lines, I think it's friendly to run
"git log --oneline" on the file you're changing, and make yours
match the previous ones.

  $ git log --oneline drivers/parisc/dino.c
  3f05536d226d PCI/Parisc: Use pci_scan_root_bus() for simplicity
  3335f75a8877 parisc: dino: fix %d confusingly prefixed with 0x in format string
  3fad9b8d597f drivers/parisc: Use printf extension %pR for struct resource
  0fe763c570ad Drivers: misc: remove __dev* attributes.
  0b79ca2a800d parisc/PCI: Use list_for_each_entry() for bus->devices traversal
  30aa80da43a5 parisc/PCI: register busn_res for root buses
  ...

Yours doesn't match any of them, but "parisc/PCI" seems the best match.

> Now pci_bus_add_devices() has been ripped out
> from pci_scan_root_bus(), we could use pci_scan_root_bus()
> instead of pci_create_root_bus() + pci_scan_child_bus()
> for simplicity. We could also remove the pci bus
> resource(dino_current_bus,255) and pci_bus_update_busn_res_end(),
> because pci_scan_root_bus() would do the same thing.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> CC: "James E.J. Bottomley" <jejb@parisc-linux.org>
> CC: linux-parisc at vger.kernel.org
> ---
>  drivers/parisc/dino.c    |   11 ++---------
>  drivers/parisc/lba_pci.c |    7 ++-----
>  2 files changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
> index a0580af..e5ee339 100644
> --- a/drivers/parisc/dino.c
> +++ b/drivers/parisc/dino.c
> @@ -977,15 +977,11 @@ static int __init dino_probe(struct parisc_device *dev)
>  	if (dino_dev->hba.gmmio_space.flags)
>  		pci_add_resource(&resources, &dino_dev->hba.gmmio_space);
>  
> -	dino_dev->hba.bus_num.start = dino_current_bus;
> -	dino_dev->hba.bus_num.end = 255;
> -	dino_dev->hba.bus_num.flags = IORESOURCE_BUS;
> -	pci_add_resource(&resources, &dino_dev->hba.bus_num);

I know pci_scan_root_bus() does default to bus 0-255, but I don't really
like that behavior, and I think it's a bug for drivers like this to rely on
that.  The PCI core has no way to discover the actual bus number range, and
the only reason it supplies a default is because it was inconvenient to
change all the callers.  The host bridge driver is the only code that has
any chance of discovering and/or configuring the correct range.

So I think it's more correct to leave the existing code here, even though
this code is is likely incorrect.  At least then if we trip over an issue
with the bus range being incorrect, it will be clear that the fix should
be in dino.c rather than the PCI core.
