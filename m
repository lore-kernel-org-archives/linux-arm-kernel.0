From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Mar 2017 18:53:10 +0000
Subject: [PATCH 12/14] arm64: kill acpi_set_mailbox_entry()
In-Reply-To: <20170321183755.GA2976@red-moon>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
 <1489143891-11596-13-git-send-email-mark.rutland@arm.com>
 <20170321180040.GA4849@red-moon>
 <20170321181554.GF29116@leverpostej>
 <20170321183755.GA2976@red-moon>
Message-ID: <20170321185310.GG29116@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 06:37:55PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Mar 21, 2017 at 06:15:54PM +0000, Mark Rutland wrote:
> > On Tue, Mar 21, 2017 at 06:00:40PM +0000, Lorenzo Pieralisi wrote:
> > > On Fri, Mar 10, 2017 at 11:04:49AM +0000, Mark Rutland wrote:
> > 
> > > > +static struct parking_protocol_mailbox __iomem *mailboxes[NR_CPUS];
> > > 
> > > Nit: If I am not mistaken it can be made a percpu pointer.
> > 
> > Unfortunately, we don't set up the percpu areas until we know how many
> > CPUs are possible (i.e. after we've parsed the MADT).
> > 
> > The flow looks like:
> > 
> > start_kernel()
> >   setup_arch()
> >     smp_init_cpus()
> >       acpi_table_parse_madt()
> >         acpi_parse_gic_cpu_interface()
> >           acpi_map_gic_cpu_interface() // setup cpu mailbox here
> 
> The mailbox data yes, not the pointer at which it is mapped (which
> is what gets stashed in mailboxes[]).

Sorry, I got myself confused here between this and the MADT GICC
stashing to which the above does apply.

You are correct that this can and should be a percpu pointer.

I'll fix this up. I just need to figure out where the __iomem attribute
is supposed to live on a percpu definition.

Thanks,
Mark.
