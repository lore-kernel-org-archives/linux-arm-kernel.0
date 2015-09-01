From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 01 Sep 2015 19:30:53 +0200
Subject: Possible regression: module insertion, relocation misalignement
References: <87egil26sn.fsf@belgarion.home> <87vbbvysfc.fsf@belgarion.home>
 <20150831234638.GI21084@n2100.arm.linux.org.uk>
Message-ID: <87k2sayrle.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Tue, Sep 01, 2015 at 01:00:39AM +0200, Robert Jarzmik wrote:
>> [2] readelf -Sr pxa3xx_nand.ko
>> ==============================
>>   [12] __bug_table       PROGBITS        00000000 002232 000018 00   A  0   0  1
>
> This shows that the bug table has an alignment of 1, which is silly as
> it contains 32-bit values - this really ought to be indicating an
> alignment of 4.
>
> I notice that a bunch of my modules are the same as well.  Try adding
> ".align 2" into arch/arm/include/asm/bug.h, __BUG() macro, just after
> ".pushsection __bug_table" which should have the effect of increasing
> the alignment of the section.
Okay, I made the change, and tested it now I'm after work. Your fix does indeed
remove the problem.

> It probably hasn't been noticed on ARMv6 and later because they'll
> always fix up these relocations transparently.
>
> For ARMv5 and older, you really ought to have the alignment handler
> enabled - IP networking pretty much relies on this being present to
> catch corner cases (eg, with TCP options mis-aligning subsequent data.)
That is curious, because I have this in my configuration :
  #define CONFIG_ALIGNMENT_TRAP 1.
And yet it happens ... I will remove the fix and try to follow the data abort
path to understand why the alignment fault is not dealt with.

-- 
Robert

PS: This is the patch I have prepared, and which I'll send to the mailing list
once my testing tells me it fixes my issue.

--->8---
>From afc8eeab3cdedb749f4903385840f3b48e7dd75e Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Tue, 1 Sep 2015 11:03:04 +0200
Subject: [PATCH] ARM: fix alignement of __bug_table section entries

On old ARM chips, unaligned accesses to memory are not trapped and
fixed.  On module load, symbols are relocated, and the relocation of
__bug_table symbols is done on a u32 basis. Yet the section is not
aligned to a multiple of 4 address, but to a multiple of 2.

This triggers an Oops on pxa architecture, where address 0xbf0021ea
is the first relocation in the __bug_table section :
  apply_relocate(): pxa3xx_nand: section 13 reloc 0 sym ''
  Unable to handle kernel paging request at virtual address bf0021ea
  pgd = e1cd0000
  [bf0021ea] *pgd=c1cce851, *pte=c1cde04f, *ppte=c1cde01f
  Internal error: Oops: 23 [#1] ARM
  Modules linked in:
  CPU: 0 PID: 606 Comm: insmod Not tainted 4.2.0-rc8-next-20150828-cm-x300+ #887
  Hardware name: CM-X300 module
  task: e1c68700 ti: e1c3e000 task.ti: e1c3e000
  PC is at apply_relocate+0x2f4/0x3d4
  LR is at 0xbf0021ea
  pc : [<c000e7c8>]    lr : [<bf0021ea>]    psr: 80000013
  sp : e1c3fe30  ip : 60000013  fp : e49e8c60
  r10: e49e8fa8  r9 : 00000000  r8 : e49e7c58
  r7 : e49e8c38  r6 : e49e8a58  r5 : e49e8920  r4 : e49e8918
  r3 : bf0021ea  r2 : bf007034  r1 : 00000000  r0 : bf000000
  Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
  Control: 0000397f  Table: c1cd0018  DAC: 00000051
  Process insmod (pid: 606, stack limit = 0xe1c3e198)
  [<c000e7c8>] (apply_relocate) from [<c005ce5c>] (load_module+0x1248/0x1f5c)
  [<c005ce5c>] (load_module) from [<c005dc54>] (SyS_init_module+0xe4/0x170)
  [<c005dc54>] (SyS_init_module) from [<c000a420>] (ret_fast_syscall+0x0/0x38)

Fix this by ensuring entries in __bug_table are all aligned to at least
of multiple of 4. This transforms a module section  __bug_table as :
-   [12] __bug_table       PROGBITS        00000000 002232 000018 00   A  0   0  1
+   [12] __bug_table       PROGBITS        00000000 002232 000018 00   A  0   0  4

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/include/asm/bug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
index b274bde24905..e7335a92144e 100644
--- a/arch/arm/include/asm/bug.h
+++ b/arch/arm/include/asm/bug.h
@@ -40,6 +40,7 @@ do {								\
 		"2:\t.asciz " #__file "\n" 			\
 		".popsection\n" 				\
 		".pushsection __bug_table,\"a\"\n"		\
+		".align 2\n"					\
 		"3:\t.word 1b, 2b\n"				\
 		"\t.hword " #__line ", 0\n"			\
 		".popsection");					\
-- 
2.1.4
