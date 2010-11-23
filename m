From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Nov 2010 08:56:49 +0000
Subject: [PATCH v2 8/9] ARM: Thumb-2: Fix long-distance conditional
	branches in head.S for Thumb-2.
In-Reply-To: <alpine.LFD.2.00.1011221918230.9313@xanadu.home>
References: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
	<1290449065-28843-9-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1011221346170.9313@xanadu.home>
	<20101122191719.GO31227@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1011221512460.9313@xanadu.home>
	<20101122234427.GP31227@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1011221918230.9313@xanadu.home>
Message-ID: <20101123085649.GA17561@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 22, 2010 at 07:26:51PM -0500, Nicolas Pitre wrote:
> On Mon, 22 Nov 2010, Russell King - ARM Linux wrote:
> 
> > On Mon, Nov 22, 2010 at 03:24:11PM -0500, Nicolas Pitre wrote:
> > > On Mon, 22 Nov 2010, Russell King - ARM Linux wrote:
> > > > No, you're not thinking right.  It was _intentional_ that __error_p
> > > > ended up in a different section to __init.  With CPU hotplug, as it
> > > > is called from the hotplug CPU initialization path, it needs to be
> > > > available for that path to call.
> > > 
> > > Well... agreed for the hotplug CPU case.  The section selection is good 
> > > as it is for that.
> > > 
> > > However I doubt this was intentional when commit 75d90832d5 was created, 
> > > which is when the actual section move took place.
> > 
> > Well, T2 is not something I particularly test for.  There's already too
> > many combinations to test as it is.
> 
> Fair enough.  My point was only about the unintentional drop of the 
> __init section attribute for the __error_p and __error_a functions (and 
> probably some others in head-common.S) from commit 75d9083 which is 
> orthogonal to the T2 issue.

What are you talking about Nicolas?

75d9083 is about adding nommu support, which was added some 4 years ago
well before Thumb 2 was talked about.  It moves some code out of head.S,
and creates a new file, head-common.S to contain this code.  head-common.S
is included by head.S, which means the assembler sees it as a single file.

And to prove the point, this is what head.o looks like immediately after
commit 75d9083:

00000000 l    d  .text  00000000 .text
00000000 l    d  .data  00000000 .data
00000000 l    d  .bss   00000000 .bss
00000000 l    d  .init.text     00000000 .init.text
00000000 g     F .init.text     00000000 stext
00000030 l     F .init.text     00000000 __enable_mmu
00000060 l     F .init.text     00000000 __turn_mmu_on
00000078 l     F .init.text     00000000 __create_page_tables
00000118 l     O .init.text     00000000 __switch_data
0000013c l     F .init.text     00000000 __mmap_switched
00000180 l     F .init.text     00000000 __error_p
0000018c l       .init.text     00000000 str_p1
000001c4 l     F .init.text     00000000 __error_a
00000230 l       .init.text     00000000 str_a1
00000265 l       .init.text     00000000 str_a2
00000294 l       .init.text     00000000 str_a3
000002cc l     F .init.text     00000000 __error
000002d4 l     F .init.text     00000000 __lookup_processor_type
0000030c g       .init.text     00000000 lookup_processor_type
00000334 l     F .init.text     00000000 __lookup_machine_type
00000368 g       .init.text     00000000 lookup_machine_type
c0004000 g       *ABS*  00000000 swapper_pg_dir

As you can see, everything after this commit is in the .init.text section,
including the __error_p and __error_a functions.
