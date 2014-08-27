From: lv.zheng@intel.com (Zheng, Lv)
Date: Wed, 27 Aug 2014 05:43:07 +0000
Subject: [PATCH 1/9] ACPI / PM: Let acpi_dev_pm_detach() return an error
 code
In-Reply-To: <1409054837-5667-2-git-send-email-ulf.hansson@linaro.org>
References: <1409054837-5667-1-git-send-email-ulf.hansson@linaro.org>
 <1409054837-5667-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1AE640813FDE7649BE1B193DEA596E880265FDCA@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> From: linux-acpi-owner at vger.kernel.org [mailto:linux-acpi-owner at vger.kernel.org] On Behalf Of Ulf Hansson
> Sent: Tuesday, August 26, 2014 8:07 PM
> To: Rafael J. Wysocki; Brown, Len; Pavel Machek; Greg Kroah-Hartman; linux-pm at vger.kernel.org
> 
> To give callers the option of acting on a errors while removing the
> pm_domain ops for the device in the ACPI power domain, let
> acpi_dev_pm_detach() return an int to provide the error code.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/acpi/device_pm.c | 4 ++++
>  include/linux/acpi.h     | 7 +++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 67075f8..fa78abb 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1087,6 +1087,8 @@ EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
>   *
>   * Callers must ensure proper synchronization of this function with power
>   * management callbacks.
> + *
> + * Returns 0 on successfully detached power domain or negative error code.
>   */
>  void acpi_dev_pm_detach(struct device *dev, bool power_off)

Should the return type be "int" here?

Thanks and best regards
-Lv

>  {
> @@ -1107,7 +1109,9 @@ void acpi_dev_pm_detach(struct device *dev, bool power_off)
>  			acpi_device_wakeup(adev, ACPI_STATE_S0, false);
>  			acpi_dev_pm_low_power(dev, adev, ACPI_STATE_S0);
>  		}
> +		return 0;
>  	}
> +	return -ENODEV;
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_pm_detach);
>  #endif /* CONFIG_PM */
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 5320153..a7bfdf6 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -576,7 +576,7 @@ static inline int acpi_subsys_freeze(struct device *dev) { return 0; }
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PM)
>  struct acpi_device *acpi_dev_pm_get_node(struct device *dev);
>  int acpi_dev_pm_attach(struct device *dev, bool power_on);
> -void acpi_dev_pm_detach(struct device *dev, bool power_off);
> +int acpi_dev_pm_detach(struct device *dev, bool power_off);
>  #else
>  static inline struct acpi_device *acpi_dev_pm_get_node(struct device *dev)
>  {
> @@ -586,7 +586,10 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
>  {
>  	return -ENODEV;
>  }
> -static inline void acpi_dev_pm_detach(struct device *dev, bool power_off) {}
> +static inline int acpi_dev_pm_detach(struct device *dev, bool power_off)
> +{
> +	return -ENODEV;
> +}
>  #endif
> 
>  #ifdef CONFIG_ACPI
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
