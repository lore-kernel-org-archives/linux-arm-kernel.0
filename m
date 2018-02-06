From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Feb 2018 14:36:17 +0000
Subject: [PATCH 1/2] arm64: kprobes: Remove unneeded address sanity check
In-Reply-To: <20180201093459.20477-2-takahiro.akashi@linaro.org>
References: <20180201093459.20477-1-takahiro.akashi@linaro.org>
 <20180201093459.20477-2-takahiro.akashi@linaro.org>
Message-ID: <20180206143617.GF22740@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 06:34:58PM +0900, AKASHI Takahiro wrote:
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Remove unneeded address sanity check in arch_prepare_kprobe().
> Since do_debug_exception() is already blacklisted for kprobes, no need
> to reject all __exception functions. Also, since generic kprobe
> framework already ensures the address is in kernel text, no need to
> check it is in rodata again.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/arm64/kernel/probes/kprobes.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index d849d9804011..3c487a389252 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -78,8 +78,6 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
>  int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  {
>  	unsigned long probe_addr = (unsigned long)p->addr;
> -	extern char __start_rodata[];
> -	extern char __end_rodata[];
>  
>  	if (probe_addr & 0x3)
>  		return -EINVAL;
> @@ -87,12 +85,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  	/* copy instruction */
>  	p->opcode = le32_to_cpu(*p->addr);
>  
> -	if (in_exception_text(probe_addr))
> -		return -EINVAL;
> -	if (probe_addr >= (unsigned long) __start_rodata &&
> -	    probe_addr <= (unsigned long) __end_rodata)
> -		return -EINVAL;
> -

Does this mean we can remove in_exception_text and the corresponding
__exception annotations from arm64?

Will
