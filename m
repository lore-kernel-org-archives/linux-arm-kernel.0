From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 29 Nov 2017 19:28:14 +0530
Subject: [PATCH V3 3/4] dmaengine: qcom_hidma: add support for the new
 revision
In-Reply-To: <1510281175-27173-3-git-send-email-okaya@codeaurora.org>
References: <1510281175-27173-1-git-send-email-okaya@codeaurora.org>
 <1510281175-27173-3-git-send-email-okaya@codeaurora.org>
Message-ID: <20171129135813.GE32417@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 09:32:54PM -0500, Sinan Kaya wrote:

> -static bool hidma_msi_capable(struct device *dev)
> +static bool hidma_test_capability(struct device *dev, enum hidma_cap test_cap)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(dev);
> -	const char *of_compat;
> -	int ret = -EINVAL;
> +	enum hidma_cap cap;
>  
> -	if (!adev || acpi_disabled) {
> -		ret = device_property_read_string(dev, "compatible",
> -						  &of_compat);
> -		if (ret)
> -			return false;
> +	if (!adev || acpi_disabled)
> +		cap = (enum hidma_cap) of_device_get_match_data(dev);
> +	else
> +		cap = (enum hidma_cap) acpi_device_get_match_data(dev);

should this not reside in core? How about a device_get_match_data() which
returns the data for folks based on node being acpi/of

-- 
~Vinod
