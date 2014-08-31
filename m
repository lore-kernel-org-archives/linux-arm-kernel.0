From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 31 Aug 2014 23:11:29 +0100
Subject: [PATCH v1] arm64: fix bug for reloading FPSIMD state after cpu
 power off
In-Reply-To: <1409463591-661-1-git-send-email-leoy@marvell.com>
References: <1409463591-661-1-git-send-email-leoy@marvell.com>
Message-ID: <CC25C839-1C64-4BD0-818B-4DA0CD7EC28B@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 Aug 2014, at 06:39, Leo Yan <leoy@marvell.com> wrote:
> Now arm64 defers reloading FPSIMD state, but this optimization also
> introduces the bug after cpu resume back from low power mode.

You are right, I can see a bug here.

> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index ad8aebb..4caef93 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -268,13 +268,9 @@ static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
> {
> 	switch (cmd) {
> 	case CPU_PM_ENTER:
> -		if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE))
> -			fpsimd_save_state(&current->thread.fpsimd_state);

That?s needed if we enter a low power state directly from a task with
a valid mm (user). I?m not sure that?s possible, but just in case.

> +		this_cpu_write(fpsimd_last_state, NULL);

That?s correct. In most cases, we enter low power state from the idle
thread which does not have an mm, so the CPU_PM_EXIT case wouldn?t set
a TIF_FOREIGN_FPSTATE, so thread switching would not detect the change.

> 		break;
> 	case CPU_PM_EXIT:
> -		if (current->mm)
> -			set_thread_flag(TIF_FOREIGN_FPSTATE);

See above for why this may still be needed (it case it returns to user
directly without fpsimd_thread_switch() to detect fpsimd_last_state).

Catalin
