From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 29 Jan 2013 17:27:56 +0100
Subject: [PATCH 5/5] mv643xx_eth: convert to use the Marvell Orion MDIO
 driver
In-Reply-To: <20130129170131.7964a110@skate>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1359473048-26551-6-git-send-email-florian@openwrt.org>
 <20130129170131.7964a110@skate>
Message-ID: <5107F88C.8030002@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2013 05:01 PM, Thomas Petazzoni wrote:
> Dear Florian Fainelli,
>
> On Tue, 29 Jan 2013 16:24:08 +0100, Florian Fainelli wrote:
>> This patch converts the Marvell MV643XX ethernet driver to use the
>> Marvell Orion MDIO driver. As a result, PowerPC and ARM platforms
>> registering the Marvell MV643XX ethernet driver are also updated to
>> register a Marvell Orion MDIO driver. This driver voluntarily overlaps
>> with the Marvell Ethernet shared registers because it will use a subset
>> of this shared register (shared_base + 0x4 - shared_base + 0x84). The
>> Ethernet driver is also updated to look up for a PHY device using the
>> Orion MDIO bus driver.
>>
>> Signed-off-by: Florian Fainelli <florian@openwrt.org>
>> ---
>>   arch/arm/plat-orion/common.c               |   84 +++++++++++--
> In this file, there was one "MV643XX_ETH_SHARED_NAME" platform_device
> registered for each network interface. Why? If the driver is shared,
> isn't the whole idea to register it only once?
It looks like I introduced two redundant mvmdio instances as ge01 refers 
to the ge00 smi bus (the same applies to ge11 and ge10). Thanks for 
spotting this.

>
> In any case, one of the idea of separating the mvmdio driver from the
> mvneta driver in the first place is that there should be only one
> instance of the mvmdio device, even if there are multiple network
> interfaces. The reason is that from a HW point of the view, the MDIO
> unit is shared between the network interfaces. If you look at
> armada-370-xp.dtsi, there is only one mvmdio device registered, and two
> network interfaces (using the mvneta driver) that are registered (and
> actually up to four network interfaces can exist, they are added by
> some other .dtsi files depending on the specific SoC).
>
> So I don't think there should be one instance of the mvmdio per network
> interface.
>
> Also, I am wondering what's left in this MV643XX_ETH_SHARED_NAME driver
> once the MDIO stuff has been pulled out in a separate driver? I think
> the whole point of this work should be to get rid of this
> MV643XX_ETH_SHARED_NAME driver, no?

If you take a closer look at mv643xx_eth you will see that the "shared" 
driver still handles the mconf bus window configuration, which is not 
abstracted yet. Besides that, I would rather do it step by step.
--
Florian
