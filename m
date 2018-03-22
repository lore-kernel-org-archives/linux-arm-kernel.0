From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 22 Mar 2018 06:57:10 +0200
Subject: [PATCH] arm64: avoid race condition issue in dump_backtrace
In-Reply-To: <1521687960-3744-1-git-send-email-ji.zhang@mediatek.com>
References: <1521687960-3744-1-git-send-email-ji.zhang@mediatek.com>
Message-ID: <20180322045710.vmmjr2wcankea45o@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ji Zhang,

On Thu, Mar 22, 2018 at 11:06:00AM +0800, Ji Zhang wrote:
> When we dump the backtrace of some specific task, there is a potential race
> condition due to the task may be running on other cores if SMP enabled.
> That is because for current implementation, if the task is not the current
> task, we will get the registers used for unwind from cpu_context saved in
> thread_info, which is the snapshot before context switch, but if the task
> is running on other cores, the registers and the content of stack are
> changed.
> This may cause that we get the wrong backtrace or incomplete backtrace or
> even crash the kernel.
> To avoid this case, do not dump the backtrace of the tasks which are
> running on other cores.
> This patch cannot solve the issue completely but can shrink the window of
> race condition.
> 
> Signed-off-by: Ji Zhang <ji.zhang@mediatek.com>
> ---
>  arch/arm64/kernel/traps.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index eb2d151..95749364 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -113,6 +113,9 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  	if (tsk == current) {
>  		frame.fp = (unsigned long)__builtin_frame_address(0);
>  		frame.pc = (unsigned long)dump_backtrace;
> +	else if (tsk->state == TASK_RUNNING) {

Missing closing brace. Does this build?

> +		pr_notice("Do not dump other running tasks\n");
> +		return;
>  	} else {
>  		/*
>  		 * task blocked in __switch_to

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
