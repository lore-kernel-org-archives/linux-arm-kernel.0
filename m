From: slash.tmp@free.fr (Mason)
Date: Tue, 09 Jun 2015 15:04:23 +0200
Subject: [IRQ] Buggy driver makes __setup_irq segfault
Message-ID: <5576E457.6020805@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm a noob, so I suppose this behavior is expected, but I'm reporting it,
just in case. (I tested with 3.14.41)

Consider this buggy driver, calling request_irq() multiple times,
and not calling free_irq in the cleanup routine.

static irqreturn_t scard_isr(int irq, void *dev_id)
{
	return IRQ_HANDLED;
}

static int __init zozo_init(void)
{
	printk("RET=%d\n", request_irq(64, scard_isr, 0, "scard", NULL));
	printk("RET=%d\n", request_irq(64, scard_isr, 0, "scard", NULL));
	printk("RET=%d\n", request_irq(64, scard_isr, 0, "scard", NULL));
	return 0;
}

static void __exit zozo_cleanup(void)
{
}

module_init(zozo_init);
module_exit(zozo_cleanup);


When the module is inserted for the first time, everything behaves as
expected: the first call to request_irq() succeeds, and the next calls
fail, with an error message from kernel/irq/manage.c:__setup_irq()

# insmod zozo.ko                                
[  402.477185] RET=0
[  402.479131] new=e76f1580 old=e76f1400
[  402.482809] genirq: Flags mismatch irq 64. 00000000 (scard) vs. 00000000 (scard)
[  402.490239] OK
[  402.491957] RET=-16
[  402.494178] new=e76f1580 old=e76f1400
[  402.497860] genirq: Flags mismatch irq 64. 00000000 (scard) vs. 00000000 (scard)
[  402.505289] OK
[  402.507006] RET=-16

But the next time the module is inserted, the process segfaults
trying to write the error message in __setup_irq()

