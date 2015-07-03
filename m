From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 03 Jul 2015 02:21:02 +0200
Subject: [PATCH v3 1/3] ACPI : introduce macros for using the ACPI
 specification version
In-Reply-To: <1435880916-2153-2-git-send-email-al.stone@linaro.org>
References: <1435880916-2153-1-git-send-email-al.stone@linaro.org>
 <1435880916-2153-2-git-send-email-al.stone@linaro.org>
Message-ID: <2553932.NLQ9D78ybW@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 02, 2015 05:48:34 PM Al Stone wrote:
> Add the __ACPI_FADT_SPEC_VERSION() helper macro to build a proper version
> number from a major and minor revision number.  Add also macros that use
> the helper to construct the current version from the values in the FADT
> (i.e., ACPI_FADT_SPEC_VERSION) and both the 5.1 and 6.0 versions.
> 
> These macros are added in order to simplify retrieving and comparing ACPI
> specification version numbers, since this is becoming a more frequent need.
> In particular, there are some architectures that require at least a certain
> version of the spec, and there are differences in some structure sizes that
> have changed with recent versions but can only be tracked by spec version
> number.
> 
> Fixes: aeb823bbacc2 (ACPICA: ACPI 6.0: Add changes for FADT table.)
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  include/linux/acpi.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index c471dfc..0e525e8 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -48,6 +48,16 @@
>  #include <acpi/acpi_io.h>
>  #include <asm/acpi.h>
>  
> +#define __ACPI_FADT_SPEC_VERSION(major, minor) \
> +	((unsigned int)major << 8 | (unsigned int)minor)
> +
> +#define ACPI_FADT_SPEC_VERSION	\
> +	__ACPI_FADT_SPEC_VERSION(acpi_gbl_FADT.header.revision, \
> +				 acpi_gbl_FADT.minor_revision)
> +
> +#define ACPI_FADT_SPEC_VERSION_51 __ACPI_FADT_SPEC_VERSION(5, 1)
> +#define ACPI_FADT_SPEC_VERSION_60 __ACPI_FADT_SPEC_VERSION(6, 0)

I'd add underscores here, eg. ACPI_FADT_SPEC_VERSION_6_0

And what if there is 5.2 or even 5.3?

> +
>  static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
>  {
>  	return adev ? adev->handle : NULL;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
