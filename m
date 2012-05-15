From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 16:36:03 +0100
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120515170020.23c68cac@skate>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB26E4B.4020609@codethink.co.uk> <20120515170020.23c68cac@skate>
Message-ID: <4FB277E3.4020805@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 16:00, Thomas Petazzoni wrote:
> Le Tue, 15 May 2012 15:55:07 +0100,
> Ben Dooks<ben.dooks@codethink.co.uk>  a ?crit :
>
>>> This preliminary support only includes the necessary code for timer
>>> and IRQ support, the serial controller is a standard
>>> 16550-compatible one. The diffstat looks like:
>>
>> FYI, built and tested on our system here and it gets to
>> printing the sched_clock line and getting no further.
>>
>> I will have a debug.
>
> Hum, strange. On which platform exactly?

I've tracked this down to the following:
arch/arm/mach-armada/time.c

    190          } else {
    191                  u32 clk;
    192                  of_property_read_u32(np, "clock-frequency", &clk);
    193                  WARN_ON(!clk);

The problem is the 'clk' variable is un-initialised and therefore
the fact my device-tree is missing a clock-frequency property is
causing the system to use what was in 'clk' which was around 16000
from the stack.

I suggest that any property that is necessary to a unit operation
should check that there was something to read. WARN_ON() is fine,
but they you should not carry on and initialise the unit anyway.

I have now gone and fixed my .dts file and the system now gets to
the point to try and mount an initrd.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
