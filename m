From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 25 Jul 2013 18:54:56 +0100
Subject: [PATCH 1/2] ARM: Correct BUG() assembly to ensure it is
 endian-agnostic
In-Reply-To: <51F14CAF.5010602@codethink.co.uk>
References: <1374763357-4893-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374763357-4893-2-git-send-email-ben.dooks@codethink.co.uk>
 <20130725155700.GD2546@localhost.localdomain>
 <51F14CAF.5010602@codethink.co.uk>
Message-ID: <20130725175456.GF2546@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 05:05:03PM +0100, Ben Dooks wrote:
> On 25/07/13 16:57, Dave Martin wrote:
> >On Thu, Jul 25, 2013 at 03:42:36PM +0100, Ben Dooks wrote:
> >>Currently BUG() uses .word or .hword to create the necessary illegal
> >>instructions. However if we are building BE8 then these get swapped
> >>by the linker into different illegal instructions in the text.
> >
> >In the case of Thumb, the resulting instruction is actually not illegal,
> >which is even worse...
> >
> >>Change to using .inst and .inst.w to create the instructions and mark
> >>them as instructions so that the linker acts correctly.
> >>
> >>Signed-off-by: Ben Dooks<ben.dooks@codethink.co.uk>
> >>---
> >>  arch/arm/include/asm/bug.h |    4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
> >>index 7af5c6c..b95da52 100644
> >>--- a/arch/arm/include/asm/bug.h
> >>+++ b/arch/arm/include/asm/bug.h
> >>@@ -12,10 +12,10 @@
> >>   */
> >>  #ifdef CONFIG_THUMB2_KERNEL
> >>  #define BUG_INSTR_VALUE 0xde02
> >>-#define BUG_INSTR_TYPE ".hword "
> >>+#define BUG_INSTR_TYPE ".inst.w "
> >>  #else
> >>  #define BUG_INSTR_VALUE 0xe7f001f2
> >>-#define BUG_INSTR_TYPE ".word "
> >>+#define BUG_INSTR_TYPE ".inst "
> >>  #endif
> >
> >There was some uncertainty a while ago about precisely which versions of
> >gas support .inst.
> >
> ><asm/opcodes.h>  implements an abstracted workaround for this issue,
> >whereby you can emit instructions using the __inst*() macros, and
> >the swabbing and assembler directives should be generated for you.
> >
> >The patch below ought to do this for BUG(), but I've only briefly
> >build-tested it.
> >
> >
> >Note that the disassembly of the injected instructions in .o files
> >can be a bit confusing, because they are marked as data, do ld --be8
> >doesn't swab them (unlike the instructions, which do get swabbed).
> >objdump may also do extra swabbing during disassembly.
> >
> >You can sanity-check what is really in the image by dumping the text
> >section of vmlinux with objdump -s.
> >
> >
> >The change to<asm/opcodes.h>  is due to a missing include which is
> >really required for correctness, but which didn't show up without
> >the<asm/bug.h>  change (this causes opcodes.h to get included way
> >more often than is otherwise the case).
> >
> >Cheers
> >---Dave
> 
> Given it was added ~2006 according the mailing lists I have seen, then
> it should be ok to use for building modern kernels with. I think the
> use of .inst and .inst.w is a better solution than having the code
> having bits of it marked as data.

Of course it is.  But this discussion can be decoupled from bug.h:
if we decide to migrate to .inst, we can do that in one place in
opcodes.h, no?

Otherwise, we have multiple fixes to apply when we decide to make
that change.

Cheers
---Dave
