From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 27 Feb 2016 09:49:16 +0800
Subject: [PATCH] ARM64: ACPI: Update documentation for latest
 specification version
In-Reply-To: <1455926041-9579-1-git-send-email-al.stone@linaro.org>
References: <1455926041-9579-1-git-send-email-al.stone@linaro.org>
Message-ID: <56D1009C.90803@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

On 2016/2/20 7:54, al.stone at linaro.org wrote:
> From: Al Stone <al.stone@linaro.org>	
>
> The ACPI 6.1 specification was recently released at the end of January 2016,
> but the arm64 kernel documentation for the use of ACPI was written for the
> 5.1 version of the spec.  There were significant additions to the spec that
> had not yet been mentioned -- for example, the 6.0 mechanisms added to make
> it easier to define processors and low power idle states, as well as the
> 6.1 addition allowing regular interrupts (not just from GPIO) be used to
> signal ACPI general purpose events.
>
> This patch reflects going back through and examining the specs in detail
> and updating content appropriately.  Whilst there, a few odds and ends of
> typos were caught as well.  This brings the documentation up to date with
> ACPI 6.1 for arm64.
>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  Documentation/arm64/acpi_object_usage.txt | 433 ++++++++++++++++++++++--------
>  Documentation/arm64/arm-acpi.txt          |  28 +-
>  2 files changed, 346 insertions(+), 115 deletions(-)
>
> diff --git a/Documentation/arm64/acpi_object_usage.txt b/Documentation/arm64/acpi_object_usage.txt
> index a6e1a18..e321235 100644
> --- a/Documentation/arm64/acpi_object_usage.txt
> +++ b/Documentation/arm64/acpi_object_usage.txt
> @@ -13,13 +13,14 @@ For ACPI on arm64, tables also fall into the following categories:
>  
>         -- Required: DSDT, FADT, GTDT, MADT, MCFG, RSDP, SPCR, XSDT
>  
> -       -- Recommended: BERT, EINJ, ERST, HEST, SSDT
> +       -- Recommended: BERT, EINJ, ERST, HEST, IORT, PCCT, SSDT

I would suggest IORT is Required, because IORT is the key table for supporting
PCI MSI (MCFG is required above and I think ARM server should have PCI :) ), also
IORT is needed for SMMU and platform  MSI.

>  
> -       -- Optional: BGRT, CPEP, CSRT, DRTM, ECDT, FACS, FPDT, MCHI, MPST,
> -          MSCT, RASF, SBST, SLIT, SPMI, SRAT, TCPA, TPM2, UEFI
> +       -- Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, MCHI,
> +          MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, SPMI, SRAT, STAO, TCPA,
> +	  TPM2, UEFI, XENV
>  
> -       -- Not supported: BOOT, DBG2, DBGP, DMAR, ETDT, HPET, IBFT, IVRS,
> -          LPIT, MSDM, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
> +       -- Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IBFT, IVRS, LPIT, 
> +          MSDM, OEMx, PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
>  
>  
>  Table  Usage for ARMv8 Linux
> @@ -50,7 +51,9 @@ CSRT   Signature Reserved (signature == "CSRT")
>  
>  DBG2   Signature Reserved (signature == "DBG2")
>         == DeBuG port table 2 ==
> -       Microsoft only table, will not be supported.
> +       License has changed and should be usable.  

> Patches are available as of
> +       this writing, but they have not been accepted into the kernel.  Optional

The information will be outdated once those patches are accepted, can we remove
it?

> +       if used instead of earlycon=<device> on the command line.
>  
>  DBGP   Signature Reserved (signature == "DBGP")
>         == DeBuG Port table ==
> @@ -133,10 +136,11 @@ GTDT   Section 5.2.24 (signature == "GTDT")
>  
>  HEST   Section 18.3.2 (signature == "HEST")
>         == Hardware Error Source Table ==
> -       Until further error source types are defined, use only types 6 (AER
> -       Root Port), 7 (AER Endpoint), 8 (AER Bridge), or 9 (Generic Hardware
> -       Error Source).  Firmware first error handling is possible if and only
> -       if Trusted Firmware is being used on arm64.
> +       ARM-specific error sources have been defined; please use those or the
> +       PCI types such as type 6 (AER Root Port), 7 (AER Endpoint), or 8 (AER 
> +       Bridge), or use type 9 (Generic Hardware Error Source).  Firmware first
> +       error handling is possible if and only if Trusted Firmware is being 
> +       used on arm64.
>  
>         Must be supplied if RAS support is provided by the platform.  It
>         is recommended this table be supplied.
> @@ -149,20 +153,26 @@ IBFT   Signature Reserved (signature == "IBFT")
>         == iSCSI Boot Firmware Table ==
>         Microsoft defined table, support TBD.
>  
> +IORT   Signature Reserved (signature == "IORT")
> +       == Input Output Remapping Table ==
> +       arm64 only table, required in order to describe the SMMU and/or ITS 
> +       when it is provided by the platform.

How about the following:

"arm64 only table, required in order to describe IO topology, SMMUs, and GIC ITSs,
and how those various components are connected together, such as identify which
components are behind which SMMU/ITS(ITSs)."

Thanks
Hanjun
