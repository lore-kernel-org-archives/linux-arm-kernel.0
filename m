From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 14 Feb 2012 13:59:34 -0800
Subject: [PATCH] Optimize multi-CPU tlb flushing a little more
In-Reply-To: <20120213165926.GA24426@debian>
References: <20110823110602.GG19622@n2100.arm.linux.org.uk>
 <CAH+eYFC_mkdObV0NfN5Jtv0L6fM9e0YGOBghTEVSqf=TAFxdXw@mail.gmail.com>
 <20120213162359.GC25655@n2100.arm.linux.org.uk>
 <20120213165926.GA24426@debian>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178FACB6A1@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rabin Vincent wrote at Monday, February 13, 2012 9:59 AM:
> On Mon, Feb 13, 2012 at 04:23:59PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Feb 13, 2012 at 09:36:35PM +0530, Rabin Vincent wrote:
> > > This part conditionally calls get_cpu() but unconditionally calls
> > > put_cpu():
> >
> > Can you try getting rid of put_cpu(), and replacing get_cpu()
> > with smp_processor_id().
> >
> > In theory, this function should be called with preempt disabled so
> > smp_processor_id() should be safe here.
> 
> Just deleting put_cpu() and replacing get_cpu() with smp_processor_id()
> doesn't cause any problems on my setup, because in my setup (v7 SMP) the
> test for possible_tlb_flags fails so
> cpu_mask_test_cpu(smp_processor_id(),...) never gets called.

Aha, I should have searched harder for my stack trace... This thread
describes the exact problem I just posted about a couple of hours ago,
and Russell's suggested fix solves my problem.

> However, local_flush_tlb_mm() itself does not appear to be called with
> preemption disabled, because if I reverse the check so that
> smp_processor_id() is called, I get loads of the following:

I also tried that, and /don't/ see the following stack traces on Tegra,
FWIW.

>  BUG: using smp_processor_id() in preemptible [00000000] code: init/1
>  [<c0013c0c>] (unwind_backtrace+0x0/0xec) from [<c028b2a4>] (dump_stack+0x20/0x24)
>  [<c028b2a4>] (dump_stack+0x20/0x24) from [<c019bbb4>] (debug_smp_processor_id+0xc4/0xf8)
>  [<c019bbb4>] (debug_smp_processor_id+0xc4/0xf8) from [<c0012e30>] (flush_tlb_mm+0x60/0x84)
>  [<c0012e30>] (flush_tlb_mm+0x60/0x84) from [<c00e2578>] (setup_arg_pages+0x260/0x39c)
>  [<c00e2578>] (setup_arg_pages+0x260/0x39c) from [<c011ffcc>] (load_elf_binary+0x3ec/0x11d8)
>  [<c011ffcc>] (load_elf_binary+0x3ec/0x11d8) from [<c00e1e38>] (search_binary_handler+0xd8/0x2c8)
>  [<c00e1e38>] (search_binary_handler+0xd8/0x2c8) from [<c00e3b1c>] (do_execve+0x29c/0x3b4)
>  [<c00e3b1c>] (do_execve+0x29c/0x3b4) from [<c0011080>] (kernel_execve+0x48/0x90)
>  [<c0011080>] (kernel_execve+0x48/0x90) from [<c028b080>] (run_init_process+0x24/0x2c)
>  [<c028b080>] (run_init_process+0x24/0x2c) from [<c028b0e4>] (init_post+0x5c/0xd4)
>  [<c028b0e4>] (init_post+0x5c/0xd4) from [<c039bb04>] (kernel_init+0x174/0x1ac)
> 
>  BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/27
>  [<c0013c0c>] (unwind_backtrace+0x0/0xec) from [<c028b2a4>] (dump_stack+0x20/0x24)
>  [<c028b2a4>] (dump_stack+0x20/0x24) from [<c019bbb4>] (debug_smp_processor_id+0xc4/0xf8)
>  [<c019bbb4>] (debug_smp_processor_id+0xc4/0xf8) from [<c0012e30>] (flush_tlb_mm+0x60/0x84)
>  [<c0012e30>] (flush_tlb_mm+0x60/0x84) from [<c00ca7e4>] (exit_mmap+0x134/0x1e8)
>  [<c00ca7e4>] (exit_mmap+0x134/0x1e8) from [<c001d4b0>] (mmput+0x60/0xf0)
>  [<c001d4b0>] (mmput+0x60/0xf0) from [<c00217bc>] (exit_mm+0x124/0x12c)
>  [<c00217bc>] (exit_mm+0x124/0x12c) from [<c0023084>] (do_exit+0x1e8/0x7b8)
>  [<c0023084>] (do_exit+0x1e8/0x7b8) from [<c0023944>] (do_group_exit+0x98/0xc4)
>  [<c0023944>] (do_group_exit+0x98/0xc4) from [<c0023990>] (__wake_up_parent+0x0/0x30)
>  [<c0023990>] (__wake_up_parent+0x0/0x30) from [<c000dca0>] (ret_fast_syscall+0x0/0x3c)

-- 
nvpublic
