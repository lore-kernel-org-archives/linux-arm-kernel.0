From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 3 Mar 2014 17:07:37 -0800
Subject: [REGRESSION] Arndale Octa panics when booting 3.14-rc1
In-Reply-To: <5314D239.7090001@gmail.com>
References: <20140303185755.GA11460@e102654-lin.cambridge.arm.com>
 <5314D239.7090001@gmail.com>
Message-ID: <CAPtuhTj-yKebFG=N38=CjugxbehmugXSmA+9fAWXSkF5MgaWpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 3, 2014 at 11:04 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi,
>
>
> On 03.03.2014 19:57, Javi Merino wrote:
>>
>> Hi,
>>
>> Commit fcb0ee6a3d (clk: Implement clk_unregister) added calls to
>> kref_get() and kref_put() to __clk_get() and __clk_put() without
>> checking if clk is not NULL:
>>
>>> @@ -1987,6 +2097,7 @@ int __clk_get(struct clk *clk)
>>>          if (clk && !try_module_get(clk->owner))
>>>                  return 0;
>>>
>>> +       kref_get(&clk->ref);
>>>          return 1;
>>>   }
>>>
>>> @@ -1995,6 +2106,10 @@ void __clk_put(struct clk *clk)
>>>          if (WARN_ON_ONCE(IS_ERR(clk)))
>>>                  return;
>>>
>>> +       clk_prepare_lock();
>>> +       kref_put(&clk->ref, __clk_release);
>>> +       clk_prepare_unlock();
>>> +
>>>          if (clk)
>>>                  module_put(clk->owner);
>>>   }
>>
>>
>> Before this commit, these functions allowed clk to be NULL.  In
>> particular, the "if (clk)" in __clk_put() is now useless, as clk has
>> been dereferenced by the time you reach it.
>>
>> This causes Arndale Octa to panic on boot:
>>
>> 8<---
>>      [    7.430000] Creating amba device /amba/pdma at 121B0000
>>      [    7.435000]    create child: /amba/mdma at 10800000
>>      [    7.440000] Creating amba device /amba/mdma at 10800000
>>      [    7.445000] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000050
>>      [    7.450000] pgd = c0004000
>>      [    7.450000] [00000050] *pgd=00000000
>>      [    7.455000] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
>>      [    7.455000] Modules linked in:
>>      [    7.455000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
>> 3.14.0-rc3-00003-gb6026fe-dirty #23
>>      [    7.455000] task: ee0a8000 ti: ee0a6000 task.ti: ee0a6000
>>      [    7.455000] PC is at __clk_get+0x24/0x84
>>      [    7.455000] LR is at of_clk_get+0x5c/0x74
>>      [    7.455000] pc : [<c02e5cc8>]    lr : [<c02e34b8>]    psr:
>> 60000113
>>      [    7.455000] sp : ee0a7d78  ip : ee0a7d88  fp : 00000001
>>      [    7.455000] r10: f001c000  r9 : ee193a10  r8 : 00000000
>>      [    7.455000] r7 : 00000000  r6 : ee7dedb4  r5 : c045e930  r4 :
>> 00000000
>>      [    7.455000] r3 : 00000050  r2 : 000001d9  r1 : c0575df8  r0 :
>> 00000000
>>      [    7.455000] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
>> Segment kernel
>>      [    7.455000] Control: 10c5387d  Table: 2000406a  DAC: 00000015
>>      [    7.455000] Process swapper/0 (pid: 1, stack limit = 0xee0a6240)
>>      [    7.455000] Stack: (0xee0a7d78 to 0xee0a8000)
>>      [    7.455000] 7d60:
>> 00000000 c02e34b8
>>      [    7.455000] 7d80: ee0a7d88 c02df2e4 ee7dd984 00000001 000001d9
>> ee7dedb4 00000000 c02df300
>>      [    7.455000] 7da0: ee1779c0 c045e930 ee7dedb4 00000000 ee1779c0
>> c02e350c 00000000 ee1779c0
>>      [    7.455000] 7dc0: c045e930 00001000 00000000 c02e35a4 00000000
>> ee194000 ee194128 c01ee6fc
>>      [    7.455000] 7de0: ee194000 ee194128 00001000 c01ee7ec 00000000
>> ee7dedb4 ee194000 00000009
>>      [    7.455000] 7e00: ee19416c 00000000 00000001 c02e0f94 c053f0f2
>> 00000000 ee193a10 c03b6880
>>      [    7.455000] 7e20: 00000000 ee7dedb4 ee193a10 00000000 00000000
>> 00000001 00000000 c0385924
>>      [    7.455000] 7e40: c047832c ee7dea18 00000000 ee7dedb4 ee193a10
>> 00000000 00000000 00000001
>>      [    7.455000] 7e60: 00000000 c02e103c 00000001 c04c9500 00000079
>> c03b6880 00000000 00000000
>>      [    7.455000] 7e80: 60000113 c05352d8 00000000 00000000 c03b6880
>> 00000001 00000000 ee7dea18
>>      [    7.455000] 7ea0: ee7d6e28 00000000 00000000 c03b6880 00000000
>> 00000001 00000000 c02e116c
>>      [    7.455000] 7ec0: 00000001 00000000 c04cc264 ee0a6000 c04ec240
>> 00000000 c04c9500 c04fec18
>>      [    7.455000] 7ee0: 00000079 c04cc280 00000000 c00088e8 00000000
>> c038cb70 0000006d 00000000
>>      [    7.455000] 7f00: 00000001 c0101a2c ee15ce00 ee15d080 60000100
>> c050fb40 60000113 c050fb40
>>      [    7.455000] 7f20: c04ec230 c050fb3c c050fb3c c04a79f0 c04a79f0
>> ef7fc9ff ef7fc9fb c0034f40
>>      [    7.455000] 7f40: c043e434 c04a7260 00000003 00000003 00000000
>> c04ec260 00000003 c04ec240
>>      [    7.455000] 7f60: c053b2c0 c04c9500 c04fec18 00000079 00000000
>> c04c9c50 00000003 00000003
>>      [    7.455000] 7f80: c04c9500 c003e450 00000000 c0384474 00000000
>> 00000000 00000000 00000000
>>      [    7.455000] 7fa0: 00000000 c038447c 00000000 c000e4b8 00000000
>> 00000000 00000000 00000000
>>      [    7.455000] 7fc0: 00000000 00000000 00000000 00000000 00000000
>> 00000000 00000000 00000000
>>      [    7.455000] 7fe0: 00000000 00000000 00000000 00000000 00000013
>> 00000000 ffffffff ffffffff
>>      [    7.455000] [<c02e5cc8>] (__clk_get) from [<c02e34b8>]
>> (of_clk_get+0x5c/0x74)
>>      [    7.455000] [<c02e34b8>] (of_clk_get) from [<c02e350c>]
>> (of_clk_get_by_name+0x3c/0xb0)
>>      [    7.455000] [<c02e350c>] (of_clk_get_by_name) from [<c02e35a4>]
>> (clk_get+0x24/0x44)
>>      [    7.455000] [<c02e35a4>] (clk_get) from [<c01ee6fc>]
>> (amba_get_enable_pclk+0x10/0x60)
>>      [    7.455000] [<c01ee6fc>] (amba_get_enable_pclk) from [<c01ee7ec>]
>> (amba_device_add+0xa0/0x1e0)
>>      [    7.455000] [<c01ee7ec>] (amba_device_add) from [<c02e0f94>]
>> (of_platform_bus_create+0x190/0x308)
>>      [    7.455000] [<c02e0f94>] (of_platform_bus_create) from
>> [<c02e103c>] (of_platform_bus_create+0x238
>>      [    7.455000] [<c02e103c>] (of_platform_bus_create) from
>> [<c02e116c>] (of_platform_populate+0x60/0x
>>      [    7.455000] [<c02e116c>] (of_platform_populate) from [<c04cc280>]
>> (customize_machine+0x1c/0x40)
>>      [    7.455000] [<c04cc280>] (customize_machine) from [<c00088e8>]
>> (do_one_initcall+0xe4/0x140)
>>      [    7.455000] [<c00088e8>] (do_one_initcall) from [<c04c9c50>]
>> (kernel_init_freeable+0xfc/0x1c8)
>>      [    7.455000] [<c04c9c50>] (kernel_init_freeable) from [<c038447c>]
>> (kernel_init+0x8/0xe4)
>>      [    7.455000] [<c038447c>] (kernel_init) from [<c000e4b8>]
>> (ret_from_fork+0x14/0x3c)
>>      [    7.455000] Code: e3500000 08bd8010 e2843050 f57ff05b (e1932f9f)
>>      [    7.460000] ---[ end trace fe5cfa405506a77d ]---
>>      [    7.460000] Kernel panic - not syncing: Attempted to kill init!
>> exitcode=0x0000000b
>> 8<---
>>
>> I've tried putting "if (clk)" around the calls to kref_get() and
>> kref_put(), but that makes the Octa fail to boot like 3.13 did: when
>> tries to mount root.
>>
>> What works for me so far is to remove the offending nodes from the DT:
>>
>> 8<---
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
>> b/arch/arm/boot/dts/exynos5420.dtsi
>> index 8db792b..c4ab992 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -303,27 +303,6 @@
>>                          #dma-requests = <32>;
>>                  };
>>
>> -               mdma0: mdma at 10800000 {
>> -                       compatible = "arm,pl330", "arm,primecell";
>> -                       reg = <0x10800000 0x1000>;
>> -                       interrupts = <0 33 0>;
>> -                       clocks = <&clock 473>;
>> -                       clock-names = "apb_pclk";
>> -                       #dma-cells = <1>;
>> -                       #dma-channels = <8>;
>> -                       #dma-requests = <1>;
>> -               };
>> -
>> -               mdma1: mdma at 11C10000 {
>> -                       compatible = "arm,pl330", "arm,primecell";
>> -                       reg = <0x11C10000 0x1000>;
>> -                       interrupts = <0 124 0>;
>> -                       clocks = <&clock 442>;
>> -                       clock-names = "apb_pclk";
>> -                       #dma-cells = <1>;
>> -                       #dma-channels = <8>;
>> -                       #dma-requests = <1>;
>> -               };
>>          };
>>
>>          spi_0: spi at 12d20000 {
>> 8<---
>>
>> With this the Arndale Octa boots.  This issue is present from 3.14-rc1
>> to 3.14-rc5.  Any idea how this should be properly fixed in mainline?
>
>
> This should be fixed with [1], which was supposed to be merged for 3.14-rc5.
> Mike?

Sent but not merged for -rc5. Guess it will be merged for -rc6:

https://lkml.org/lkml/2014/3/2/277

Regards,
Mike

>
> [1]
> https://git.linaro.org/people/mike.turquette/linux.git/commit/00efcb1c8e1c3c5e5d3ce6f0682d66402911a84f
>
> Best regards,
> Tomasz
