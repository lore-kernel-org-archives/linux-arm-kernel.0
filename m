From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Apr 2017 14:52:14 +0200
Subject: [RFC/RFT PATCH 05/18] ARM: PCI: dove: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <CAK8P3a1bnnq-9iuse43bCNX_9TirZPOtmH_vFsvJ9VOAsoUBzQ@mail.gmail.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-6-lorenzo.pieralisi@arm.com>
 <CAK8P3a1bnnq-9iuse43bCNX_9TirZPOtmH_vFsvJ9VOAsoUBzQ@mail.gmail.com>
Message-ID: <CAK8P3a26HBoN=ZcNwB30AGheEy3AU1GrTWGXQ9pmQHe8sH+vTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 2:38 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Apr 26, 2017 at 1:17 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>> The introduction of pci_scan_root_bus_bridge() provides a PCI core
>> API to scan a PCI root bus backed by an already initialized
>> struct pci_host_bridge object, which simplifies the bus scan
>> interface and makes the PCI scan root bus interface easier to
>> generalize as members are added to the struct pci_host_bridge().
>>
>> Convert ARM dove platform code to pci_scan_root_bus_bridge() to improve
>> the PCI root bus scanning interface.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>
> Is this patch required for one of the later steps in the series?
>
> As non-DT dove uses the traditional pci_common_init() helper rather
> than registering its own driver, I wonder if there is anything to gain here.

Thinking about it some more, if we make the change to allocate from
pcibios_init_hw(), we can also initialize most of the fields there and
do the cleanup in common code when the scan callback fails, which
in turn makes the changes in arch/arm/mach*/pci.c drivers very simple.

        Arnd
