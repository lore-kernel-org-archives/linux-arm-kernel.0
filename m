From: jpoimboe@redhat.com (Josh Poimboeuf)
Date: Mon, 2 Oct 2017 16:31:09 -0500
Subject: 4879b7ae05 ("Merge tag 'dmaengine-4.12-rc1' of .."): WARNING:
 kernel stack regs at bd92bc2e in 01-cpu-hotplug:3811 has bad 'bp' value
 000001be
In-Reply-To: <20171002212654.rsm4uj3hfioddldd@treble>
References: <59d177a7.vsiddgOxdHRIlRvy%fengguang.wu@intel.com>
 <CA+55aFz_ijfUxyk2kdLhfzfS1z0_uRBw6eQb9UxFvh=5zOzzaw@mail.gmail.com>
 <20171002212654.rsm4uj3hfioddldd@treble>
Message-ID: <20171002213109.5n3skzy76edhwkvf@treble>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 04:26:54PM -0500, Josh Poimboeuf wrote:
> Fengguang, assuming it's reliably recreatable, any chance you could
> recreate with the following patch?

Sorry, here's a version which actually compiles.

diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index d145a0b1f529..00234fa5a33a 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -44,7 +44,8 @@ static void unwind_dump(struct unwind_state *state)
 			state->stack_info.type, state->stack_info.next_sp,
 			state->stack_mask, state->graph_idx);
 
-	for (sp = state->orig_sp; sp; sp = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
+	for (sp = PTR_ALIGN(state->orig_sp, sizeof(long)); sp;
+	     sp = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
 		if (get_stack_info(sp, state->task, &stack_info, &visit_mask))
 			break;
 
