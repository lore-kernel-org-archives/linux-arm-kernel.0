From: abailon@baylibre.com (Alexandre Bailon)
Date: Mon, 5 Dec 2016 11:00:26 +0100
Subject: [PATCH v4] ARM: davinci: da8xx: Fix sleeping function called from
 invalid context
In-Reply-To: <907a3c22-534f-80ce-daff-be84dd5e5cf8@lechnology.com>
References: <1480690380-13216-1-git-send-email-abailon@baylibre.com>
 <907a3c22-534f-80ce-daff-be84dd5e5cf8@lechnology.com>
Message-ID: <9ce5049b-e3ce-a723-8aa6-08ee1fc8bac2@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2016 04:44 AM, David Lechner wrote:
> On 12/02/2016 08:53 AM, Alexandre Bailon wrote:
>> Everytime the usb20 phy is enabled, there is a
>> "sleeping function called from invalid context" BUG.
>>
>> clk_enable() from arch/arm/mach-davinci/clock.c uses spin_lock_irqsave()
>> before to invoke the callback usb20_phy_clk_enable().
>> usb20_phy_clk_enable() uses clk_get() and clk_enable_prepapre()
>> which may sleep.
>> Move clk_get() to da8xx_register_usb20_phy_clk() and
>> replace clk_prepare_enable() by clk_enable().
>>
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>> ---
>>  arch/arm/mach-davinci/usb-da8xx.c | 28 +++++++++++++++-------------
>>  1 file changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/usb-da8xx.c
>> b/arch/arm/mach-davinci/usb-da8xx.c
>> index b010e5f..704f506 100644
>> --- a/arch/arm/mach-davinci/usb-da8xx.c
>> +++ b/arch/arm/mach-davinci/usb-da8xx.c
>> @@ -22,6 +22,8 @@
>>  #define DA8XX_USB0_BASE        0x01e00000
>>  #define DA8XX_USB1_BASE        0x01e25000
>>
>> +static struct clk *usb20_clk;
>> +
>>  static struct platform_device da8xx_usb_phy = {
>>      .name        = "da8xx-usb-phy",
>>      .id        = -1,
>> @@ -158,21 +160,14 @@ int __init da8xx_register_usb_refclkin(int rate)
>>
>>  static void usb20_phy_clk_enable(struct clk *clk)
>>  {
>> -    struct clk *usb20_clk;
>>      int err;
>>      u32 val;
>>      u32 timeout = 500000; /* 500 msec */
>>
>>      val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
>>
>> -    usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
>> -    if (IS_ERR(usb20_clk)) {
>> -        pr_err("could not get usb20 clk: %ld\n", PTR_ERR(usb20_clk));
>> -        return;
>> -    }
>> -
>>      /* The USB 2.O PLL requires that the USB 2.O PSC is enabled as
>> well. */
>> -    err = clk_prepare_enable(usb20_clk);
>> +    err = clk_enable(usb20_clk);
>>      if (err) {
>>          pr_err("failed to enable usb20 clk: %d\n", err);
>>          clk_put(usb20_clk);
> 
> Need to remove clk_put() here.
I will do.
> 
>> @@ -197,8 +192,7 @@ static void usb20_phy_clk_enable(struct clk *clk)
>>
>>      pr_err("Timeout waiting for USB 2.0 PHY clock good\n");
>>  done:
>> -    clk_disable_unprepare(usb20_clk);
>> -    clk_put(usb20_clk);
>> +    clk_disable(usb20_clk);
>>  }
>>
>>  static void usb20_phy_clk_disable(struct clk *clk)
>> @@ -285,11 +279,19 @@ static struct clk_lookup usb20_phy_clk_lookup =
>>  int __init da8xx_register_usb20_phy_clk(bool use_usb_refclkin)
>>  {
>>      struct clk *parent;
>> -    int ret = 0;
>> +    int ret;
>> +
>> +    usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
>> +    ret = PTR_ERR_OR_ZERO(usb20_clk);
>> +    if (ret)
>> +        return ret;
>>
>>      parent = clk_get(NULL, use_usb_refclkin ? "usb_refclkin" :
>> "pll0_aux");
>> -    if (IS_ERR(parent))
>> -        return PTR_ERR(parent);
>> +    ret = PTR_ERR_OR_ZERO(parent);
>> +    if (ret) {
>> +        clk_put(usb20_clk);
>> +        return ret;
>> +    }
>>
>>      usb20_phy_clk.parent = parent;
>>      ret = clk_register(&usb20_phy_clk);
>>
> 
> 
> I have just tried this patch with a bunch of kernel hacking options
> enabled. I am getting the message show at the end of this email. We
> still have the problem of nested spin locks due to nested calls to
> clk_enable(). So, really, we need to use __clk_enable() and
> __clk_disable() from arch/arm/mach-davinci/clock.c in
> usb20_phy_clk_enable() above.
> 
> Applying the following patch on top of your patch fixed the recursive
> lock message.
Good catch.

Thanks,
Alexandre
> 
> ---
> 
> diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
> index df42c93..4fba579 100644
> --- a/arch/arm/mach-davinci/clock.c
> +++ b/arch/arm/mach-davinci/clock.c
> @@ -31,7 +31,7 @@ static LIST_HEAD(clocks);
>  static DEFINE_MUTEX(clocks_mutex);
>  static DEFINE_SPINLOCK(clockfw_lock);
> 
> -static void __clk_enable(struct clk *clk)
> +void __clk_enable(struct clk *clk)
>  {
>         if (clk->parent)
>                 __clk_enable(clk->parent);
> @@ -44,7 +44,7 @@ static void __clk_enable(struct clk *clk)
>         }
>  }
> 
> -static void __clk_disable(struct clk *clk)
> +void __clk_disable(struct clk *clk)
>  {
>         if (WARN_ON(clk->usecount == 0))
>                 return;
> diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
> index e2a5437..8493242 100644
> --- a/arch/arm/mach-davinci/clock.h
> +++ b/arch/arm/mach-davinci/clock.h
> @@ -136,6 +136,9 @@ int davinci_clk_reset(struct clk *clk, bool reset);
>  extern struct platform_device davinci_wdt_device;
>  extern void davinci_watchdog_reset(struct platform_device *);
> 
> +void __clk_enable(struct clk *clk);
> +void __clk_disable(struct clk *clk);
> +
>  #endif
> 
>  #endif
> diff --git a/arch/arm/mach-davinci/usb-da8xx.c
> b/arch/arm/mach-davinci/usb-da8xx
> .c
> index 896d014..80ba0df 100644
> --- a/arch/arm/mach-davinci/usb-da8xx.c
> +++ b/arch/arm/mach-davinci/usb-da8xx.c
> @@ -160,19 +160,13 @@ int __init da8xx_register_usb_refclkin(int rate)
> 
>  static void usb20_phy_clk_enable(struct clk *clk)
>  {
> -       int err;
>         u32 val;
>         u32 timeout = 500000; /* 500 msec */
> 
>         val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> 
>         /* The USB 2.O PLL requires that the USB 2.O PSC is enabled as
> well. */
> -       err = clk_enable(usb20_clk);
> -       if (err) {
> -               pr_err("failed to enable usb20 clk: %d\n", err);
> -               clk_put(usb20_clk);
> -               return;
> -       }
> +       __clk_enable(usb20_clk);
> 
>         /*
>          * Turn on the USB 2.0 PHY, but just the PLL, and not OTG. The
> USB 1.1
> @@ -192,7 +186,7 @@ static void usb20_phy_clk_enable(struct clk *clk)
> 
>         pr_err("Timeout waiting for USB 2.0 PHY clock good\n");
>  done:
> -       clk_disable(usb20_clk);
> +       __clk_disable(usb20_clk);
>  }
> 
>  static void usb20_phy_clk_disable(struct clk *clk)
> 
> 
> 
> ---
> 
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> 4.9.0-rc8-dlech-ev3-lms2012+ #22 Not tainted
> ---------------------------------------------
> swapper/1 is trying to acquire lock:
>  (
> clockfw_lock
> ){......}
> , at:
> [<c0014884>] clk_enable+0x24/0x50
> k:
>  (
> clockfw_lock
> ){......}
> , at:
> [<c0014884>] clk_enable+0x24/0x50
> ebug this:
>  Possible unsafe locking scenario:
>        CPU0
>        ----
>   lock(
> clockfw_lock
> );
>   lock(
> clockfw_lock
> );
>  May be due to missing lock nesting notation
> 4 locks held by swapper/1:
>  #0:
>  (
> &dev->mutex
> ){......}
> , at:
> [<c02bd60c>] __driver_attach+0x68/0xb4
>  #1:
>  (
> &dev->mutex
> ){......}
> , at:
> [<c02bd61c>] __driver_attach+0x78/0xb4
>  #2:
>  (
> &phy->mutex
> ){+.+...}
> , at:
> [<c025ee18>] phy_power_on+0x5c/0xe4
>  #3:
>  (
> clockfw_lock
> ){......}
> , at:
> [<c0014884>] clk_enable+0x24/0x50
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.9.0-rc8-dlech-ev3-lms2012+ #22
> Hardware name: Generic DA850/OMAP-L138/AM18x
> Backtrace:
> [<c000d824>] (dump_backtrace) from [<c000dac4>] (show_stack+0x18/0x1c)
>  r7:c0e998a4 r6:c0820750 r5:c0820750 r4:c3838000
> [<c000daac>] (show_stack) from [<c02393dc>] (dump_stack+0x20/0x28)
> [<c02393bc>] (dump_stack) from [<c004bd7c>] (__lock_acquire+0x10f4/0x167c)
> [<c004ac88>] (__lock_acquire) from [<c004c6ac>] (lock_acquire+0x78/0x98)
>  r10:00000000 r9:c06a5ed4 r8:00000000 r7:00000001 r6:60000093 r5:00000000
>  r4:ffffe000
> [<c004c634>] (lock_acquire) from [<c04d8fac>]
> (_raw_spin_lock_irqsave+0x60/0x74)
>  r7:0000003b r6:c0014884 r5:80000093 r4:c06b09a0
> [<c04d8f4c>] (_raw_spin_lock_irqsave) from [<c0014884>]
> (clk_enable+0x24/0x50)
>  r6:c06f69f4 r5:0001ef02 r4:c06b3398
> [<c0014860>] (clk_enable) from [<c0015c74>]
> (usb20_phy_clk_enable+0x24/0xb8)
>  r5:0001ef02 r4:c06f69f0
> [<c0015c50>] (usb20_phy_clk_enable) from [<c0014858>]
> (__clk_enable+0x74/0x7c)
>  r9:c06a5ed4 r8:00000000 r7:0000003b r6:c3a6ca00 r5:80000013 r4:c06b7ee8
> [<c00147e4>] (__clk_enable) from [<c0014808>] (__clk_enable+0x24/0x7c)
>  r4:c06b8648
> [<c00147e4>] (__clk_enable) from [<c0014890>] (clk_enable+0x30/0x50)
>  r4:c06b8648
> [<c0014860>] (clk_enable) from [<c025f43c>]
> (da8xx_usb11_phy_power_on+0x30/0x80)
>  r5:c3a54050 r4:c06b8648
> [<c025f40c>] (da8xx_usb11_phy_power_on) from [<c025ee3c>]
> (phy_power_on+0x80/0xe4)
>  r5:c3a6c800 r4:fffffdf4
> [<c025edbc>] (phy_power_on) from [<c032243c>] (ohci_da8xx_enable+0x4c/0x80)
>  r7:0000003b r6:c3af6000 r5:c3af6000 r4:00000000
> [<c03223f0>] (ohci_da8xx_enable) from [<c03224f0>]
> (ohci_da8xx_reset+0x1c/0xd8)
>  r5:00000000 r4:c3af6000
> [<c03224d4>] (ohci_da8xx_reset) from [<c0309118>] (usb_add_hcd+0x314/0x834)
>  r7:0000003b r6:ffffffed r5:00000000 r4:c3af6000
> [<c0308e04>] (usb_add_hcd) from [<c032200c>] (ohci_da8xx_probe+0x14c/0x21c)
>  r9:c06a5ed4 r8:00000000 r7:c38bd010 r6:c38bd000 r5:c3af6000 r4:c38af900
> [<c0321ec0>] (ohci_da8xx_probe) from [<c02bec44>]
> (platform_drv_probe+0x40/0x8c)
>  r7:c06e610c r6:c06e610c r5:c38bd010 r4:c0321ec0
> [<c02bec04>] (platform_drv_probe) from [<c02bd438>]
> (driver_probe_device+0x138/0x2a4)
>  r7:c06e610c r6:c0e9db10 r5:00000000 r4:c38bd010
> [<c02bd300>] (driver_probe_device) from [<c02bd634>]
> (__driver_attach+0x90/0xb4)
>  r9:c06a5ed4 r8:c06f66e0 r7:c06e1250 r6:c06e610c r5:c38bd044 r4:c38bd010
> [<c02bd5a4>] (__driver_attach) from [<c02bba5c>]
> (bus_for_each_dev+0x74/0x98)
>  r7:c06e1250 r6:c02bd5a4 r5:c06e610c r4:00000000
> [<c02bb9e8>] (bus_for_each_dev) from [<c02bcf2c>] (driver_attach+0x20/0x28)
>  r6:c39a2300 r5:00000000 r4:c06e610c
> [<c02bcf0c>] (driver_attach) from [<c02bca80>] (bus_add_driver+0xd4/0x1f0)
> [<c02bc9ac>] (bus_add_driver) from [<c02bdcec>] (driver_register+0xa4/0xe8)
>  r7:c0698850 r6:00000000 r5:00000000 r4:c06e610c
> [<c02bdc48>] (driver_register) from [<c02bebac>]
> (__platform_driver_register+0x38/0x4c)
>  r5:00000000 r4:c06acce4
> [<c02beb74>] (__platform_driver_register) from [<c068da20>]
> (ohci_da8xx_init+0x64/0x90)
> [<c068d9bc>] (ohci_da8xx_init) from [<c00096c0>]
> (do_one_initcall+0xb0/0x168)
>  r5:c068d9bc r4:ffffe000
> [<c0009610>] (do_one_initcall) from [<c0676e14>]
> (kernel_init_freeable+0x110/0x1cc)
>  r9:c06a5ed4 r8:c06f66e0 r7:c0698850 r6:000000c1 r5:c06f66e0 r4:00000007
> [<c0676d04>] (kernel_init_freeable) from [<c04d37e4>]
> (kernel_init+0x10/0xf8)
>  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c04d37d4 r4:00000000
> [<c04d37d4>] (kernel_init) from [<c000a2ac>] (ret_from_fork+0x14/0x28)
>  r5:c04d37d4 r4:00000000
> BUG: spinlock lockup suspected on CPU#0, swapper/1
>  lock: clockfw_lock+0x0/0x20, .magic: dead4ead, .owner: swapper/1,
> .owner_cpu: 0
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.9.0-rc8-dlech-ev3-lms2012+ #22
> Hardware name: Generic DA850/OMAP-L138/AM18x
> Backtrace:
> [<c000d824>] (dump_backtrace) from [<c000dac4>] (show_stack+0x18/0x1c)
>  r7:00000000 r6:04605000 r5:c06b09a0 r4:c3838000
> [<c000daac>] (show_stack) from [<c02393dc>] (dump_stack+0x20/0x28)
> [<c02393bc>] (dump_stack) from [<c004f140>] (spin_dump+0x80/0x94)
> [<c004f0c0>] (spin_dump) from [<c004f2c4>] (do_raw_spin_lock+0xdc/0x11c)
>  r5:00000000 r4:c06b09a0
> [<c004f1e8>] (do_raw_spin_lock) from [<c04d8fb4>]
> (_raw_spin_lock_irqsave+0x68/0x74)
>  r10:00000000 r9:c06a5ed4 r8:00000000 r7:0000003b r6:c0014884 r5:80000093
>  r4:c06b09a0 r3:c3838000
> [<c04d8f4c>] (_raw_spin_lock_irqsave) from [<c0014884>]
> (clk_enable+0x24/0x50)
>  r6:c06f69f4 r5:0001ef02 r4:c06b3398
> [<c0014860>] (clk_enable) from [<c0015c74>]
> (usb20_phy_clk_enable+0x24/0xb8)
>  r5:0001ef02 r4:c06f69f0
> [<c0015c50>] (usb20_phy_clk_enable) from [<c0014858>]
> (__clk_enable+0x74/0x7c)
>  r9:c06a5ed4 r8:00000000 r7:0000003b r6:c3a6ca00 r5:80000013 r4:c06b7ee8
> [<c00147e4>] (__clk_enable) from [<c0014808>] (__clk_enable+0x24/0x7c)
>  r4:c06b8648
> [<c00147e4>] (__clk_enable) from [<c0014890>] (clk_enable+0x30/0x50)
>  r4:c06b8648
> [<c0014860>] (clk_enable) from [<c025f43c>]
> (da8xx_usb11_phy_power_on+0x30/0x80)
>  r5:c3a54050 r4:c06b8648
> [<c025f40c>] (da8xx_usb11_phy_power_on) from [<c025ee3c>]
> (phy_power_on+0x80/0xe4)
>  r5:c3a6c800 r4:fffffdf4
> [<c025edbc>] (phy_power_on) from [<c032243c>] (ohci_da8xx_enable+0x4c/0x80)
>  r7:0000003b r6:c3af6000 r5:c3af6000 r4:00000000
> [<c03223f0>] (ohci_da8xx_enable) from [<c03224f0>]
> (ohci_da8xx_reset+0x1c/0xd8)
>  r5:00000000 r4:c3af6000
> [<c03224d4>] (ohci_da8xx_reset) from [<c0309118>] (usb_add_hcd+0x314/0x834)
>  r7:0000003b r6:ffffffed r5:00000000 r4:c3af6000
> [<c0308e04>] (usb_add_hcd) from [<c032200c>] (ohci_da8xx_probe+0x14c/0x21c)
>  r9:c06a5ed4 r8:00000000 r7:c38bd010 r6:c38bd000 r5:c3af6000 r4:c38af900
> [<c0321ec0>] (ohci_da8xx_probe) from [<c02bec44>]
> (platform_drv_probe+0x40/0x8c)
>  r7:c06e610c r6:c06e610c r5:c38bd010 r4:c0321ec0
> [<c02bec04>] (platform_drv_probe) from [<c02bd438>]
> (driver_probe_device+0x138/0x2a4)
>  r7:c06e610c r6:c0e9db10 r5:00000000 r4:c38bd010
> [<c02bd300>] (driver_probe_device) from [<c02bd634>]
> (__driver_attach+0x90/0xb4)
>  r9:c06a5ed4 r8:c06f66e0 r7:c06e1250 r6:c06e610c r5:c38bd044 r4:c38bd010
> [<c02bd5a4>] (__driver_attach) from [<c02bba5c>]
> (bus_for_each_dev+0x74/0x98)
>  r7:c06e1250 r6:c02bd5a4 r5:c06e610c r4:00000000
> [<c02bb9e8>] (bus_for_each_dev) from [<c02bcf2c>] (driver_attach+0x20/0x28)
>  r6:c39a2300 r5:00000000 r4:c06e610c
> [<c02bcf0c>] (driver_attach) from [<c02bca80>] (bus_add_driver+0xd4/0x1f0)
> [<c02bc9ac>] (bus_add_driver) from [<c02bdcec>] (driver_register+0xa4/0xe8)
>  r7:c0698850 r6:00000000 r5:00000000 r4:c06e610c
> [<c02bdc48>] (driver_register) from [<c02bebac>]
> (__platform_driver_register+0x38/0x4c)
>  r5:00000000 r4:c06acce4
> [<c02beb74>] (__platform_driver_register) from [<c068da20>]
> (ohci_da8xx_init+0x64/0x90)
> [<c068d9bc>] (ohci_da8xx_init) from [<c00096c0>]
> (do_one_initcall+0xb0/0x168)
>  r5:c068d9bc r4:ffffe000
> [<c0009610>] (do_one_initcall) from [<c0676e14>]
> (kernel_init_freeable+0x110/0x1cc)
>  r9:c06a5ed4 r8:c06f66e0 r7:c0698850 r6:000000c1 r5:c06f66e0 r4:00000007
> [<c0676d04>] (kernel_init_freeable) from [<c04d37e4>]
> (kernel_init+0x10/0xf8)
>  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c04d37d4 r4:00000000
> [<c04d37d4>] (kernel_init) from [<c000a2ac>] (ret_from_fork+0x14/0x28)
>  r5:c04d37d4 r4:00000000
