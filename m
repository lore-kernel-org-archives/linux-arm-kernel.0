From: s-anna@ti.com (Suman Anna)
Date: Fri, 28 Jul 2017 14:55:47 -0500
Subject: kernel crash during remoteproc error recovery with 4.13-rc1
Message-ID: <6c5f7a34-7058-806e-1fcf-985e99fd89f9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,


As I am rebasing my patches and testing them for submission, I am seeing
kernel crashes with my error recovery tests with TI remoteprocs that use
the virtio_rpmsg transport. This should be a common problem for all
remoteprocs using virtio devices from resource table. Bisecting it led
to the commits from Sarang that switches over the error recovery to
rproc_{start,stop} API. Reverting 7e83cab824a8 to begin with resolves my
issues.

7e83cab824a8 remoteproc: Modify recovery path to use rproc_{start,stop}()
1efa30d0895e remoteproc: Introduce rproc_{start,stop}() functions

Following is the crash log when testing error recovery on one of my
Keystone DSPs. I have also seen similar crashes with my other
remoteprocs as well.

regards
Suman

---

[  181.812557] remoteproc remoteproc0: crash detected in 10800000.dsp:
type fatal error
[  181.820423] remoteproc remoteproc0: handling crash #1 in 10800000.dsp
[  181.827688] remoteproc remoteproc0: recovering 10800000.dsp
[  181.833874] remoteproc remoteproc0: stopped remote processor 10800000.dsp
[  181.857652] kobject (ee395c40): tried to init an initialized object,
something is seriously wrong.
[  181.867465] CPU: 0 PID: 352 Comm: kworker/0:1 Not tainted
4.13.0-rc1-00010-gb02c20d77b5b #132
[  181.875960] Hardware name: Keystone
[  181.879459] Workqueue: events rproc_crash_handler_work [remoteproc]
[  181.885716] [<c020ffdc>] (unwind_backtrace) from [<c020bdf8>]
(show_stack+0x10/0x14)
[  181.893434] [<c020bdf8>] (show_stack) from [<c0831ca4>]
(dump_stack+0x78/0x8c)
[  181.900632] [<c0831ca4>] (dump_stack) from [<c08359b4>]
(kobject_init+0x84/0x94)
[  181.908003] [<c08359b4>] (kobject_init) from [<c0595518>]
(device_initialize+0x24/0xac)
[  181.915979] [<c0595518>] (device_initialize) from [<c0597aac>]
(device_register+0xc/0x18)
[  181.924131] [<c0597aac>] (device_register) from [<bf0003e0>]
(register_virtio_device+0xa8/0xe8 [virtio])
[  181.933593] [<bf0003e0>] (register_virtio_device [virtio]) from
[<bf032858>] (rproc_add_virtio_dev+0x5c/0xb0 [remoteproc])
[  181.944618] [<bf032858>] (rproc_add_virtio_dev [remoteproc]) from
[<bf03024c>] (rproc_start+0xd0/0x1c4 [remoteproc])
[  181.955122] [<bf03024c>] (rproc_start [remoteproc]) from [<bf031d0c>]
(rproc_trigger_recovery+0xb8/0xe0 [remoteproc])
[  181.965704] [<bf031d0c>] (rproc_trigger_recovery [remoteproc]) from
[<c02369c0>] (process_one_work+0x1ec/0x55c)
[  181.975755] [<c02369c0>] (process_one_work) from [<c0237720>]
(worker_thread+0x38/0x554)
[  181.983819] [<c0237720>] (worker_thread) from [<c023c704>]
(kthread+0x128/0x158)
[  181.991191] [<c023c704>] (kthread) from [<c0208108>]
(ret_from_fork+0x14/0x2c)
[  181.999587] alloc_contig_range: [81f840, 81f880) PFNs busy
[  182.005322] virtio_rpmsg_bus virtio0: rpmsg host is online
[  182.010944] remoteproc remoteproc0: registered virtio0 (type 7)
[  182.010951] remoteproc remoteproc0: remote processor 10800000.dsp is
now up
[  182.011338] virtio_rpmsg_bus virtio0: creating channel
rpmsg-client-sample addr 0x32



