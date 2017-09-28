From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 27 Sep 2017 21:50:46 -0700
Subject: [PATCH v6 11/11] of: mdio: Prevent of_mdiobus_register from
 scanning mdio-mux nodes
In-Reply-To: <20170927141213.GF13516@lunn.ch>
References: <20170927073414.17361-1-clabbe.montjoie@gmail.com>
 <20170927073414.17361-12-clabbe.montjoie@gmail.com>
 <20170927141213.GF13516@lunn.ch>
Message-ID: <c8697b60-294f-7cc1-8425-aa5b837fcca0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/27/2017 07:12 AM, Andrew Lunn wrote:
> On Wed, Sep 27, 2017 at 09:34:14AM +0200, Corentin Labbe wrote:
>> Each child node of an MDIO node is scanned as a PHY when calling
>> of_mdiobus_register() givint the following result:
>> [   18.175379] mdio_bus stmmac-0: /soc/ethernet at 1c30000/mdio/mdio-mux has invalid PHY address
>> [   18.175408] mdio_bus stmmac-0: scan phy mdio-mux at address 0
>> [   18.175450] mdio_bus stmmac-0: scan phy mdio-mux at address 1
>> [...]
>> [   18.176420] mdio_bus stmmac-0: scan phy mdio-mux at address 30
>> [   18.176452] mdio_bus stmmac-0: scan phy mdio-mux at address 31
>>
>> Since mdio-mux nodes are not PHY, this patch a way to to not scan
>> them.
> 
> Hi Corentin
> 
> I still don't like this, but ...

Me neither, even more so as I don't understand the reasoning behind
putting the mux as a child node of the MDIO bus controller in the first
place.

Also, you need to re-order patches such that this patch comes before the
DTS changes.

> 
>>
>> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
>> ---
>>  drivers/of/of_mdio.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
>> index d94dd8b77abd..d90ddb0d90f2 100644
>> --- a/drivers/of/of_mdio.c
>> +++ b/drivers/of/of_mdio.c
>> @@ -190,6 +190,10 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
>>  	struct device_node *child;
>>  	bool scanphys = false;
>>  	int addr, rc;
>> +	static const struct of_device_id do_not_scan[] = {
>> +		{ .compatible = "mdio-mux" },
>> +		{}
>> +	};
> 
> Please rename this to some less generic. What i don't want is other
> compatible strings added here. We want to make the exception for
> muxes, but nothing else. So something like compatible_muxes?
> 
>        Andrew
> 

-- 
Florian
