From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 12 Jun 2015 15:52:44 +0100
Subject: [PATCH 2/3] ACPI: add BAD_MADT_GICC_ENTRY() macro
In-Reply-To: <1434051911-14665-3-git-send-email-al.stone@linaro.org>
References: <1434051911-14665-1-git-send-email-al.stone@linaro.org>
 <1434051911-14665-3-git-send-email-al.stone@linaro.org>
Message-ID: <20150612145244.GB27385@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 08:45:10PM +0100, al.stone at linaro.org wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> The BAD_MADT_ENTRY() macro is designed to work for all of the subtables
> of the MADT.  In the ACPI 5.1 version of the spec, the struct for the
> GICC subtable (struct acpi_madt_generic_interrupt) is 76 bytes long; in
> ACPI 6.0, the struct is 80 bytes long.  But, there is only one definition
> in ACPICA for this struct -- and that is the 6.0 version.  Hence, when
> BAD_MADT_ENTRY() compares the struct size to the length in the GICC
> subtable, it fails if 5.1 structs are in use, and there are systems in
> the wild that have them.
> 
> This patch adds the BAD_MADT_GICC_ENTRY() that checks the GICC subtable
> only, accounting for the difference in specification versions that are
> possible.  The BAD_MADT_ENTRY() will continue to work as is for all other
> MADT subtables.

Unfortunately that's nothing new, it seems. ia64 put in place a quite
nifty solution to that (I *guess* owing to ACPI 3.0 updates to Local
sapic specs), have a look at:

arch/ia64/kernel/acpi.c acpi_parse_lsacpi()

/*Skip BAD_MADT_ENTRY check, as lsapic size could vary */

We remove the check, job done ;-)

> Signed-off-by: Al Stone <al.stone@linaro.org>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> Reviewed-by: Graeme Gregory <graeme.gregory@linaro.org>
> 
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Len Brown <lenb@kernel.org>
> 
> ---
>  include/linux/acpi.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 33ed313..8a83f91 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -127,6 +127,13 @@ static inline void acpi_initrd_override(void *data, size_t size)
>  		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
>  		((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
>  
> +#define BAD_MADT_GICC_ENTRY(entry, end) (				    \
> +		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
> +		((ACPI_FADT_SPEC_VERSION == ACPI_SPEC_VERSION(5,1)) &&	    \
> +		 (entry->header.length != 76))				||  \
> +		((ACPI_FADT_SPEC_VERSION == ACPI_SPEC_VERSION(6,0)) &&	    \
> +		 (entry->header.length != 80)))

I would make those length magic numbers ACPICA defines at least.

It is not a GICC only issue, that's true for all MADT subtables that change
size with versions so, maybe we can replace the sizeof(*entry) in
BAD_MADT_ENTRY with a macro compound statement returning the subtable
length (where you can add a switch case on entry->type and return
sizeof(*entry) in the default case) ?

Overkill ? Certainly ugly, but at least you do not need to patch anything
else.

I am inclined to relegate these checks to ACPICA tools (statically)
altogether.

It is better to check Len and Rafael opinion on this first before coding it.

Lorenzo
