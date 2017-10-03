From: fengguang.wu@intel.com (Fengguang Wu)
Date: Tue, 3 Oct 2017 11:45:38 +0800
Subject: 4879b7ae05 ("Merge tag 'dmaengine-4.12-rc1' of .."): WARNING:
 kernel stack regs at bd92bc2e in 01-cpu-hotplug:3811 has bad 'bp' value
 000001be
In-Reply-To: <20171002213109.5n3skzy76edhwkvf@treble>
References: <59d177a7.vsiddgOxdHRIlRvy%fengguang.wu@intel.com>
 <CA+55aFz_ijfUxyk2kdLhfzfS1z0_uRBw6eQb9UxFvh=5zOzzaw@mail.gmail.com>
 <20171002212654.rsm4uj3hfioddldd@treble>
 <20171002213109.5n3skzy76edhwkvf@treble>
Message-ID: <20171003034538.ntvuwtm2uha6wt6h@wfg-t540p.sh.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Mon, Oct 02, 2017 at 04:31:09PM -0500, Josh Poimboeuf wrote:
>On Mon, Oct 02, 2017 at 04:26:54PM -0500, Josh Poimboeuf wrote:
>> Fengguang, assuming it's reliably recreatable, any chance you could
>> recreate with the following patch?

Sure, I'll try your patch on v4.14-rc3 since it looks the most
reproducible kernel. For the bisected 4879b7ae05, the warning only
shows up once out of 909 boots according to the below stats. So I'm
not sure whether it's the _first_ bad commit. To double confirm, I
just queued 5000 more boot tests for each of its parent commits.

> ecc721a72c  Merge tag 'pwm/for-4.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm
> be13ec668d  Merge branch 'topic/pl330' into for-linus
> 4879b7ae05  Merge tag 'dmaengine-4.12-rc1' of git://git.infradead.org/users/vkoul/slave-dma
> 9e66317d3c  Linux 4.14-rc3
> 1418b85217  Add linux-next specific files for 20170929
> +-------------------------------------------------------+------------+------------+------------+-----------+---------------+
> |                                                       | ecc721a72c | be13ec668d | 4879b7ae05 | v4.14-rc3 | next-20170929 |
> +-------------------------------------------------------+------------+------------+------------+-----------+---------------+
> | boot_successes                                        | 1009       | 1009       | 909        | 5         | 510           |
> | boot_failures                                         | 0          | 0          | 1          | 4         | 153           |
> | WARNING:kernel_stack                                  | 0          | 0          | 1          | 3         | 111           |
> | BUG:unable_to_handle_kernel                           | 0          | 0          | 0          | 3         | 48            |
> | Oops:#[##]                                            | 0          | 0          | 0          | 3         | 48            |
> | EIP:update_stack_state                                | 0          | 0          | 0          | 3         | 48            |
> | Kernel_panic-not_syncing:Fatal_exception_in_interrupt | 0          | 0          | 0          | 3         | 48            |
> | invoked_oom-killer:gfp_mask=0x                        | 0          | 0          | 0          | 1         | 16            |
> | Mem-Info                                              | 0          | 0          | 0          | 1         | 16            |
> | EIP:clear_user                                        | 0          | 0          | 0          | 0         | 2             |
> | EIP:copy_page_to_iter                                 | 0          | 0          | 0          | 0         | 1             |
> +-------------------------------------------------------+------------+------------+------------+-----------+---------------+

>Sorry, here's a version which actually compiles.

OK.

Thanks,
Fengguang

>diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
>index d145a0b1f529..00234fa5a33a 100644
>--- a/arch/x86/kernel/unwind_frame.c
>+++ b/arch/x86/kernel/unwind_frame.c
>@@ -44,7 +44,8 @@ static void unwind_dump(struct unwind_state *state)
> 			state->stack_info.type, state->stack_info.next_sp,
> 			state->stack_mask, state->graph_idx);
>
>-	for (sp = state->orig_sp; sp; sp = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
>+	for (sp = PTR_ALIGN(state->orig_sp, sizeof(long)); sp;
>+	     sp = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
> 		if (get_stack_info(sp, state->task, &stack_info, &visit_mask))
> 			break;
>
