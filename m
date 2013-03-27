From: monstr@monstr.eu (Michal Simek)
Date: Wed, 27 Mar 2013 15:15:53 +0100
Subject: [PATCH v2 05/10] arm: zynq: Move slcr initialization to separate
 file
In-Reply-To: <20130327094138.GG16139@pengutronix.de>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <201303262143.23708.arnd@arndb.de>
 <20130327065551.GC16139@pengutronix.de>
 <201303270931.26351.arnd@arndb.de>
 <20130327094138.GG16139@pengutronix.de>
Message-ID: <CAHTX3dLu+KPVc0MRbtgntv=YKWypT0KMwSR=+nNuwk91fQ+GAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/27 Steffen Trumtrar <s.trumtrar@pengutronix.de>:
> On Wed, Mar 27, 2013 at 09:31:26AM +0000, Arnd Bergmann wrote:
>> On Wednesday 27 March 2013, Steffen Trumtrar wrote:
>> > On Tue, Mar 26, 2013 at 09:43:23PM +0000, Arnd Bergmann wrote:
>> > > On Tuesday 26 March 2013, Michal Simek wrote:
>> > > > Create separate slcr driver instead of pollute common code.
>> > > >
>> > > > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> > >
>> > > Can't you move that code into the zynq_cpu_clk_setup function
>> > > instead, and only call of_clk_init(NULL) from platform code?
>> > >
>> > if you are talking about the slcr function, than moving it into
>> > a separate file is the right move. This should actually become a
>> > real driver. The slcr is master over all clock, reset, pinmux and
>> > ddr registers. And as all those registers can be locked/unlocked
>> > via a slcr register (for whatever reason one would do that), there
>> > should be one master that controls this space.
>>
>> Ok, I see. Thanks for the explanation. Should this be using the
>> drivers/mfd/syscon.c infrastructure then?
>
> A quick look suggests that this might be the way to go. I wasn't aware of that.

I have looked at syscon driver but the problem is when this driver is
ready to use.
It is too late because bus probing is done in init_machine but
we need to unlock slcr before clk and timer init functions are called.
For unlocking we have to also map it.

of_clk_init(NULL)  is called from zynq clock. It is no problem to move it
to common code but still we have to map slcr register in the driver
and pass this address to clk driver.
Currently we are passing slcr reg base as xilinx_zynq_clocks_init() parameter
to avoid to have extern in C file.

I see that Rob in highbank clk choose a way with extern.
of_iomap is done in highbank_timer_init and in the same function calls
of_clk_init()
and clocksource_of_init().

Syscon will be nice to use much later but not for this core stuff.
But maybe you know nicer way how to handle it.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
