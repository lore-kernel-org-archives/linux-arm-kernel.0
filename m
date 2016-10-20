From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Oct 2016 11:48:16 +0100
Subject: [PATCH 1/2] arm64/numa: fix pcpu_cpu_distance() to get correct
 CPU proximity
In-Reply-To: <1476935576-59941-1-git-send-email-guohanjun@huawei.com>
References: <1476935576-59941-1-git-send-email-guohanjun@huawei.com>
Message-ID: <20161020104815.GC24914@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 11:52:55AM +0800, Hanjun Guo wrote:
> From: Yisheng Xie <xieyisheng1@huawei.com>
> 
> The pcpu_build_alloc_info() function group CPUs according to their
> proximity, by call callback function @cpu_distance_fn from different
> ARCHs.
> 
> For arm64 the callback of @cpu_distance_fn is
>     pcpu_cpu_distance(from, to)
>         -> node_distance(from, to)
> The @from and @to for function node_distance() should be nid.
> 
> However, pcpu_cpu_distance() in arch/arm64/mm/numa.c just past the
> cpu id for @from and @to.
> 
> For this incorrect cpu proximity get from ARCH, it may cause each CPU
> in one group and make group_cnt out of bound:
> 
> 	setup_per_cpu_areas()
> 		pcpu_embed_first_chunk()
> 			pcpu_build_alloc_info()
> in pcpu_build_alloc_info, since cpu_distance_fn will return
> REMOTE_DISTANCE if we pass cpu ids (0,1,2...), so
> cpu_distance_fn(cpu, tcpu) > LOCAL_DISTANCE will wrongly be ture.
> 
> This may results in triggering the BUG_ON(unit != nr_units) later:
> 
> [    0.000000] kernel BUG at mm/percpu.c:1916!
> [    0.000000] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.9.0-rc1-00003-g14155ca-dirty #26
> [    0.000000] Hardware name: Hisilicon Hi1616 Evaluation Board (DT)
> [    0.000000] task: ffff000008d6e900 task.stack: ffff000008d60000
> [    0.000000] PC is at pcpu_embed_first_chunk+0x420/0x704
> [    0.000000] LR is at pcpu_embed_first_chunk+0x3bc/0x704
> [    0.000000] pc : [<ffff000008c754f4>] lr : [<ffff000008c75490>] pstate: 800000c5
> [    0.000000] sp : ffff000008d63eb0
> [    0.000000] x29: ffff000008d63eb0 [    0.000000] x28: 0000000000000000
> [    0.000000] x27: 0000000000000040 [    0.000000] x26: ffff8413fbfcef00
> [    0.000000] x25: 0000000000000042 [    0.000000] x24: 0000000000000042
> [    0.000000] x23: 0000000000001000 [    0.000000] x22: 0000000000000046
> [    0.000000] x21: 0000000000000001 [    0.000000] x20: ffff000008cb3bc8
> [    0.000000] x19: ffff8413fbfcf570 [    0.000000] x18: 0000000000000000
> [    0.000000] x17: ffff000008e49ae0 [    0.000000] x16: 0000000000000003
> [    0.000000] x15: 000000000000001e [    0.000000] x14: 0000000000000004
> [    0.000000] x13: 0000000000000000 [    0.000000] x12: 000000000000006f
> [    0.000000] x11: 00000413fbffff00 [    0.000000] x10: 0000000000000004
> [    0.000000] x9 : 0000000000000000 [    0.000000] x8 : 0000000000000001
> [    0.000000] x7 : ffff8413fbfcf63c [    0.000000] x6 : ffff000008d65d28
> [    0.000000] x5 : ffff000008d65e50 [    0.000000] x4 : 0000000000000000
> [    0.000000] x3 : ffff000008cb3cc8 [    0.000000] x2 : 0000000000000040
> [    0.000000] x1 : 0000000000000040 [    0.000000] x0 : 0000000000000000
> [...]
> [    0.000000] Call trace:
> [    0.000000] Exception stack(0xffff000008d63ce0 to 0xffff000008d63e10)
> [    0.000000] 3ce0: ffff8413fbfcf570 0001000000000000 ffff000008d63eb0 ffff000008c754f4
> [    0.000000] 3d00: ffff000008d63d50 ffff0000081af210 00000413fbfff010 0000000000001000
> [    0.000000] 3d20: ffff000008d63d50 ffff0000081af220 00000413fbfff010 0000000000001000
> [    0.000000] 3d40: 00000413fbfcef00 0000000000000004 ffff000008d63db0 ffff0000081af390
> [    0.000000] 3d60: 00000413fbfcef00 0000000000001000 0000000000000000 0000000000001000
> [    0.000000] 3d80: 0000000000000000 0000000000000040 0000000000000040 ffff000008cb3cc8
> [    0.000000] 3da0: 0000000000000000 ffff000008d65e50 ffff000008d65d28 ffff8413fbfcf63c
> [    0.000000] 3dc0: 0000000000000001 0000000000000000 0000000000000004 00000413fbffff00
> [    0.000000] 3de0: 000000000000006f 0000000000000000 0000000000000004 000000000000001e
> [    0.000000] 3e00: 0000000000000003 ffff000008e49ae0
> [    0.000000] [<ffff000008c754f4>] pcpu_embed_first_chunk+0x420/0x704
> [    0.000000] [<ffff000008c6658c>] setup_per_cpu_areas+0x38/0xc8
> [    0.000000] [<ffff000008c608d8>] start_kernel+0x10c/0x390
> [    0.000000] [<ffff000008c601d8>] __primary_switched+0x5c/0x64
> [    0.000000] Code: b8018660 17ffffd7 6b16037f 54000080 (d4210000)
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> 
> Fix by getting CPUs proximity through its node. We only care about
> whether it is LOCAL_DISTANCE or not, for pcpu_build_alloc_info() only
> use this to group CPUs.
> 
> Fixes: 7af3a0a99252 ("arm64/numa: support HAVE_SETUP_PER_CPU_AREA")
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/mm/numa.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index 778a985..34415fc 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -147,7 +147,10 @@ static int __init early_cpu_to_node(int cpu)
>  
>  static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
>  {
> -	return node_distance(from, to);
> +	if (early_cpu_to_node(from) == early_cpu_to_node(to))
> +		return LOCAL_DISTANCE;
> +	else
> +		return REMOTE_DISTANCE;

Why can't this be node_distance(early_cpu_to_node(from), early_cpu_to_node(to))?

Will
