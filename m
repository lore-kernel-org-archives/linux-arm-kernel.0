From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 10 Nov 2015 06:19:17 +0000
Subject: [PATCH] drivers: pci: remove unused pci_sys_data structures
In-Reply-To: <7247058.o5kTvZ3CSC@wuerfel>
References: <1447095459-21777-1-git-send-email-lorenzo.pieralisi@arm.com>
 <7247058.o5kTvZ3CSC@wuerfel>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E162A5EC2@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

[...]
> 
> Nice!
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> On the downside, I just saw how b3a72384fe29 ("ARM/PCI: Replace
> pci_sys_data->align_resource with global function pointer") manages
> to get rid of the last user of this, and how this is not the way
> we had planned for it to be done.
> 
> It doesn't matter that much, because there is only a single
> user of hw->align_resource, but this is now unportable code and
> cannot easily be separated from hw_pci. It also breaks if we ever
> get a machine with two different host controllers on ARM that
> don't use the same pointer here.
> 
> I really would have hoped we could put that function pointer
> into 'struct pci_host_bridge' instead, and eventually killed
> off the architecture specific pcibios_align_resource function
> as well.

say we move that in pci_host_bridge struct,

Are you suggesting to modify pcibios_init_hw to assign the 
align_resource function pointer at the end after
pci_scan_root_bus_msi() has created the host bridge structure;
then we can retrieve it in pcibios_align_resource using
pci_find_host_bridge(dev->bus)....?

> 
> Any idea why it was done with a global function pointer for
> ARM rather than a proper solution?

Well just because I didn't think about the solution above...

If you think the above one can work I can send out another
patch to fix this...

Many Thanks

Gab


> 
> 	Arnd
