From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 10 Dec 2013 12:40:19 +0000
Subject: [Linaro-acpi] [PATCH v3 5/5] ACPI: do not map/unmap memory
 regions for FADT entries in reduced HW mode
In-Reply-To: <1386192127-28564-6-git-send-email-al.stone@linaro.org>
References: <1386192127-28564-1-git-send-email-al.stone@linaro.org> <
 1386192127-28564-6-git-send-email-al.stone@linaro.org>
Message-ID: <20131210124019.C14A5C40A27@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  4 Dec 2013 14:22:07 -0700, al.stone at linaro.org wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> Several of the FADT fields are normally kept in specific memory
> regions.  Since these fields are to be ignored in hardware reduced
> ACPI mode, do not map those addresses when in that mode, and of
> course do not release the mappings that have not been made.
> 
> The function acpi_os_initialize() could become a stub in the header
> file but is left here in case it can be of further use.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/osl.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 613e4a1..3a0bb92 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1776,10 +1776,12 @@ __setup("acpi_no_auto_ssdt", acpi_no_auto_ssdt_setup);
>  
>  acpi_status __init acpi_os_initialize(void)
>  {
> -	acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
> -	acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
> -	acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe0_block);
> -	acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe1_block);
> +	if (!acpi_gbl_reduced_hardware) {
> +		acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
> +		acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
> +		acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe0_block);
> +		acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe1_block);
> +	}

So, I'm confused. This patch is making the hardware reduced decision at
runtime (which is good), but the other patches are using #ifdef blocks
to take the code right out. Why the discrepancy?

g.
