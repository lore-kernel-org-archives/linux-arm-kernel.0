From: stefan@agner.ch (Stefan Agner)
Date: Wed, 24 Sep 2014 09:55:44 +0200
Subject: [PATCH 1/2] ARM: dts: vf610: Add ARM Global Timer
In-Reply-To: <87mw9qmix9.fsf@nbsps.com>
References: <1410437175-6636-1-git-send-email-stefan@agner.ch>
 <87mw9qmix9.fsf@nbsps.com>
Message-ID: <1dc8267dcf1a4990ba32569b65a1dcf4@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bill,

Am 2014-09-23 17:54, schrieb Bill Pringlemeir:
> On 11 Sep 2014, stefan at agner.ch wrote:
> 
>> Add Global Timer support which is part of the Snoop Control Unit
>> of the Cortex-A5 processor. This Global Timer is compatible with the
>> Cortex-A9 implementation. It's a 64-bit timer and is clocked by the
>> peripheral clock, which is typically 133 or 166MHz on Vybrid.
> 
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> arch/arm/boot/dts/vf610.dtsi | 8 ++++++++
>> 1 file changed, 8 insertions(+)
> 
> As per the GPC and SRC series, adding these peripherals to the
> 'vf610.dtsi' may make some configuration no longer boot.  I have an
> Cortex-A5 MQX in the secure world and it uses the Global timer for the
> OS tick.  Maybe that is just my problem and I need to have several
> trees.  However, It would be nice if the system timer choice was made in
> a '.config' and the machine DT and not the generic Vybrid one.

So MQX is running "beneath" Linux and steals CPU from it? And this works
with an unmodified Linux kernel? Did not know that this is possible and
implemented for Vybrid.

I just thought that it would be nice to have the PIT timer free for the
M4, and hence use the Cortex-A5 private ARM Global Timer.

But if there are reasons to not use the Global Timer but opt for the PIT
timer, I guess we could create a configuration here.


> Also, the timer is listed in the same bank as the snoop control unit,
> but it is part of several banks of registers,
> 
>  0x40002000 AIPS slot 2, CA5-SCU+GIC CPU Interface registers 1
> 
>  0x000-0x054 SCU 
>  0x100-0x1fc GIC local registers
>  0x200-0x218 Global Timer
>  0x600-0x634 Local timer/watchdog timer
> 
> I think that the 'reg' mapping will be limited to 4k MMU pages and so we
> will have a bunch of aliases.  At least the GIC registers are already
> mapped.  Is there some way in the DT to provide several sets of
> registers under one mapping and then use the different offsets in the
> driver/device instance?

You can define multiple address/size tuples in one reg property, as its
done for the GIC:

intc: interrupt-controller at 40002000 {
	compatible = "arm,cortex-a9-gic";
	#interrupt-cells = <3>;
	interrupt-controller;
	reg = <0x40003000 0x1000>,
	      <0x40002100 0x100>;
};

The device tree should describe the hardware, and when it comes to GIC
and Global Timer it quite accurate: For the Global Timer, I only map
those 0x20 registers (actually its one 32-bit register too many, but I
don't think this is used for anything). The GIC mapping is only mapping
0x100-0x1ff of the snoop contorl unit bank.

Both, the GIC driver as well as the ARM Global Timer use of_iomap on
those registers. It apparently works.

--
Stefan
