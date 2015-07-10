From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 10 Jul 2015 18:02:54 +0100
Subject: ACPI: regression: Failed to initialize GIC IRQ controller
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D30B373@ORSMSX112.amr.corp.intel.com>
References: <CACVXFVPkZYm2i+S3m8B0tixKmTx02psGndo79ehdJxLiz9T92A@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D30B295@ORSMSX112.amr.corp.intel.com>
 <CACVXFVPjRiE55ndUY8PrGt6Qjnj1M_cJ5De=PDuRF-mz9NpAvg@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D30B2E9@ORSMSX112.amr.corp.intel.com>
 <20150710151740.GB12489@red-moon>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D30B373@ORSMSX112.amr.corp.intel.com>
Message-ID: <20150710170254.GC14257@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 04:47:34PM +0100, Moore, Robert wrote:
> 
> 
> > -----Original Message-----
> > From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi at arm.com]
> > Sent: Friday, July 10, 2015 8:18 AM
> > To: Moore, Robert
> > Cc: Ming Lei; Zheng, Lv; Wysocki, Rafael J; Linux Kernel Mailing List;
> > linux-arm-kernel; Thomas Gleixner; Jason Cooper; hanjun.guo at linaro.org
> > Subject: Re: ACPI: regression: Failed to initialize GIC IRQ controller
> > 
> > On Fri, Jul 10, 2015 at 03:45:32PM +0100, Moore, Robert wrote:
> > > It's nice that someone took a sizeof() on the struct -- so, one would
> > hope that no code actually depended on a particular value, no?
> > 
> > Unfortunately that sizeof has been there forever (x86/ia64),
> > ia64 code ran into a similar issue, so the check was removed to cope with
> > lsapic MADT updates, see:
> > 
> > arch/ia64/kernel/acpi.c line 204
> > 
> > /*Skip BAD_MADT_ENTRY check, as lsapic size could vary */
> > 
> > Is checking the subtable length field against a static value really
> > worthwhile/suitable ?
> > 
> 
> I would at least traverse the subtables via the subtable length given in the table, and not use a sizeof() for each subtable. Then, multiple table/subtable versions are handled automatically; you don't have to use any new fields until necessary.

I lost you here, sorry. You are describing how the subtable entries are
parsed in acpi_parse_entries, but that's not what we are debating here.
BAD_MADT_ENTRY checks the subtable length against the ACPICA MADT structs
sized through sizeof to determine if the length field is "correct", I do
not see how you can do it by traversing the tables (how can you determine
where a subtable _really_ ends or to put it differently how to check that
a subtable length is _really_ right ?).

Thanks,
Lorenzo
