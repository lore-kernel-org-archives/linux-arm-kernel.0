From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 29 Jun 2018 13:18:16 -0500
Subject: [PATCH] ACPI/PPTT: use ACPI ID whenever
 ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set
In-Reply-To: <1530289077-2444-1-git-send-email-sudeep.holla@arm.com>
References: <1530289077-2444-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <955705e0-1d31-2c4b-3c5a-9c10603e36f8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/29/2018 11:17 AM, Sudeep Holla wrote:
> Currently we use the ACPI processor ID only for the leaf/processor nodes
> as the specification states it must match the value of ACPI processor ID
> field in the processor?s entry in the MADT.
> 
> However, if a PPTT structure represents processors group, it match a
> processor container UID in the namespace and ACPI_PPTT_ACPI_PROCESSOR_ID_VALID
> flag describe whether the ACPI processor ID is valid.
> 
> Lets use UID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set to be
> consistent instead of using table offset as it's currently done for non
> leaf nodes.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/acpi/pptt.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> Hi,
> 
> There's ongoing discussion on assigning ID based in OS using simple
> counters. It can never be consistent with firmware's view. So if the
> firmware provides valid UID for non-processors node, we must use it.
> 
> Regards,
> Sudeep
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index e5ea1974d1e3..d1e26cb599bf 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -481,8 +481,14 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
>   	if (cpu_node) {
>   		cpu_node = acpi_find_processor_package_id(table, cpu_node,
>   							  level, flag);
> -		/* Only the first level has a guaranteed id */
> -		if (level == 0)
> +		/*
> +		 * As per specification if the processor structure represents
> +		 * an actual processor, then ACPI processor ID must be valid.
> +		 * For processor containers ACPI_PPTT_ACPI_PROCESSOR_ID_VALID
> +		 * should be set if the UID is valid
> +		 */
> +		if (level == 0 ||
> +		    cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
>   			return cpu_node->acpi_processor_id;

While, for some machines this likely helps create more human readable 
ID's... What happens when the ID namespaces conflict with each other?

AKA, I'm a little shy of this change because your going from something 
we can guarantee is unique to depending on an portion of the PPTT 
definition that has a couple different ways that it can be interpreted.

OTOH the change is probably safe at the moment because i don't think 
anyone has partially marked nodes at a given PPTT "level" valid, or put 
structures that aren't part of the PE/cache's in the tree (outside of my 
juno test tree with the GPU's/etc).
