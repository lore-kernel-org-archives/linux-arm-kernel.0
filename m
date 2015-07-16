From: ahs3@redhat.com (Al Stone)
Date: Thu, 16 Jul 2015 12:05:01 -0600
Subject: [PATCH] ARM64: kernel: implement ACPI parking protocol
In-Reply-To: <20150716171221.GB18582@red-moon>
References: <1436959990-32054-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1437063431.3583.2.camel@redhat.com> <20150716171221.GB18582@red-moon>
Message-ID: <55A7F24D.2000100@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2015 11:12 AM, Lorenzo Pieralisi wrote:
> On Thu, Jul 16, 2015 at 05:17:11PM +0100, Mark Salter wrote:
>> On Wed, 2015-07-15 at 12:33 +0100, Lorenzo Pieralisi wrote:
>>
>>> The SBBR and ACPI specifications allow ACPI based systems that do not
>>> implement PSCI (eg systems with no EL3) to boot through the ACPI parking
>>> protocol specification[1].
>>>
>>> This patch implements the ACPI parking protocol CPU operations, and adds
>>> code that eases parsing the parking protocol data structures to the
>>> ARM64 SMP initializion carried out at the same time as cpus enumeration.
>>>
>>> To wake-up the CPUs from the parked state, this patch implements a
>>> wakeup IPI for ARM64 (ie arch_send_wakeup_ipi_mask()) that mirrors the
>>> ARM one, so that a specific IPI is sent for wake-up purpose in order
>>> to distinguish it from other IPI sources.
>>>
>>> Given the current ACPI MADT parsing API, the patch implements a glue
>>> layer that helps passing MADT GICC data structure from SMP initialization
>>
>> Somewhat off topic, but this reminds once again, that it might be
>> better to generalize the ACPI_MADT_TYPE_GENERIC_INTERRUPT so that it
>> could be done in one pass. Currently, the SMP code and the GIC code
>> need boot-time info from ACPI_MADT_TYPE_GENERIC_INTERRUPT tables. This
>> patch adds parking protocol, and this patch:
>>
>>  https://lkml.org/lkml/2015/5/1/203
>>
>> need to get the PMU irq from the same table. I've been thinking of
>> something like a single loop through the table in setup.c with
>> callouts to registered users of the various bits of data.
> 
> It is not off topic at all, it is bang on topic. I hate the code
> as it stands forcing parsing the MADT in multiple places at different
> times, that's why I added hooks to set the parking protocol entries
> from smp.c and I know that's ugly, I posted it like this on purpose
> to get feedback.
> 
>> Those users could register a handler function with something like an
>> ACPI_MADT_GIC_DECLARE() macro which would add a handler to a
>> special linker section.
>>
>> I could work up a separate patch if others think it a worthwhile
>> thing to do.
> 
> Something simpler ? Like stashing the GICC entries (I know we need
> permanent table mappings for that to work unless we create data
> structures out of the MADT entries with the fields we are interested in)
> for possible CPUS ?

Right -- it seems like it would be pretty straightforward to traverse
the MADT once, and capture all the GICC subtables in a list of pointers,
or even make a copy of the contents of all of them.  Each user of the
content would still have to traverse the list, though, unless data is
reduced to only those things that are needed and the rest tossed.  Even
if only keep the info needed, I've still got a list of entries, one for
each CPU, I think, that I would still have to traverse.

If I have to register a handler to gather a specific bit of data needed,
I'm not understanding how that's any less complicated than what I need
to do today -- call acpi_parse_table_madt() with my GICC handler.  Wouldn't
both GICC subtable handlers be just about the same code?

I'm probably missing something obvious, but I'm not understanding what problem
is being solved....

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
