From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Sun, 24 Nov 2013 05:27:07 +0000
Subject: [PATCH] arm64: reboot driver missing dts entry and ACPI
 support for storm platform.
In-Reply-To: <1383938010-15296-1-git-send-email-fkan@apm.com>
References: <1383938010-15296-1-git-send-email-fkan@apm.com>
Message-ID: <20131124052707.GA7964@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 08, 2013 at 11:13:30AM -0800, Feng Kan wrote:
> +#ifdef CONFIG_ACPI
> +	if (efi_enabled(EFI_BOOT)) {
> +		unsigned long long value;
> +		acpi_status status;
> +		if (acpi_name == NULL)
> +			return -ENODEV;
> +		status = acpi_evaluate_integer(ACPI_HANDLE(&pdev->dev),
> +					       acpi_name, NULL, &value);
> +		if (ACPI_FAILURE(status))
> +			return -ENODEV;
> +		*param = value;
> +		return 0;

The normal way to handle reboots in ACPI is to provide register address 
and value information in the FADT. The firmware should populate this at 
init time, and then you don't need this driver at all.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
