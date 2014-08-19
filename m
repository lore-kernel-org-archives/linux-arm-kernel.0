From: robert.moore@intel.com (Moore, Robert)
Date: Tue, 19 Aug 2014 22:55:59 +0000
Subject: [PATCH v2 05/18] ARM64 / ACPI: Parse FADT table to get PSCI
 flags for PSCI init
In-Reply-To: <53F33F7A.7030307@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-6-git-send-email-hanjun.guo@linaro.org>
 <20140818142721.GR20043@localhost> <53F2C983.8000800@linaro.org>
 <20140819111000.GG3302@leverpostej> <53F33F7A.7030307@linaro.org>
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D1E7D1B@ORSMSX112.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I should warn you that FADT version numbers are notoriously unreliable; In fact, in ACPICA we were eventually forced to abandon them entirely. We use the actual size of the FADT instead.

Bob



> -----Original Message-----
> From: Hanjun Guo [mailto:hanjun.guo at linaro.org]
> Sent: Tuesday, August 19, 2014 5:14 AM
> To: Mark Rutland
> Cc: Catalin Marinas; Rafael J. Wysocki; graeme.gregory at linaro.org; Arnd
> Bergmann; Olof Johansson; grant.likely at linaro.org; Sudeep Holla; Will
> Deacon; Jason Cooper; Marc Zyngier; Bjorn Helgaas; Daniel Lezcano; Mark
> Brown; Rob Herring; Robert Richter; Zheng, Lv; Moore, Robert; Lorenzo
> Pieralisi; Liviu Dudau; Randy Dunlap; Charles Garcia-Tobin; linux-
> acpi at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; linaro-acpi at lists.linaro.org
> Subject: Re: [PATCH v2 05/18] ARM64 / ACPI: Parse FADT table to get PSCI
> flags for PSCI init
> 
> On 2014-8-19 19:10, Mark Rutland wrote:
> >>>> @@ -47,6 +49,26 @@ void __init __acpi_unmap_table(char *map, unsigned
> long size)
> >>>>  	early_memunmap(map, size);
> >>>>  }
> >>>>
> >>>> +static int __init acpi_parse_fadt(struct acpi_table_header *table)
> >>>> +{
> >>>> +	struct acpi_table_fadt *fadt = (struct acpi_table_fadt
> *)table;
> >>>> +
> >>>> +	/*
> >>>> +	 * Revision in table header is the FADT Major version,
> >>>> +	 * and there is a minor version of FADT which was introduced
> >>>> +	 * by ACPI 5.1, we only deal with ACPI 5.1 or higher version
> >>>> +	 * to get arm boot flags, or we will disable ACPI.
> >>>> +	 */
> >>>> +	if (table->revision < 5 || fadt->minor_revision < 1) {
> >>>
> >>> If we ever get revision 6.0, this would trigger.
> >>
> >> Yes, good catch, actually I already fixed that in my local git repo,
> >>
> >> +       if (table->revision > 5 ||
> >> +           (table->revision == 5 && fadt->minor_revision >= 1)) {
> >> +               return 0;
> >> +       } else {
> >> +               pr_info("FADT revision is %d.%d, no PSCI support,
> >> + should be 5.1
> >> or higher\n",
> >> +                       table->revision, fadt->minor_revision);
> >> +               disable_acpi();
> >> +               return -EINVAL;
> >> +       }
> >
> > Given you return in the first path, you don't need the remaining code
> > to live in an else block.
> 
> Agreed, I will update it, and move disable_acpi() outside this function
> and keep it in one place as Sudeep suggested.
> 
> Thanks
> Hanjun
