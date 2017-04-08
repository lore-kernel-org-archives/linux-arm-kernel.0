From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 8 Apr 2017 08:04:47 +0100
Subject: [PATCH] acpi: pci: don't ignore function ID of bridge device in
 _PRT
In-Reply-To: <20170407213621.GA12591@red-moon>
References: <20170407132222.28300-1-ard.biesheuvel@linaro.org>
 <20170407170654.GA30103@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_rivjMaQ740LWO1Nm8SPMGuQ1J1TFeD8QXnRch8Lv6bg@mail.gmail.com>
 <20170407180652.GA12301@red-moon>
 <CAKv+Gu-wXAU9_eHFLSDNKa6hTznHne=HDU8qi-c69PrgSR1i=Q@mail.gmail.com>
 <20170407213621.GA12591@red-moon>
Message-ID: <CAKv+Gu_ZCWgAwWBQYOCJ_hNOqdpCa5kLYtU=bnnfg4Q9nVNDeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 April 2017 at 22:36, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Fri, Apr 07, 2017 at 07:35:45PM +0100, Ard Biesheuvel wrote:
>> On 7 April 2017 at 19:06, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>> > On Fri, Apr 07, 2017 at 06:12:05PM +0100, Ard Biesheuvel wrote:
>> >> On 7 April 2017 at 18:06, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> >> > Hi Ard,
>> >> >
>> >> > On Fri, Apr 07, 2017 at 02:22:22PM +0100, Ard Biesheuvel wrote:
>> >> >> We currently derive legacy interrupt routing by matching _PRT
>> >> >> entries on the PCI device only, presumably under the assumption
>> >> >> that PRT entries always have a value of 0xffff in the function
>> >> >> field, meaning 'match all functions'.
>> >> >
>> >> > The spec (ACPI v6.0, sec 6.2.13) contains a note that:
>> >> >
>> >> >   The PCI function number in the Address field of the _PRT packages
>> >> >   must be 0xFFFF, indicating "any" function number or "all functions".
>> >> >
>> >> > If we need a patch like this, we need to somehow reconcile it with
>> >> > that spec text to make sure firmware and OS folks have a common
>> >> > understanding of how this is supposed to work.
>> >> >
>> >> >> This no longer holds for modern PCIe topologies, where the
>> >> >> legacy interrupts for different slots may be wired to different
>> >> >> functions on the same bridge device. For instance, on AMD Seattle,
>> >> >> we may have something like
>> >> >>
>> >> >> -[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Device 1a00
>> >> >>            +-02.0  Advanced Micro Devices, Inc. [AMD] Device 1a01
>> >> >>            +-02.2-[01]----00.0  Renesas uPD720202 USB 3.0 Host Controller
>> >> >>            \-02.3-[02]----00.0  Realtek RTL8169 PCIe Gigabit Ethernet
>> >> >>
>> >> >> where the _PRT describes the legacy interrupt routing as
>> >> >>
>> >> >>     Name (_PRT, Package ()  // _PRT: PCI Routing Table
>> >> >>     {
>> >> >>         // slot 1: dev 2 fn 1
>> >> >>         Package () { 0x20001, 0x0, 0x0, 0x140 },
>> >> >>         Package () { 0x20001, 0x1, 0x0, 0x141 },
>> >> >>         Package () { 0x20001, 0x2, 0x0, 0x142 },
>> >> >>         Package () { 0x20001, 0x3, 0x0, 0x143 },
>> >> >>
>> >> >>         // slot 1: dev 2 fn 2
>> >> >>         Package () { 0x20002, 0x0, 0x0, 0x144 },
>> >> >>         Package () { 0x20002, 0x1, 0x0, 0x145 },
>> >> >>         Package () { 0x20002, 0x2, 0x0, 0x146 },
>> >> >>         Package () { 0x20002, 0x3, 0x0, 0x147 },
>> >> >>
>> >> >>         // slot 1: dev 2 fn 3
>> >> >>         Package () { 0x20003, 0x0, 0x0, 0x148 },
>> >> >>         Package () { 0x20003, 0x1, 0x0, 0x149 },
>> >> >>         Package () { 0x20003, 0x2, 0x0, 0x14a },
>> >> >>         Package () { 0x20003, 0x3, 0x0, 0x14b }
>> >> >>     }) // _PRT
>> >> >
>> >> > But I think this _PRT description is incorrect and we should change
>> >> > the _PRT rather than the kernel.  My laptop has a basically identical
>> >> > topology:
>> >> >
>> >> >   -[0000:00]-+-00.0  Intel Corporation Sky Lake Host Bridge/DRAM Registers
>> >> >              +-1c.0-[02]----00.0  Realtek Semiconductor Co., Ltd.  Device 525a
>> >> >              +-1c.2-[04]----00.0  Intel Corporation Wireless 8260
>> >> >
>> >> > and the ASL looks like this (paraphrased):
>> >> >
>> >> >   Device (EXP1) {
>> >> >     Name (_ADR, 0x001C0000)
>> >> >     Name (_PRT) {
>> >> >       Package () { 0xFFFF, 0x00, \_SB.LNKA, 0x00 },
>> >> >       Package () { 0xFFFF, 0x01, \_SB.LNKB, 0x00 },
>> >> >       ...
>> >> >     }
>> >> >   }
>> >> >   Device (EXP3) {
>> >> >     Name (_ADR, 0x001C0002)
>> >> >     Name (_PRT) {
>> >> >       Package () { 0xFFFF, 0x00, \_SB.LNKC, 0x00 },
>> >> >       Package () { 0xFFFF, 0x01, \_SB.LNKD, 0x00 },
>> >> >       ...
>> >> >     }
>> >> >   }
>> >> >
>> >>
>> >> Thanks for the explanation. But how is this wired up into the PNP0A08
>> >> device then? IOW, how does the ACPI code in Linux discover the
>> >> relation between these devices and my PCI root device?
>> >
>> > You describe the PCI hierarchy starting from PNP0A08 at root and the
>> > kernel assigns the ACPI companion through _ADR matching (see
>> > acpi_pci_find_companion()) which is what is used by _PRT parsing
>> > code to route IRQs IIUC.
>> >
>>
>> OK, I have changed my DSDT as follows:
>>
>>
>> Device (PCI0)
>> {
>>     Name (_ADR, 0x00)
>>     Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
>>     Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
>>     Name (_SEG, 0x00)  // _SEG: PCI Segment
>>     Name (_BBN, 0x00)  // _BBN: BIOS Bus Number
>>     Name (_CCA, 0x01)  // _CCA: Cache Coherency Attribute
>>
>>     Device (EXP1)
>>     {
>>         Name (_ADR, 0x20001)  // _ADR: Address
>>         Name (_PRT, Package ()  // _PRT: PCI Routing Table
>>         {
>>             // slot 1: dev 2 fn 1
>>             Package () { 0xFFFF, 0x0, 0x0, 0x140 },
>                            ^
>                            0x2FFFF
>
> Ditto for the other entries.
>

I had already tried that as well, but it doesn't work.

Single stepping through the ACPI code, it seems like the _PRT entry is
never found by acpi_get_irq_routing_table(), and so whether the
contents are correct doesn't really matter at this point.

>>
>> So could we be missing anything in the arm64 implementation that
>> prevents the companion device from being found?
>
> No and if there is that's a bug. I will help you debug it next week,
> mind trying the change I suggest above please ? I *think* the devfn
> parameter in the _PRT entry must match the device looked-up, in
> particular the device bits.
>

Yes, let's look into this on Monday.
