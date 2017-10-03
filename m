From: jpoimboe@redhat.com (Josh Poimboeuf)
Date: Tue, 3 Oct 2017 08:21:25 -0500
Subject: 4879b7ae05 ("Merge tag 'dmaengine-4.12-rc1' of .."): WARNING:
 kernel stack regs at bd92bc2e in 01-cpu-hotplug:3811 has bad 'bp' value
 000001be
In-Reply-To: <20171003034538.ntvuwtm2uha6wt6h@wfg-t540p.sh.intel.com>
References: <59d177a7.vsiddgOxdHRIlRvy%fengguang.wu@intel.com>
 <CA+55aFz_ijfUxyk2kdLhfzfS1z0_uRBw6eQb9UxFvh=5zOzzaw@mail.gmail.com>
 <20171002212654.rsm4uj3hfioddldd@treble>
 <20171002213109.5n3skzy76edhwkvf@treble>
 <20171003034538.ntvuwtm2uha6wt6h@wfg-t540p.sh.intel.com>
Message-ID: <20171003132125.ulj3nnmiimamsm6w@treble>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 03, 2017 at 11:45:38AM +0800, Fengguang Wu wrote:
> Hi Josh,
> 
> On Mon, Oct 02, 2017 at 04:31:09PM -0500, Josh Poimboeuf wrote:
> > On Mon, Oct 02, 2017 at 04:26:54PM -0500, Josh Poimboeuf wrote:
> > > Fengguang, assuming it's reliably recreatable, any chance you could
> > > recreate with the following patch?
> 
> Sure, I'll try your patch on v4.14-rc3 since it looks the most
> reproducible kernel. For the bisected 4879b7ae05, the warning only
> shows up once out of 909 boots according to the below stats. So I'm
> not sure whether it's the _first_ bad commit. To double confirm, I
> just queued 5000 more boot tests for each of its parent commits.

Fengguang, here's an improved version of the patch based on Linus'
suggestions.  If you can use it instead, that would be helpful because
it has a better chance of dumping useful data.  Thanks!


diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index d145a0b1f529..191012762aa0 100644
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
 
@@ -178,7 +179,7 @@ static struct pt_regs *decode_frame_pointer(unsigned long *bp)
 {
 	unsigned long regs = (unsigned long)bp;
 
-	if (!(regs & 0x1))
+	if ((regs & (sizeof(long)-1)) != 1)
 		return NULL;
 
 	return (struct pt_regs *)(regs & ~0x1);
@@ -221,6 +222,10 @@ static bool update_stack_state(struct unwind_state *state,
 				   &state->stack_mask))
 			return false;
 
+	/* Make sure the frame pointer is properly aligned: */
+	if ((unsigned long)frame & (sizeof(long)-1))
+		return false;
+
 	/* Make sure it only unwinds up and doesn't overlap the prev frame: */
 	if (state->orig_sp && state->stack_info.type == prev_type &&
 	    frame < prev_frame_end)
