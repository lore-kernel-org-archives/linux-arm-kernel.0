From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 21 Apr 2014 20:28:40 +0200
Subject: [PATCH 0/3] net: mvneta: fix usage as a module, and support
 QSGMII properly
In-Reply-To: <1397569821-5530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397569821-5530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140421202840.789d0e24@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

Would it be possible to get PATCH 3/3 merged into 3.15-rc in the not
too distant future? David Miller has already sent PATCH 1/3 and PATCH
2/3, and they are part of the just released -rc2. However, the Device
Tree fix for Armada XP GP QSGMII usage is missing.

Thanks!

Thomas

On Tue, 15 Apr 2014 15:50:18 +0200, Thomas Petazzoni wrote:
> Hello,
> 
> This set of patches is a new attempt at fixing the operation of the
> mvneta driver when built as a module. For the record, the previous
> attempt, merged in commit e3a8786c10e75903f1269474e21fe8cb49c3a670
> ('net: mvneta: fix usage as a module on RGMII configurations') caused
> problems for all RGMII configurations.
> 
> In fact, it turned out that the MAC to PHY connection on the Armada XP
> GP, which was described as using RGMII-ID according to its Device
> Tree, is in fact a QSGMII connection. And the RGMII and QSGMII
> configurations have to be handled in a different way in the driver,
> because the SERDES configuration is different in those two cases.
> 
> So, this patch series fixes that by:
> 
>  * Adding minimal handling of a "qsgmii" connection type in the PHY
>    layer. Mainly to make sure that a "qsgmii" phy-mode in the Device
>    Tree is recognized, and handed over to the driver as
>    PHY_INTERFACE_QSGMII.
> 
>  * Changing the mvneta driver to properly configure the RGMIIEn and
>    PCSEn bits in the GMAC_CTRL_2 register, and configure the SERDES
>    register, in the three possible cases: RGMII, SGMII and QSGMII.
> 
>  * Updating the Device Tree of the Armada XP GP board to reflect the
>    fact that it uses a QSGMII MAC/PHY connection.
> 
> PATCH 1 and 2 would be merged by David Miller, through the net tree,
> while PATCH 3 would be merged by the mach-mvebu maintainers, through
> their tree and arm-soc.
> 
> This set of patches has been tested on:
> 
>  * Armada XP GP (four QSGMII interfaces)
>  * Armada XP DB (two RGMII interfaces and two SGMII interfaces)
>  * Armada 370 Mirabox (two RGMII interfaces)
> 
> I've tested both the driver built-in, and compiled as a module.
> 
> Since the last attempt at fixing this was quite a fiasco, I'd like
> this new attempt to be tested more widely before being applied. I'll
> try to do some testing on other Armada boards I have, but independent
> testing from other persons would also be appreciated.
> 
> Note that these patches apply after reverting the previous attempt,
> obviously.
> 
> Thanks,
> 
> Thomas
> 
> Thomas Petazzoni (3):
>   net: phy: add minimal support for QSGMII PHY
>   net: mvneta: properly configure the MAC <-> PHY connection in all
>     situations
>   ARM: mvebu: use qsgmii phy-mode for Armada XP GP interfaces
> 
>  Documentation/devicetree/bindings/net/ethernet.txt |  2 +-
>  arch/arm/boot/dts/armada-xp-gp.dts                 |  8 +--
>  drivers/net/ethernet/marvell/mvneta.c              | 73 ++++++++++------------
>  include/linux/phy.h                                |  3 +
>  4 files changed, 42 insertions(+), 44 deletions(-)
> 



-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
