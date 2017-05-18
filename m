From: qnguyen@apm.com (Quan Nguyen)
Date: Thu, 18 May 2017 11:39:48 +0700
Subject: [PATCH net-next] drivers: net: xgene: Check all RGMII phy mode
 variants
In-Reply-To: <20170517202633.GA14413@lunn.ch>
References: <1495051550-28961-1-git-send-email-isubramanian@apm.com>
 <20170517202633.GA14413@lunn.ch>
Message-ID: <CAFopSPTP07TFcgc8pACQDF4ZXHOftUMBqBCgF4hVpAmUt0cCWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 3:26 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> +bool is_xgene_enet_phy_mode_rgmii(struct net_device *ndev)
>> +{
>> +     struct xgene_enet_pdata *pdata = netdev_priv(ndev);
>> +     int phy_mode = pdata->phy_mode;
>> +     bool ret;
>> +
>> +     ret = phy_mode == PHY_INTERFACE_MODE_RGMII ||
>> +           phy_mode == PHY_INTERFACE_MODE_RGMII_ID ||
>> +           phy_mode == PHY_INTERFACE_MODE_RGMII_RXID ||
>> +           phy_mode == PHY_INTERFACE_MODE_RGMII_TXID;
>> +
>> +     return ret;
>> +}
>
> include/linux/phy.h:
>
> /**
>  * phy_interface_is_rgmii - Convenience function for testing if a PHY interface
>  * is RGMII (all variants)
>  * @phydev: the phy_device struct
>  */
> static inline bool phy_interface_is_rgmii(struct phy_device *phydev)
> {
>         return phydev->interface >= PHY_INTERFACE_MODE_RGMII &&
>                 phydev->interface <= PHY_INTERFACE_MODE_RGMII_TXID;
> };
>

Hi Andrew,

Our purpose is to handle our internal pdata->phy_mode, so
phy_interface_is_rgmii(phydev) seems not to fit.
Instead, we're working on the below:

+bool is_xgene_enet_phy_mode_rgmii(struct net_device *ndev)
+{
+       struct xgene_enet_pdata *pdata = netdev_priv(ndev);
+
+       return pdata->phy_mode >= PHY_INTERFACE_MODE_RGMII &&
+              pdata->phy_mode <= PHY_INTERFACE_MODE_RGMII_TXID;
+}
+
