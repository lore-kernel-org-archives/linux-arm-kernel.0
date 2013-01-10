From: konszert@marvell.com (Kosta Zertsekel)
Date: Thu, 10 Jan 2013 17:57:25 +0200
Subject: [PATCH 2/2] Fix phy_attach - forward dev_flags for phy_attach
In-Reply-To: <50EED2E4.80008@openwrt.org>
References: <1357819234-27752-1-git-send-email-konszert@marvell.com>
 <1357819234-27752-3-git-send-email-konszert@marvell.com>
 <50EED2E4.80008@openwrt.org>
Message-ID: <BC373419EB4337418B2B595BAEDC155F015896370062@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> By the way, most, if not all of the phy_connect() users in drivers/net/ethernet/ also do not ensure they pass the phy device flags, so you might 

want to fix this globally and not just for Marvell driver.
Indeed, phy_connect() mostly just pass zero intead of phy_dev->dev_flags.
But, I think, the guy that calls phy_connect() in its driver should know what he does, and,
probably, we should rely on him knowing his stuff.
The only evidence of the bug is when phy_dev->dev_flags was actually changed by PHY fixup callback
(see dns323-setup.c for example) and was *not* propagated to phy_connect() or phy_attach() as in pxa168_eth.c phy_init().
The code conforming to the former should be fixed IMHO.

Thanks,
--- KostaZ