# rmmod zozo && insmod zozo.ko 
[  695.802972] new=e76f1540 old=e76f1400
[  695.806676] Unable to handle kernel paging request at virtual address bf000024
[  695.813934] pgd = e6e0c000
[  695.816648] [bf000024] *pgd=a768e811, *pte=00000000, *ppte=00000000
[  695.822957] Internal error: Oops: 7 [#1] PREEMPT SMP ARM
[  695.828292] Modules linked in: zozo(O+) [last unloaded: zozo]
[  695.834080] CPU: 0 PID: 848 Comm: insmod Tainted: G           O 3.14.41+ #8
[  695.841077] task: e75d4da0 ti: e6c8e000 task.ti: e6c8e000
[  695.846510] PC is at strnlen+0x14/0x68
[  695.850277] LR is at string.isra.7+0x38/0xe4
[  695.854567] pc : [<c01880c0>]    lr : [<c018a1a8>]    psr: a0000093
[  695.854567] sp : e6c8fc38  ip : e6c8fc48  fp : e6c8fc44
[  695.866106] r10: c02c8434  r9 : c03dc99c  r8 : 00000000
[  695.871355] r7 : bf000024  r6 : c03dc5fc  r5 : c03dc99c  r4 : ffffffff
[  695.877912] r3 : 00000000  r2 : bf000024  r1 : ffffffff  r0 : bf000024
[  695.884473] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  695.891731] Control: 10c5387d  Table: a6e0c04a  DAC: 00000015
[  695.897503] Process insmod (pid: 848, stack limit = 0xe6c8e240)
[  695.903450] Stack: (0xe6c8fc38 to 0xe6c90000)
[  695.907826] fc20:                                                       e6c8fc6c e6c8fc48
[  695.916048] fc40: c018a1a8 c01880b8 c03dc5fc c033f531 c033f533 00000002 e6c8fd78 c03dc99c
[  695.924269] fc60: e6c8fcc4 e6c8fc70 c018b600 c018a17c ffffffff ffffffff 00000008 ffffffff
[  695.932490] fc80: e6c8fcdc c03dc5bc c03d2367 000003e0 ff0a0004 ffffffff 00000010 000003e0
[  695.940711] fca0: c03b7bc4 00000000 ffffffff 60000093 00000000 c03dbc88 e6c8fcdc e6c8fcc8
[  695.948933] fcc0: c018bda4 c018b454 c03dbc88 c03b7bc4 e6c8fd3c e6c8fce0 c00678e4 c018bd9c
[  695.957154] fce0: 00000000 00000000 00000000 00000000 c03dc5bc 00000019 e6c8e020 00000000
[  695.965374] fd00: 00000000 c03dc5bc 00000000 00000000 ffffffff c03a48c0 e76f1540 e76f1400
[  695.973595] fd20: fffffff0 00000040 c03a491c 60000013 e6c8fd5c e6c8fd40 c02b286c c0067848
[  695.981816] fd40: c033f4fc e6c8fd64 e7402ec4 e6c8fd64 e6c8fdac e6c8fd70 c006b598 c02b2840
[  695.990037] fd60: c033f4fc 00000040 00000000 bf004024 00000000 bf000024 00000004 e6c8fe18
[  695.998258] fd80: e6dd8884 e76f1540 c03a48c0 bf004000 00000000 00000000 00000000 00000040
[  696.006479] fda0: e6c8fddc e6c8fdb0 c006b6fc c006b0c8 00000000 00000000 bf00402c bf004000
[  696.014700] fdc0: bf004024 00000001 e76f12e4 00000000 e6c8fe04 e6c8fde0 bf006048 c006b65c
[  696.022921] fde0: bf004024 00000000 e6c8e008 bf006000 bf004064 e76f12c0 e6c8fe8c e6c8fe08
[  696.031142] fe00: c00088b4 bf00600c c009daf4 c009b438 e76f1540 00000000 e76fd380 e885e000
[  696.039363] fe20: 00000001 00000001 e76f12e4 bf004058 e6c8fe54 e6c8fe40 0000000e e76fd380
[  696.047584] fe40: e885e000 00000001 e6c8fe74 e6c8fe58 c00c1698 c00ca918 e6c8ff48 00000001
[  696.055805] fe60: bf004064 e6c8ff48 00000001 bf004064 e76f12c0 00000001 e76f12e4 bf004058
[  696.064026] fe80: e6c8ff44 e6c8fe90 c00865b8 c00087c0 bf004064 00007fff c0083560 e6c8fefc
[  696.072246] fea0: e76fd380 0000002f e6c8fedc 00000000 00000000 bf004194 e6c8ff48 e6c8e010
[  696.080468] fec0: bf0040a0 00000000 000002d2 c0014328 e6c8e000 0000000e e6c8ff1c 00000000
[  696.088689] fee0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  696.096910] ff00: 00000000 00000000 00000000 00000000 00000000 00000000 c00c1e20 0000d412
[  696.105130] ff20: 000a9018 000a9008 00000080 c0014328 e6c8e000 00000000 e6c8ffa4 e6c8ff48
[  696.113351] ff40: c00869e0 c0084a54 e885e000 0000d412 e8867e80 e8867d4f e886b320 00000194
[  696.121572] ff60: 00000244 00000000 00000000 00000000 0000001e 0000001f 00000008 00000000
[  696.129793] ff80: 00000005 00000000 c0017a00 0000d412 be820c7a be820b64 00000000 e6c8ffa8
[  696.138014] ffa0: c0014180 c008690c 0000d412 be820c7a 000a9018 0000d412 000a9008 be820c7a
[  696.146235] ffc0: 0000d412 be820c7a be820b64 00000080 000a67e0 000821de 0000004d 00000000
[  696.154456] ffe0: be8209a0 be820990 0001cee4 b6e68190 60000010 000a9018 13406dc4 c091bbe3
[  696.162672] Backtrace: 
[  696.165134] [<c01880ac>] (strnlen) from [<c018a1a8>] (string.isra.7+0x38/0xe4)
[  696.172398] [<c018a170>] (string.isra.7) from [<c018b600>] (vsnprintf+0x1b8/0x47c)
[  696.180004]  r9:c03dc99c r8:e6c8fd78 r7:00000002 r6:c033f533 r5:c033f531 r4:c03dc5fc
[  696.187806] [<c018b448>] (vsnprintf) from [<c018bda4>] (vscnprintf+0x14/0x2c)
[  696.194974]  r10:c03dbc88 r9:00000000 r8:60000093 r7:ffffffff r6:00000000 r5:c03b7bc4
[  696.202856]  r4:000003e0
[  696.205409] [<c018bd90>] (vscnprintf) from [<c00678e4>] (vprintk_emit+0xa8/0x4f4)
[  696.212926]  r5:c03b7bc4 r4:c03dbc88
[  696.216529] [<c006783c>] (vprintk_emit) from [<c02b286c>] (printk+0x3c/0x44)
[  696.223611]  r10:60000013 r9:c03a491c r8:00000040 r7:fffffff0 r6:e76f1400 r5:e76f1540
[  696.231493]  r4:c03a48c0
[  696.234040] [<c02b2834>] (printk) from [<c006b598>] (__setup_irq+0x4dc/0x504)
[  696.241208]  r3:bf004024 r2:00000000 r1:00000040 r0:c033f4fc
[  696.246908] [<c006b0bc>] (__setup_irq) from [<c006b6fc>] (request_threaded_irq+0xac/0x12c)
[  696.255212]  r10:00000040 r9:00000000 r8:00000000 r7:00000000 r6:bf004000 r5:c03a48c0
[  696.263093]  r4:e76f1540
[  696.265644] [<c006b650>] (request_threaded_irq) from [<bf006048>] (zozo_init+0x48/0xb0 [zozo])
[  696.274297]  r10:00000000 r9:e76f12e4 r8:00000001 r7:bf004024 r6:bf004000 r5:bf00402c
[  696.282178]  r4:00000000 r3:00000000
[  696.285779] [<bf006000>] (zozo_init [zozo]) from [<c00088b4>] (do_one_initcall+0x100/0x15c)
[  696.294171]  r7:e76f12c0 r6:bf004064 r5:bf006000 r4:e6c8e008
[  696.299874] [<c00087b4>] (do_one_initcall) from [<c00865b8>] (load_module+0x1b70/0x1eb8)
[  696.308003]  r10:bf004058 r9:e76f12e4 r8:00000001 r7:e76f12c0 r6:bf004064 r5:00000001
[  696.315884]  r4:e6c8ff48
[  696.318430] [<c0084a48>] (load_module) from [<c00869e0>] (SyS_init_module+0xe0/0xf4)
[  696.326210]  r10:00000000 r9:e6c8e000 r8:c0014328 r7:00000080 r6:000a9008 r5:000a9018
[  696.334092]  r4:0000d412
[  696.336645] [<c0086900>] (SyS_init_module) from [<c0014180>] (ret_fast_syscall+0x0/0x30)
[  696.344774]  r6:be820b64 r5:be820c7a r4:0000d412
[  696.349423] Code: e92dd800 e24cb004 e3510000 0a000010 (e5d03000) 
[  696.355558] ---[ end trace 4f268acdc5b20400 ]---
[  696.360200] note: insmod[848] exited with preempt_count 2
Segmentation fault

Is this expected?

Regards.
