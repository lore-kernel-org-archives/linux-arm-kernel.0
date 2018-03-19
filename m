From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 19 Mar 2018 11:46:20 +0100
Subject: [PATCH v7 05/13] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
In-Reply-To: <20180228220619.6992-6-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-6-jeremy.linton@arm.com>
Message-ID: <2844054.uKnBIypXtU@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 28, 2018 11:06:11 PM CET Jeremy Linton wrote:
> ACPI 6.2 adds a new table, which describes how processing units
> are related to each other in tree like fashion. Caches are
> also sprinkled throughout the tree and describe the properties
> of the caches in relation to other caches and processing units.
> 
> Add the code to parse the cache hierarchy and report the total
> number of levels of cache for a given core using
> acpi_find_last_cache_level() as well as fill out the individual
> cores cache information with cache_setup_acpi() once the
> cpu_cacheinfo structure has been populated by the arch specific
> code.
> 
> An additional patch later in the set adds the ability to report
> peers in the topology using find_acpi_cpu_topology()
> to report a unique ID for each processing unit at a given level
> in the tree. These unique id's can then be used to match related
> processing units which exist as threads, COD (clusters
> on die), within a given package, etc.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

A couple of cosmetic comments.

> ---
>  drivers/acpi/pptt.c | 488 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 488 insertions(+)
>  create mode 100644 drivers/acpi/pptt.c
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> new file mode 100644
> index 000000000000..883e4318c6cd
> --- /dev/null
> +++ b/drivers/acpi/pptt.c
> @@ -0,0 +1,488 @@

Use an SPDX license ID here and then you don't need the license boilerplate
below.

> +/*
> + * Copyright (C) 2018, ARM
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * This file implements parsing of Processor Properties Topology Table (PPTT)
> + * which is optionally used to describe the processor and cache topology.
> + * Due to the relative pointers used throughout the table, this doesn't
> + * leverage the existing subtable parsing in the kernel.
> + *
> + * The PPTT structure is an inverted tree, with each node potentially
> + * holding one or two inverted tree data structures describing
> + * the caches available at that level. Each cache structure optionally
> + * contains properties describing the cache at a given level which can be
> + * used to override hardware probed values.
> + */
> +#define pr_fmt(fmt) "ACPI PPTT: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/cacheinfo.h>
> +#include <acpi/processor.h>
> +
> +/*
> + * Given the PPTT table, find and verify that the subtable entry
> + * is located within the table
> + */

If you add a comment above a function, make it a kerneldoc.  That
never hurts, but really helps sometimes.

> +static struct acpi_subtable_header *fetch_pptt_subtable(

Don't break the line here, it can be broken after the first arg.

That's OK even if it is more than 80 chars long.

> +	struct acpi_table_header *table_hdr, u32 pptt_ref)
> +{
> +	struct acpi_subtable_header *entry;
> +
> +	/* there isn't a subtable at reference 0 */
> +	if (pptt_ref < sizeof(struct acpi_subtable_header))
> +		return NULL;
> +
> +	if (pptt_ref + sizeof(struct acpi_subtable_header) > table_hdr->length)
> +		return NULL;
> +
> +	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr, pptt_ref);
> +
> +	if (pptt_ref + entry->length > table_hdr->length)
> +		return NULL;
> +
> +	return entry;
> +}
> +
> +static struct acpi_pptt_processor *fetch_pptt_node(
> +	struct acpi_table_header *table_hdr, u32 pptt_ref)
> +{
> +	return (struct acpi_pptt_processor *)fetch_pptt_subtable(table_hdr,
> +								 pptt_ref);

You don't need to break this line too.

> +}
> +
> +static struct acpi_pptt_cache *fetch_pptt_cache(
> +	struct acpi_table_header *table_hdr, u32 pptt_ref)
> +{
> +	return (struct acpi_pptt_cache *)fetch_pptt_subtable(table_hdr,
> +							     pptt_ref);

And here.

> +}
> +
> +static struct acpi_subtable_header *acpi_get_pptt_resource(
> +	struct acpi_table_header *table_hdr,
> +	struct acpi_pptt_processor *node, int resource)
> +{
> +	u32 *ref;
> +
> +	if (resource >= node->number_of_priv_resources)
> +		return NULL;
> +
> +	ref = ACPI_ADD_PTR(u32, node, sizeof(struct acpi_pptt_processor));
> +	ref += resource;
> +
> +	return fetch_pptt_subtable(table_hdr, *ref);
> +}
> +
> +/*
> + * Match the type passed and special case the TYPE_UNIFIED so that
> + * it match both ACPI_PPTT_CACHE_TYPE_UNIFIED(_ALT) types.
> + */
> +static inline bool acpi_pptt_match_type(int table_type, int type)
> +{
> +	return (((table_type & ACPI_PPTT_MASK_CACHE_TYPE) == type) ||
> +		(table_type & ACPI_PPTT_CACHE_TYPE_UNIFIED & type));
> +}
> +
> +/*
> + * Attempt to find a given cache level, while counting the max number
> + * of cache levels for the cache node.
> + *
> + * Given a pptt resource, verify that it is a cache node, then walk
> + * down each level of caches, counting how many levels are found
> + * as well as checking the cache type (icache, dcache, unified). If a
> + * level & type match, then we set found, and continue the search.
> + * Once the entire cache branch has been walked return its max
> + * depth.
> + */
> +static int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
> +				int local_level,
> +				struct acpi_subtable_header *res,
> +				struct acpi_pptt_cache **found,
> +				int level, int type)
> +{
> +	struct acpi_pptt_cache *cache;
> +
> +	if (res->type != ACPI_PPTT_TYPE_CACHE)
> +		return 0;
> +
> +	cache = (struct acpi_pptt_cache *) res;
> +	while (cache) {
> +		local_level++;
> +
> +		if ((local_level == level) &&
> +		    (cache->flags & ACPI_PPTT_CACHE_TYPE_VALID) &&
> +		    acpi_pptt_match_type(cache->attributes, type)) {
> +			if ((*found != NULL) && (cache != *found))

Inner parens are not necessary (and above and in some other places too).

> +				pr_err("Found duplicate cache level/type unable to determine uniqueness\n");

This is not an error, rather a statement that something is inconsistent in the
ACPI table, so please consider using a different log level here.

[cut]

I guess I could post similar comments for the other general ACPI patches in
this series, so please address them in there too if applicable.

Thanks!
