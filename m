From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 30 Apr 2018 09:59:27 +0200
Subject: [PATCH v8 05/13] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
In-Reply-To: <b750e86b-bc51-0440-b48d-0e8d3177fa8d@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <CAJZ5v0jjPnyC0vm-Fb8y2hw1B9Uc2J5sZrtZYzt_ENT2Sini3A@mail.gmail.com>
 <b750e86b-bc51-0440-b48d-0e8d3177fa8d@arm.com>
Message-ID: <14124257.1v74WDqhJi@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 27, 2018 6:20:44 PM CEST Jeremy Linton wrote:
> Hi,
> 
> Thanks for taking a look at this.
> 
> On 04/27/2018 06:02 AM, Rafael J. Wysocki wrote:
> > On Thu, Apr 26, 2018 at 1:31 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> >> ACPI 6.2 adds a new table, which describes how processing units
> >> are related to each other in tree like fashion. Caches are
> >> also sprinkled throughout the tree and describe the properties
> >> of the caches in relation to other caches and processing units.
> >>
> >> Add the code to parse the cache hierarchy and report the total
> >> number of levels of cache for a given core using
> >> acpi_find_last_cache_level() as well as fill out the individual
> >> cores cache information with cache_setup_acpi() once the
> >> cpu_cacheinfo structure has been populated by the arch specific
> >> code.
> >>
> >> An additional patch later in the set adds the ability to report
> >> peers in the topology using find_acpi_cpu_topology()
> >> to report a unique ID for each processing unit at a given level
> >> in the tree. These unique id's can then be used to match related
> >> processing units which exist as threads, within a given
> >> package, etc.
> >>
> >> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> >> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> >> ---
> >>   drivers/acpi/pptt.c | 518 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 518 insertions(+)
> >>   create mode 100644 drivers/acpi/pptt.c
> >>
> >> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> >> new file mode 100644
> >> index 000000000000..cced71ef851a
> >> --- /dev/null
> >> +++ b/drivers/acpi/pptt.c
> >> @@ -0,0 +1,518 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * pptt.c - parsing of Processor Properties Topology Table
> >> + *
> >> + * Copyright (C) 2018, ARM
> >> + *
> >> + * This file implements parsing of Processor Properties Topology Table (PPTT)
> >> + * which is optionally used to describe the processor and cache topology.
> >> + * Due to the relative pointers used throughout the table, this doesn't
> >> + * leverage the existing subtable parsing in the kernel.
> >> + *
> >> + * The PPTT structure is an inverted tree, with each node potentially
> >> + * holding one or two inverted tree data structures describing
> >> + * the caches available at that level. Each cache structure optionally
> >> + * contains properties describing the cache at a given level which can be
> >> + * used to override hardware probed values.
> >> + */
> >> +#define pr_fmt(fmt) "ACPI PPTT: " fmt
> >> +
> >> +#include <linux/acpi.h>
> >> +#include <linux/cacheinfo.h>
> >> +#include <acpi/processor.h>
> >> +
> >> +/**
> >> + * fetch_pptt_subtable() - Find/Verify that the PPTT ref is a valid subtable
> > 
> > The parens above are at least redundant (if not harmful).  Everywhere
> > else in a similar context too.
> 
> The kerneldoc ones? I guess i'm confused the kernel doc example in 
> doc-guide/kernel-doc has
> 
> * function_name() - Brief description of function.

Well, OK, the parens not harmful, then, but it works without them.
