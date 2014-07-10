From: balbi@ti.com (Felipe Balbi)
Date: Thu, 10 Jul 2014 08:48:59 -0500
Subject: [PATCH v2 4/4] USB: PHY: tegra: Call tegra_usb_phy_close only on
 device removal
In-Reply-To: <1404436179-10745-5-git-send-email-ttynkkynen@nvidia.com>
References: <1404436179-10745-1-git-send-email-ttynkkynen@nvidia.com>
 <1404436179-10745-5-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <20140710134859.GM15340@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 04, 2014 at 04:09:39AM +0300, Tuomas Tynkkynen wrote:
> tegra_usb_phy_close() is supposed to undo the effects of
> tegra_usb_phy_init(). It is also currently added as the USB PHY shutdown
> callback, which is wrong, since tegra_usb_phy_init() is only called

you could just make tegra_usb_phy_init() be called as u_phy->init().
That way you even delay enabling clocks and regulators to the point
where they are more likely to be needed. Also, if EHCI is never loaded,
you won't power up the PHY for no reason.

> during probing wheras the shutdown callback can get called multiple
> times. This then leads to warnings about unbalanced regulator_disable if
> the EHCI driver is unbound and bound again at runtime.
> 
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>

I suppose this has no dependencies with the rest of the series ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140710/5f856e66/attachment.sig>
