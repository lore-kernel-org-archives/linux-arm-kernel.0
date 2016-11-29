From: abailon@baylibre.com (Alexandre Bailon)
Date: Tue, 29 Nov 2016 12:16:33 +0100
Subject: [PATCH] ARM: davinci: da8xx: Fix sleeping function called from
 invalid context
In-Reply-To: <36a2e5e1-e7b7-2ca0-0484-98636771ec65@ti.com>
References: <1480350566-26225-1-git-send-email-abailon@baylibre.com>
 <36a2e5e1-e7b7-2ca0-0484-98636771ec65@ti.com>
Message-ID: <b2ddb9ed-2cf8-da93-6aba-e77ea0eea006@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2016 11:48 AM, Sekhar Nori wrote:
> On Monday 28 November 2016 09:59 PM, Alexandre Bailon wrote:
>> Everytime the usb20 phy is enabled, there is a
>> "sleeping function called from invalid context" BUG.
> 
> Who calls PHY clk_enable() from non-preemptible context? Can you provide
> the call stack?
Actually, clk_enable() is called from preemptible context (from phy
driver) but it disables interrupts before to call the clk_enable()
callback.
I attached the call stack that is probably more understandable than
my explanation.
> 
>> usb20_phy_clk_enable(), called with the irq disabled uses
>> clk_get() and clk_enable_prepapre() which may sleep.
>> Move clk_get() to da8xx_register_usb20_phy_clk() and
>> replace clk_prepare_enable() by clk_enable().
>>
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>> ---
>>  arch/arm/mach-davinci/usb-da8xx.c | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
>> index b010e5f..c9b5cd4 100644
>> --- a/arch/arm/mach-davinci/usb-da8xx.c
>> +++ b/arch/arm/mach-davinci/usb-da8xx.c
>> @@ -156,23 +156,23 @@ int __init da8xx_register_usb_refclkin(int rate)
>>  	return 0;
>>  }
>>  
>> +static struct clk *usb20_clk;
>> +
>>  static void usb20_phy_clk_enable(struct clk *clk)
>>  {
>> -	struct clk *usb20_clk;
>>  	int err;
>>  	u32 val;
>>  	u32 timeout = 500000; /* 500 msec */
>>  
>>  	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
>>  
>> -	usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
>> -	if (IS_ERR(usb20_clk)) {
>> +	if (!usb20_clk || IS_ERR(usb20_clk)) {
> 
> NULL is a valid clock handle. There is no way clock enable of
> usb20_phy_clk can be invoked if its not registered. So, you can assume
> that usb20_clk is valid if you get here.
OK.
> 
>>  		pr_err("could not get usb20 clk: %ld\n", PTR_ERR(usb20_clk));
>>  		return;
>>  	}
>>  
>>  	/* The USB 2.O PLL requires that the USB 2.O PSC is enabled as well. */
>> -	err = clk_prepare_enable(usb20_clk);
>> +	err = clk_enable(usb20_clk);
>>  	if (err) {
>>  		pr_err("failed to enable usb20 clk: %d\n", err);
>>  		clk_put(usb20_clk);
>> @@ -197,8 +197,7 @@ static void usb20_phy_clk_enable(struct clk *clk)
>>  
>>  	pr_err("Timeout waiting for USB 2.0 PHY clock good\n");
>>  done:
>> -	clk_disable_unprepare(usb20_clk);
>> -	clk_put(usb20_clk);
>> +	clk_disable(usb20_clk);
> 
> 
> I noticed that we are missing clk_disable(usb20_clk) in
> usb20_phy_clk_disable(). It will now be easier to do that after this
> patch. Can you add that in a separate patch?
> 
I don't think we need it.
What we don't see in this patch is that usb20_clk is enabled and,
it is disabled right after the PHY PLL is ready in usb20_phy_clk_enable().
>>  }
>>  
>>  static void usb20_phy_clk_disable(struct clk *clk)
>> @@ -287,6 +286,10 @@ int __init da8xx_register_usb20_phy_clk(bool use_usb_refclkin)
>>  	struct clk *parent;
>>  	int ret = 0;
>>  
>> +	usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
>> +	if (IS_ERR(usb20_clk))
>> +		return PTR_ERR(parent);
>> +
>>  	parent = clk_get(NULL, use_usb_refclkin ? "usb_refclkin" : "pll0_aux");
>>  	if (IS_ERR(parent))
>>  		return PTR_ERR(parent);
> 
> clk_put(usb20_clk) should be called here on failure path.
I will fix it.
> 
> Thanks,
> Sekhar
> 
Thanks,
Alexandre

-------------- next part --------------
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:97
in_atomic(): 1, irqs_disabled(): 128, pid: 1053, name: udevd
Preemption disabled at:[<c0017220>] clk_enable+0x40/0x94
CPU: 0 PID: 1053 Comm: udevd Not tainted 4.9.0-rc5-08315-gc26ef3f-dirty #90
Hardware name: Generic DA850/OMAP-L138/AM18x
Backtrace: 
[<c000d968>] (dump_backtrace) from [<c000dcf8>] (show_stack+0x20/0x24)
 r6:c0531e04 r5:c0017220
 r4:00000000 r3:00000000

[<c000dcd8>] (show_stack) from [<c025b398>] (dump_stack+0x20/0x28)
[<c025b378>] (dump_stack) from [<c00432e4>] (___might_sleep+0x140/0x1d8)
[<c00431a4>] (___might_sleep) from [<c00433e8>] (__might_sleep+0x6c/0xac)
 r5:00000061 r4:00000000

[<c004337c>] (__might_sleep) from [<c049487c>] (mutex_lock+0x28/0x4c)
 r7:c06592cc r6:0000ef32
 r5:c052b8a8 r4:c06592cc

[<c0494854>] (mutex_lock) from [<c02abc2c>] (clk_get_sys+0x2c/0x118)
 r4:c0676cbc r3:c06231f8

[<c02abc00>] (clk_get_sys) from [<c02abd48>] (clk_get+0x30/0x34)
 r10:4ea11003 r9:00000000
 r8:bf1fb620 r7:fee00000
 r6:0000ef32 r5:80000013
 r4:c0676cbc
[<c02abd18>] (clk_get) from [<c0018504>] (usb20_phy_clk_enable+0x2c/0x140)
[<c00184d8>] (usb20_phy_clk_enable) from [<c00171bc>] (__clk_enable+0x60/0x84)
 r7:fee00000 r6:c7bdbd80
 r5:80000013 r4:c0623388

[<c001715c>] (__clk_enable) from [<c0017228>] (clk_enable+0x48/0x94)
 r4:c0623388
[<c00171e0>] (clk_enable) from [<bf000238>] (da8xx_usb20_phy_power_on+0x38/0x88 [phy_da8xx_usb])
 r5:c7ba0fd0 r4:c0623388

[<bf000200>] (da8xx_usb20_phy_power_on [phy_da8xx_usb]) from [<c0284348>] (phy_power_on+0x9c/0xec)
 r5:c7bdbc00 r4:fffffdf4

[<c02842ac>] (phy_power_on) from [<bf1fa4dc>] (da8xx_musb_init+0xe4/0x1dc [da8xx])
 r6:c71fee50 r5:00000000
 r4:c7a3a010 r3:00000081

[<bf1fa3f8>] (da8xx_musb_init [da8xx]) from [<bf1deba4>] (musb_probe+0x1b4/0xc2c [musb_hdrc])
 r10:c7164540 r8:bf1ed3b8
 r7:bf1ee420 r6:bf1fae00
 r5:fee00000 r4:c7a3a010
[<bf1de9f0>] (musb_probe [musb_hdrc]) from [<c02f02e8>] (platform_drv_probe+0x48/0x98)
 r10:0000000c r9:00000000
 r8:bf1ed3b8 r7:00000000
 r6:c70d5410 r5:bf1ed3b8
 r4:bf1de9f0
[<c02f02a0>] (platform_drv_probe) from [<c02ee114>] (driver_probe_device+0x24c/0x448)
 r6:c0673938 r5:c06dce14
 r4:c70d5410 r3:c02f02a0

[<c02edec8>] (driver_probe_device) from [<c02ee694>] (__device_attach_driver+0xc0/0x128)
 r10:00000000 r8:c799d010
 r7:c710bb40 r6:c70d5410
 r5:bf1ed3b8 r4:00000001
[<c02ee5d4>] (__device_attach_driver) from [<c02ec104>] (bus_for_each_drv+0x70/0x98)
 r7:00000000 r6:00000000
 r5:c02ee5d4 r4:c710bb40

[<c02ec094>] (bus_for_each_drv) from [<c02eddbc>] (__device_attach+0xac/0x138)
 r6:00000001 r5:c70d5444
 r4:c70d5410
[<c02edd10>] (__device_attach) from [<c02ee718>] (device_initial_probe+0x1c/0x20)
 r7:00000000 r6:c70d5410
 r5:c065dff8 r4:c70d5410

[<c02ee6fc>] (device_initial_probe) from [<c02ed164>] (bus_probe_device+0x94/0x9c)
[<c02ed0d0>] (bus_probe_device) from [<c02eaf70>] (device_add+0x31c/0x570)
 r6:c06dcdf0 r5:c70d5418
 r4:c70d5410 r3:00000001

[<c02eac54>] (device_add) from [<c02f0504>] (platform_device_add+0x130/0x264)
 r10:00000000 r9:00000000
 r8:ffffffff r7:00000001
 r6:c70d5410 r5:c70d5400
 r4:00000002
[<c02f03d4>] (platform_device_add) from [<c02f0dbc>] (platform_device_register_full+0xec/0x118)
 r7:c710bc10 r6:c71fee90
 r5:c70d5400 r4:c710bc50

[<c02f0cd0>] (platform_device_register_full) from [<bf1facac>] (da8xx_probe+0x1a8/0x284 [da8xx])
 r5:c71fee50 r4:c799d010

[<bf1fab04>] (da8xx_probe [da8xx]) from [<c02f02e8>] (platform_drv_probe+0x48/0x98)
 r10:0000000b r9:bf1fb4a8
 r8:bf1fb360 r7:00000000
 r6:c799d010 r5:bf1fb360
 r4:bf1fab04
[<c02f02a0>] (platform_drv_probe) from [<c02ee114>] (driver_probe_device+0x24c/0x448)
 r6:c0673938 r5:c06dce14
 r4:c799d010 r3:c02f02a0

[<c02edec8>] (driver_probe_device) from [<c02ee40c>] (__driver_attach+0xfc/0x128)
 r10:c8ae54a4 r8:00000000
 r7:c0673860 r6:bf1fb360
 r5:c799d010 r4:c799d044
[<c02ee310>] (__driver_attach) from [<c02ec194>] (bus_for_each_dev+0x68/0x98)
 r6:00000000 r5:c02ee310
 r4:bf1fb360 r3:00000000

[<c02ec12c>] (bus_for_each_dev) from [<c02ed7b8>] (driver_attach+0x28/0x30)
 r6:c065dff8 r5:c723b420
 r4:bf1fb360
[<c02ed790>] (driver_attach) from [<c02ed43c>] (bus_add_driver+0x18c/0x268)
[<c02ed2b0>] (bus_add_driver) from [<c02ef0d0>] (driver_register+0x88/0x104)
 r8:bf1fd000 r7:c71fedc0
 r6:00000000 r5:00000001
 r4:bf1fb360
[<c02ef048>] (driver_register) from [<c02f0058>] (__platform_driver_register+0x40/0x54)
 r5:00000001 r4:bf1fb460

[<c02f0018>] (__platform_driver_register) from [<bf1fd018>] (da8xx_driver_init+0x18/0x24 [da8xx])
[<bf1fd000>] (da8xx_driver_init [da8xx]) from [<c0009af0>] (do_one_initcall+0x50/0x188)
[<c0009aa0>] (do_one_initcall) from [<c0085a2c>] (do_init_module+0x6c/0x1e8)
 r8:bf1fb460 r7:c71fedc0
 r6:c7164240 r5:00000001
 r4:bf1fb460
[<c00859c0>] (do_init_module) from [<c008795c>] (load_module+0x1ce8/0x2344)
 r6:00000001 r5:00000001
 r4:c710bf34
[<c0085c74>] (load_module) from [<c00881f4>] (SyS_finit_module+0xb4/0xe0)
 r10:00000000 r9:c710a000
 r8:c000aaa4 r7:00000000
 r6:7fffffff r5:0004f8c0
 r4:00000000
[<c0088140>] (SyS_finit_module) from [<c000a900>] (ret_fast_syscall+0x0/0x38)
 r7:0000017b r6:00000000
 r5:0004f8c0 r4:00020000
