From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Jan 2015 10:40:26 +0100
Subject: [PATCH 08/28] PCI: Introduce pci_host_assign_domain_nr() to
 assign domain
In-Reply-To: <13182982.DnZJMY2KHL@wuerfel>
References: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
 <1421372666-12288-9-git-send-email-wangyijing@huawei.com>
 <13182982.DnZJMY2KHL@wuerfel>
Message-ID: <3026954.09KG7UaUTi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 January 2015 10:08:45 Arnd Bergmann wrote:
> On Friday 16 January 2015 09:44:06 Yijing Wang wrote:
> > Introduce pci_host_assign_domain_nr() to assign domain
> > number for pci_host_bridge. Later we will remove
> > pci_bus_assign_domain_nr().
> > 
> > Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> 
> I'm confused: the same code is already part of the PCI tree, but with
> Lorenzo Pieralisi listed as the patch author. The code is good,
> and I acked it in the past, but one of you is (probably by accident)
> misattributing the patch.
> 
> Assuming that the patch that is already merged in next is the right
> one, I think you should rebase your series on top of
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git#next
> 
> to avoid conflicts like this one.
>

I think I just got confused because the code duplicates most of
pci_bus_assign_domain_nr(). Maybe this can be done in a better way
by splitting the existing function into 

static int pci_assign_domain_nr(struct device *)
{
	... /* most of pci_bus_assign_domain_nr */

	return domain;
}

void pci_host_assign_domain_nr(struct pci_host_bridge *host)
{
	host->domain = pci_assign_domain_nr(host->dev.parent);
}

void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
{
	bus->domain_nr = pci_assign_domain_nr(parent);
}
