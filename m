From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Thu, 25 Sep 2014 20:44:16 +0800
Subject: [PATCH v4 0/8] arm/arm64: KVM: dynamic VGIC sizing
In-Reply-To: <1410433755-3612-1-git-send-email-marc.zyngier@arm.com>
References: <1410433755-3612-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <54240E20.8060505@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I have a problem that I want to ask for your advice.
Before I send this mail to Marc and Christoffer. But it seems that they are busy or not online recently.

I git clone Marc's "kvmtool-vgic-dyn" branch and run it on Fastmodel Cortex-A57*4 with qemu 2.1.0.
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git

I want to do repeated lifecycle test. The test is that start 2 VMs, sleep 10 and do pkill qemu.
Test script is following:
#!/bin/sh
while true
do
	qemu-system-aarch64 \
    		-enable-kvm -smp 4 \
    		-kernel Image \
    		-m 512 -machine virt,kernel_irqchip=on \
    		-initrd guestfs.cpio.gz \
    		-cpu host \
    		-chardev pty,id=pty0,mux=on -monitor chardev:pty0 \
    		-serial chardev:pty0 -daemonize \
    		-vnc 0.0.0.0:0 \
    		-append "rdinit=/sbin/init console=ttyAMA0 mem=512M root=/dev/ram earlyprintk=pl011,0x9000000 rw" &

	qemu-system-aarch64 \
    		-enable-kvm -smp 4 \
    		-kernel Image \
    		-m 512 -machine virt,kernel_irqchip=on \
    		-initrd guestfs.cpio.gz \
    		-cpu host \
    		-chardev pty,id=pty0,mux=on -monitor chardev:pty0 \
   		-serial chardev:pty0 -daemonize \
    		-vnc 0.0.0.0:1 \
    		-append "rdinit=/sbin/init console=ttyAMA0 mem=512M root=/dev/ram earlyprintk=pl011,0x9000000 rw" &
    	sleep 10
	pkill qemu
done

After repeating sometimes there is something wrong happened as followed.
Look forward for your reply.
Thanks,
Shannon

