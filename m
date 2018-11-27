From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 27 Nov 2018 15:01:50 +0000
Subject: [PATCH 2/2] arm64: acpi: Prepare for longer MADTs
In-Reply-To: <20181012192937.3819951-1-jeremy.linton@arm.com>
References: <20181012192937.3819951-1-jeremy.linton@arm.com>
Message-ID: <20181127150150.GA25270@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 02:29:37PM -0500, Jeremy Linton wrote:
> The BAD_MADT_GICC_ENTRY check is a little too strict because
> it rejects MADT entries that don't match the currently known
> lengths. We should remove this restriction to avoid problems
> if the table length changes. Future code which might depend on
> additional fields should be written to validate those fields
> before using them, rather than trying to globally check
> known MADT version lengths.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/include/asm/acpi.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Hi Jeremy,

as mentioned, I added a comment to the macro so that in the future
we will be able to remember the logic behind it.

I pushed the commit out:

git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git acpi/madt

Please have a look, if I hear no objections I shall be sending it to
Will and Catalin to queue it for v4.21.

Thanks,
Lorenzo

> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 709208dfdc8b..4d0946bd485a 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -22,12 +22,12 @@
>  #include <asm/tlbflush.h>
>  
>  /* Macros for consistency checks of the GICC subtable of MADT */
> -#define ACPI_MADT_GICC_LENGTH	\
> -	(acpi_gbl_FADT.header.revision < 6 ? 76 : 80)
> +#define ACPI_MADT_GICC_MIN_LENGTH   ACPI_OFFSET(  \
> +	struct acpi_madt_generic_interrupt, efficiency_class)
>  
>  #define BAD_MADT_GICC_ENTRY(entry, end)					\
> -	(!(entry) || (entry)->header.length != ACPI_MADT_GICC_LENGTH ||	\
> -	(unsigned long)(entry) + ACPI_MADT_GICC_LENGTH > (end))
> +	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
> +	(unsigned long)(entry) + (entry)->header.length > (end))
>  
>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
> -- 
> 2.14.3
> 
