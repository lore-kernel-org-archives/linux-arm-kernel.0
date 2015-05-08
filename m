From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 May 2015 16:37:58 +0100
Subject: [PATCH v4 2/2] arm64: perf: Fix callchain parse error with
 kernel tracepoint events
In-Reply-To: <1431063784-137600-3-git-send-email-houpengyang@huawei.com>
References: <1431063784-137600-1-git-send-email-houpengyang@huawei.com>
 <1431063784-137600-3-git-send-email-houpengyang@huawei.com>
Message-ID: <20150508153758.GG25587@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 06:43:04AM +0100, Hou Pengyang wrote:
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
> ---
>  arch/arm64/include/asm/perf_event.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
> index d26d1d5..6471773 100644
> --- a/arch/arm64/include/asm/perf_event.h
> +++ b/arch/arm64/include/asm/perf_event.h
> @@ -24,4 +24,11 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
>  #define perf_misc_flags(regs)	perf_misc_flags(regs)
>  #endif
>  
> +#define perf_arch_fetch_caller_regs(regs, __ip) { \
> +	(regs)->pc = (__ip);    \
> +	(regs)->regs[AARCH64_INSN_REG_FP] = (unsigned long) __builtin_frame_address(0); \

Just a minor thing, but I'd rather we explicitly used '29' as the index
here. The AARCH64_INSN_REG_FP is really for the instruction generation
code used by BPF and I think it's better to be explicit about the register
number here.

Anyway, I've queued your arch/arm/ patch and Catalin can take this one
for 4.2 once you've made the small change above and added my Ack.

Thanks,

Will
