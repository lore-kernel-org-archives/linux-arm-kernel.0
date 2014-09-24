From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Wed, 24 Sep 2014 11:26:19 -0400
Subject: [PATCH 1/2] ARM: dts: vf610: Add ARM Global Timer
In-Reply-To: <1dc8267dcf1a4990ba32569b65a1dcf4@agner.ch> (Stefan Agner's
 message of "Wed, 24 Sep 2014 09:55:44 +0200")
References: <1410437175-6636-1-git-send-email-stefan@agner.ch>
 <87mw9qmix9.fsf@nbsps.com> <1dc8267dcf1a4990ba32569b65a1dcf4@agner.ch>
Message-ID: <8738bhm44k.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 Sep 2014, stefan at agner.ch wrote:

> Am 2014-09-23 17:54, schrieb Bill Pringlemeir:
>> On 11 Sep 2014, stefan at agner.ch wrote:
>>
>>> Add Global Timer support which is part of the Snoop Control Unit
>>> of the Cortex-A5 processor. This Global Timer is compatible with the
>>> Cortex-A9 implementation. It's a 64-bit timer and is clocked by the
>>> peripheral clock, which is typically 133 or 166MHz on Vybrid.
>>
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>> ---
>>> arch/arm/boot/dts/vf610.dtsi | 8 ++++++++
>>> 1 file changed, 8 insertions(+)
>>
>> As per the GPC and SRC series, adding these peripherals to the
>> 'vf610.dtsi' may make some configuration no longer boot.  I have an
>> Cortex-A5 MQX in the secure world and it uses the Global timer for
>> the OS tick.  Maybe that is just my problem and I need to have
>> several trees.  However, It would be nice if the system timer choice
>> was made in a '.config' and the machine DT and not the generic Vybrid
>> one.

> So MQX is running "beneath" Linux and steals CPU from it? And this
> works with an unmodified Linux kernel? Did not know that this is
> possible and implemented for Vybrid.

Yes, this was working well.  The only patch is,

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 076172b..4c560e7 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1514,6 +1514,10 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 
        data = of_match_node(l2x0_ids, np)->data;
 
+       /* Call monitor to turn on L2 cache. */
+       if(of_property_read_bool(np,"trustzone"))
+               asm(" .arch_extension sec\n smc #5\n");
+
        if (of_device_is_compatible(np, "arm,pl310-cache") &&
            of_property_read_bool(np, "arm,io-coherent"))
                data = &of_l2c310_coherent_data;

Ie, the 'normal' world Linux doesn't have permission to access the L2.
I think this may not be an issue if you don't use a 'bzImage'.  It seems
the compressed loader expect cache disabled, but then enables it.  Also,
the 'cache-l2x0.c' will see it exists and then try to enable it, if not
already enabled.  So, the compress boot needs it disabled, but the
'cache-l2x0.c' needs it enabled.

MQX needs more significant modifications.  Especially, the DMA support
needs to be disabled.   Probably the same for M4-MQX/A5-Linux.

> I just thought that it would be nice to have the PIT timer free for
> the M4, and hence use the Cortex-A5 private ARM Global Timer.

> But if there are reasons to not use the Global Timer but opt for the
> PIT timer, I guess we could create a configuration here.

Other use cases are the M4 is 'secure' and the A5 runs in normal world
without any secure TZ A5 accesses.  People may wish to do this to 'lock
down' an A5 Linux; Ie, restrict bus peripherals.  Here, whatever boot
loader could give permission for the Normal world to use the ARM global
timer.  I just think it should be an option as opposed to a default.

There is a stronger case to make this the default for the A5.  Only a
trustzone version would care about this on the Vybrid.  The M4 can not
access the global timer.

>> Also, the timer is listed in the same bank as the snoop control unit,
>> but it is part of several banks of registers,
>>
>> 0x40002000 AIPS slot 2, CA5-SCU+GIC CPU Interface registers 1
>>
>> 0x000-0x054 SCU 
>> 0x100-0x1fc GIC local registers
>> 0x200-0x218 Global Timer
>> 0x600-0x634 Local timer/watchdog timer
>>
>> I think that the 'reg' mapping will be limited to 4k MMU pages and so
>> we will have a bunch of aliases.  At least the GIC registers are
>> already mapped.  Is there some way in the DT to provide several sets
>> of registers under one mapping and then use the different offsets in
>> the driver/device instance?
>
> You can define multiple address/size tuples in one reg property, as
> its done for the GIC:
>
> intc: interrupt-controller at 40002000 {
> 	compatible = "arm,cortex-a9-gic";
> 	#interrupt-cells = <3>;
> 	interrupt-controller;
> 	reg = <0x40003000 0x1000>,
> 	      <0x40002100 0x100>;
> };

> The device tree should describe the hardware, and when it comes to GIC
> and Global Timer it quite accurate: For the Global Timer, I only map
> those 0x20 registers (actually its one 32-bit register too many, but I
> don't think this is used for anything). The GIC mapping is only
> mapping 0x100-0x1ff of the snoop contorl unit bank.

> Both, the GIC driver as well as the ARM Global Timer use of_iomap on
> those registers. It apparently works.

Yes, it works.  I just mean that we will have the same memory mapped
twice.  of_iomap() will be limited to 4k regions by the ARM hardware.
Both the 'interrupt-controller' and the 'global-timer' will have virtual
mappings to the same 4k physical page.

There seems to be no way for two drivers to share the same virtual
mapping; maybe Linux will reference count this and just provide an
offset to an existing mapping.  Sorry, I think that side tracked me.

Mainly the commit message is a little wrong,

> Add Global Timer support which is part of the Snoop Control Unit
> of the Cortex-A5 processor.

Maybe,

> Add Global Timer support which is part of the private peripherals
> of the Cortex-A5 processor.
