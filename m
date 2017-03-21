From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 21 Mar 2017 18:37:55 +0000
Subject: [PATCH 12/14] arm64: kill acpi_set_mailbox_entry()
In-Reply-To: <20170321181554.GF29116@leverpostej>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
 <1489143891-11596-13-git-send-email-mark.rutland@arm.com>
 <20170321180040.GA4849@red-moon>
 <20170321181554.GF29116@leverpostej>
Message-ID: <20170321183755.GA2976@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 06:15:54PM +0000, Mark Rutland wrote:
> On Tue, Mar 21, 2017 at 06:00:40PM +0000, Lorenzo Pieralisi wrote:
> > On Fri, Mar 10, 2017 at 11:04:49AM +0000, Mark Rutland wrote:
> 
> > > +static struct parking_protocol_mailbox __iomem *mailboxes[NR_CPUS];
> > 
> > Nit: If I am not mistaken it can be made a percpu pointer.
> 
> Unfortunately, we don't set up the percpu areas until we know how many
> CPUs are possible (i.e. after we've parsed the MADT).
> 
> The flow looks like:
> 
> start_kernel()
>   setup_arch()
>     smp_init_cpus()
>       acpi_table_parse_madt()
>         acpi_parse_gic_cpu_interface()
>           acpi_map_gic_cpu_interface() // setup cpu mailbox here

The mailbox data yes, not the pointer at which it is mapped (which
is what gets stashed in mailboxes[]).

>   ...
>   setup_per_cpu_areas() // percpu available here
> 
> Otherwise, I completely agree that a percpu pointer would be the right
> thing to do.

Yes but the only purpose of the mailboxes array is to stash the
ioremap'ed VA after a secondary has been booted (through
cpu_ops->cpu_boot which is called to boot secondaries when per_cpu areas
are already set-up) to run checks in cpu_postboot() method, hence my
suggestion.

> 
> > Other than that:
> > 
> > Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> I take it this stands, given the above?

Yes, thanks for making this change.

Lorenzo
