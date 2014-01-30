From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 30 Jan 2014 11:31:32 +0100
Subject: [PATCH 0/4] clk: mvebu: fix clk init order
In-Reply-To: <52EA2875.5020807@free-electrons.com>
References: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <52EA2875.5020807@free-electrons.com>
Message-ID: <52EA2A04.2070109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/14 11:24, Gregory CLEMENT wrote:
> On 25/01/2014 19:19, Sebastian Hesselbarth wrote:
>> This patch set fixes clk init order that went upside-down with
>> v3.14. I haven't really investigated what caused this, but I assume
>> it is related with DT node reordering by addresses.
>
> Can you explain what kind of issue do you observe?

Sure. When probing CLK_OF_DECLAREed clock drivers, clock-gating driver
gets registered before core-clocks. It therefore cannot resolve it's
parent clock name for tclk and all clock gates will have no parent
clock.

Usually, you'll see in some drivers (e.g. v643xx_eth) div_by_zero errors
poping up, when they calculate a frequency division factors based on
clock gate frequency, which should have been tclk but is 0 now.

> I have just tested the master branch of Linus and (excepted for SATA
> but Andrew will send a patch set soon), I didn't experiment any
> issues on Armada 370 and Armada XP based boards.
