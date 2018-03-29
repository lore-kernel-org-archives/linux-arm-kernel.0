From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 29 Mar 2018 12:35:43 -0400
Subject: [net-next PATCH v2 05/10] net: netcp: ethss: use rgmii link
 status for 2u cpsw hardware
In-Reply-To: <20180327172953.GP5862@lunn.ch>
References: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
 <1522168309-12338-6-git-send-email-m-karicheri2@ti.com>
 <20180327172953.GP5862@lunn.ch>
Message-ID: <1a88b074-e3b1-3a95-d993-327486915455@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2018 01:29 PM, Andrew Lunn wrote:
> On Tue, Mar 27, 2018 at 12:31:44PM -0400, Murali Karicheri wrote:
>> Introduce rgmii link status to handle link state events for 2u
>> cpsw hardware on K2G.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> ---
>>  drivers/net/ethernet/ti/netcp_ethss.c | 27 +++++++++++++++++++++++----
>>  1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
>> index ab9d369..078a1b8 100644
>> --- a/drivers/net/ethernet/ti/netcp_ethss.c
>> +++ b/drivers/net/ethernet/ti/netcp_ethss.c
>> @@ -552,6 +552,7 @@ struct gbe_ss_regs {
>>  struct gbe_ss_regs_ofs {
>>  	u16	id_ver;
>>  	u16	control;
>> +	u16	rgmii_status; /* 2U */
>>  };
>>  
>>  struct gbe_switch_regs {
>> @@ -2120,23 +2121,39 @@ static bool gbe_phy_link_status(struct gbe_slave *slave)
>>  	 return !slave->phy || slave->phy->link;
>>  }
>>  
>> +#define RGMII_REG_STATUS_LINK	BIT(0)
>> +
>> +static void netcp_2u_rgmii_get_port_link(struct gbe_priv *gbe_dev, bool *status)
>> +{
>> +	u32 val = 0;
>> +
>> +	val = readl(GBE_REG_ADDR(gbe_dev, ss_regs, rgmii_status));
>> +	*status = false;
>> +	if ((val & RGMII_REG_STATUS_LINK) != 0)
>> +		*status = true;
> 
>   *status = !!(val & RGMII_REG_STATUS_LINK);
> 

Ok

> 
>> +}
>> +
>>  static void netcp_ethss_update_link_state(struct gbe_priv *gbe_dev,
>>  					  struct gbe_slave *slave,
>>  					  struct net_device *ndev)
>>  {
>> -	int sp = slave->slave_num;
>> -	int phy_link_state, sgmii_link_state = 1, link_state;
>> +	bool sw_link_state = true, phy_link_state;
>> +	int sp = slave->slave_num, link_state;
>>  
>>  	if (!slave->open)
>>  		return;
>>  
>>  	if (!SLAVE_LINK_IS_XGMII(slave)) {
>> -		sgmii_link_state =
>> +		if (SLAVE_LINK_IS_RGMII(slave))
>> +			netcp_2u_rgmii_get_port_link(gbe_dev,
>> +						     &sw_link_state);
>> +		else
>> +			sw_link_state =
>>  			netcp_sgmii_get_port_link(SGMII_BASE(gbe_dev, sp), sp);
> 
> This would be more readable as
> 
>      if (SLAVE_LINK_IS_RGMII(slave))
> 		netcp_2u_rgmii_get_port_link(gbe_dev,
> 					     &sw_link_state);
>      if (SLAVE_LINK_IS_SGMII(slave))
> 	sw_link_state = netcp_sgmii_get_port_link(
> 	   SGMII_BASE(gbe_dev, sp), sp);

OK. I will add the new macro for SLAVE_LINK_IS_SGMII() as well.

> 
>    Andrew
> 


-- 
Murali Karicheri
Linux Kernel, Keystone
