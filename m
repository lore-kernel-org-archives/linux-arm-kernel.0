From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 16 May 2014 11:27:36 -0700
Subject: [PATCHv4 0/5] Add DT support for fixed PHYs
In-Reply-To: <1400249647-4643-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400249647-4643-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CAGVrzca7xi4_sGgF0FyFcM0Zo3-mMENP0-aoU=qoV9qshxNzsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

2014-05-16 7:14 GMT-07:00 Thomas Petazzoni
<thomas.petazzoni@free-electrons.com>:
> Subject: Add DT support for fixed PHYs
>
> Hello,
>
> Here is a fourth version of the patch set that adds a Device Tree
> binding and the related code to support fixed PHYs. I'm hoping to get
> this merged in 3.16.

Thanks for being persistent on this and coming back with these
patches, that is really appreciated.

I gave this patch set a try on a brcmstb system with SYSTEMPORT and my
latest changes to net/dsa/ to allow for different PHY setups to be
used with the SoC integrated switch. This switch has a mix of fixed
and real PHYs. This works like a charm, so long as you consistently
use the "new" functions, and not the old ones, which is totally
expected. This is excellent work!

As we discussed offline, I think we need to progressively get rid of
of_phy_connect_fixed() to avoid having to debug situations where the
old 'fixed-link' property used some sparse addressing scheme, which is
now incompatible with the dynamic address allocation scheme.

>
> Changes since v3:
>
>  * Rebased on top of v3.15-rc5
>
>  * In patch "net: phy: decouple PHY id and PHY address in fixed PHY
>    driver", changed the PHY ID of fixed PHYs from 0xdeadbeef to 0x0,
>    as suggested by Grant Likely.
>
>  * Fixed the !CONFIG_PHY_FIXED case in patch "net: phy: extend fixed
>    driver with fixed_phy_register()". Noticed by Florian Fainelli.
>
>  * Added Acked-by from Grant Likely and Florian Fainelli on patch
>    "net: phy: extend fixed driver with fixed_phy_register()".
>
>  * Reworked the new fixed-link DT binding to be just a sub-node of the
>    Ethernet MAC node, and not a node referenced by the 'phy'
>    property. This was requested by Grant Likely.
>
>  * Reworked the code implementing the new DT binding to also make it
>    accept the old, single property based, DT binding.
>
>  * Added a patch that actually uses the new fixed link DT binding for
>    the Armada XP Matrix board.
>
> Changes since v2:
>
>  * Rebased on top of v3.14-rc1, and re-tested on hardware.
>
>  * Removed the RFC tag, since there seems to be some real interest in
>    this feature, and the code has gone through several iterations
>    already.
>
>  * The error handling in fixed_phy_register() has been fixed.
>
> Changes since v1:
>
>  * Instead of using a 'fixed-link' property inside the Ethernet device
>    DT node, with a fairly cryptic succession of integer values, we now
>    use a PHY subnode under the Ethernet device DT node, with explicit
>    properties to configure the duplex, speed, pause and other PHY
>    properties.
>
>  * The PHY address is automatically allocated by the kernel and no
>    longer visible in the Device Tree binding.
>
>  * The PHY device is created directly when the network driver calls
>    of_phy_connect_fixed_link(), and associated to the PHY DT node,
>    which allows the existing of_phy_connect() function to work,
>    without the need to use the deprecated of_phy_connect_fixed_link().
>
> Posts of previous versions:
>
>   RFCv1:   http://www.spinics.net/lists/netdev/msg243253.html
>   RFCv2:   http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/196919.html
>   PATCHv3: http://www.spinics.net/lists/netdev/msg273117.html
>
> Thanks,
>
> Thomas
>
> Thomas Petazzoni (5):
>   net: phy: decouple PHY id and PHY address in fixed PHY driver
>   net: phy: extend fixed driver with fixed_phy_register()
>   of: provide a binding for fixed link PHYs
>   net: mvneta: add support for fixed links
>   ARM: mvebu: use the fixed-link PHY DT binding for the Armada XP Matrix
>     board
>
>  .../devicetree/bindings/net/fixed-link.txt         | 31 +++++++++
>  arch/arm/boot/dts/armada-xp-matrix.dts             |  4 ++
>  drivers/net/ethernet/marvell/mvneta.c              | 19 ++++-
>  drivers/net/phy/fixed.c                            | 81 +++++++++++++++++++---
>  drivers/of/of_mdio.c                               | 67 ++++++++++++++++++
>  include/linux/of_mdio.h                            | 15 ++++
>  include/linux/phy_fixed.h                          | 11 +++
>  7 files changed, 215 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/fixed-link.txt
>
> --
> 1.9.3

-- 
Florian