^H[  203.049258] INFO: rcu_preempt self-detected stall on CPU
[  203.054560]  0-...: (2099 ticks this GP) idle=222/140000000000001/0
softirq=2987/2987 fqs=1049
[  203.063223]   (t=2100 jiffies g=616 c=615 q=4332)
[  203.067911] NMI backtrace for cpu 0
[  203.071385] CPU: 0 PID: 352 Comm: kworker/0:1 Not tainted
4.13.0-rc1-00010-gb02c20d77b5b #132
[  203.079876] Hardware name: Keystone
[  203.083354] Workqueue: events handle_event [keystone_remoteproc]
[  203.089350] [<c020ffdc>] (unwind_backtrace) from [<c020bdf8>]
(show_stack+0x10/0x14)
[  203.097066] [<c020bdf8>] (show_stack) from [<c0831ca4>]
(dump_stack+0x78/0x8c)
[  203.104265] [<c0831ca4>] (dump_stack) from [<c08378ac>]
(nmi_cpu_backtrace+0x10c/0x110)
[  203.112242] [<c08378ac>] (nmi_cpu_backtrace) from [<c08379b8>]
(nmi_trigger_cpumask_backtrace+0x108/0x154)
[  203.121865] [<c08379b8>] (nmi_trigger_cpumask_backtrace) from
[<c027a698>] (rcu_dump_cpu_stacks+0xa0/0xd0)
[  203.131487] [<c027a698>] (rcu_dump_cpu_stacks) from [<c02795a0>]
(rcu_check_callbacks+0x924/0xaf0)
[  203.140415] [<c02795a0>] (rcu_check_callbacks) from [<c027f048>]
(update_process_times+0x34/0x5c)
[  203.149258] [<c027f048>] (update_process_times) from [<c028eb28>]
(tick_sched_timer+0x68/0x228)
[  203.157928] [<c028eb28>] (tick_sched_timer) from [<c02800b0>]
(__hrtimer_run_queues+0x144/0x37c)
[  203.166683] [<c02800b0>] (__hrtimer_run_queues) from [<c02804c0>]
(hrtimer_interrupt+0xa8/0x1f8)
[  203.175439] [<c02804c0>] (hrtimer_interrupt) from [<c0690880>]
(arch_timer_handler_phys+0x28/0x30)
[  203.184368] [<c0690880>] (arch_timer_handler_phys) from [<c026e5a4>]
(handle_percpu_devid_irq+0xa0/0x2c4)
[  203.193902] [<c026e5a4>] (handle_percpu_devid_irq) from [<c0269608>]
(generic_handle_irq+0x24/0x34)
[  203.202916] [<c0269608>] (generic_handle_irq) from [<c0269b4c>]
(__handle_domain_irq+0x7c/0xec)
[  203.211581] [<c0269b4c>] (__handle_domain_irq) from [<c020145c>]
(gic_handle_irq+0x48/0x8c)
[  203.219902] [<c020145c>] (gic_handle_irq) from [<c084c738>]
(__irq_svc+0x58/0x8c)
[  203.227354] Exception stack(0xeea1fdc0 to 0xeea1fe08)
[  203.232385] fdc0: 00000000 00000000 0000ee9e 00004100 ee9e4580
eea1fe58 00000000 c0595978
[  203.240530] fde0: eea1fe30 eda4f4cc 00000000 bf0269d8 00000000
eea1fe10 c0243adc c084be74
[  203.248673] fe00: 800e0013 ffffffff
[  203.252149] [<c084c738>] (__irq_svc) from [<c084be74>]
(_raw_spin_lock+0x3c/0x50)
[  203.259605] [<c084be74>] (_raw_spin_lock) from [<c0835478>]
(klist_next+0x18/0xf4)
[  203.267148] [<c0835478>] (klist_next) from [<c0595b9c>]
(device_find_child+0x48/0x88)
[  203.274955] [<c0595b9c>] (device_find_child) from [<bf026aa8>]
(rpmsg_ns_cb+0xd0/0x254 [virtio_rpmsg_bus])
[  203.284583] [<bf026aa8>] (rpmsg_ns_cb [virtio_rpmsg_bus]) from
[<bf026880>] (rpmsg_recv_done+0x150/0x2a8 [virtio_rpmsg_bus])
[  203.295771] [<bf026880>] (rpmsg_recv_done [virtio_rpmsg_bus]) from
[<bf008f14>] (vring_interrupt+0x50/0xa8 [virtio_ring])
[  203.306695] [<bf008f14>] (vring_interrupt [virtio_ring]) from
[<bf0481c0>] (handle_event+0x14/0x24 [keystone_remoteproc])
[  203.317617] [<bf0481c0>] (handle_event [keystone_remoteproc]) from
[<c02369c0>] (process_one_work+0x1ec/0x55c)
[  203.327582] [<c02369c0>] (process_one_work) from [<c0237720>]
(worker_thread+0x38/0x554)
[  203.335645] [<c0237720>] (worker_thread) from [<c023c704>]
(kthread+0x128/0x158)
[  203.343016] [<c023c704>] (kthread) from [<c0208108>]
(ret_from_fork+0x14/0x2c)
