From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 17 Jul 2015 11:35:00 +0100
Subject: [PATCH] ARM64: kernel: implement ACPI parking protocol
In-Reply-To: <1437068449.3583.4.camel@redhat.com>
References: <1436959990-32054-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1437063431.3583.2.camel@redhat.com>
 <20150716171221.GB18582@red-moon>
 <1437068449.3583.4.camel@redhat.com>
Message-ID: <20150717103500.GA19067@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[CC'ing Ard in relation to the ioremap issue]

On Thu, Jul 16, 2015 at 06:40:49PM +0100, Mark Salter wrote:
> On Thu, 2015-07-16 at 18:12 +0100, Lorenzo Pieralisi wrote:
> 
> > On Thu, Jul 16, 2015 at 05:17:11PM +0100, Mark Salter wrote:
> 
> > > On Wed, 2015-07-15 at 12:33 +0100, Lorenzo Pieralisi wrote:
> > >
> 
> > > > The SBBR and ACPI specifications allow ACPI based systems that do not
> > > > implement PSCI (eg systems with no EL3) to boot through the ACPI parking
> > > > protocol specification[1].
> > > >
> > > > This patch implements the ACPI parking protocol CPU operations, and adds
> > > > code that eases parsing the parking protocol data structures to the
> > > > ARM64 SMP initializion carried out at the same time as cpus enumeration.
> > > >
> > > > To wake-up the CPUs from the parked state, this patch implements a
> > > > wakeup IPI for ARM64 (ie arch_send_wakeup_ipi_mask()) that mirrors the
> > > > ARM one, so that a specific IPI is sent for wake-up purpose in order
> > > > to distinguish it from other IPI sources.
> > > >
> > > > Given the current ACPI MADT parsing API, the patch implements a glue
> > > > layer that helps passing MADT GICC data structure from SMP initialization
> > >
> > > Somewhat off topic, but this reminds once again, that it might be
> > > better to generalize the ACPI_MADT_TYPE_GENERIC_INTERRUPT so that it
> > > could be done in one pass. Currently, the SMP code and the GIC code
> > > need boot-time info from ACPI_MADT_TYPE_GENERIC_INTERRUPT tables. This
> > > patch adds parking protocol, and this patch:
> > >
> > >  https://lkml.org/lkml/2015/5/1/203
> > >
> > > need to get the PMU irq from the same table. I've been thinking of
> > > something like a single loop through the table in setup.c with
> > > callouts to registered users of the various bits of data.
> >
> > It is not off topic at all, it is bang on topic. I hate the code
> > as it stands forcing parsing the MADT in multiple places at different
> > times, that's why I added hooks to set the parking protocol entries
> > from smp.c and I know that's ugly, I posted it like this on purpose
> > to get feedback.
> >
> 
> > > Those users could register a handler function with something like an
> > > ACPI_MADT_GIC_DECLARE() macro which would add a handler to a
> > > special linker section.
> > >
> > > I could work up a separate patch if others think it a worthwhile
> > > thing to do.
> >
> > Something simpler ? Like stashing the GICC entries (I know we need
> > permanent table mappings for that to work unless we create data
> > structures out of the MADT entries with the fields we are interested in)
> > for possible CPUS ?
> >
> 
> I thought about that too. Permanent mapping doesn't save you from
> having to parse more than once (validating the entries over and
> over). Parsing once and saving the info is better but if done
> generically, could end up wasting memory. I thought the handler
> callout would work best so that the user of the info could decide
> what needed saving and how to save it most efficiently. I'll put
> together a patch and we can go from there to improve it.

Ok, thanks, happy to review it and test it.

> > > > code to the parking protocol implementation somewhat overriding the CPU
> > > > operations interfaces. This to avoid creating a completely trasparent
> > >                                                              ^^^ transparent
> >
> > Ok.
> >
> > [...]
> >
> 
> 
> > > > +static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
> > > > +{
> > > > +     struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
> > > > +     struct parking_protocol_mailbox __iomem *mailbox;
> > > > +     __le32 cpu_id;
> > > > +
> > > > +     /*
> > > > +      * Map mailbox memory with attribute device nGnRE (ie ioremap -
> > > > +      * this deviates from the parking protocol specifications since
> > > > +      * the mailboxes are required to be mapped nGnRnE; the attribute
> > > > +      * discrepancy is harmless insofar as the protocol specification
> > > > +      * is concerned).
> > > > +      * If the mailbox is mistakenly allocated in the linear mapping
> > > > +      * by FW ioremap will fail since the mapping will be prevented
> > > > +      * by the kernel (it clashes with the linear mapping attributes
> > > > +      * specifications).
> > > > +      */
> > > > +     mailbox = ioremap(cpu_entry->mailbox_addr, sizeof(*mailbox));
> > > > +     if (!mailbox)
> > > > +             return -EIO;
> > > > +
> > > > +     cpu_id = readl_relaxed(&mailbox->cpu_id);
> > > > +     /*
> > > > +      * Check if firmware has set-up the mailbox entry properly
> > > > +      * before kickstarting the respective cpu.
> > > > +      */
> > > > +     if (cpu_id != ~0U) {
> > > > +             iounmap(mailbox);
> > > > +             return -ENXIO;
> > > > +     }
> > > > +
> > > > +     /*
> > > > +      * We write the entry point and cpu id as LE regardless of the
> > > > +      * native endianness of the kernel. Therefore, any boot-loaders
> > > > +      * that read this address need to convert this address to the
> > > > +      * Boot-Loader's endianness before jumping.
> > > > +      */
> > > > +     writeq_relaxed(__pa(secondary_entry), &mailbox->entry_point);
> > > > +     writel_relaxed(cpu_entry->gic_cpu_id, &mailbox->cpu_id);
> > > > +
> > > > +     arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> > > > +
> > > > +     iounmap(mailbox);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void acpi_parking_protocol_cpu_postboot(void)
> > > > +{
> > > > +     int cpu = smp_processor_id();
> > > > +     struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
> > > > +     struct parking_protocol_mailbox __iomem *mailbox;
> > > > +     __le64 entry_point;
> > > > +
> > > > +     /*
> > > > +      * Map mailbox memory with attribute device nGnRE (ie ioremap -
> > > > +      * this deviates from the parking protocol specifications since
> > > > +      * the mailboxes are required to be mapped nGnRnE; the attribute
> > >
> > > Where is the nGnRnE requirement? I couldn't find it in the protocol doc.
> > > Just curious.
> >
> > Page 11 (3.5 Mailbox Access Rules), in the Note
> > "...On ARM v8 Systems, the OS must map the memory as Device-nGnRnE".
> >
> 
> That explains it. The document you linked to only has 10 pages and no
> mention of specific attributes. Maybe you have one which is not public
> yet.

No, I do not have a special edition, the one I added to the log
defines what I mentioned, here:

https://acpica.org/related-documents
"Multi-processor Startup for ARM Platforms"

in 3.5 attributes are explicitly mentioned.

> > > > +      * discrepancy is harmless insofar as the protocol specification
> > > > +      * is concerned).
> > > > +      * If the mailbox is mistakenly allocated in the linear mapping
> > > > +      * by FW ioremap will fail since the mapping will be prevented
> > > > +      * by the kernel (it clashes with the linear mapping attributes
> > > > +      * specifications).
> > >
> > > The kernel will only add cached memory regions to linear mapping and
> > > presumably, the FW will mark the mailboxes as uncached. Otherwise, it
> > > is a FW bug. But I suppose we could run into problems with kernels
> > > using 64K pagesize since firmware assumes 4k.
> >
> > Nope, ioremap takes care of that, everything should be fine.
> 
> The mailbox is 4K. If it is next to a cached UEFI region, the kernel may
> have to overlap the mailbox with a cached 64K mapping in order to include
> the adjoining UEFI region in the linear map. Then the ioremap would fail
> because the mailbox is included in the linear mapping.

Ok, I thought you were referring to the ioremap implementation and
the related 4K vs 64k alignment/offset issues.

I think this has been already debated here (from a different perspective
but that's the same problem):

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/276586.html

That's what you are referring to, right ?

> > Did you give this patch a go ?
> 
> No. I have nothing to try it on. All firmware implementations I have
> access to mark the mailboxes as cached memory. And one requires an
> event rather than irq for wakeup because it tries to satisfy both
> spin-table and parking protocol at the same time. There's a sad amount
> of necessary hackery right now. I'm very keen on psci saving us from
> all that on future platforms. And non-compliant existing firmwares
> will need to get compliant whenever parking protocol gets pulled in
> upstream.

Excellent, it looks promising. Yes, PSCI will save us from all this
stuff, but that's not the reason why I posted this code, I posted
it to enable platforms that can't rely on PSCI at all.

I do not think we should change this patch though, except for possibly
handling the ioremap issue above, somehow.

Lorenzo
