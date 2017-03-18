From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 18 Mar 2017 09:41:56 -0700
Subject: [PATCH v3 1/2] ARM: dts: bcm5301x: Add TWD WD Support to DT
In-Reply-To: <ece3845e-fdaf-3d90-6667-790dcfdcbe9c@gmail.com>
References: <1488817485-7503-1-git-send-email-jon.mason@broadcom.com>
 <1488817485-7503-2-git-send-email-jon.mason@broadcom.com>
 <03eb99e1-f18c-d4a3-32bf-d90640b14ab1@gmail.com>
 <ece3845e-fdaf-3d90-6667-790dcfdcbe9c@gmail.com>
Message-ID: <171eeda6-76d7-a241-b8cf-19c7e4283ca2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/18/2017 03:36 AM, Rafa? Mi?ecki wrote:
> On 03/15/2017 10:53 PM, Florian Fainelli wrote:
>> On 03/06/2017 08:24 AM, Jon Mason wrote:
>>> From: Jon Mason <jonmason@broadcom.com>
>>>
>>> Add support for the ARM TWD Watchdog to the bcm5301x device tree.  The
>>> ARM TWD timer allocated the register space for the WDT, so this patch
>>> necessitated shrinking that.  Also, the GIC masks were added for these.
>>>
>>> Signed-off-by: Jon Mason <jonmason@broadcom.com>
>>
>> There were some minor conflicts that have been resolved, applied, thanks!
> 
> Solving conflict by removing a reg property? ;)
> timer at 20600 {
>     compatible = "arm,cortex-a9-twd-timer";
>     interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
>                   IRQ_TYPE_EDGE_RISING)>;
>     clocks = <&periph_clk>;
> };

Sorry about that, the new commit is pushed to the same branch:

https://github.com/Broadcom/stblinux/commit/f22c635e585471d01a38b829c0753c1467b5058e

and it now incorporates:

ARM: dts: BCM5301X: Correct GIC_PPI interrupt flags

which was applied to devicetree/fixes and not devicetree/next.

> 
> This may be a bad idea :P
> [    0.020330] ------------[ cut here ]------------
> [    0.025280] WARNING: CPU: 0 PID: 0 at arch/arm/kernel/smp_twd.c:412
> twd_local_timer_of_register+0x6c/0x80()
> [    0.035653] twd_local_timer_of_register failed (-12)
> [    0.040924] Modules linked in:
> [    0.044171] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.4.53 #0
> [    0.050462] Hardware name: BCM5301X
> [    0.054161] Backtrace:
> [    0.056781] [<c0017050>] (dump_backtrace) from [<c001724c>]
> (show_stack+0x18/0x1c)
> [    0.064831]  r7:0000019c r6:c03ea15e r5:600000d3 r4:00000000
> [    0.070992] [<c0017234>] (show_stack) from [<c0181724>]
> (dump_stack+0x84/0xa4)
> [    0.078688] [<c01816a0>] (dump_stack) from [<c0021534>]
> (warn_slowpath_common+0x8c/0xb8)
> [    0.087294]  r5:00000009 r4:c0497f48
> [    0.091188] [<c00214a8>] (warn_slowpath_common) from [<c0021598>]
> (warn_slowpath_fmt+0x38/0x40)
> [    0.100444]  r8:c7ffe700 r7:c04b0a14 r6:c04983c0 r5:00000002 r4:c6de78f0
> [    0.107721] [<c0021564>] (warn_slowpath_fmt) from [<c0464010>]
> (twd_local_timer_of_register+0x6c/0x80)
> [    0.117629]  r3:fffffff4 r2:c03ea135
> [    0.121512] [<c0463fa4>] (twd_local_timer_of_register) from
> [<c04760b0>] (clocksource_probe+0x54/0x94)
> [    0.131410]  r5:00000002 r4:c6de78f0
> [    0.135299] [<c047605c>] (clocksource_probe) from [<c046366c>]
> (time_init+0x30/0x38)
> [    0.143532]  r5:ffffffff r4:00000000
> [    0.147412] [<c046363c>] (time_init) from [<c0460be0>]
> (start_kernel+0x274/0x3f4)
> [    0.155376] [<c046096c>] (start_kernel) from [<0000807c>] (0x807c)
> [    0.161944]  r10:00000000 r9:413fc090 r8:0000406a r7:c049acd4
> r6:c0488a24 r5:c0498444
> [    0.170454]  r4:c04b0b20
> [    0.173213] ---[ end trace f24b6c88ae00fa9a ]---
> 

-- 
Florian
