From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 5 Apr 2017 12:52:38 +0200
Subject: [PATCH] phy: bcm-ns-usb3: split all writes into reg & val pairs
In-Reply-To: <a5216597-2256-a665-2514-26eeba145210@ti.com>
References: <20170402165522.14058-1-zajec5@gmail.com>
 <a5216597-2256-a665-2514-26eeba145210@ti.com>
Message-ID: <7c67eea1-1a01-5e20-5a77-41b1f8a32471@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2017 12:10 PM, Kishon Vijay Abraham I wrote:
> On Sunday 02 April 2017 10:25 PM, Rafa? Mi?ecki wrote:
>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>
>> So far all the PHY initialization was implemented using some totally
>> magic values. There was some pattern there but it wasn't clear what is
>> it about.
>>
>> Thanks to the patch submitted by Broadcom:
>> [PATCH 5/6] phy: Add USB3 PHY support for Broadcom NSP SoC
>> and the upstream "iproc-mdio" driver we now know there is a MDIO bus
>> underneath with PHY(s) and their registers.
>>
>> It allows us to clean the driver a bit by making all these values less
>> magical. The next step is switching to using a proper MDIO layer.
>>
>> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
>> ---
>>  drivers/phy/phy-bcm-ns-usb3.c | 69 ++++++++++++++++++++++++++++++-------------
>>  1 file changed, 49 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/phy/phy-bcm-ns-usb3.c b/drivers/phy/phy-bcm-ns-usb3.c
>> index f420fa4bebfc..22b5e7047fa6 100644
>> --- a/drivers/phy/phy-bcm-ns-usb3.c
>> +++ b/drivers/phy/phy-bcm-ns-usb3.c
>> @@ -2,6 +2,7 @@
>>   * Broadcom Northstar USB 3.0 PHY Driver
>>   *
>>   * Copyright (C) 2016 Rafa? Mi?ecki <rafal@milecki.pl>
>> + * Copyright (C) 2016 Broadcom
>>   *
>>   * All magic values used for initialization (and related comments) were obtained
>>   * from Broadcom's SDK:
>> @@ -23,6 +24,23 @@
>>
>>  #define BCM_NS_USB3_MII_MNG_TIMEOUT_US	1000	/* usecs */
>>
>> +#define BCM_NS_USB3_PHY_BASE_ADDR_REG	0x1f
>> +#define BCM_NS_USB3_PHY_PLL30_BLOCK	0x8000
>> +#define BCM_NS_USB3_PHY_TX_PMD_BLOCK	0x8040
>> +#define BCM_NS_USB3_PHY_PIPE_BLOCK	0x8060
>> +
>> +/* Registers of PLL30 block */
>> +#define BCM_NS_USB3_PLL_CONTROL		0x01
>> +#define BCM_NS_USB3_PLLA_CONTROL0	0x0a
>> +#define BCM_NS_USB3_PLLA_CONTROL1	0x0b
>> +
>> +/* Registers of TX PMD block */
>> +#define BCM_NS_USB3_TX_PMD_CONTROL1	0x01
>> +
>> +/* Registers of PIPE block */
>> +#define BCM_NS_USB3_LFPS_CMP		0x02
>> +#define BCM_NS_USB3_LFPS_DEGLITCH	0x03
>> +
>>  enum bcm_ns_family {
>>  	BCM_NS_UNKNOWN,
>>  	BCM_NS_AX,
>> @@ -76,8 +94,10 @@ static inline int bcm_ns_usb3_mii_mng_wait_idle(struct bcm_ns_usb3 *usb3)
>>  				    usecs_to_jiffies(BCM_NS_USB3_MII_MNG_TIMEOUT_US));
>>  }
>>
>> -static int bcm_ns_usb3_mii_mng_write32(struct bcm_ns_usb3 *usb3, u32 value)
>> +static int bcm_ns_usb3_mdio_phy_write(struct bcm_ns_usb3 *usb3, u16 reg,
>> +				      u16 value)
>>  {
>> +	u32 tmp = 0;
>>  	int err;
>>
>>  	err = bcm_ns_usb3_mii_mng_wait_idle(usb3);
>> @@ -86,7 +106,11 @@ static int bcm_ns_usb3_mii_mng_write32(struct bcm_ns_usb3 *usb3, u32 value)
>>  		return err;
>>  	}
>>
>> -	writel(value, usb3->ccb_mii + BCMA_CCB_MII_MNG_CMD_DATA);
>> +	/* TODO: Use a proper MDIO bus layer */
>
> Instead of using this intermediate patch, can we directly convert this to
> mdio_driver or you see issues with converting it?

This is a bit more complex task with some possible issues to consider:
1) Backward compatibility - should we still support old DTB files?
2) Support for PHY DT node put in MDIO bus node - it requires reg = <phy num>; which is in conflict with current "reg" usage
3) Support for different reset reg - Northstar+ uses a different one - we'll probably need a syscon
4) My limited time (sadly)

The good point of this patch is that all changes made in:
bcm_ns_usb3_phy_init_ns_ax
bcm_ns_usb3_phy_init_ns_bx
will survive, so we're not going to change all the code back and forth.

If that's acceptable for you, I'd prefer to handle this with smaller patches.
