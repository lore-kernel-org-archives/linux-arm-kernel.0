From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Dec 2013 17:29:07 +0000
Subject: [PATCH RFC v3 08/12] arm64: kernel: implement HW breakpoints CPU
 PM notifier
In-Reply-To: <1385033059-25896-9-git-send-email-lorenzo.pieralisi@arm.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1385033059-25896-9-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20131220172907.GF16829@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Thu, Nov 21, 2013 at 11:24:15AM +0000, Lorenzo Pieralisi wrote:
> When a CPU is shutdown either through CPU idle or suspend to RAM, the
> content of HW breakpoint registers must be reset or restored to proper
> values when CPU resume from low power states. This patch adds debug register
> restore operations to the HW breakpoint control function and implements a
> CPU PM notifier that allows to restore the content of HW breakpoint registers
> to allow proper suspend/resume operations.

This looks mostly fine to me, but I have one questions you might be able to
answer...

> @@ -840,18 +847,36 @@ void hw_breakpoint_thread_switch(struct task_struct *next)
>  /*
>   * CPU initialisation.
>   */
> -static void reset_ctrl_regs(void *unused)
> +static void hw_breakpoint_reset(void *unused)
>  {
>  	int i;
> -
> -	for (i = 0; i < core_num_brps; ++i) {
> -		write_wb_reg(AARCH64_DBG_REG_BCR, i, 0UL);
> -		write_wb_reg(AARCH64_DBG_REG_BVR, i, 0UL);
> +	struct perf_event **slots;
> +	/*
> +	 * When a CPU goes through cold-boot, it does not have any installed
> +	 * slot, so it is safe to share the same function for restoring and
> +	 * resetting breakpoints; when a CPU is hotplugged in, it goes
> +	 * through the slots, which are all empty, hence it just resets control
> +	 * and value for debug registers.
> +	 * When this function is triggered on warm-boot through a CPU PM
> +	 * notifier some slots might be initialized; if so they are
> +	 * reprogrammed according to the debug slots content.
> +	 */
> +	for (slots = this_cpu_ptr(bp_on_reg), i = 0; i < core_num_brps; ++i) {
> +		if (slots[i]) {
> +			hw_breakpoint_control(slots[i], HW_BREAKPOINT_RESTORE);
> +		} else {
> +			write_wb_reg(AARCH64_DBG_REG_BCR, i, 0UL);
> +			write_wb_reg(AARCH64_DBG_REG_BVR, i, 0UL);
> +		}

When this runs on warm-boot and starts restoring debug state, are debug
exceptions guaranteed to be masked? I think that the debug restoration
should appear atomic to a debugger (i.e. you can't take a debug exception
half-way through the restore).

Providing that's the case:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
