From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 05 Sep 2015 15:48:38 +0200
Subject: [PATCH] ARM: fix alignement of __bug_table section entries
In-Reply-To: <20150902103955.GF6281@e103592.cambridge.arm.com> (Dave Martin's
 message of "Wed, 2 Sep 2015 11:39:56 +0100")
References: <1441175009-26730-1-git-send-email-robert.jarzmik@free.fr>
 <20150902103955.GF6281@e103592.cambridge.arm.com>
Message-ID: <878u8lx9hl.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Martin <Dave.Martin@arm.com> writes:

> On Wed, Sep 02, 2015 at 08:23:29AM +0200, Robert Jarzmik wrote:
>> On old ARM chips, unaligned accesses to memory are not trapped and
>> fixed.  On module load, symbols are relocated, and the relocation of
>> __bug_table symbols is done on a u32 basis. Yet the section is not
>> aligned to a multiple of 4 address, but to a multiple of 2.

Hi Russell,

I dug deeper, and got another stack, unrelated to modules insertion but related
to alignement fault (see [1] for reference). As before, this didn't happen on
v4.1, but happens on linux-next.
I'm wondering if alignement fixup does work in my case and if I understand it.

This time I took my JTAG to have a look at the flow, in arch/arm/mm/alignment.c,
where I added the small chunk in [2], which gave in my case :
    RJK: fault=4 instr=0x00000000 instrptr=0xc02b37c8 thumb_mode=0 tinstr=0x0000

The instruction (as seen with vmlinux disassembly or JTAG memory dump) is  :
    0xc02b37c8 <+372>:	b2 50 c6 10	strhne	r5, [r6], #2

I must admit I fail to see how the following "fixup:" label can be reached with
a "missed" copy_from_user() (fault == 4).

This is probably what happened to me with the modules __bug_table section, and
it will continue to happen until I understand why this copy fails. It's really
odd nobody but me faces this issue.

Cheers.

-- 
Robert

[1] New stack
=============
  #0: pxa2xx-ac97 (Wolfson WM9713,WM9714)
