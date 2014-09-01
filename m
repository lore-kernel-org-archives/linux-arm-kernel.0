From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Sep 2014 17:17:51 +0200
Subject: [Linaro-acpi] [RFC PATCH for Juno 1/2] net: smsc911x add support
 for probing from ACPI
In-Reply-To: <1409583961-7466-2-git-send-email-hanjun.guo@linaro.org>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <1409583961-7466-2-git-send-email-hanjun.guo@linaro.org>
Message-ID: <2861461.8zNpLC3I2n@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 September 2014 23:06:00 Hanjun Guo wrote:
> +#ifdef CONFIG_ACPI
> +/* Configure some sensible defaults for ACPI mode */
> +static int smsc911x_probe_config_acpi(struct smsc911x_platform_config *config,
> +                                   acpi_handle *ahandle)
> +{
> +       if (!ahandle)
> +               return -ENOSYS;
> +
> +       config->phy_interface = PHY_INTERFACE_MODE_MII;
> 

Please remove the #ifdef and use 

	if (!IS_ENABLED(CONFIG_ACPI) || !ahandle)

to check for ACPI support. This should result in the same object code
in all cases, but give better compile-time coverage when ACPI is
disabled.

Also, -ENOSYS is probably the wrong return value. I think you mean
-ENXIO.

	Arnd
