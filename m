From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 26 Apr 2012 00:24:51 -0600 (MDT)
Subject: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree data
In-Reply-To: <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1204260017540.30642@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Vaibhav, Afzal, Vaibhav,

while working on clock33xx_data.c, it became clear that we would not be 
able to remove the MODULEMODE leaf clocks for several IP blocks that share 
driver code with other DaVinci chips.  This is because:

1. the drivers for these IP blocks only use the clock framework, rather 
than runtime PM;

and 

2. the clk_get() calls in those drivers do not specify a con_id 
parameter, which could cause problems with the clkdev clk_find()'s fuzzy 
matching algorithm.

So perhaps your group can work on converting the drivers to use runtime 
PM?  Discussing this with Kevin, it sounds like DaVinci doesn't have 
runtime PM hooks implemented, but you can probably use OMAP1 as an example 
of how to do it.

And then if clk_get() is still needed in the drivers, a specific con_id 
should be supplied, such as "fck", which can also be supplied by the OMAP 
codebase.


- Paul
