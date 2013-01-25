From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 25 Jan 2013 11:16:29 -0700
Subject: [RFC PATCH 4/4] net: mvmdio: add getter and setter for PHY
 addresses
In-Reply-To: <1359108409-4378-5-git-send-email-florian@openwrt.org>
References: <1359108409-4378-1-git-send-email-florian@openwrt.org>
 <1359108409-4378-5-git-send-email-florian@openwrt.org>
Message-ID: <20130125181629.GA7393@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 11:06:49AM +0100, Florian Fainelli wrote:
> This patch adds orion_mdio_{set,get}_phy_addr(.., port_number, phy_addr)
> which is a feature available in this MDIO driver to monitor a particular
> PHY address. This brings mvmdio one step closer to what is used in
> mv643x_eth.

This seems really strange.

Are you sure this should be part of the MDIO driver? Based on my docs,
this register is part of the ethernet controller HW, which
autonomously reads from the phy via MDIO.

It seems cleaner to set this register from the ethernet controller
based on the phy it is using and keep the MDIO driver purely for MDIO
bus access.

It is acceptable to overlap the device address ranges, start the
ethernet controller at 72000 and start the MDIO at 72004, the platform
bus code automatically nests them.

Jason
