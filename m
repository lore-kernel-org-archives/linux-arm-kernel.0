From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 19:08:10 +0000
Subject: [PATCH] Arch: arm: plat-pxa - Fix possible NULL derefrence.
In-Reply-To: <1485752311-29754-1-git-send-email-shailendra.v@samsung.com>
References: <CGME20170130045842epcas2p274b2125a1f158e4d656096bdf3a3a1d9@epcas2p2.samsung.com>
 <1485752311-29754-1-git-send-email-shailendra.v@samsung.com>
Message-ID: <20170130190809.GH27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 10:28:31AM +0530, Shailendra Verma wrote:
> of_match_device could return NULL, and so can cause a NULL
> pointer dereference later.

Please explain how this can happen.

The driver is matched to the device via the driver model looking up
the compatible string in the match table:

                .of_match_table = of_match_ptr(pxa_ssp_of_ids),

It then calls the probe function, which notices that there's a DT
node pointer, and the driver looks the device up in the very same
table.

If the driver model found a match and then the device driver didn't
for the very same device, something really bad went wrong.

So, if you want to add something:

	if (WARN_ON(!id))
		return -ENODEV;

should be about it, since it's something we expect to never encounter.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
