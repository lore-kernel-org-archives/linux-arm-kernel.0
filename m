From: jpoimboe@redhat.com (Josh Poimboeuf)
Date: Mon, 2 Oct 2017 16:26:54 -0500
Subject: 4879b7ae05 ("Merge tag 'dmaengine-4.12-rc1' of .."): WARNING:
 kernel stack regs at bd92bc2e in 01-cpu-hotplug:3811 has bad 'bp' value
 000001be
In-Reply-To: <CA+55aFz_ijfUxyk2kdLhfzfS1z0_uRBw6eQb9UxFvh=5zOzzaw@mail.gmail.com>
References: <59d177a7.vsiddgOxdHRIlRvy%fengguang.wu@intel.com>
 <CA+55aFz_ijfUxyk2kdLhfzfS1z0_uRBw6eQb9UxFvh=5zOzzaw@mail.gmail.com>
Message-ID: <20171002212654.rsm4uj3hfioddldd@treble>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 01:09:31PM -0700, Linus Torvalds wrote:
> Bringing in Josh on this, because the merge commit gets fingered
> because it seems to be an interaction between the new code from the
> merge and the ORC unwinder changes. It's probably some almost trivial
> code difference that just causes some code generation to change.
> 
> And because Josh wasn't implicated in the merge, he didn't get cc'd by
> the kernel test robot.
> 
> Of course, the stack trace itself seems to be pretty useless, since
> that randconfig doesn't have KALLSYMS enabled, so it's just random hex
> numbers.
> 
> Josh, original email on lkml and a few other mailing lists, see for example:
> 
>     https://www.spinics.net/lists/devicetree/msg196692.html
> 
> Any ideas?

The bisect is pointing to a commit which is almost 5 months old, so this
is pre-ORC.  Kallsyms *is* enabled, but the unwinder dump isn't smart
enough to realize it's dumping misaligned stack addresses:

[  110.399425] WARNING: kernel stack regs at bd92bc2e in 01-cpu-hotplug:3811 has bad 'bp' value 000001be
[  110.399428] unwind stack type:0 next_sp:  (null) mask:0x2 graph_idx:0
[  110.399431] bd92bc2e: 92bc7f00 (0x92bc7f00)
[  110.399433] bd92bc32: c27041bd (0xc27041bd)

So kallsyms doesn't help if I'm dumping bad data.  Oops.

I tried to recreate it with the reproducer script and a similar GCC
version, but no luck.

Fengguang, assuming it's reliably recreatable, any chance you could
recreate with the following patch?


diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index 82c6d7f1fd73..64282ec73eb8 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -42,7 +42,7 @@ static void unwind_dump(struct unwind_state *state)
 			state->stack_info.type, state->stack_info.next_sp,
 			state->stack_mask, state->graph_idx);
 
-	for (sp = state->orig_sp; sp; sp = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
+	for (sp = PTR_ALIGN(state->orig_sp); sp; sp = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
 		if (get_stack_info(sp, state->task, &stack_info, &visit_mask))
 			break;
 
