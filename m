From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Jan 2013 22:59:32 +0100
Subject: [PATCH v2 05/27] arm: pci: add a align_resource hook
In-Reply-To: <20130129213308.7e845064@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301291645.08040.arnd@arndb.de> <20130129180936.3737e550@skate>
 <201301292015.21478.arnd@arndb.de> <20130129213308.7e845064@skate>
Message-ID: <20130129225932.01efb45b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Tue, 29 Jan 2013 21:33:08 +0100, Thomas Petazzoni wrote:

> Basically, I have currently two suggestions:
> 
>  * From Jason Gunthorpe, to not use any host bridge, and instead use
>    only PCI-to-PCI bridges, one per PCIe interface.
> 
>  * From you, to not use any PCI-to-PCI bridge, and use only host
>    bridges, one per PCIe interface.

Thinking more about this, this solution (using one emulated host bridge
per PCIe interface) would cause one problem: the PCIe device itself
would no longer be in slot 0.

If I'm correct, with one host bridge per PCIe interface, we would have
the following topology:

 bus 0, slot 0: emulated host bridge 0
 bus 0, slot 1: PCIe device connected to PCIe interface 0
 bus 1, slot 0: emulated host bridge 1
 bus 1, slot 1: PCIe device connected to PCIe interface 1
 bus 2, slot 0: emulated host bridge 2
 bus 2, slot 1: PCIe device connected to PCIE interface 2
 etc.

However, one of the reason to use a PCI-to-PCI bridge was to ensure
that the PCIe devices were all listed in slot 0. According to the
Marvell engineers who work on the PCIe stuff, some new PCIe devices
have this requirement. I don't have a lot of details about this, but I
was told that most of the new Intel NICs require this, for example the
Intel X520 fiber NIC. Maybe PCIe experts (Jason?) could provide more
details about this, and confirm/infirm this statement.

The usage of PCI-to-PCI bridge allows to have each PCIe device on its
own bus, at slot 0, which also solves this problem.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
