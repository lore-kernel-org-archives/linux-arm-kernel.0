From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 17 Jan 2018 15:16:33 -0800
Subject: [PATCH net-next] net: stmmac: Fix reception of Broadcom switches
 tags
In-Reply-To: <4fb40e11-a160-b9c7-aa02-f30a9de172bd@st.com>
References: <20180116232545.22054-1-f.fainelli@gmail.com>
 <4fb40e11-a160-b9c7-aa02-f30a9de172bd@st.com>
Message-ID: <d33e6f92-7080-5077-ba44-629fefef052d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peppe,

On 01/16/2018 11:06 PM, Giuseppe CAVALLARO wrote:
> Hi Florian
> 
> for gmac4.x and gmac3.x series the ACS bit is the Automatic Pad or CRC
> Stripping, so the
> core strips the Pad or FCS on frames if the value of the length field is
> < 1536 bytes.
> For MAC10-100 there is the Bit 8 (ASTP) of the reg0 that does the same
> if len is < 46bytes.

OK, thanks for the detail on the older core, I will update my v2 to take
that into account.

> In your patch I can just suggest to add a new field to strip the PAD/FCS
> w/o passing the whole
> netdev struct to the core_init. In the main driver, we could manage the
> pad-strip feature (also
> by using dt) or disable it in case of netdev_uses_dsa; then propagating
> this setting to the core_init
> or calling a new callback. What do you think?

I don't think adding a DT property is a good idea, because we can
determine whether ACS is necessary or not at runtime when DSA with
proprietary Ethernet switch tags is used or not using netdev_uses_dsa().

Having the DT property to configure whether ACS is turned on or off
means that the Device Tree now describes a policy, rather than a
capability, which is counter to the Device Tree spirit. Besides, this
leaves room for making mistake, and this creates a support burden. When
interfaced with a switch, the switch is guaranteed to egress 64 bytes
(including FCS) packets towards stmmac, and the only thing we need to do
is ensure that stmmac does the same thing. This is a small penalty to
pay for small packets, and this is done only when DSA is used.

Regarding passing a net_device to the core_init functions, this was done
because dev->mtu was already accessed, and we might need to access
additional net_device members in the future, 2 means we need to find a
solution that scales, so passing the net_device around was a natural
choice. Function pointers described in common.h are not exactly
consistent in what type of arguments they take, so I did not see this as
being a big problem.

Thank you.

