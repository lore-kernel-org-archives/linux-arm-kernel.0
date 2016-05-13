From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 13 May 2016 09:48:50 +0800
Subject: [PATCH v5 1/1] ARM64: ACPI: Update documentation for latest
 specification version
In-Reply-To: <1461619287-27211-2-git-send-email-al.stone@linaro.org>
References: <1461619287-27211-1-git-send-email-al.stone@linaro.org>
 <1461619287-27211-2-git-send-email-al.stone@linaro.org>
Message-ID: <57353282.3090107@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/4/26 5:21, Al Stone wrote:
> The ACPI 6.1 specification was recently released at the end of January
> 2016, but the arm64 kernel documentation for the use of ACPI was written
> for the 5.1 version of the spec.  There were significant additions to the
> spec that had not yet been mentioned -- for example, the 6.0 mechanisms
> added to make it easier to define processors and low power idle states,
> as well as the 6.1 addition allowing regular interrupts (not just from
> GPIO) be used to signal ACPI general purpose events.
>
> This patch reflects going back through and examining the specs in detail
> and updating content appropriately.  Whilst there, a few odds and ends of
> typos were caught as well.  This brings the documentation up to date with
> ACPI 6.1 for arm64.
>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>   Documentation/arm64/acpi_object_usage.txt | 343 ++++++++++++++++--------------
>   Documentation/arm64/arm-acpi.txt          |  40 ++--
>   2 files changed, 213 insertions(+), 170 deletions(-)
>
> diff --git a/Documentation/arm64/acpi_object_usage.txt b/Documentation/arm64/acpi_object_usage.txt
> index a6e1a18..c77010c 100644
> --- a/Documentation/arm64/acpi_object_usage.txt
> +++ b/Documentation/arm64/acpi_object_usage.txt
> @@ -13,14 +13,14 @@ For ACPI on arm64, tables also fall into the following categories:
>
>          -- Required: DSDT, FADT, GTDT, MADT, MCFG, RSDP, SPCR, XSDT
>
> -       -- Recommended: BERT, EINJ, ERST, HEST, SSDT
> +       -- Recommended: BERT, EINJ, ERST, HEST, PCCT, SSDT
>
> -       -- Optional: BGRT, CPEP, CSRT, DRTM, ECDT, FACS, FPDT, MCHI, MPST,
> -          MSCT, RASF, SBST, SLIT, SPMI, SRAT, TCPA, TPM2, UEFI
> -
> -       -- Not supported: BOOT, DBG2, DBGP, DMAR, ETDT, HPET, IBFT, IVRS,
> -          LPIT, MSDM, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
> +       -- Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, IORT,
> +          MCHI, MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, SPMI, SRAT, STAO,
> +	  TCPA, TPM2, UEFI, XENV
>
> +       -- Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IBFT, IVRS, LPIT,
> +          MSDM, OEMx, PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
>
>   Table  Usage for ARMv8 Linux
>   -----  ----------------------------------------------------------------
> @@ -50,7 +50,8 @@ CSRT   Signature Reserved (signature == "CSRT")
>
>   DBG2   Signature Reserved (signature == "DBG2")
>          == DeBuG port table 2 ==
> -       Microsoft only table, will not be supported.
> +       License has changed and should be usable.  Optional if used instead
> +       of earlycon=<device> on the command line.
>
>   DBGP   Signature Reserved (signature == "DBGP")
>          == DeBuG Port table ==
> @@ -133,10 +134,11 @@ GTDT   Section 5.2.24 (signature == "GTDT")
>
>   HEST   Section 18.3.2 (signature == "HEST")
>          == Hardware Error Source Table ==
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
>          Must be supplied if RAS support is provided by the platform.  It
>          is recommended this table be supplied.
> @@ -149,20 +151,30 @@ IBFT   Signature Reserved (signature == "IBFT")
>          == iSCSI Boot Firmware Table ==
>          Microsoft defined table, support TBD.
>
> +IORT   Signature Reserved (signature == "IORT")
> +       == Input Output Remapping Table ==
> +       arm64 only table, required in order to describe IO topology, SMMUs,
> +       and GIC ITSs, and how those various components are connected together,
> +       such as identifying which components are behind which SMMUs/ITSs.
> +       This table will only be required on certain SBSA platforms (e.g.,
> +       when using GICv3-ITS and an SMMU); on SBSA Level 0 platforms, it
> +       remains optional.

Hmm, yes, for GICv2 based system, we don't need a IORT table,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
