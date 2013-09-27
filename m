From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Sep 2013 11:59:03 +0100
Subject: [RFT PATCH v1 6/7] amd64: avoid saving and restoring FPSIMD
 registers until threads access them
In-Reply-To: <1380269087-8520-7-git-send-email-liuj97@gmail.com>
References: <1380269087-8520-1-git-send-email-liuj97@gmail.com>
 <1380269087-8520-7-git-send-email-liuj97@gmail.com>
Message-ID: <20130927105902.GH9057@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 09:04:46AM +0100, Jiang Liu wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
> 
> Use PF_USED_MATH flag to mark whether the thread has accessed any FPSIMD
> registers, so we could avoid saving and restroing FPSIMD registers until
> threads access them. This may improve performance when lazy FPSIMD restore
> is disabled.

Hehe, the subject made me smile :)

I suppose that means I have to give a semi-useful review for the patch...

> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Cc: Jiang Liu <liuj97@gmail.com>
> ---
>  arch/arm64/kernel/fpsimd.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 267e54a..a81af5f 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -99,7 +99,8 @@ void fpsimd_disable_lazy_restore(void)
>   * If lazy mode is enabled, caller needs to disable preemption
>   * when calling fpsimd_load_state_lazy() and fpsimd_save_state_lazy().
>   */
> -static void fpsimd_load_state_lazy(struct fpsimd_state *state)
> +static void fpsimd_load_state_lazy(struct fpsimd_state *state,
> +				   struct task_struct *tsk)
>  {
>  	/* Could we reuse the hardware context? */
>  	if (state->last_cpu == smp_processor_id() &&
> @@ -109,13 +110,19 @@ static void fpsimd_load_state_lazy(struct fpsimd_state *state)
>  	if (static_key_false(&fpsimd_lazy_mode)) {
>  		fpsimd_clear_on_hw(state);
>  		fpsimd_enable_trap();
> -	} else {
> +	} else if (tsk_used_math(tsk)) {
> +		fpsimd_disable_trap();
>  		fpsimd_load_state(state);
> +	} else {
> +		fpsimd_enable_trap();

One thing worth checking in sequences like this is that you have the
relevant memory barriers (isb instructions) to ensure that the CPU is
synchronised wrt side-effects from the msr instructions. *Some* operations
are self-synchronising, but I don't think this is the case for fpsimd in v8
(although I haven't re-checked).

Your earlier patch (3/7) doesn't seem to have any of these barriers.

Will
