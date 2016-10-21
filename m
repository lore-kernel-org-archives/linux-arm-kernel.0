From: slash.tmp@free.fr (Mason)
Date: Fri, 21 Oct 2016 18:37:52 +0200
Subject: Disabling an interrupt in the handler locks the system up
Message-ID: <580A4460.2090306@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On my platform, one HW block pulls the interrupt line high
as long as it remains idle, and low when it is busy.

The device tree node is:

		test at 22222 {
			compatible = "vendor,testme";
			interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
		};

I wrote a minimal driver which registers the irq.
And in the interrupt handler, I disable said irq.

Since the irq is IRQ_TYPE_LEVEL_HIGH, it will fire as soon as
it is registered (because the block is idle).

Here is the code I've been running, request_irq doesn't return.

#include <linux/module.h>
#include <linux/of_irq.h>
#include <linux/interrupt.h>
#include <linux/platform_device.h>

static irqreturn_t test_isr(int irq, void *dev)
{
	printk("irq=%d dev=%p\n", irq, dev);
	disable_irq_nosync(irq);
	printk("IRQ %d NOW DISABLED\n", irq);
	return IRQ_HANDLED;
}

static int test_probe(struct platform_device *pdev)
{
	unsigned res, virq;
	printk("ENTER %s\n", __func__);

	virq = irq_of_parse_and_map(pdev->dev.of_node, 0);
	printk("virq = %u\n", virq);

	res = request_irq(virq, test_isr, 0, "testme", (void *)0x42);
	printk("request_irq = %d\n", res);

	return 0;
}

static const struct of_device_id test_ids[] = {
	{ .compatible = "vendor,testme" },
	{ /* sentinel */ }
};

static struct platform_driver test_driver = {
	.probe	= test_probe,
	.driver	= {
		.name		= "test",
		.of_match_table	= test_ids,
	},
};

module_platform_driver(test_driver);
MODULE_LICENSE("GPL");


