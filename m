From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 8 Nov 2018 16:42:02 -0600
Subject: [PATCH 4/5] phy: mvebu-cp110-comphy: convert to use eth phy mode
 and submode
In-Reply-To: <20181108222123.GZ30658@n2100.armlinux.org.uk>
References: <20181108003617.10334-1-grygorii.strashko@ti.com>
 <20181108003617.10334-5-grygorii.strashko@ti.com>
 <20181108222123.GZ30658@n2100.armlinux.org.uk>
Message-ID: <61832475-9828-078c-170a-0d25915687d7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Russell,

On 11/8/18 4:21 PM, Russell King - ARM Linux wrote:
> On Wed, Nov 07, 2018 at 06:36:16PM -0600, Grygorii Strashko wrote:
>> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>> index 7a37a37..fb28b71 100644
>> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>> @@ -1165,28 +1165,17 @@ static void mvpp22_gop_setup_irq(struct mvpp2_port *port)
>>    */
>>   static int mvpp22_comphy_init(struct mvpp2_port *port)
>>   {
>> -	enum phy_mode mode;
>> +	int submode;
>>   	int ret;
>>   
>>   	if (!port->comphy)
>>   		return 0;
>>   
>> -	switch (port->phy_interface) {
>> -	case PHY_INTERFACE_MODE_SGMII:
>> -	case PHY_INTERFACE_MODE_1000BASEX:
>> -		mode = PHY_MODE_SGMII;
>> -		break;
>> -	case PHY_INTERFACE_MODE_2500BASEX:
>> -		mode = PHY_MODE_2500SGMII;
>> -		break;
>> -	case PHY_INTERFACE_MODE_10GKR:
>> -		mode = PHY_MODE_10GKR;
>> -		break;
>> -	default:
>> -		return -EINVAL;
>> -	}
>> +	submode = port->phy_interface;
>> +	if (submode == PHY_INTERFACE_MODE_1000BASEX)
>> +		submode = PHY_INTERFACE_MODE_SGMII;
> 
> If the intention is to move the ethernet PHY mode into the generic PHY
> layer, I'd suggest that the equivalence of 1000base-X and SGMII is
> handled in the generic PHY driver rather than ethernet drivers.  Just
> move this into this hunk of the comphy driver:

sure, will do

> 
>> @@ -517,10 +519,14 @@ static int mvebu_comphy_set_mode(struct phy *phy,
>>   {
>>   	struct mvebu_comphy_lane *lane = phy_get_drvdata(phy);
>>   
>> -	if (mvebu_comphy_get_mux(lane->id, lane->port, mode) < 0)
>> +	if (mode != PHY_MODE_ETHERNET)
>> +		return -EINVAL;
>> +
>> +	if (mvebu_comphy_get_mux(lane->id, lane->port, mode, submode) < 0)
>>   		return -EINVAL;
>>   
>>   	lane->mode = mode;
>> +	lane->submode = submode;
>>   	return 0;
>>   }
> 

-- 
regards,
-grygorii
