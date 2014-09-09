From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 11:08:11 +0200
Subject: [PATCH v2 1/4] phy: phy-stih407-usb: Add usb picoPHY driver found
 on stih407 SoC family
In-Reply-To: <1410253218-18318-2-git-send-email-peter.griffin@linaro.org>
References: <1410253218-18318-1-git-send-email-peter.griffin@linaro.org>
 <1410253218-18318-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <2894228.eRmxgHsWbh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 10:00:15 Peter Griffin wrote:
> This is the generic phy driver for the picoPHY ports used by the
> USB2 and USB3 Host controllers when controlling usb2/1.1 devices. It
> is found on STiH407 SoC family from STMicroelectronics.
> 
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Looks good overall, just one question:

> +
> +	match = of_match_device(stih407_usb2_picophy_of_match, dev);
> +	if (!match)
> +		return -ENODEV;
....
> +
> +	phy = devm_phy_create(dev, NULL, match->data, NULL);
> +	if (IS_ERR(phy)) {
> +		dev_err(dev, "failed to create Display Port PHY\n");
> +		return PTR_ERR(phy);
> +	}
> +

There is only one entry in the match table, so it always points to
stih407_usb2_picophy_data. Do you have plans to add another set of
operations soon?
If not, just remove the .data pointer and hardcode the operations
in the devm_phy_create call.

	Arnd