RJK: fault=4 instr=0x00000000 instrptr=0xc02b37c8 thumb_mode=0 tinstr=0x0000
&Unable to handle kernel paging request at virtual address c3057661
&pgd = c0004000
"[c3057661] *pgd=a300040e(bad)
Internal error: Oops: 803 [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.2.0-rc8-next-20150828+ #900
Hardware name: MIO A701
task: c3858bc0 ti: c385c000 task.ti: c385c000
PC is at doc_read_data_area+0x174/0x370
LR is at doc_read_page_getbytes+0x58/0x78
pc : [<c02b37c8>]    lr : [<c02b3a1c>]    psr: a8000013
sp : c385d8e0  ip : c07142b8  fp : c385d91c
r10: c3aac540  r9 : c070ffc0  r8 : c385c000
@QGi
r7 : 00000002  r6 : c3057661  r5 : 0000c1e5  r4 : 0000000b
r3 : 0000000a  r2 : 0000000b  r1 : c3057661  r0 : 00000000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 0000397f  Table: a0004000  DAC: 00000053
Process swapper (pid: 1, stack limit = 0xc385c198)
Stack: (0xc385d8e0 to 0xc385e000)
d8e0: 00000000 c02b3a34 00000001 0000000a c385d914 c3057660 0000000c c3aac540
... chop chop ...
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 f3ff8cdd 4cf3d76f
[<c02b37c8>] (doc_read_data_area) from [<c02b3a1c>] (doc_read_page_getbytes+0x58/0x78)
[<c02b3a1c>] (doc_read_page_getbytes) from [<c02b5f20>] (doc_read_oob+0x22c/0x75c)
[<c02b5f20>] (doc_read_oob) from [<c02b64b4>] (doc_read+0x64/0x74)
[<c02b64b4>] (doc_read) from [<c02ade08>] (part_read+0x58/0x9c)
[<c02ade08>] (part_read) from [<c02aa8d8>] (mtd_read+0x88/0xbc)
[<c02aa8d8>] (mtd_read) from [<c02c35ec>] (ubi_io_read+0x16c/0x358)
[<c02c35ec>] (ubi_io_read) from [<c02c0450>] (ubi_eba_read_leb+0x384/0x4d4)
[<c02c0450>] (ubi_eba_read_leb) from [<c02bf944>] (ubi_leb_read+0xd4/0x134)
[<c02bf944>] (ubi_leb_read) from [<c0185e9c>] (ubifs_leb_read+0x3c/0xa8)s
[<c0185e9c>] (ubifs_leb_read) from [<c019fd94>] (ubifs_read_nnode+0xec/0x200)
[<c019fd94>] (ubifs_read_nnode) from [<c01a03a0>] (ubifs_lpt_lookup_dirty+0x38/0x330)
[<c01a03a0>] (ubifs_lpt_lookup_dirty) from [<c0190448>] (ubifs_replay_journal+0x3c/0x1b38)
[<c0190448>] (ubifs_replay_journal) from [<c0182c38>] (ubifs_mount+0x1444/0x2410)
[<c0182c38>] (ubifs_mount) from [<c00eb604>] (mount_fs+0x24/0xb0)
[<c00eb604>] (mount_fs) from [<c01081d0>] (vfs_kern_mount+0x58/0x124)
[<c01081d0>] (vfs_kern_mount) from [<c010b384>] (do_mount+0xb40/0xd10)
[<c010b384>] (do_mount) from [<c010b8a8>] (SyS_mount+0x84/0xb0)
[<c010b8a8>] (SyS_mount) from [<c068319c>] (mount_block_root+0x12c/0x2dc)
[<c068319c>] (mount_block_root) from [<c0683564>] (prepare_namespace+0x98/0x1bc)
[<c0683564>] (prepare_namespace) from [<c0682eb4>] (kernel_init_freeable+0x188/0x1d4)
[<c0682eb4>] (kernel_init_freeable) from [<c04a2610>] (kernel_init+0x18/0xfc)
[<c04a2610>] (kernel_init) from [<c000a5ec>] (ret_from_fork+0x14/0x28)
Code: 1a000060 e51b3030 e3560000 e2877002 (10c650b2) 
---[ end trace a0bcca195299a22d ]---

[2] Debug patch
===============
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 2c0c541c60ca..b0897da5456c 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -787,6 +787,8 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
                instr = __mem_to_opcode_arm(instr);
        }
 
+       pr_info("RJK: fault=%d instr=0x%08lx instrptr=0x%08lx thumb_mode=%lu tinstr=0x%04x\n",
+               fault, instr, instrptr, thumb_mode(regs), tinstr);
        if (fault) {
                type = TYPE_FAULT;
                goto bad_or_fault;

[3] Abort stack
===============
#0  panic (fmt=0xc385d6c4 <incomplete sequence \344>) at kernel/panic.c:72
#1  0xc000e788 in oops_end (regs=<optimized out>, signr=<optimized out>, flags=<optimized out>) at arch/arm/kernel/traps.c:311
#2  die (str=0x68000013 "", regs=<optimized out>, err=-1014638958) at arch/arm/kernel/traps.c:333
#3  0xc00137c0 in __do_kernel_fault (mm=0xc06e8c04 <init_mm>, addr=3271915105, fsr=2051, regs=0xc385d890) at arch/arm/mm/fault.c:150
#4  0xc0013b10 in do_bad_area (addr=<optimized out>, fsr=<optimized out>, regs=<optimized out>) at arch/arm/mm/fault.c:198
#5  0xc00166c8 in do_alignment (addr=3271915105, fsr=2051, regs=0xc385d890) at arch/arm/mm/alignment.c:900
#6  0xc0009264 in do_DataAbort (addr=3271915105, fsr=2051, regs=0xc385d890) at arch/arm/mm/fault.c:550
#7  0xc000f024 in __dabt_svc () at arch/arm/kernel/entry-armv.S:204

[4] frame #6 regs dump
======================
$1 = {uregs = {0, 3271915105, 11, 10, 11, 49637, 3271915105, 2, 3280322560, 3228630976, 3282748736, 3280328988, 3228648120, 3280328928, 3224058396, 3224057800, 2818572307, 
    4294967295}}