> 
> Regards
> Peppe
> 
> On 1/17/2018 12:25 AM, Florian Fainelli wrote:
>> Broadcom tags inserted by Broadcom switches put a 4 byte header after
>> the MAC SA and before the EtherType, which may look like some sort of 0
>> length LLC/SNAP packet (tcpdump and wireshark do think that way). With
>> ACS enabled in stmmac the packets were truncated to 8 bytes on
>> reception, whereas clearing this bit allowed normal reception to occur.
>>
>> In order to make that possible, we need to pass a net_device argument to
>> the different core_init() functions and we are dependent on the Broadcom
>> tagger padding packets correctly (which it now does). To be as little
>> invasive as possible, this is only done for gmac1000 when the network
>> device is DSA-enabled (netdev_uses_dsa() returns true).
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> ? drivers/net/ethernet/stmicro/stmmac/common.h???????? |? 2 +-
>> ? drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c??? |? 3 ++-
>> ? drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 12 +++++++++++-
>> ? drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c? |? 3 ++-
>> ? drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c??? | 11 ++++++++++-
>> ? drivers/net/ethernet/stmicro/stmmac/stmmac_main.c??? |? 2 +-
>> ? 6 files changed, 27 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h
>> b/drivers/net/ethernet/stmicro/stmmac/common.h
>> index ce2ea2d491ac..2ffe76c0ff74 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
>> @@ -474,7 +474,7 @@ struct mac_device_info;
>> ? /* Helpers to program the MAC core */
>> ? struct stmmac_ops {
>> ????? /* MAC core initialization */
>> -??? void (*core_init)(struct mac_device_info *hw, int mtu);
>> +??? void (*core_init)(struct mac_device_info *hw, struct net_device
>> *dev);
>> ????? /* Enable the MAC RX/TX */
>> ????? void (*set_mac)(void __iomem *ioaddr, bool enable);
>> ????? /* Enable and verify that the IPC module is supported */
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> index 9eb7f65d8000..a3fa65b1ca8e 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> @@ -483,7 +483,8 @@ static int sun8i_dwmac_init(struct platform_device
>> *pdev, void *priv)
>> ????? return 0;
>> ? }
>> ? -static void sun8i_dwmac_core_init(struct mac_device_info *hw, int mtu)
>> +static void sun8i_dwmac_core_init(struct mac_device_info *hw,
>> +????????????????? struct net_device *dev)
>> ? {
>> ????? void __iomem *ioaddr = hw->pcsr;
>> ????? u32 v;
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
>> index 8a86340ff2d3..540d21786a43 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
>> @@ -25,18 +25,28 @@
>> ? #include <linux/crc32.h>
>> ? #include <linux/slab.h>
>> ? #include <linux/ethtool.h>
>> +#include <net/dsa.h>
>> ? #include <asm/io.h>
>> ? #include "stmmac_pcs.h"
>> ? #include "dwmac1000.h"
>> ? -static void dwmac1000_core_init(struct mac_device_info *hw, int mtu)
>> +static void dwmac1000_core_init(struct mac_device_info *hw,
>> +??????????????? struct net_device *dev)
>> ? {
>> ????? void __iomem *ioaddr = hw->pcsr;
>> ????? u32 value = readl(ioaddr + GMAC_CONTROL);
>> +??? int mtu = dev->mtu;
>> ? ????? /* Configure GMAC core */
>> ????? value |= GMAC_CORE_INIT;
>> ? +??? /* Clear ACS bit because Ethernet switch tagging formats such as
>> +???? * Broadcom tags can look like invalid LLC/SNAP packets and cause
>> the
>> +???? * hardware to truncate packets on reception.
>> +???? */
>> +??? if (netdev_uses_dsa(dev))
>> +??????? value &= ~GMAC_CONTROL_ACS;
>> +
>> ????? if (mtu > 1500)
>> ????????? value |= GMAC_CONTROL_2K;
>> ????? if (mtu > 2000)
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
>> index 8ef517356313..c1ee427c42cb 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
>> @@ -28,7 +28,8 @@
>> ? #include <asm/io.h>
>> ? #include "dwmac100.h"
>> ? -static void dwmac100_core_init(struct mac_device_info *hw, int mtu)
>> +static void dwmac100_core_init(struct mac_device_info *hw,
>> +?????????????????? struct net_device *dev)
>> ? {
>> ????? void __iomem *ioaddr = hw->pcsr;
>> ????? u32 value = readl(ioaddr + MAC_CONTROL);
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
>> index f3ed8f7853eb..6af5100d3cb2 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
>> @@ -20,13 +20,22 @@
>> ? #include "stmmac_pcs.h"
>> ? #include "dwmac4.h"
>> ? -static void dwmac4_core_init(struct mac_device_info *hw, int mtu)
>> +static void dwmac4_core_init(struct mac_device_info *hw,
>> +???????????????? struct net_device *dev)
>> ? {
>> ????? void __iomem *ioaddr = hw->pcsr;
>> ????? u32 value = readl(ioaddr + GMAC_CONFIG);
>> +??? int mtu = dev->mtu;
>> ? ????? value |= GMAC_CORE_INIT;
>> ? +??? /* Clear ACS bit because Ethernet switch tagging formats such as
>> +???? * Broadcom tags can look like invalid LLC/SNAP packets and cause
>> the
>> +???? * hardware to truncate packets on reception.
>> +???? */
>> +??? if (netdev_uses_dsa(dev))
>> +??????? value &= ~GMAC_CONTROL_ACS;
>> +
>> ????? if (mtu > 1500)
>> ????????? value |= GMAC_CONFIG_2K;
>> ????? if (mtu > 2000)
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index f99f14c35063..7ad841434ec8 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -2527,7 +2527,7 @@ static int stmmac_hw_setup(struct net_device
>> *dev, bool init_ptp)
>> ????? }
>> ? ????? /* Initialize the MAC Core */
>> -??? priv->hw->mac->core_init(priv->hw, dev->mtu);
>> +??? priv->hw->mac->core_init(priv->hw, dev);
>> ? ????? /* Initialize MTL*/
>> ????? if (priv->synopsys_id >= DWMAC_CORE_4_00)
> 
> 


-- 
Florian
