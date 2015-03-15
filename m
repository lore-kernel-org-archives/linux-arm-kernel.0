From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 15 Mar 2015 21:33:30 +0000
Subject: Versatile Express randomly fails to boot
Message-ID: <20150315213330.GB8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have noticed recently that the Versatile Express with the CT9x4 tile
randomly fails to boot in the nightly boot tests.

Remember that these are from my build system, which is mainline plus
my development, plus arm-soc, so they're not pure -rc1, -rc2 nor -rc3.

Booting the exact same kernel image multuple times, with the same DT
blob shows the same symptom - there are no kernel messages output
after decompression.  This is a fairly recent regression - 4.0-rc1
seemed fine, the few tests that 4.0-rc2 were subjected to also look
fine, 4.0-rc3 seems to randomly fail.

Adding in my standard DEBUG_LL hack, and a few extra printk()s reveals
that the kernel stops when trying to bring up the secondary CPUs:

...
Calibrating local timer... 200.00MHz.
Calibrating delay loop... 795.44 BogoMIPS (lpj=3977216)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x6038ef68 - 0x6038efc0
trying to boot secondary 1
sending ipi
ipi sent, waiting
wait done
boot secondary returned 0
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
trying to boot secondary 2

So, we see that we brought up the CPU1 just fine, and:

printk("trying to boot secondary %u\n", cpu);
        ret = smp_ops.smp_boot_secondary(cpu, idle);
printk("boot secondary returned %d\n", ret);

we reached that printk() for CPU2, but we didn't get to:

int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
{
        spin_lock(&boot_lock);
        write_pen_release(cpu_logical_map(cpu));
printk("sending ipi\n");
        arch_send_wakeup_ipi_mask(cpumask_of(cpu));
printk("ipi sent, waiting\n");

here.

Winding the kernel back to -rc1 results in it behaving again.

I don't see anything in the diff between -rc1 and -rc3 which would
explain it.

Another boot:

CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x6038efd8 - 0x6038f030
trying to boot secondary 1
before spin_lock()
before write_pen_release()
sending ipi
ipi sent, waiting
wait done
BUG: spinlock lockup suspected on CPU#1, swapper/1/0
 lock: boot_lock+0x0/0x30, .magic: dead4ead, .owner: swapper/0/1, .owner_cpu: 0
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.0.0-rc3+ #1
Hardware name: ARM-Versatile Express
Backtrace:
[<c0011a64>] (dump_backtrace) from [<c0011d24>] (show_stack+0x18/0x1c)
 r6:17b4c000 r5:c050d150 r4:00000000 r3:00200040
[<c0011d0c>] (show_stack) from [<c0388e00>] (dump_stack+0x74/0x90)
[<c0388d8c>] (dump_stack) from [<c038695c>] (spin_dump+0x80/0x94)
 r4:ee860000 r3:ee865a00
[<c03868dc>] (spin_dump) from [<c005a9d8>] (do_raw_spin_lock+0xec/0x1c0)
 r5:00000000 r4:17b4c000
[<c005a8ec>] (do_raw_spin_lock) from [<c038e55c>] (_raw_spin_lock+0x3c/0x44)
 r10:00000000 r9:410fc091 r8:6000406a r7:c0532d3c r6:10c0387d r5:00000015
 r4:c050d150
[<c038e520>] (_raw_spin_lock) from [<c001beb0>] (versatile_secondary_init+0x20/0x30)
 r4:c050d150
[<c001be90>] (versatile_secondary_init) from [<c00138f0>] (secondary_start_kernel+0x100/0x160)
 r4:00000001 r3:c001be90
[<c00137f0>] (secondary_start_kernel) from [<600087e4>] (0x600087e4)
 r4:8e87406a r3:c00087cc
boot secondary returned 0

This one is interesting, as it /seems/ that the boot CPU got stuck on
spin_unlock() in versatile_boot_secondary() - the unlock wasn't seen by
CPU1, but neither did CPU0 make it out of versatile_boot_secondary()
despite getting out of the pen_release==-1 loop.

Another interesting factor is that adding these printk()s appear to have
stopped it booting at all... :(

Arnd suggested commit 17f480342026e54000, so I reverted that, and I get
a different behaviour - instead of the spinlock lockup, I get:

trying to boot secondary 1
before spin_lock()
before write_pen_release()
sending ipi
ipi sent, waiting
wait done
boot secondary returned 0

instead - I guess it just changes the timing due to the placement of
code/data in the kernel.

I'm going to try a few other kernels to try and track down what's going
on - whether something from arm-soc or my tree is responsible for this
really weird behaviour.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
