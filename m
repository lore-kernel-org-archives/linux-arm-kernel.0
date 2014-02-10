From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 10 Feb 2014 10:34:50 -0700
Subject: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
In-Reply-To: <201402092130.25615.arnd@arndb.de>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <3724624.kd9jZNUiTF@wuerfel>
 <20140207114607.GE5976@mudshark.cambridge.arm.com>
 <201402092130.25615.arnd@arndb.de>
Message-ID: <20140210173450.GA5554@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 09, 2014 at 09:30:25PM +0100, Arnd Bergmann wrote:

> > bash-4.2# cat /proc/iomem
> > 40000000-40ffffff : /pci
> > 41000400-410005ff : virtio-pci
> > 41000c00-41000dff : virtio-pci
> > 41001400-410015ff : virtio-pci
> > 41001c00-41001dff : virtio-pci
> > 80000000-93ffffff : System RAM
> >   80008000-8053df0b : Kernel code
> >   80570000-805c07fb : Kernel data
> 
> You should normally see a parent resource for the PCI bus and the virtio-pci
> resources under that. For some reason, neither of the two appears to have
> been registered correctly.

I noticed this on mvebu as well..

3.13 w/ mvebu driver:

e0001000-e0001fff : /mbus/pex at e0000000/pcie at 1,0/fpga at 0/fpga_sysmon at 1000
e0006000-e0006fff : /mbus/pex at e0000000/pcie at 1,0/fpga at 0/qdr2p at 6000

3.10 w/ old kirkwood driver:

e0000000-e7ffffff : PCIe 0 MEM
  e0000000-e001ffff : 0000:00:01.0
    e0001000-e0001fff : /mbus/pex at e0000000/pcie at 1,0/fpga at 0/fpga_sysmon at 1000
    e0006000-e0006fff : /mbus/pex at e0000000/pcie at 1,0/fpga at 0/qdr2p at 6000

The latter is obviously correct and matches x86. I'm not sure where
the new style host drivers are going wrong, even the resource that
should be added by the PCI core itself for the BAR is missing..

Jason
