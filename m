From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 16 Sep 2016 13:55:36 +0100
Subject: genirq: Setting trigger mode 0 for irq 11 failed
 (txx9_irq_set_type+0x0/0xb8)
In-Reply-To: <1474023805.17258.10.camel@gmail.com>
References: <CAMuHMdVW1eTn20=EtYcJ8hkVwohaSuH_yQXrY2MGBEvZ8fpFOg@mail.gmail.com>
 <1473980577.17787.21.camel@gmail.com> <57DBA464.9010506@arm.com>
 <1474023805.17258.10.camel@gmail.com>
Message-ID: <57DBEBC8.7000209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Krzystof, Kukjin,

On 16/09/16 12:03, Alban Browaeys wrote:
> Le vendredi 16 septembre 2016 ? 08:51 +0100, Marc Zyngier a ?crit :
>> Hi Alban,
>>
>> On 16/09/16 00:02, Alban Browaeys wrote:
>>> I am seeing this on arm odroid u2 devicetree :
>>> genirq: Setting trigger mode 0 for irq 16 failed
>>> (gic_set_type+0x0/0x64)
>>
>> Passing IRQ_TYPE_NONE to a cascading interrupt is risky at best...
>> Can you point me to the various DTs and their failing interrupts?
> 
> mine is:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4412-odroidu3.dts
> 
> I got a report of this issue to another odroid :
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4412-odroidx2.dts
> 
> 
> 
> they both get their settings from :
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4412.dtsi
> 
> relevant in the chain are:
> - combiner modified:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4x12.dtsi#n460

How wonderful. This section is an utter pile of crap. Really.
Having 0 as the trigger is illegal, and the valid values are fully
documented in the GIC binding. No wonder things start breaking.

> - gic:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi#n576
> - gic and combiner initial settings:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4.dtsi#n134
> 
> 
> 
>> Also, can you please give the following patch a go and let me know
>> if that fixes the issue (I'm interested in the potential warning
>> here).
> 
> 1st batch of warnings is :
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at kernel/irq/chip.c:833 __irq_do_set_handler+0x1c0/0x1c4
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.0-rc6-debug+ #30
> Hardware name: ODROID-U2/U3
> [<c010fc74>] (unwind_backtrace) from [<c010c9a0>] (show_stack+0x10/0x14)
> [<c010c9a0>] (show_stack) from [<c035cafc>] (dump_stack+0xa8/0xd4)
> [<c035cafc>] (dump_stack) from [<c01214dc>] (__warn+0xe8/0x100)
> [<c01214dc>] (__warn) from [<c01215a4>] (warn_slowpath_null+0x20/0x28)
> [<c01215a4>] (warn_slowpath_null) from [<c017d394>] (__irq_do_set_handler+0x1c0/0x1c4)
> [<c017d394>] (__irq_do_set_handler) from [<c017d450>] (irq_set_chained_handler_and_data+0x38/0x54)
> [<c017d450>] (irq_set_chained_handler_and_data) from [<c0a15878>] (combiner_of_init+0x1a0/0x1c4)
> [<c0a15878>] (combiner_of_init) from [<c0a1ead4>] (of_irq_init+0x194/0x2e8)
> [<c0a1ead4>] (of_irq_init) from [<c0a07450>] (exynos_init_irq+0x8/0x3c)
> [<c0a07450>] (exynos_init_irq) from [<c0a0190c>] (init_IRQ+0x2c/0x88)
> [<c0a0190c>] (init_IRQ) from [<c0a00b78>] (start_kernel+0x284/0x388)
> [<c0a00b78>] (start_kernel) from [<40008078>] (0x40008078)
> ---[ end trace f68728a0d3053b52 ]---

That's our above friend the combiner.

