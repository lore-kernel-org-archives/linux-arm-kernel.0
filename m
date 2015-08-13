From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 13 Aug 2015 10:53:15 -0400 (EDT)
Subject: [PATCH 3/3] Add ACPI bindings for the EHCI platform driver.
In-Reply-To: <1439416290-21228-4-git-send-email-jeremy.linton@arm.com>
Message-ID: <Pine.LNX.4.44L0.1508131049001.1277-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Aug 2015, Jeremy Linton wrote:

> This enables USB on the ARM juno board when booted with
> an ACPI kernel. The PNP id comes from the PNP/ACPI registry
> and describes a EHCI controller without debug.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Looks okay, but...

> ---
>  drivers/usb/host/ehci-platform.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index 82e396f..1807baa 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -27,6 +27,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/acpi.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
> @@ -382,6 +383,13 @@ static const struct of_device_id vt8500_ehci_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);
>  
> +static const struct acpi_device_id ehci_acpi_match[] = {
> +	{ "PNP0D20", 0 },

How about a comment on this line?  Something like:

+	{ "PNP0D20", 0 },	/* EHCI controller without debug */

I realize the of_device_id table doesn't include similar comments, but 
there the entries are more or less self-documenting.  The same cannot 
be said for "PNP0D20".

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, ehci_acpi_match);
> +
> +

Undesired extra blank line.

>  static const struct platform_device_id ehci_platform_table[] = {
>  	{ "ehci-platform", 0 },
>  	{ }
> @@ -400,6 +408,7 @@ static struct platform_driver ehci_platform_driver = {
>  		.name	= "ehci-platform",
>  		.pm	= &ehci_platform_pm_ops,
>  		.of_match_table = vt8500_ehci_ids,
> +		.acpi_match_table = ACPI_PTR(ehci_acpi_match),
>  	}
>  };

With these changes:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
