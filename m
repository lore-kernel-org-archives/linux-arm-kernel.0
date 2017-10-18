From: kdinh@apm.com (Khuong Dinh)
Date: Tue, 17 Oct 2017 22:45:35 -0700
Subject: [PATCH v4 pci 0/2] PCI/MSI: pci-xgene-msi: Enable MSI support in
 ACPI boot for X-Gene v1
In-Reply-To: <20171017133807.GB948@red-moon>
References: <1506448161-30961-1-git-send-email-kdinh@apm.com>
 <CAAsHzqv-oQVNm-pNP4Q1KmiSmjaiFx1S4j8uCnij53Te3h8KKg@mail.gmail.com>
 <20171017133807.GB948@red-moon>
Message-ID: <CAAsHzqsxMy8On5ThggTwYohqMCLEJTbA=b1LgUPiuKu9C+eHeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Tue, Oct 17, 2017 at 6:38 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Hi Khuong,
>
> On Mon, Oct 16, 2017 at 02:19:50PM -0700, Khuong Dinh wrote:
>> Hi Lorenzo,
>>   Do you have any comments for this patch?
>
> I'd have some comments but given that there are related issues with ACPI
> probe ordering that Marc is trying to solve on his side - I will work
> with him to see if we can accommodate changes that can solve this issue
> too.
>
> Again - I recognize it is a complex problem (that is not even
> contemplated by the current ACPI specs), we have to try to make
> the solution as generic as we can to prevent reinventing the wheel
> anytime a sligthly different issue (related to ACPI probe ordering)
> comes up.
>
> Leave it to me (us) and I will get back to you on this.

Thanks for helping to take care of the generic ACPI probe ordering issue.
Given that the patch 'PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI
boot for X-Gene v1" adds only the ACPI ID, can you pull in this patch
independently from the ACPI probe ordering issue?

Best regards,
Khuong Dinh

> Thanks,
> Lorenzo
>
>> Best regards,
>> Khuong Dinh
>>
>> On Tue, Sep 26, 2017 at 10:49 AM, Khuong Dinh <kdinh@apm.com> wrote:
>> > This patch set enables ACPI MSI support for X-Gene PCIe v1 hardware
>> > and provides the proper MSI driver initialization ordering.
>> >
>> > Signed-off-by: Khuong Dinh <kdinh@apm.com>
>> > ---
>> > v4:
>> >  - Remove Marc Zyngier ACK in v2
>> >  - Use acpi_bus_scan on MSI controller handle when MSI device is found
>> >  - Register ACPI MSI driver when MSI device is found instead of using
>> >  subsys_initcall
>> >  - Split ACPI MSI driver support into two patches - one to enable MSI
>> > support for X-Gene PCIe v1 hardware, one to enforce MSI driver loaded
>> > before PCIe controller driver in ACPI boot mode
>> > v3:
>> >  - Input X-Gene MSI base address for irq_domain_alloc_fwnode
>> >  - Add a hook to enforce X-Gene MSI be probed prior acpi_bus_scan happens
>> > v2:
>> >  - Verify with BIOS version 3.06.25 and 3.07.09
>> > v1:
>> >  - Initial version
>> > ---
>> >
>> > Khuong Dinh (2):
>> >   PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI boot for X-Gene v1
>> >   PCI/MSI: Enforce MSI driver loaded before PCIe in ACPI boot
>> >
>> >  drivers/acpi/Makefile            |    2 +-
>> >  drivers/acpi/acpi_msi.c          |   86 ++++++++++++++++++++++++++++++++++++++
>> >  drivers/acpi/acpi_platform.c     |    3 +-
>> >  drivers/acpi/internal.h          |    1 +
>> >  drivers/acpi/scan.c              |    1 +
>> >  drivers/pci/host/pci-xgene-msi.c |   60 ++++++++++++++++++++++++--
>> >  include/linux/acpi_msi.h         |   37 ++++++++++++++++
>> >  7 files changed, 183 insertions(+), 7 deletions(-)
>> >  create mode 100644 drivers/acpi/acpi_msi.c
>> >  create mode 100644 include/linux/acpi_msi.h
>> >