And here's what I get when I try to load the module:
(I'm using the default CONFIG_RCU_CPU_STALL_TIMEOUT=21)

$ insmod test.ko
[   91.571065] ENTER test_probe
[   91.574208] virq = 21
[   91.576902] irq=21 dev=00000042
[   91.580061] IRQ 21 NOW DISABLED
[  102.038544] nfs: server 172.27.64.1 not responding, still trying
[  112.571855] INFO: rcu_preempt self-detected stall on CPU
[  112.577201]  0-...: (6298 ticks this GP) idle=c45/140000000000002/0 softirq=1295/1295 fqs=2045 
[  112.585942]   (t=6300 jiffies g=208 c=207 q=20)
[  112.590497] Task dump for CPU 0:
[  112.593735] insmod          R running      0   951    929 0x00000002
[  112.600124] Backtrace: 
[  112.602601] [<c010b9a4>] (dump_backtrace) from [<c010bba0>] (show_stack+0x18/0x1c)
[  112.610207]  r7:c0702434[  112.612571]  r6:c07024c8
 r5:000003a1[  112.616163]  r4:df570dc0
[  112.618701] 
[  112.620202] [<c010bb88>] (show_stack) from [<c0143a28>] (sched_show_task+0xbc/0x110)
[  112.627989] [<c014396c>] (sched_show_task) from [<c0145ef0>] (dump_cpu_task+0x40/0x48)
[  112.635943]  r5:00000000[  112.638307]  r4:00000000
[  112.640845] 
[  112.642347] [<c0145eb0>] (dump_cpu_task) from [<c01a8130>] (rcu_dump_cpu_stacks+0xb0/0xcc)
[  112.650651]  r5:00000000[  112.653014]  r4:c070a840
[  112.655553] 
[  112.657055] [<c01a8080>] (rcu_dump_cpu_stacks) from [<c01743ec>] (rcu_check_callbacks+0x8f8/0x9b0)
[  112.666058]  r10:c07024c0[  112.668509]  r9:c0702518
 r8:1f5a3000[  112.672100]  r7:c070a840
 r6:c0702100[  112.675691]  r5:c0637f40
[  112.678230]  r4:dfbdaf40[  112.680592]  r3:ffff2458
[  112.683130] 
[  112.684629] [<c0173af4>] (rcu_check_callbacks) from [<c0177b70>] (update_process_times+0x3c/0x64)
[  112.693545]  r10:c0188c54[  112.695995]  r9:00000001
 r8:dfbd870c[  112.699588]  r7:0000001a
 r6:00000000[  112.703178]  r5:df570dc0
[  112.705717]  r4:ffffe000[  112.708080] 
[  112.709581] [<c0177b34>] (update_process_times) from [<c0188c50>] (tick_sched_handle+0x50/0x54)
[  112.718322]  r7:0000001a[  112.720684]  r6:35192494
 r5:def2dab8[  112.724274]  r4:dfbd88f8
[  112.726812] 
[  112.728309] [<c0188c00>] (tick_sched_handle) from [<c0188cb0>] (tick_sched_timer+0x5c/0xa0)
[  112.736705] [<c0188c54>] (tick_sched_timer) from [<c0178bf4>] (__hrtimer_run_queues+0x11c/0x1ac)
[  112.745533]  r7:00000000[  112.747896]  r6:dfbd8700
 r5:dfbd88f8[  112.751486]  r4:dfbd86c0
[  112.754025] 
[  112.755519] [<c0178ad8>] (__hrtimer_run_queues) from [<c0178e88>] (hrtimer_interrupt+0xbc/0x20c)
[  112.764347]  r10:dfbd8738[  112.766798]  r9:dfbd8778
 r8:dfbd8758[  112.770389]  r7:dfbd86d4
 r6:ffffffff[  112.773979]  r5:00000003
[  112.776518]  r4:dfbd86c0[  112.778881] 
[  112.780378] [<c0178dcc>] (hrtimer_interrupt) from [<c010ed0c>] (twd_handler+0x38/0x48)
[  112.788332]  r10:def2dab8[  112.790782]  r9:df402400
 r8:00000001[  112.794373]  r7:df408700
 r6:00000013[  112.797964]  r5:c0702744
[  112.800504]  r4:00000001[  112.802866] 
[  112.804362] [<c010ecd4>] (twd_handler) from [<c016a134>] (handle_percpu_devid_irq+0x94/0x14c)
[  112.812928]  r5:c0702744[  112.815291]  r4:df405300
[  112.817829] 
[  112.819327] [<c016a0a0>] (handle_percpu_devid_irq) from [<c0165134>] (generic_handle_irq+0x2c/0x3c)
[  112.828417]  r7:def2dbd0[  112.830780]  r6:00000013
 r5:00000000[  112.834370]  r4:c0635ec4
[  112.836909] 
[  112.838404] [<c0165108>] (generic_handle_irq) from [<c01656dc>] (__handle_domain_irq+0x84/0xf4)
[  112.847150] [<c0165658>] (__handle_domain_irq) from [<c01014ac>] (gic_handle_irq+0x50/0x94)
[  112.855541]  r10:def2dbd0[  112.857992]  r9:e0803100
 r8:e0802100[  112.861583]  r7:def2dab8
 r6:e080210c[  112.865173]  r5:c0702744
[  112.867712]  r4:c070ff50[  112.870076]  r3:def2dab8
[  112.872614] 
[  112.874107] [<c010145c>] (gic_handle_irq) from [<c010c70c>] (__irq_svc+0x6c/0xa8)
[  112.881626] Exception stack(0xdef2dab8 to 0xdef2db00)
[  112.886699] daa0:                                                       00000000 c057c9b4
[  112.894919] dac0: c07216c0 00000000 00000202 ffffe000 00000013 00000000 00000001 df402400
[  112.903140] dae0: def2dbd0 def2db64 def2daf8 def2db08 c030db68 c0121068 20000113 ffffffff
[  112.911356]  r9:def2c000[  112.913719]  r8:00000001
 r7:def2daec[  112.917310]  r6:ffffffff
 r5:20000113[  112.920901]  r4:c0121068
[  112.923448] [<c0120fc0>] (__do_softirq) from [<c0121520>] (irq_exit+0xd4/0x110)
[  112.930792]  r10:def2dbd0[  112.933242]  r9:df402400
 r8:00000001[  112.936833]  r7:00000000
 r6:00000013[  112.940423]  r5:00000000
[  112.942962]  r4:c0635ec4[  112.945324] 
[  112.946819] [<c012144c>] (irq_exit) from [<c01656e0>] (__handle_domain_irq+0x88/0xf4)
[  112.954690] [<c0165658>] (__handle_domain_irq) from [<c01014ac>] (gic_handle_irq+0x50/0x94)
[  112.963080]  r10:00000000[  112.965531]  r9:e0803100
 r8:e0802100[  112.969122]  r7:def2dbd0
 r6:e080210c[  112.972714]  r5:c0702744
[  112.975253]  r4:c070ff50[  112.977617]  r3:def2dbd0
[  112.980154] 
[  112.981648] [<c010145c>] (gic_handle_irq) from [<c010c70c>] (__irq_svc+0x6c/0xa8)
[  112.989166] Exception stack(0xdef2dbd0 to 0xdef2dc18)
[  112.994240] dbc0:                                     df506260 60000013 00000000 00000005
[  113.002460] dbe0: dedbd680 df506200 00000015 df506260 60000013 df506238 00000000 def2dc2c
[  113.010679] dc00: def2dc30 def2dc20 c0167f90 c04d68d0 60000013 ffffffff
[  113.017324]  r9:def2c000[  113.019687]  r8:60000013
 r7:def2dc04[  113.023277]  r6:ffffffff
 r5:60000013[  113.026868]  r4:c04d68d0
[  113.029418] [<c04d68a8>] (_raw_spin_unlock_irqrestore) from [<c0167f90>] (__setup_irq+0x440/0x5f0)
[  113.038426] [<c0167b50>] (__setup_irq) from [<c0168300>] (request_threaded_irq+0xf0/0x188)
[  113.046730]  r10:00000000[  113.049179]  r9:00000015
 r8:df506210[  113.052770]  r7:00000000
 r6:df506200[  113.056362]  r5:00000000
[  113.058901]  r4:dedbd680[  113.061263] 
[  113.062767] [<c0168210>] (request_threaded_irq) from [<bf0040b8>] (test_probe+0x74/0x90 [zozo])
[  113.071508]  r10:00000000[  113.073959]  r9:21242a5c
 r8:00000001[  113.077550]  r7:fffffdfb
 r6:bf004320[  113.081142]  r5:df516810
[  113.083681]  r4:00000015[  113.086044]  r3:00000000
[  113.088582] 
[  113.090085] [<bf004044>] (test_probe [zozo]) from [<c03595e8>] (platform_drv_probe+0x54/0xb8)
[  113.098652]  r4:c0752d30[  113.101014] 
[  113.102510] [<c0359594>] (platform_drv_probe) from [<c0357b88>] (driver_probe_device+0x228/0x2b8)
[  113.111425]  r7:bf004320[  113.113789]  r6:df516844
 r5:df516810[  113.117379]  r4:c0752d30
[  113.119917] 
[  113.121412] [<c0357960>] (driver_probe_device) from [<c0357cd8>] (__driver_attach+0xc0/0xc4)
[  113.129891]  r9:21242a5c[  113.132255]  r8:00000001
 r7:00000000[  113.135845]  r6:df516844
 r5:bf004320[  113.139436]  r4:df516810
[  113.141980] [<c0357c18>] (__driver_attach) from [<c0355d00>] (bus_for_each_dev+0x70/0xa4)
[  113.150196]  r7:00000000[  113.152560]  r6:c0357c18
 r5:bf004320[  113.156150]  r4:00000000
[  113.158689] 
[  113.160183] [<c0355c90>] (bus_for_each_dev) from [<c03573d4>] (driver_attach+0x24/0x28)
[  113.168224]  r6:c0714090[  113.170587]  r5:df7efc80
 r4:bf004320[  113.174178] 
[  113.175673] [<c03573b0>] (driver_attach) from [<c0356fa0>] (bus_add_driver+0x1a8/0x220)
[  113.183719] [<c0356df8>] (bus_add_driver) from [<c0358498>] (driver_register+0x80/0x100)
[  113.191848]  r7:bf004380[  113.194211]  r6:dedbdc80
 r5:bf006000[  113.197801]  r4:bf004320
[  113.200339] 
[  113.201834] [<c0358418>] (driver_register) from [<c0359548>] (__platform_driver_register+0x48/0x50)
[  113.210924]  r5:bf006000[  113.213287]  r4:c0714090
[  113.215826] 
[  113.217323] [<c0359500>] (__platform_driver_register) from [<bf006020>] (test_driver_init+0x20/0x24 [zozo])
[  113.227113]  r5:bf006000[  113.229475]  r4:ffffe000
[  113.232014] 
[  113.233511] [<bf006000>] (test_driver_init [zozo]) from [<c01017f4>] (do_one_initcall+0x4c/0x17c)
[  113.242432] [<c01017a8>] (do_one_initcall) from [<c01a81b4>] (do_init_module+0x68/0x3a4)
[  113.250561]  r10:dedbd5c8[  113.253011]  r9:21242a5c
 r8:00000001[  113.256602]  r7:bf004380
 r6:dedbdc80[  113.260193]  r5:00000001
[  113.262732]  r4:bf004380[  113.265094] 
[  113.266591] [<c01a814c>] (do_init_module) from [<c01925f0>] (load_module+0x1dc0/0x2180)
[  113.274633]  r6:dedbd5c0[  113.276997]  r5:00000001
 r4:def2df34[  113.280587] 
[  113.282082] [<c0190830>] (load_module) from [<c0192b08>] (SyS_init_module+0x158/0x170)
[  113.290037]  r10:00000051[  113.292487]  r9:def2c000
 r8:01bbf008[  113.296078]  r7:e08682cc
 r6:00000000[  113.299667]  r5:01bc02e4
[  113.302207]  r4:000012cc[  113.304569] 
[  113.306065] [<c01929b0>] (SyS_init_module) from [<c0107ba0>] (ret_fast_syscall+0x0/0x3c)
[  113.314194]  r10:00000000[  113.316645]  r9:def2c000
 r8:c0107d64[  113.320236]  r7:00000080
 r6:be98bb54[  113.323828]  r5:be98bc6d
[  113.326368]  r4:000012cc[  113.328729] 


Are we not supposed to disable the irq in the handler?

Regards.
