From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 29 Mar 2017 12:33:05 +0100
Subject: [PATCH v22 07/11] acpi/arm64: Add GTDT table parse driver
In-Reply-To: <CADyBb7sDnp+p5Z=Cde-YS2UG8pxo9O=Tvkq8D79k37wOrUw19Q@mail.gmail.com>
References: <20170321163122.9183-1-fu.wei@linaro.org>
 <20170321163122.9183-8-fu.wei@linaro.org>
 <20170328113535.GA17440@red-moon>
 <CADyBb7v9jaiQjaWzwafkih_tsU+-hNi+TA7hcDbFgtLLChXM_g@mail.gmail.com>
 <20170329102118.GB10807@red-moon>
 <CADyBb7sDnp+p5Z=Cde-YS2UG8pxo9O=Tvkq8D79k37wOrUw19Q@mail.gmail.com>
Message-ID: <20170329113305.GA10960@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 06:48:26PM +0800, Fu Wei wrote:
> Hi Lorenzo,
> 
> On 29 March 2017 at 18:21, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > On Wed, Mar 29, 2017 at 05:48:17PM +0800, Fu Wei wrote:
> >
> > [...]
> >
> >>  * @platform_timer_count: It points to a integer variable which is used
> >>  *                           for storing the number of platform timers.
> >>  *                           This pointer could be NULL, if the caller
> >>  *                           doesn't need this info.
> >>
> >> >
> >> >> + *
> >> >> + * Return: 0 if success, -EINVAL if error.
> >> >> + */
> >> >> +int __init acpi_gtdt_init(struct acpi_table_header *table,
> >> >> +                       int *platform_timer_count)
> >> >> +{
> >> >> +     int ret = 0;
> >> >> +     int timer_count = 0;
> >> >> +     void *platform_timer = NULL;
> >> >> +     struct acpi_table_gtdt *gtdt;
> >> >> +
> >> >> +     gtdt = container_of(table, struct acpi_table_gtdt, header);
> >> >> +     acpi_gtdt_desc.gtdt = gtdt;
> >> >> +     acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
> >> >> +
> >> >> +     if (table->revision < 2)
> >> >> +             pr_warn("Revision:%d doesn't support Platform Timers.\n",
> >> >> +                     table->revision);
> >> >
> >> > Ok, two points here. First, I am not sure why you should warn if the
> >> > table revision is < 2, is that a FW bug ? I do not think it is, you
> >> > can just return 0.
> >>
> >> I used pr_debug here before v20, then I got Hanjun's suggestion:
> >> -------
> >> GTDT table revision is updated to 2 in ACPI 5.1, we will
> >> not support ACPI version under 5.1 and disable ACPI in FADT
> >> parse before this code is called, so if we get revision
> >> <2 here, I think we need to print warning (we need to keep
> >> the firmware stick to the spec on ARM64).
> >> -------
> >> https://lkml.org/lkml/2017/1/19/82
> >>
> >> So I started to use pr_warn.
> >
> > Thanks for the explanation, so it is a FW bug and the warning
> > is granted :) just leave it there.
> >
> > Still, please check my comment on acpi_gtdt_init() being called
> > multiple times on patch 11.
> 
> Thanks
> 
> For calling acpi_gtdt_init() twice:
> (1) 1st time: in early boot(bootmem), for init arch_timer and
> memory-mapped timer, we initialize the acpi_gtdt_desc.
> you can see that all the items in this struct are pointer.
> (2) 2nd time: when system switch from bootmem to slab, all the
> pointers in the acpi_gtdt_desc are invalid, so we have to
> re-initialize(re-map) them.
> 
> I have tested it, if we don't re-initialize  the acpi_gtdt_desc,
> system will go wrong.

Ok, that's what I feared. My complaint on patch 11 is that:

1) Stashing the GTDT pointer in acpi_gtdt_desc is not needed to
   parse SBSA watchdogs
2) It is not clear at all from the code or the commit log _why_ you
   need to call acpi_gtdt_init() again (ie technically you don't need
   to call it - you grab a valid pointer to the table and parse the
   watchdogs in the _same_ function gtdt_sbsa_gwdt_init())

I do not think there is much you can do to improve the arch timer gtdt
interface (and it is too late for that anyway) but in patch 11 it would
be ideal if you avoid calling acpi_gtdt_init() again, just parse GTDT
entries and initialize the corresponding watchdogs (ie pointers stashed
in acpi_gtdt_desc are stale anyway but that's __initdata so I can live
with that).

You should add comments to summarize this issue so that it can be
easily understood by anyone maintaining this code, it is not crystal
clear by reading the code why you need to multiple acpi_gtdt_init()
calls and that's not a piffling detail.

The ACPI patches are fine with me otherwise, I will complete the
review shortly.

Thanks !
Lorenzo
