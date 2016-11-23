From: tomas.hlavacek@nic.cz (tomas.hlavacek at nic.cz)
Date: Wed, 23 Nov 2016 23:45:20 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <20161123145916.GL14947@lunn.ch>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
 <1479126185.15557.5@smtp.gmail.com>
 <20161114201640.rr32iyjf5a53v33t@perseus.defre.kleine-koenig.org>
 <20161114202832.GG24546@lunn.ch> <1479586147.10840.0@smtp.gmail.com>
 <20161120203037.pd5mhqyjeotileve@perseus.defre.kleine-koenig.org>
 <1479851991.26813.2@smtp.gmail.com> <20161123145916.GL14947@lunn.ch>
Message-ID: <1479941120.10840.13@smtp.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew!

On Wed, Nov 23, 2016 at 3:59 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>>  >CZ11NIC12 is indicated on my board.
>> 
>>  :-( Well, this board version has wrongly matched length of some
>>  differential pairs, IRQ from 88E1514 is connected differently, there
>>  are slight differences in power supplies and (if I am not mistaken)
>>  something changed in RTC support circuitry. It looks like a huge
>>  mistake on our side.
> 
> Hi Tomas
> 
> Would these problems also explain why the Ethernet links to the switch
> don't work? Maybe the differential pairs?

I do not think so. The ethernet links to the switch are RGMII, not 
differential pairs. Differential pair is used only for the eth2 to link 
either SFP+ or 88E1514 (via a high-speed switch that selects one or 
another). So the problems with differential pairs affect only WAN 
interface.

> 
> 
>>  It seems that libphy is probed before pca9538 and we end up with:
>>  [    4.217550] libphy: orion_mdio_bus: probed
>>  [    4.221777] irq: no irq domain found for
>>  /soc/internal-regs/i2c at 11000/i2cmux at 70/i2c at 7/gpio at 71 !
>> 
>>  Any clue where to look in order to defer probing libphy or at least
>>  orion_mdio_bus?
> 
> I think there is a known phylib problem here. Somewhere in the call
> chain there is a void function, so the EPROBE_DEFFER gets
> discarded. But i could be remembering this wrongly.

Oh yes, I thought that and I tried to find exactly this type of problem 
yesterday, but I didn't succeed. But I think that we agreed that we are 
going to stick with PHY polling rather then experimenting with 
unreliable IRQ over the GPIO expander, so we can leave this unresolved.

I will look into the I2C mux concerns, fix the remaining comments 
regarding my version and test RTC more extensively - Uwe's board is 
still not ticking, mine does, so we have to rule out that it is a 
common problem.

Tomas