> 
> 2nd batch is :
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1 at kernel/irq/chip.c:833 __irq_do_set_handler+0x1c0/0x1c4
> Modules linked in:
> CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       4.8.0-rc6-debug+ #30
> Hardware name: ODROID-U2/U3
> [<c010fc74>] (unwind_backtrace) from [<c010c9a0>] (show_stack+0x10/0x14)
> [<c010c9a0>] (show_stack) from [<c035cafc>] (dump_stack+0xa8/0xd4)
> [<c035cafc>] (dump_stack) from [<c01214dc>] (__warn+0xe8/0x100)
> [<c01214dc>] (__warn) from [<c01215a4>] (warn_slowpath_null+0x20/0x28)
> [<c01215a4>] (warn_slowpath_null) from [<c017d394>] (__irq_do_set_handler+0x1c0/0x1c4)
> [<c017d394>] (__irq_do_set_handler) from [<c017d450>] (irq_set_chained_handler_and_data+0x38/0x54)
> [<c017d450>] (irq_set_chained_handler_and_data) from [<c038e340>] (exynos_eint_wkup_init+0x188/0x2dc)
> [<c038e340>] (exynos_eint_wkup_init) from [<c038d668>] (samsung_pinctrl_probe+0x874/0xa18)
> [<c038d668>] (samsung_pinctrl_probe) from [<c04342c8>] (platform_drv_probe+0x4c/0xb0)
> [<c04342c8>] (platform_drv_probe) from [<c043267c>] (driver_probe_device+0x24c/0x440)
> [<c043267c>] (driver_probe_device) from [<c0430658>] (bus_for_each_drv+0x64/0x98)
> [<c0430658>] (bus_for_each_drv) from [<c04322e8>] (__device_attach+0xb4/0x144)
> [<c04322e8>] (__device_attach) from [<c04316f4>] (bus_probe_device+0x88/0x90)
> [<c04316f4>] (bus_probe_device) from [<c042f850>] (device_add+0x428/0x5c8)
> [<c042f850>] (device_add) from [<c054c3f8>] (of_platform_device_create_pdata+0x84/0xb8)
> [<c054c3f8>] (of_platform_device_create_pdata) from [<c054c59c>] (of_platform_bus_create+0x164/0x440)
> [<c054c59c>] (of_platform_bus_create) from [<c054ca20>] (of_platform_populate+0x80/0x114)
> [<c054ca20>] (of_platform_populate) from [<c0a1d458>] (of_platform_default_populate_init+0x6c/0x80)
> [<c0a1d458>] (of_platform_default_populate_init) from [<c01018d4>] (do_one_initcall+0x50/0x198)
> [<c01018d4>] (do_one_initcall) from [<c0a00ecc>] (kernel_init_freeable+0x250/0x2f0)
> [<c0a00ecc>] (kernel_init_freeable) from [<c06c1064>] (kernel_init+0x8/0x114)
> [<c06c1064>] (kernel_init) from [<c0108710>] (ret_from_fork+0x14/0x24)
> ---[ end trace f68728a0d3053b66 ]---

And that's from the following stuff:

	&pinctrl_0 {
        	compatible = "samsung,exynos4x12-pinctrl";
	        reg = <0x11400000 0x1000>;
	        interrupts = <0 47 0>;
	};

	&pinctrl_1 {
	        compatible = "samsung,exynos4x12-pinctrl";
	        reg = <0x11000000 0x1000>;
	        interrupts = <0 46 0>;

	        wakup_eint: wakeup-interrupt-controller {
	                compatible = "samsung,exynos4210-wakeup-eint";
	                interrupt-parent = <&gic>;
	                interrupts = <0 32 0>;
	        };
	};

	[...]

	&pinctrl_3 {
	        compatible = "samsung,exynos4x12-pinctrl";
	        reg = <0x106E0000 0x1000>;
	        interrupts = <0 72 0>;
	};

which perpetuates this fine tradition...

At that stage, I'm not sure I should care. Does the workaround make your
platform usable? The Samsung maintainers should really try and fix their
DT, because it is a miracle this has made it that far.

I'm also interested in hearing from Geert, whose platform doesn't seem
to be DT driven.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
