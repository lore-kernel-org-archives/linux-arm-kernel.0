From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Apr 2017 14:13:57 +0200
Subject: [RFC/RFT PATCH 01/18] PCI: Initialize bridge release function at
 bridge allocation
In-Reply-To: <20170426111809.19922-2-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-2-lorenzo.pieralisi@arm.com>
Message-ID: <CAK8P3a2jUj1npEr+So+JkjjQWgZWceE2whvO=Se=wPyaWOGbQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 1:17 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> The introduction of pci_register_host_bridge() kernel interface
> allows PCI host controller drivers to create the struct pci_host_bridge
> object, initialize it and register it with the kernel so that its
> corresponding PCI bus can be scanned and its devices probed.
>
> The host bridge device release function pci_release_host_bridge_dev is a
> static function common for all struct pci_host_bridge allocated objects,
> so in its current form cannot be used by PCI host bridge controllers
> drivers to initialize the allocated struct pci_host_bridge, which
> leaves struct pci_host_bridge devices release function uninitialized.
>
> Since pci_release_host_bridge_dev is a function common to all PCI
> host bridge objects, initialize it in pci_alloc_host_bridge() (ie
> common host bridge allocation interface) so that all struct
> pci_host_bridge objects have their release function initialized by
> default at allocation time, removing the need for exporting the
> common pci_release_host_bridge_dev function to other compilation
> units.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Makes sense. I think originally I did not have the bridge->release_fn
callback, so drivers would have to provide their won release callback,
but this is no longer needed as they can override the release_fn instead.

Acked-by: Arnd Bergmann <arnd@arndb.de>
