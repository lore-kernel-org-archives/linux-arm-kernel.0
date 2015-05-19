From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 May 2015 17:52:03 +0100
Subject: [PATCH v5] arm64: perf: Fix callchain parse error with kernel
 tracepoint events
In-Reply-To: <1431256060-161483-1-git-send-email-houpengyang@huawei.com>
References: <20150508153758.GG25587@arm.com>
 <1431256060-161483-1-git-send-email-houpengyang@huawei.com>
Message-ID: <20150519165202.GA21251@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 10, 2015 at 11:07:40AM +0000, Hou Pengyang wrote:
> For ARM64, when tracing with tracepoint events, the IP and pstate are set
> to 0, preventing the perf code parsing the callchain and resolving the
> symbols correctly.
> 
>  ./perf record -e sched:sched_switch -g --call-graph dwarf ls
>     [ perf record: Captured and wrote 0.146 MB perf.data ]
>  ./perf report -f
>     Samples: 194  of event 'sched:sched_switch', Event count (approx.): 194
>     Children      Self    Command  Shared Object     Symbol
>     100.00%       100.00%  ls       [unknown]         [.] 0000000000000000
> 
> The fix is to implement perf_arch_fetch_caller_regs for ARM64, which fills
> several necessary registers used for callchain unwinding, including pc,sp,
> fp and spsr .
> 
> With this patch, callchain can be parsed correctly as follows:
> 
>      ......
> +    2.63%     0.00%  ls       [kernel.kallsyms]  [k] vfs_symlink
> +    2.63%     0.00%  ls       [kernel.kallsyms]  [k] follow_down
> +    2.63%     0.00%  ls       [kernel.kallsyms]  [k] pfkey_get
> +    2.63%     0.00%  ls       [kernel.kallsyms]  [k] do_execveat_common.isra.33
> -    2.63%     0.00%  ls       [kernel.kallsyms]  [k] pfkey_send_policy_notify
>      pfkey_send_policy_notify
>      pfkey_get
>      v9fs_vfs_rename
>      page_follow_link_light
>      link_path_walk
>      el0_svc_naked
>     .......
> 
> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
> Acked-by: Will Deacon <will.deacon@arm.com>

Queued for 4.2. Thanks.

-- 
Catalin
