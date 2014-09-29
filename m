From: post@twien.net (post at twien.net)
Date: Mon, 29 Sep 2014 17:23:59 +0200
Subject: ARMADA 370 - Kernel panic during boot
In-Reply-To: <20140929155724.579964b5@free-electrons.com>
References: <6241a6200de0d573c982f73f062ed7fa@twien.net>
 <542938A7.8050307@free-electrons.com>
 <d1be3a0a37860f969b99ecc09b4cfcd8@twien.net>
 <20140929155724.579964b5@free-electrons.com>
Message-ID: <68f0f9805e88b1cc33c3d2f9521cc93f@twien.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, that made it!

Actually to change the Physical base address of the debug UART was 
actually a shot in the dark, because I got nothing out, and I just 
decided to give it a try.
To me this is somewhat confusing: I thought the physical address of 
those register were 0xd0000000 (according to the hardware specification) 
and that the U-boot remapped those to the virtual address 0xf1000000. 
Well, since it worked on another board with 0xd0000000 (ref. mail from 
Gregory), I assume this is not so simple, and that this may vary 
depending on how U-boot remaps the registers, or? I'm using the U-boot 
provided by Marvell.

I have to debug further though, because it stopped with the message 
bootconsole [...] disabled. I guess the problem is that the switch chip 
(88E6532) is not detected (in the U-boot OK though, as egiga0), and this 
is my only way out.... (SGMII->PHY)

So thanks for the help. I'll keep on with the debugging.
Tormod



On 2014-09-29 15:57, Thomas Petazzoni wrote:
> Hello,
> 
> On Mon, 29 Sep 2014 13:25:03 +0200, post at twien.net wrote:
> 
>> 	soc {
>> 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
> 
> Are you really sure about the 0xd0000000 value here? Your earlyprintk
> works using CONFIG_DEBUG_MVEBU_UART_ALTERNATE=y according to
> your .config, which indicates that your internal registers are mapped 
> at
> 0xf1000000 and not at 0xd0000000 as your Device Tree indicates.
> 
> Can you change this line to:
> 
> 	ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
> 
> And try again?
> 
> Thanks,
> 
> Thomas
