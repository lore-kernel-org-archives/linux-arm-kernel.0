From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 19 Jun 2017 18:54:52 +0100
Subject: [PATCH v3 1/2] acpica: iort: Update SMMUv3 header for proximity
 domain mapping
In-Reply-To: <1496897059-8272-2-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1496897059-8272-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1496897059-8272-2-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <0d0d6cb6-7674-5751-d780-af5114ddd569@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/17 05:44, Ganapatrao Kulkarni wrote:
> ARM IORT specification (rev. C) has added two new fields to define
> proximity domain for the SMMUv3 node in the IORT table.
> 
> Proximity Domain Valid:
> 	Set to 1 if the value provided in the Proximity Domain field is
> 	valid. Set to 0 otherwise.
> 
> Proximity domain:
> 	If the Proximity Domain Valid flag is set to 1, this entry
> 	provides the proximity domain to which this SMMU
> 	instance belongs.
> 
> Update header file to reflect this.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  include/acpi/actbl2.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 4b306a6..389e91f 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -805,6 +805,9 @@ struct acpi_iort_smmu_v3 {
>  	u32 pri_gsiv;
>  	u32 gerr_gsiv;
>  	u32 sync_gsiv;
> +	u8 pxm;
> +	u8 reserved1;
> +	u16 reserved2;

Why add the padding if you're not also adding the following field that
it aligns? (side note: could it not just be a u8[3]?)

If the actual structure definition is changing, do there not need to be
corresponding IASL changes too?

>  };
>  
>  /* Values for Model field above */
> @@ -817,6 +820,7 @@ struct acpi_iort_smmu_v3 {
>  
>  #define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE   (1)
>  #define ACPI_IORT_SMMU_V3_HTTU_OVERRIDE     (1<<1)
> +#define ACPI_IORT_SMMU_V3_PXM_VALID         (1<<3)

Maybe it's just me, but "PXM" seems incredibly cryptic.

Robin.

>  
>  /*******************************************************************************
>   *
> 
