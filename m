From: benoitm@perenite.com (Benoit Masson)
Date: Wed, 23 Jul 2014 23:15:18 +0200
Subject: [PATCH 1/2] Added dts defintion for Lenovo ix4-300d nas
In-Reply-To: <20140723164958.GH2856@lunn.ch>
References: <1406117232-5962-1-git-send-email-yahoo@perenite.com>
 <20140723134534.GF23220@titan.lakedaemon.net> <20140723141443.GC2856@lunn.ch>
 <47823826-CDE8-47D2-B1B6-B688118CF985@perenite.com>
 <20140723164958.GH2856@lunn.ch>
Message-ID: <9AE6F1AD-9296-47E9-91E2-9E34AA48EBB4@perenite.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Well after several test with the original BSP driver I found that this is not fully WOL related. It could be that the LED pin is linked to poweron for WOL, yet here the issue is on shutdown pulling up MPP24 should poweroff the deice but only reboots it except is both PHY have some reg written to...

By the way the current nv_neta does not seems to support WOL for 88e1318 and still having them both up is enough to have poweroff to work, which is why I'm putting the WOL as a side track.

Both phy are :
marvell,88e1318

example of a minimal reg write that lead MPP24 to shutdown instead of rebooting on original BSP driver
XXXXX BasicInit
XXXXXXXXXXXXXX phyAdr 0: regOffs: 16 data: 3 caller: mvEthE1310PhyBasicInit+0x2c/0x58
XXXXXXXXXXXXXX phyAdr 0: regOffs: 10 data: 830 caller: mvEthE1310PhyBasicInit+0x3c/0x58
XXXXXXXXXXXXXX phyAdr 0: regOffs: 16 data: 0 caller: mvEthE1310PhyBasicInit+0x4c/0x58
XXXXX BasicInit
XXXXXXXXXXXXXX phyAdr 1: regOffs: 16 data: 3 caller: mvEthE1310PhyBasicInit+0x2c/0x58
XXXXXXXXXXXXXX phyAdr 1: regOffs: 10 data: 830 caller: mvEthE1310PhyBasicInit+0x3c/0x58
XXXXXXXXXXXXXX phyAdr 1: regOffs: 16 data: 0 caller: mvEthE1310PhyBasicInit+0x4c/0x58

I've tried something like:
compatible = "marvell,88e1318";
                                        device_type = "ethernet-phy";
                                        marvell,reg-init =
                                          /* Init led/activity workaround for MP24 shutdown. */
                                          <3 0x10 0 0x830>;

In the dts but without luck

Regards,
Benoit


Le 23 juil. 2014 ? 18:49, Andrew Lunn <andrew@lunn.ch> a ?crit :

>> Well actually the PHY need to be initialized (at least 1 mII reg
>> written), which from marvel LSP driver always occurs, while it
>> doesn't with mainline PHY driver (drivers/net/phy/marvell.c), so the
>> only simple way I found to have at least one PHY reg on both
>> interface written is to have both eth up at OS config level.
> 
> Thanks for the information. This sounds like a wake on LAN feature.
> I've seen other Marvell hardware connect a PHY LED output pin to the
> circuit controlling the main power supply. When the PHY detects the
> magic wake-up packet, it 'blinks' the LED so turning the power back
> on.
> 
> My guess is, the register write to the PHY is configuring the LED. Do
> you have the datasheet for the PHY? Can you check this?
> 
>> Probably the best option would be to have a reg-init = <reg offset
>> value> on both phy dts definition but the current armada mii doesn't
>> support this dts config...
> 
> Once we understand what is going on here, we can consider adding
> support for this.
> 
> 	Andrew
