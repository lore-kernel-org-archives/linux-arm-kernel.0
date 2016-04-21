From: alexey.klimov@arm.com (Alexey Klimov)
Date: Thu, 21 Apr 2016 14:37:56 +0100
Subject: [PATCH v4] ARM64: ACPI: Update documentation for latest
 specification version
In-Reply-To: <1461007942-20969-1-git-send-email-al.stone@linaro.org>
Message-ID: <20160421133740.GA24209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

I hope you don't mind if I put few minor questions here.

On Mon, Apr 18, 2016 at 8:32 PM, Al Stone <al.stone@linaro.org> wrote:
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

Why linux-acpi is not in the destination list?
 
> Changes for v4:
>    -- Clarify that IORT can sometimes be optional (Jon Masters).
>    -- Remove "Use as needed" descriptions of ACPI objects; they provide
>       no substantive information and doing so simplifies maintenance of
>       this document over time.  These have been replaced with a simpler
>       notice that states that unless otherwise noted, do what the APCI
>       specification says is needed.
>    -- Corrected the _OSI object usage recommendation; it described kernel
>       behavior that does not exist (Al Stone).
> 
> Changes for v3:
>    -- Clarify use of _LPI/_RDI (Vikas Sajjan)
>    -- Whitespace cleanup as pointed out by checkpatch
> 
> Changes for v2:
>    -- Clean up white space (Harb Abdulhahmid)
>    -- Clarification on _CCA usage (Harb Abdulhamid)
>    -- IORT moved to required from recommended (Hanjun Guo)
>    -- Clarify IORT description (Hanjun Guo)
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/arm64/acpi_object_usage.txt | 347 ++++++++++++++++--------------
>  Documentation/arm64/arm-acpi.txt          |  28 ++-
>  2 files changed, 212 insertions(+), 163 deletions(-)
> 
> diff --git a/Documentation/arm64/acpi_object_usage.txt
> b/Documentation/arm64/acpi_object_usage.txt
> index a6e1a18..3891750 100644
> --- a/Documentation/arm64/acpi_object_usage.txt
> +++ b/Documentation/arm64/acpi_object_usage.txt
> @@ -13,14 +13,18 @@ For ACPI on arm64, tables also fall into the
> following categories:

[..]

>         == Memory-mapped ConFiGuration space ==
> @@ -176,14 +192,38 @@ MPST   Section 5.2.21 (signature == "MPST")
>         == Memory Power State Table ==
>         Optional, not currently supported.
> 
> +MSCT   Section 5.2.19 (signature == "MSCT")
> +       == Maximum System Characteristic Table ==
> +       Optional, not currently supported.
> +
>  MSDM   Signature Reserved (signature == "MSDM")
>         == Microsoft Data Management table ==
>         Microsoft only table, will not be supported.
> 
> -MSCT   Section 5.2.19 (signature == "MSCT")
> -       == Maximum System Characteristic Table ==
> +NFIT   Section 5.2.25 (signature == "NFIT")
> +       == NVDIMM Firmware Interface Table ==
>         Optional, not currently supported.
> 
> +OEMx   Signature of "OEMx" only
> +       == OEM Specific Tables ==
> +       All tables starting with a signature of "OEM" are reserved for OEM
> +       use.  Since these are not meant to be of general use but are limited
> +       to very specific end users, they are not recommended for use and are
> +       not supported by the kernel for arm64.
> +
> +PCCT   Section 14.1 (signature == "PCCT)
> +       == Platform Communications Channel Table ==
> +       Recommend for use on arm64, and required when using CPPC to control
> +       power on the platform.

Could you please check corectness of this sentence?

If I remember correctly CPPC may operate via PCC interface but there is no
strict requirement to implement control mechanism via PCC.

> using CPPC to control power on the platform

Sorry, I think I need to disagree.
Main description of CPPC says that CPPC defines mechanism to manage performance
of logical processor.

What do you think about "to control performance on the platform"?
(or maybe "to control performance and power on the platform")

Thanks,
Alexey
