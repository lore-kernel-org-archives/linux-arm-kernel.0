From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 15 Nov 2013 09:57:17 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
Message-ID: <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:44:10AM +0000, Olof Johansson wrote:
> The more I start to see early UEFI/ACPI code, the more I am certain
> that we want none of that crap in the kernel. It's making things
> considerably messier, while we're already very busy trying to convert
> everything over and enable DT -- we'll be preempting that effort just
> to add even more boilerplate everywhere and total progress will be
> hurt.

We are certainly under a lot of pressure with the device tree migration,
and I agree that adding another information source is going to be a
source of pain. However, I'd argue that we're going to encounter pain
regardless of which approach we take.

I'm of the opinion that the only way we should support ACPI is as a
first-class citizen. We don't need to modify every driver and subsystem
to support ACPI, only those necessary to support the minimal set of
platforms using ACPI. ACPI is new in the arm space, and we can enforce
quality standards on ACPI _now_ above what we're allowing for DT, and
avoid future problems.

There may even be things which we don't have to deal with at all on ACPI
systems as used in servers (e.g. clock management), but perhaps we will
if people see value in those elements.

> The server guys really want UEFI for their boot protocols,
> installation managers, etc, etc. That's fine, let them do that, but
> that doesn't mean we need to bring the same APIs all the way into the
> kernel.
> 
> So, I'm strongly urging that whatever the server guys try to do, it
> will in the end result in the ACPI data being translated into DT
> equivalents, such that the kernel _only_ needs to handle data via DT.

I'm not sure that translating ACPI tables to dt makes any sense. If AML
is used (even sparingly), I do not believe that we can do any sensible
conversion to device tree. My understanding is that AML includes
functionality for modifying ACPI tables, and I don't see how we can
possibly support that without having to add a lot of boilerplate to all
the code handling AML to add a device tree backend...

> Just like PowerPC scrapes the OpenFirmware client interface to build a
> flat device tree, we should add a pre-boot stage that scrapes
> ACPI/UEFI data and constructs an appropriate device-tree. We can still
> bring over ACPI methods and represent those in the DT, but we should
> _not_ have two native interfaces.

I'm not sure the two cases are comparable. The format of the FDT was
designed to encode the data structure used by OpenFirmware, and thus the
two map to each other pretty well. I do not believe that mapping from
ACPI tables to an FDT blob is anywhere near as simple, and as I mention
above I do not believe that we can just copy over the ACPI methods in
isolation.

> It might be done via having a skeleton/framework DT for the vendor
> platform that is updated via UEFI/ACPI data, or it might be
> constructed entirely out of tables coming from firmware. I don't care
> about the methods for how it is done, but I do feel strongly that we
> should _not_ introduce a second API for everything. I can't think of a
> single good reason to do it.

Where does this skeleton/framework come from? Within the kernel? That
sounds like an arcane board file equivalent, and is counter to the
entire reason for using UEFI and ACPI -- having a well-defined
(excluding particular driver bindings, and I'm not arguing well-defined
means nice) stable standard that allows the kernel to boot on an
arbitrary platform without requiring arbitrary platform-specific code
everywhere in the boot path.

It might not be pretty, and it will certainly require a lot of work, but
I'd prefer it at least for a semblance of uniformity.

I think that trying to shoe-horn ACPI-derived information into device
tree is fundamentally the wrong approach. I don't think it encourages
best practices, and I don't think it's beneficial to the long term
health of Linux or the ecosystem as a whole.

> [There, commence centithread]

[centithread commenced]

Thanks,
Mark.
