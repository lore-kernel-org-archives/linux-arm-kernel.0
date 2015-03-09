From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Mar 2015 22:47:11 +0100
Subject: [PATCH 02/15] phy-sun4i-usb: Add a helper function to update the
 iscr register
In-Reply-To: <1425933628-9672-3-git-send-email-hdegoede@redhat.com>
References: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
 <1425933628-9672-3-git-send-email-hdegoede@redhat.com>
Message-ID: <4772280.xE1WBZVd8Z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 March 2015 21:40:15 Hans de Goede wrote:
> +void sun4i_usb_phy_update_iscr(struct phy *_phy, u32 clr, u32 set)
> +{
> +       struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
> +       struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
> +       u32 iscr;
> +
> +       iscr = readl(data->base + REG_ISCR);
> +       iscr &= ~clr;
> +       iscr |= set;
> +       writel(iscr, data->base + REG_ISCR);
> +}
> +EXPORT_SYMBOL(sun4i_usb_phy_update_iscr);
> +
> 

I would generally consider this a bad design. What is the purpose of
calling sun4i_usb_phy_update_iscr() and why can't there be a high-level
PHY API for this?

The only other phy driver with exports like this is the OMAP driver,
and that has caused problems in the past.

	Arnd
