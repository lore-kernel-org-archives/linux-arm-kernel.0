From: msalter@redhat.com (Mark Salter)
Date: Fri, 15 Jun 2018 13:33:15 -0400
Subject: [PATCH] arm64/acpi: Add fixup for HPE m400 quirks
In-Reply-To: <8a3034b9-6cf3-5182-717f-dd1dc8a087aa@infradead.org>
References: <51d3d738-cdf5-2992-bba5-c3e1f34096c2@infradead.org>
 <098e6d53-8dc7-439f-7165-adbe0e7c4941@arm.com>
 <8a3034b9-6cf3-5182-717f-dd1dc8a087aa@infradead.org>
Message-ID: <5120aa9f167c19712c01dc812f689eaef23bf0c5.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-06-15 at 10:17 -0700, Geoff Levand wrote:
> > > +    if (ACPI_SUCCESS(status) && !strncmp(header->oem_id, "HPE   ", 6) &&
> > > +            !strncmp(header->oem_table_id, "ProLiant", 8) &&
> > 
> > You should match the affected range of OEM table revisions too, that way a
> > firmware upgrade should start working, instead of being permanently disabled
> > because we think its unlikely.
> 
> The m400 has reached end of life. No one really expects to see any firmware
> update.  I don't know what the effected OEM table revisions are, and I don't
> think there is an active platform maintainer who could give that info either.
> 
> If someone can provide the info. I'll update the fix.
> 
> > > +            MIDR_IMPLEMENTOR(read_cpuid_id()) == ARM_CPU_IMP_APM) {
> > 
> > How is the CPU implementer relevant?
> 
> That was just a copy of what other fixes had.  Should I remove it?

It was there because HPE ProLiant strings are generic and you may end up
disabling platforms which would otherwise work. It is the ProLiant system
based on the APM chipset which is the problem. Thus the check for cpu
implementor.
