From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Sat, 8 Apr 2017 14:22:32 +0100
Subject: [PATCH] acpi: pci: don't ignore function ID of bridge device in
 _PRT
In-Reply-To: <CAKv+Gu9EoUo+_BDSBj_v6eS7yYdjktcbQQA_eiLoqY47y1oK6w@mail.gmail.com>
References: <20170407132222.28300-1-ard.biesheuvel@linaro.org>
 <20170407170654.GA30103@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_rivjMaQ740LWO1Nm8SPMGuQ1J1TFeD8QXnRch8Lv6bg@mail.gmail.com>
 <20170407180652.GA12301@red-moon>
 <CAKv+Gu-wXAU9_eHFLSDNKa6hTznHne=HDU8qi-c69PrgSR1i=Q@mail.gmail.com>
 <CAKv+Gu9EoUo+_BDSBj_v6eS7yYdjktcbQQA_eiLoqY47y1oK6w@mail.gmail.com>
Message-ID: <20170408132232.GA13027@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 08, 2017 at 12:22:15PM +0100, Ard Biesheuvel wrote:
> On 7 April 2017 at 19:35, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 7 April 2017 at 19:06, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> >> On Fri, Apr 07, 2017 at 06:12:05PM +0100, Ard Biesheuvel wrote:
> >>> On 7 April 2017 at 18:06, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [...]
> >
> > OK, I have changed my DSDT as follows:
> >
> >
> > Device (PCI0)
> > {
> >     Name (_ADR, 0x00)
> >     Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
> >     Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
> >     Name (_SEG, 0x00)  // _SEG: PCI Segment
> >     Name (_BBN, 0x00)  // _BBN: BIOS Bus Number
> >     Name (_CCA, 0x01)  // _CCA: Cache Coherency Attribute
> >
> >     Device (EXP1)
> >     {
> >         Name (_ADR, 0x20001)  // _ADR: Address
> >         Name (_PRT, Package ()  // _PRT: PCI Routing Table
> >         {
> >             // slot 1: dev 2 fn 1
> >             Package () { 0xFFFF, 0x0, 0x0, 0x140 },
> >             Package () { 0xFFFF, 0x1, 0x0, 0x141 },
> >             Package () { 0xFFFF, 0x2, 0x0, 0x142 },
> >             Package () { 0xFFFF, 0x3, 0x0, 0x143 }
> >         }) // _PRT
> >     }
> >     Device (EXP2)
> >     {
> >         Name (_ADR, 0x20002)  // _ADR: Address
> >         Name (_PRT, Package ()  // _PRT: PCI Routing Table
> >         {
> >             // slot 2: dev 2 fn 2
> >             Package () { 0xFFFF, 0x0, 0x0, 0x144 },
> >             Package () { 0xFFFF, 0x1, 0x0, 0x145 },
> >             Package () { 0xFFFF, 0x2, 0x0, 0x146 },
> >             Package () { 0xFFFF, 0x3, 0x0, 0x147 }
> >         }) // _PRT
> >     }
> >     Device (EXP3)
> >     {
> >         Name (_ADR, 0x20003)  // _ADR: Address
> >         Name (_PRT, Package ()  // _PRT: PCI Routing Table
> >         {
> >             // slot 3: dev 2 fn 3
> >             Package () { 0xFFFF, 0x0, 0x0, 0x148 },
> >             Package () { 0xFFFF, 0x1, 0x0, 0x149 },
> >             Package () { 0xFFFF, 0x2, 0x0, 0x14a },
> >             Package () { 0xFFFF, 0x3, 0x0, 0x14b }
> >         }) // _PRT
> >     }
> >
> > but it does not get picked up, and I am back to
> >
> > [    3.357555] pcieport 0000:00:02.2: can't derive routing for PCI INT A
> > [    3.370477] pcieport 0000:00:02.2: PCI INT A: no GSI
> > [    3.380549] pcieport 0000:00:02.3: can't derive routing for PCI INT A
> > [    3.393476] pcieport 0000:00:02.3: PCI INT A: no GSI
> >
> 
> OK, this does appear to work in fact, for the devices behind the
> bridges. These messages are from the pcieport driver trying to request
> an IRQ for the bridge device itself, which no longer works now that
> the _PRT methods have been moved out.
> 
> So that mostly solves the problem. I'll try adding back a _PRT in the
> PCI root device itself, but i'm not sure if I can make any inferences
> about the IRQ wiring from the data i have.

Yes and IIUC with the $SUBJECT patch applied, the endpoints would match
the _PRT entry under PNP0A08 through their bridge (PCIe port device = 2
fn = X) device entry, not their own (device = 0) (ie first look-up in
acpi_pci_irq_lookup() through acpi_pci_irq_find_prt_entry() should fail
for the endpoints, then the same look-up is carried out with the bridge
device instead and that succeeds, the _PRT entry routes IRQs for the
PCIeport AND their downstream endpoint with $SUBJECT patch applied).

If you add the _PRT under the PCIe port itself (table above) the PCIe
port can't find an ACPI parent device to route its own IRQx, that's my
reading of what's going on, I will debug it next week.

Lorenzo
