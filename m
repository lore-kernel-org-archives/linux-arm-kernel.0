From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Feb 2014 19:49:10 +0000
Subject: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
In-Reply-To: <2006726.HhIT01YuXY@wuerfel>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <201402092130.25615.arnd@arndb.de>
 <20140210173450.GA5554@obsidianresearch.com>
 <2006726.HhIT01YuXY@wuerfel>
Message-ID: <20140212194909.GM29132@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 10:42:52AM +0000, Arnd Bergmann wrote:
> On Monday 10 February 2014 10:34:50 Jason Gunthorpe wrote:
> 
> > I noticed this on mvebu as well..
> > 
> > 3.13 w/ mvebu driver:
> > 
> > e0001000-e0001fff : /mbus/pex at e0000000/pcie at 1,0/fpga at 0/fpga_sysmon at 1000
> > e0006000-e0006fff : /mbus/pex at e0000000/pcie at 1,0/fpga at 0/qdr2p at 6000
> > 
> > 3.10 w/ old kirkwood driver:
> > 
> > e0000000-e7ffffff : PCIe 0 MEM
> >   e0000000-e001ffff : 0000:00:01.0
> >     e0001000-e0001fff : /mbus/pex at e0000000/pcie at 1,0/fpga at 0/fpga_sysmon at 1000
> >     e0006000-e0006fff : /mbus/pex at e0000000/pcie at 1,0/fpga at 0/qdr2p at 6000
> > 
> > The latter is obviously correct and matches x86. I'm not sure where
> > the new style host drivers are going wrong, even the resource that
> > should be added by the PCI core itself for the BAR is missing..
> 
> I looked briefly at the code and found that mach-kirkwood/pcie.c does
> both request_resource() and pci_add_resource_offset(), while
> drivers/pci/host/pci-mvebu.c only does the latter. Does the patch
> below restore the previous behavior?

Making the equivalent changes in my generic driver fixes the issue, cheers
Arnd!

  bash-4.2# cat /proc/ioports
  00000000-0000ffff : /pci
    00006200-000065ff : virtio-pci
    00006600-000069ff : virtio-pci
    00006a00-00006dff : virtio-pci
    00006e00-000071ff : virtio-pci
  bash-4.2# cat /proc/iomem
  41000000-7fffffff : /pci
    41000000-410003ff : virtio-pci
    41000400-410005ff : virtio-pci
    41000800-41000bff : virtio-pci
    41000c00-41000dff : virtio-pci
    41001000-410013ff : virtio-pci
    41001400-410015ff : virtio-pci
    41001800-41001bff : virtio-pci
    41001c00-41001dff : virtio-pci
  80000000-93ffffff : System RAM
    80008000-80697e4f : Kernel code
    806f6000-8077b4c3 : Kernel data

Will