BUG: failure at mm/slub.c:3346/kfree()!
Kernel panic - not syncing: BUG!
CPU: 0 PID: 874 Comm: qemu-system-aar Not tainted 3.17.0-rc4+ #1
Call trace:
[<ffffffc000087f50>] dump_backtrace+0x0/0x130
[<ffffffc000088090>] show_stack+0x10/0x1c
[<ffffffc000499074>] dump_stack+0x74/0x94
[<ffffffc0004956c4>] panic+0xe0/0x218
[<ffffffc000152fb4>] kfree+0x168/0x16c
[<ffffffc0000a260c>] kvm_vgic_destroy+0x104/0x164
[<ffffffc000099f54>] kvm_arch_destroy_vm+0x68/0x7c
[<ffffffc000097a04>] kvm_put_kvm+0x158/0x244
[<ffffffc000097b28>] kvm_device_release+0x38/0x4c
[<ffffffc000159710>] __fput+0x98/0x1d8
[<ffffffc0001598a4>] ____fput+0x8/0x14
[<ffffffc0000beb04>] task_work_run+0xac/0xec
[<ffffffc0000a8314>] do_exit+0x280/0x92c
[<ffffffc0000a9788>] do_group_exit+0x40/0xd4
[<ffffffc0000b3214>] get_signal+0x2b4/0x4fc
[<ffffffc000087574>] do_signal+0x170/0x4fc
[<ffffffc000087b18>] do_notify_resume+0x58/0x64
CPU3: stopping
CPU: 3 PID: 0 Comm: swapper/3 Not tainted 3.17.0-rc4+ #1
Call trace:
[<ffffffc000087f50>] dump_backtrace+0x0/0x130
[<ffffffc000088090>] show_stack+0x10/0x1c
[<ffffffc000499074>] dump_stack+0x74/0x94
[<ffffffc00008fd74>] handle_IPI+0x180/0x198
[<ffffffc0000812d0>] gic_handle_irq+0x78/0x80
Exception stack(0xffffffc87b8dbe30 to 0xffffffc87b8dbf50)
be20:                                     7b8d8000 ffffffc8 006a00d0 ffffffc0
be40: 7b8dbf70 ffffffc8 000851a0 ffffffc0 00000000 00000000 00000000 00000000
be60: 7ffc49ec ffffffc8 00000000 01000000 00672700 ffffffc0 00000003 00000000
be80: 00000000 00098968 000002a8 00000000 7b8975b0 ffffffc8 7b8dbd80 ffffffc8
bea0: 00000400 00000000 00000400 00000000 00000018 00000000 e8000000 00000003
bec0: 00000000 00000000 80000000 0008bab2 0015879c ffffffc0 b2f741d0 0000007f
bee0: c4ae28c0 0000007f 7b8d8000 ffffffc8 006a00d0 ffffffc0 006a1bc0 ffffffc0
bf00: 004aa258 ffffffc0 0069cdc7 ffffffc0 005b3300 ffffffc0 00000001 00000000
bf20: 8070c000 00000000 00080330 ffffffc0 80000000 00000040 7b8dbf70 ffffffc8
bf40: 0008519c ffffffc0 7b8dbf70 ffffffc8
[<ffffffc000083da0>] el1_irq+0x60/0xc0
[<ffffffc0000d68cc>] cpu_startup_entry+0xe8/0x134
[<ffffffc00008f848>] secondary_start_kernel+0x108/0x118
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.17.0-rc4+ #1
Call trace:
[<ffffffc000087f50>] dump_backtrace+0x0/0x130
[<ffffffc000088090>] show_stack+0x10/0x1c
[<ffffffc000499074>] dump_stack+0x74/0x94
[<ffffffc00008fd74>] handle_IPI+0x180/0x198
[<ffffffc0000812d0>] gic_handle_irq+0x78/0x80
Exception stack(0xffffffc87b8d3e30 to 0xffffffc87b8d3f50)
3e20:                                     7b8d0000 ffffffc8 006a00d0 ffffffc0
3e40: 7b8d3f70 ffffffc8 000851a0 ffffffc0 00000000 00000000 00000000 00000000
3e60: 7ffae9ec ffffffc8 00000000 01000000 00672700 ffffffc0 00000001 00000000
3e80: 00000000 0008583b 000003fe 00000000 7b896130 ffffffc8 7b8d3d80 ffffffc8
3ea0: 00000400 00000000 00000400 00000000 004e9000 00000000 00000001 00000000
3ec0: 00000001 00000000 ffffffff ffffffff 000a9a54 ffffffc0 b16ac310 0000007f
3ee0: e8a17570 0000007f 7b8d0000 ffffffc8 006a00d0 ffffffc0 006a1bc0 ffffffc0
3f00: 004aa258 ffffffc0 0069cdc7 ffffffc0 005b3300 ffffffc0 00000001 00000000
3f20: 8070c000 00000000 00080330 ffffffc0 80000000 00000040 7b8d3f70 ffffffc8
3f40: 0008519c ffffffc0 7b8d3f70 ffffffc8
[<ffffffc000083da0>] el1_irq+0x60/0xc0
[<ffffffc0000d68cc>] cpu_startup_entry+0xe8/0x134
[<ffffffc00008f848>] secondary_start_kernel+0x108/0x118
CPU2: stopping
CPU: 2 PID: 0 Comm: swapper/2 Not tainted 3.17.0-rc4+ #1
Call trace:
[<ffffffc000087f50>] dump_backtrace+0x0/0x130
[<ffffffc000088090>] show_stack+0x10/0x1c
[<ffffffc000499074>] dump_stack+0x74/0x94
[<ffffffc00008fd74>] handle_IPI+0x180/0x198
[<ffffffc0000812d0>] gic_handle_irq+0x78/0x80
Exception stack(0xffffffc87b8d7e30 to 0xffffffc87b8d7f50)
7e20:                                     7b8d4000 ffffffc8 006a00d0 ffffffc0
7e40: 7b8d7f70 ffffffc8 000851a0 ffffffc0 00000000 00000000 00000000 00000000
7e60: 7ffb99ec ffffffc8 00000000 01000000 00672700 ffffffc0 00000002 00000000
7e80: 80000000 0007bfa4 000003fe 00000000 7b896b70 ffffffc8 7b8d7d80 ffffffc8
7ea0: 00000400 00000000 00000400 00000000 0064dd20 00000000 0064dd18 00000000
7ec0: 0064dd10 00000000 ffffffff ffffffff 00168e84 ffffffc0 93c15150 0000007f
7ee0: eed0dfc0 0000007f 7b8d4000 ffffffc8 006a00d0 ffffffc0 006a1bc0 ffffffc0
7f00: 004aa258 ffffffc0 0069cdc7 ffffffc0 005b3300 ffffffc0 00000001 00000000
7f20: 8070c000 00000000 00080330 ffffffc0 80000000 00000040 7b8d7f70 ffffffc8
7f40: 0008519c ffffffc0 7b8d7f70 ffffffc8
[<ffffffc000083da0>] el1_irq+0x60/0xc0
[<ffffffc0000d68cc>] cpu_startup_entry+0xe8/0x134
[<ffffffc00008f848>] secondary_start_kernel+0x108/0x118
---[ end Kernel panic - not syncing: BUG!

On 2014/9/11 19:09, Marc Zyngier wrote:
> So far, the VGIC data structures have been statically sized, meaning
> that we always have to support more interrupts than we actually want,
> and more CPU interfaces than we should. This is a waste of resource,
> and is the kind of things that should be tuneable.
> 
-- 
Shannon
