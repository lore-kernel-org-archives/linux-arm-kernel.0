From: bhelgaas@google.com (Bjorn Helgaas)
Date: Sat, 2 Feb 2013 14:50:36 -0700
Subject: [PATCH v3 00/22] PCI: Iterate pci host bridge instead of pci root
 bus
In-Reply-To: <1359314629-18651-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
Message-ID: <CAErSpo6r_LNEtYB3j5ELb8NdHu0a6_YOVj8S32CmByGFUpSsbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 12:23 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> Now we have pci_root_buses list, and there is lots of iteration with
> list_of_each of it, that is not safe after we add pci root bus hotplug
> support after booting stage.
>
> Add pci_get_next_host_bridge and use bus_find_device in driver core to
> iterate host bridge and the same time get root bus.
>
> We replace searching root bus with searching host_bridge,
> as host_bridge->bus is the root bus.
> After those replacing, we even could kill pci_root_buses list.

These are the problems I think you're fixing:

1) pci_find_next_bus() is not safe because even though it holds
pci_bus_sem while walking the pci_root_buses list, it doesn't hold a
reference on the bus it returns.  The bus could be removed while the
caller is using it.

2) "list_for_each_entry(bus, &pci_root_buses, node)" is not safe
because hotplug might modify the pci_root_buses list.  Replacing that
with for_each_pci_host_bridge() solves that problem by using
bus_find_device(), which is built on klists, which are designed for
that problem.

3) pci_find_next_bus() claims to iterate through all known PCI buses,
but in fact only iterates through root buses.

So far, so good.  Those are problems we need to fix.

Your solution is to introduce for_each_pci_host_bridge() as an
iterator through the known host bridges.  There are two scenarios
where we use something like this:

1) We want to perform an operation on every known host bridge.

2) We want to initialize something for every host bridge.

In my opinion, the only instance of scenario 1) is bus_rescan_store(),
where we want to rescan all PCI host bridges.

In every other case, we're doing some kind of initialization of all
the host bridges.  For these cases, for_each_pci_host_bridge() is the
wrong solution because it doesn't work for hot-added bridges.  I think
these cases should be changed to use pcibios_root_bridge_prepare() or
something something else called in the host bridge add path.

Bjorn
