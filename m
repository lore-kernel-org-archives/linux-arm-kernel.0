From: ddaney.cavm@gmail.com (David Daney)
Date: Tue, 20 Sep 2016 10:53:14 -0700
Subject: [PATCH] arm64, numa: Add cpu_to_node() implementation.
In-Reply-To: <20160920104348.GP25086@rric.localdomain>
References: <1474310970-21264-1-git-send-email-ddaney.cavm@gmail.com>
 <20160920104348.GP25086@rric.localdomain>
Message-ID: <57E1778A.6040308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2016 03:43 AM, Robert Richter wrote:
[...]
>
> Instead we need to make sure the set_*numa_node() functions are called
> earlier before secondary cpus are booted. My suggested change for that
> is this:
>
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index d93d43352504..952365c2f100 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -204,7 +204,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>   static void smp_store_cpu_info(unsigned int cpuid)
>   {
>   	store_cpu_topology(cpuid);
> -	numa_store_cpu_info(cpuid);
>   }
>
>   /*
> @@ -719,6 +718,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>   			continue;
>
>   		set_cpu_present(cpu, true);
> +		numa_store_cpu_info(cpu);
>   	}
>   }
>
>
> I have tested the code and it properly sets up all per-cpu workqueues.
>

Thanks Robert,

I have tested a slightly modified version of that, and it seems to also 
fix the problem for me.

I will submit a cleaned up patch.

David Daney



> Unfortunately either your nor my code does fix the BUG_ON() I see with
> the numa kernel:
>
>   kernel BUG at mm/page_alloc.c:1848!
>
> See below for the core dump. It looks like this happens due to moving
> a mem block where first and last page are mapped to different numa
> nodes, thus, triggering the BUG_ON().
>
> Continuing with my investigations...
>
> -Robert
>
>
>
> [    9.674272] ------------[ cut here ]------------
> [    9.678881] kernel BUG at mm/page_alloc.c:1848!
> [    9.683406] Internal error: Oops - BUG: 0 [#1] SMP
> [    9.688190] Modules linked in:
> [    9.691247] CPU: 77 PID: 1 Comm: swapper/0 Tainted: G        W       4.8.0-rc5.vanilla5-00030-ga2b86cb3ce72 #38
> [    9.701322] Hardware name: www.cavium.com ThunderX CRB-2S/ThunderX CRB-2S, BIOS 0.3 Aug 24 2016
> [    9.710008] task: ffff800fe4561400 task.stack: ffff800ffbe0c000
> [    9.715939] PC is at move_freepages+0x160/0x168
> [    9.720460] LR is at move_freepages+0x160/0x168
> [    9.724979] pc : [<ffff0000081ec7d0>] lr : [<ffff0000081ec7d0>] pstate: 600000c5
> [    9.732362] sp : ffff800ffbe0f510
> [    9.735666] x29: ffff800ffbe0f510 x28: ffff7fe043f80020
> [    9.740975] x27: ffff7fe043f80000 x26: 000000000000000c
> [    9.746283] x25: 000000000000000c x24: ffff810ffffaf0e0
> [    9.751591] x23: 0000000000000001 x22: 0000000000000000
> [    9.756898] x21: ffff7fe043ffffc0 x20: ffff810ffffaeb00
> [    9.762206] x19: ffff7fe043f80000 x18: 0000000000000010
> [    9.767513] x17: 0000000000000000 x16: 0000000100000000
> [    9.772821] x15: ffff000088f03f37 x14: 6e2c303d64696e2c
> [    9.778128] x13: 3038336566666666 x12: 6630303866666666
> [    9.783436] x11: 3d656e6f7a203a64 x10: 0000000000000536
> [    9.788744] x9 : 0000000000000060 x8 : 3030626561666666
> [    9.794051] x7 : 6630313866666666 x6 : ffff000008f03f97
> [    9.799359] x5 : 0000000000000006 x4 : 000000000000000c
> [    9.804667] x3 : 0000000000010000 x2 : 0000000000010000
> [    9.809975] x1 : ffff000008da7be0 x0 : 0000000000000050
>
> [   10.517213] Call trace:
> [   10.519651] Exception stack(0xffff800ffbe0f340 to 0xffff800ffbe0f470)
> [   10.526081] f340: ffff7fe043f80000 0001000000000000 ffff800ffbe0f510 ffff0000081ec7d0
> [   10.533900] f360: ffff000008f03988 0000000008da7bc8 ffff800ffbe0f410 ffff0000081275fc
> [   10.541718] f380: ffff800ffbe0f470 ffff000008ac5a00 ffff7fe043ffffc0 0000000000000000
> [   10.549536] f3a0: 0000000000000001 ffff810ffffaf0e0 000000000000000c 000000000000000c
> [   10.557355] f3c0: ffff7fe043f80000 ffff7fe043f80020 0000000000000030 0000000000000000
> [   10.565173] f3e0: 0000000000000050 ffff000008da7be0 0000000000010000 0000000000010000
> [   10.572991] f400: 000000000000000c 0000000000000006 ffff000008f03f97 6630313866666666
> [   10.580809] f420: 3030626561666666 0000000000000060 0000000000000536 3d656e6f7a203a64
> [   10.588628] f440: 6630303866666666 3038336566666666 6e2c303d64696e2c ffff000088f03f37
> [   10.596446] f460: 0000000100000000 0000000000000000
> [   10.601316] [<ffff0000081ec7d0>] move_freepages+0x160/0x168
> [   10.606879] [<ffff0000081ec880>] move_freepages_block+0xa8/0xb8
> [   10.612788] [<ffff0000081ecf80>] __rmqueue+0x610/0x670
> [   10.617918] [<ffff0000081ee2e4>] get_page_from_freelist+0x3cc/0xb40
> [   10.624174] [<ffff0000081ef05c>] __alloc_pages_nodemask+0x12c/0xd40
> [   10.630438] [<ffff000008244cd0>] alloc_page_interleave+0x60/0xb0
> [   10.636434] [<ffff000008245398>] alloc_pages_current+0x108/0x168
> [   10.642430] [<ffff0000081e49ac>] __page_cache_alloc+0x104/0x140
> [   10.648339] [<ffff0000081e4b00>] pagecache_get_page+0x118/0x2e8
> [   10.654248] [<ffff0000081e4d18>] grab_cache_page_write_begin+0x48/0x68
> [   10.660769] [<ffff000008298c08>] simple_write_begin+0x40/0x150
> [   10.666591] [<ffff0000081e47c0>] generic_perform_write+0xb8/0x1a0
> [   10.672674] [<ffff0000081e6228>] __generic_file_write_iter+0x178/0x1c8
> [   10.679191] [<ffff0000081e6344>] generic_file_write_iter+0xcc/0x1c8
> [   10.685448] [<ffff00000826d12c>] __vfs_write+0xcc/0x140
> [   10.690663] [<ffff00000826de08>] vfs_write+0xa8/0x1c0
> [   10.695704] [<ffff00000826ee34>] SyS_write+0x54/0xb0
> [   10.700666] [<ffff000008bf2008>] xwrite+0x34/0x7c
> [   10.705359] [<ffff000008bf20ec>] do_copy+0x9c/0xf4
> [   10.710140] [<ffff000008bf1dc4>] write_buffer+0x34/0x50
> [   10.715354] [<ffff000008bf1e28>] flush_buffer+0x48/0xb8
> [   10.720579] [<ffff000008c1faa0>] __gunzip+0x27c/0x324
> [   10.725620] [<ffff000008c1fb60>] gunzip+0x18/0x20
> [   10.730314] [<ffff000008bf26dc>] unpack_to_rootfs+0x168/0x280
> [   10.736049] [<ffff000008bf2864>] populate_rootfs+0x70/0x138
> [   10.741615] [<ffff000008082ff4>] do_one_initcall+0x44/0x138
> [   10.747179] [<ffff000008bf0d0c>] kernel_init_freeable+0x1ac/0x24c
> [   10.753267] [<ffff000008859f78>] kernel_init+0x20/0xf8
> [   10.758395] [<ffff000008082b80>] ret_from_fork+0x10/0x50
> [   10.763698] Code: 17fffff2 b00046c0 91280000 97ffd47d (d4210000)
> [   10.769834] ---[ end trace 972d622f64fd69c0 ]---
>
