From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 29 Jun 2015 11:03:04 +0100
Subject: Regular oops on shutdown of KVM/ARM64 machines with VGA device
In-Reply-To: <CAL5wTH4MtybHBk22r593HmVX+2jqCDm4fb2MyT2L0TMkHrD7pg@mail.gmail.com>
References: <CAL5wTH4MtybHBk22r593HmVX+2jqCDm4fb2MyT2L0TMkHrD7pg@mail.gmail.com>
Message-ID: <20150629100304.GB18931@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 26, 2015 at 10:16:00PM +0100, Dirk M?ller wrote:
> Hi,

Hi,

> with 4.1.0 I'm hitting a frequent memory corruption. with DEBUG_VM I
> was able to trace it down to this BUG().
> 
> I'm not sure how atomic_dec_and_test() can pass twice from two
> different CPUs. any idea?

This might be a FW issues rather than a Linux issue, see below.

> Thanks,
> Dirk
> 
> 
> [ 1994.829596] page dumped because: VM_BUG_ON_PAGE((*({
> __attribute__((unused)) typeof((&page->_
> count)->counter) __var = ( typeof((&page->_count)->counter)) 0;
> (volatile typeof((&page->_count)
> ->counter) *)&((&page->_count)->counter); })) == 0)
> [ 1994.853654] BUG: failure at ../include/linux/mm.h:364/put_page_testzero()!
> [ 1994.863295] Kernel panic - not syncing: BUG!
> [ 1994.914504] CPU: 4 PID: 16525 Comm: qemu-system-aar Tainted: G
>   W       4.1.0-0.g5faf79
> 9-default #1
> [ 1994.924059] Hardware name: Default string Default string/Default
> string, BIOS ROD0074E 04/02/
> 2015
> [ 1994.932919] Call trace:
> [ 1994.935364] [<fffffe0000098608>] dump_backtrace+0x0/0x150
> [ 1994.940754] [<fffffe0000098778>] show_stack+0x20/0x30
> [ 1994.945799] [<fffffe00006b3878>] dump_stack+0x7c/0x98
> [ 1994.950840] [<fffffe00006b1b84>] panic+0xdc/0x220
> [ 1994.955538] [<fffffe00001c4e64>] __free_pages+0xb4/0xb8
> [ 1994.960751] [<fffffe00001c5000>] free_pages+0x78/0xc0
> [ 1994.965792] [<fffffe00001c5148>] free_pages_exact+0x40/0x58
> [ 1994.971355] [<fffffe00000b5fd0>] kvm_free_stage2_pgd+0x38/0x50
> [ 1994.977178] [<fffffe00000b3540>] kvm_arch_destroy_vm+0x28/0x68
> [ 1994.983000] [<fffffe00000ac7ec>] kvm_put_kvm+0x11c/0x208
> [ 1994.988301] [<fffffe00000ac8f8>] kvm_device_release+0x20/0x38
> [ 1994.994038] [<fffffe00002305a4>] __fput+0x8c/0x1c8
> [ 1994.998818] [<fffffe000023074c>] ____fput+0x1c/0x30
> [ 1995.003686] [<fffffe00000e4d50>] task_work_run+0xb8/0xf8
> [ 1995.008989] [<fffffe00000c9f00>] do_exit+0x2d8/0xa08
> [ 1995.013942] [<fffffe00000ca6c0>] do_group_exit+0x40/0xe8
> [ 1995.019244] [<fffffe00000d688c>] get_signal+0x3cc/0x568
> [ 1995.024458] [<fffffe0000097a10>] do_signal+0x78/0x528
> [ 1995.029499] [<fffffe000009810c>] do_notify_resume+0x6c/0x78
> [ 1995.035065] CPU3: stopping
> [ 1995.037773] CPU: 3 PID: 16099 Comm: qemu-system-aar Tainted: G
>   W       4.1.0-0.g5faf79
> 9-default #1
> [ 1995.047328] Hardware name: Default string Default string/Default
> string, BIOS ROD0074E 04/02/
> 2015

I've seen issues with prior FW versions where the ethernet controller
was erroneously left active after ExitBootServices(), and would DMA
braodcast packets over the kernel. That resulted in similar failures to
what you're reporting.

Can you reproduce the issue with all ethernet cables unplugged?

You can also try enabling CONFIG_MEMTEST (and pass memtest on the
command line) at boot time, which may happen to catch DMA in the act.

Thanks,
Mark.
