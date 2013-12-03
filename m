From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Tue, 3 Dec 2013 13:59:27 +0200
Subject: [PATCH v2 2/7] usb: dwc3: adapt dwc3 core to use Generic PHY
 Framework
In-Reply-To: <1381866857-3861-3-git-send-email-kishon@ti.com>
References: <1381866857-3861-1-git-send-email-kishon@ti.com>
 <1381866857-3861-3-git-send-email-kishon@ti.com>
Message-ID: <20131203115927.GD26423@xps8300>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On Wed, Oct 16, 2013 at 01:24:12AM +0530, Kishon Vijay Abraham I wrote:
> +	count = of_property_match_string(node, "phy-names", "usb2-phy");
> +	if (count >= 0 || (pdata && pdata->usb2_generic_phy)) {
> +		dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
> +		if (IS_ERR(dwc->usb2_generic_phy)) {
> +			dev_err(dev, "no usb2 phy configured yet");
> +			return PTR_ERR(dwc->usb2_generic_phy);
> +		}
> +		dwc->usb2_phy = NULL;
> +	}
> +
> +	count = of_property_match_string(node, "phy-names", "usb3-phy");
> +	if (count >= 0 || (pdata && pdata->usb3_generic_phy)) {
> +		dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
> +		if (IS_ERR(dwc->usb3_generic_phy)) {
> +			dev_err(dev, "no usb3 phy configured yet");
> +			return PTR_ERR(dwc->usb3_generic_phy);
> +		}
> +		dwc->usb3_phy = NULL;
> +	}

Is there some specific reason for these checks? The driver should not
need to care about the platform (DT, ACPI, platform based).

Just get the phys and check the return value. In case ERR_PTR(-ENODEV)
leave the phy as NULL and let the driver continue normally. With other
errors you make the dwc3 probe fail.

Thanks,

-- 
heikki
