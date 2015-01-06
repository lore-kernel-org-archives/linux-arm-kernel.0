From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 6 Jan 2015 16:58:32 +0100
Subject: [PATCH 2/4] usb: XHCI: platform: Move the Marvell quirks after
 the enabling the clocks
In-Reply-To: <1420559110-8043-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1420559110-8043-1-git-send-email-maxime.ripard@free-electrons.com>
 <1420559110-8043-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150106165832.3e29e3a9@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

On Tue,  6 Jan 2015 16:45:08 +0100, Maxime Ripard wrote:

> +	if (of_device_is_compatible(pdev->dev.of_node,
> +				    "marvell,armada-375-xhci") ||
> +	    of_device_is_compatible(pdev->dev.of_node,
> +				    "marvell,armada-380-xhci")) {
> +		ret = xhci_mvebu_mbus_init_quirk(pdev);
> +		if (ret)
> +			return ret;
> +	}

So on error, you're leaking the struct usb_hcd now if I'm not mistaken.
When moving code around, the error handling should also be fixed. You
probably need "goto put_hcd;" instead of "return ret;".

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
