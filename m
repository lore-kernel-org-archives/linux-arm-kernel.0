From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Sep 2015 15:25:19 +0100
Subject: [PATCH] ARM: fix alignement of __bug_table section entries
In-Reply-To: <878u8lx9hl.fsf@belgarion.home>
References: <1441175009-26730-1-git-send-email-robert.jarzmik@free.fr>
 <20150902103955.GF6281@e103592.cambridge.arm.com>
 <878u8lx9hl.fsf@belgarion.home>
Message-ID: <20150905142519.GN21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 05, 2015 at 03:48:38PM +0200, Robert Jarzmik wrote:
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > On Wed, Sep 02, 2015 at 08:23:29AM +0200, Robert Jarzmik wrote:
> >> On old ARM chips, unaligned accesses to memory are not trapped and
> >> fixed.  On module load, symbols are relocated, and the relocation of
> >> __bug_table symbols is done on a u32 basis. Yet the section is not
> >> aligned to a multiple of 4 address, but to a multiple of 2.
> 
> Hi Russell,
> 
> I dug deeper, and got another stack, unrelated to modules insertion but related
> to alignement fault (see [1] for reference). As before, this didn't happen on
> v4.1, but happens on linux-next.
> I'm wondering if alignement fixup does work in my case and if I understand it.
> 
> This time I took my JTAG to have a look at the flow, in arch/arm/mm/alignment.c,
> where I added the small chunk in [2], which gave in my case :
>     RJK: fault=4 instr=0x00000000 instrptr=0xc02b37c8 thumb_mode=0 tinstr=0x0000

Right, so as fault is nonzero, this means that we were unable to read the
instruction.  That seems mad though - the instruction pointer is certainly
valid, and as we're using probe_kernel_address(), that switches to the
kernel "segment" before trying to read kernel addresses.  That should
mean that __copy_from_user_inatomic() is able to read the instruction.

I think this is the root cause of the issue.

> The instruction (as seen with vmlinux disassembly or JTAG memory dump) is  :
>     0xc02b37c8 <+372>:	b2 50 c6 10	strhne	r5, [r6], #2
> 
> I must admit I fail to see how the following "fixup:" label can be reached with
> a "missed" copy_from_user() (fault == 4).

We can't fix up the fault if we failed to read the instruction causing the
fault - because we've no idea what register(s) will need updating.

> [1] New stack
> =============
>   #0: pxa2xx-ac97 (Wolfson WM9713,WM9714)
> RJK: fault=4 instr=0x00000000 instrptr=0xc02b37c8 thumb_mode=0 tinstr=0x0000
> &Unable to handle kernel paging request at virtual address c3057661
> &pgd = c0004000
> "[c3057661] *pgd=a300040e(bad)
> Internal error: Oops: 803 [#1] PREEMPT ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.2.0-rc8-next-20150828+ #900
> Hardware name: MIO A701
> task: c3858bc0 ti: c385c000 task.ti: c385c000
> PC is at doc_read_data_area+0x174/0x370
> LR is at doc_read_page_getbytes+0x58/0x78
> pc : [<c02b37c8>]    lr : [<c02b3a1c>]    psr: a8000013
> sp : c385d8e0  ip : c07142b8  fp : c385d91c
> r10: c3aac540  r9 : c070ffc0  r8 : c385c000
> @QGi
> r7 : 00000002  r6 : c3057661  r5 : 0000c1e5  r4 : 0000000b
> r3 : 0000000a  r2 : 0000000b  r1 : c3057661  r0 : 00000000
> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none

It seems you have SW_DOMAIN_PAN enabled.

> Control: 0000397f  Table: a0004000  DAC: 00000053

And the DACR for the parent context shows that user no-access, kernel
manager-access (iow, in the doc_read_data_area() function).  I have to
wonder why that would be the case - I can't find anything that would
set the kernel to manager-access.  There's no get_ds() or KERNEL_DS
reference in fs/ubifs or drivers/mtd.

> [3] Abort stack
> ===============
> #0  panic (fmt=0xc385d6c4 <incomplete sequence \344>) at kernel/panic.c:72
> #1  0xc000e788 in oops_end (regs=<optimized out>, signr=<optimized out>, flags=<optimized out>) at arch/arm/kernel/traps.c:311
> #2  die (str=0x68000013 "", regs=<optimized out>, err=-1014638958) at arch/arm/kernel/traps.c:333
> #3  0xc00137c0 in __do_kernel_fault (mm=0xc06e8c04 <init_mm>, addr=3271915105, fsr=2051, regs=0xc385d890) at arch/arm/mm/fault.c:150
> #4  0xc0013b10 in do_bad_area (addr=<optimized out>, fsr=<optimized out>, regs=<optimized out>) at arch/arm/mm/fault.c:198
> #5  0xc00166c8 in do_alignment (addr=3271915105, fsr=2051, regs=0xc385d890) at arch/arm/mm/alignment.c:900
> #6  0xc0009264 in do_DataAbort (addr=3271915105, fsr=2051, regs=0xc385d890) at arch/arm/mm/fault.c:550
> #7  0xc000f024 in __dabt_svc () at arch/arm/kernel/entry-armv.S:204

I'm afraid this isn't useful, and I think (as seems to be typical with gdb)
some of those values are completely wrong.  There's no way "str" would
be 0x68000013 in frame 2 for example.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
