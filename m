From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 21 Nov 2010 19:11:48 +0000
Subject: Weirdo gcc 4.3.x behaviour
Message-ID: <20101121191148.GA12234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Has anyone else seen weird behaviour from the gcc 4.3 branch?

I've tried gcc-4.3.2 + patch and also gcc-4.3.5, both of which behave
differently with this change in the kernel:

(asm-generic/pgtable-nopud.h)
static inline int pgd_none(pgd_t pgd)           { return 0; }
static inline int pgd_bad(pgd_t pgd)            { return 0; }
static inline int pgd_present(pgd_t pgd)        { return 1; }

and subsequently adding:
+#define pgd_none(pgd)          0
+#define pgd_bad(pgd)           0
+#define pgd_present(pgd)       1

This causes completely unrelated functions to be optimized differently,
as can be seen via the bloat-o-meter:

add/remove: 0/0 grow/shrink: 3/1 up/down: 20/-4 (16)
function                                     old     new   delta
shmem_file_aio_read                          820     832     +12
select_task_rq_fair                         1824    1828      +4
kswapd                                      1816    1820      +4
elf_core_dump                               3264    3260      -4

The strange thing is that (eg) elf_core_dump() doesn't use any of these
macros - and the changes seem to be completely unrelated too:

c00f8cc8:       ea00018c        b       c00f9300 <elf_core_dump+0xc38>
c00f8ccc:       e3a05000        mov     r5, #0  ; 0x0
c00f8cd0:       e50b508c        str     r5, [fp, #-140]
c00f8cd4:       e50b5088        str     r5, [fp, #-136]
c00f8cd8:       ea000167        b       c00f927c <elf_core_dump+0xbb4>

vs

c00f8cb4:       ea00018d        b       c00f92f0 <elf_core_dump+0xc3c>
c00f8cb8:       e3a00000        mov     r0, #0  ; 0x0
c00f8cbc:       e1a05000        mov     r5, r0
c00f8cc0:       e50b008c        str     r0, [fp, #-140]
c00f8cc4:       e50b0088        str     r0, [fp, #-136]
c00f8cc8:       ea000167        b       c00f926c <elf_core_dump+0xbb8>

and:

c00f8d18:       e1a08000        mov     r8, r0
c00f8d1c:       e2580000        subs    r0, r8, #0      ; 0x0
c00f8d20:       e50b008c        str     r0, [fp, #-140]
c00f8d24:       050b0088        streq   r0, [fp, #-136]
c00f8d28:       0a00013e        beq     c00f9228 <elf_core_dump+0xb60>

vs

c00f8d08:       e1a08000        mov     r8, r0
c00f8d0c:       e2581000        subs    r1, r8, #0      ; 0x0
c00f8d10:       e50b108c        str     r1, [fp, #-140]
c00f8d14:       050b1088        streq   r1, [fp, #-136]
c00f8d18:       0a00013e        beq     c00f9218 <elf_core_dump+0xb64>

The changes seem to be minor register allocation differences, but what
worries me is why should this change when these functions don't go
anywhere near the page table accessors.

I've had these kinds of changes happen in snd_pcm_hw_rule_ratdens(),
which definitely has nothing to do with page tables as a result of
changing the way page tables are accessed.

The issue here is that with this noise created by the compiler, it's
not possible to properly evaluate the effect of these kinds of changes
to the page tables - and I'm wondering if this could be related to the
mysterious crashes and MMC read corruption I've seen on Versatile due
to the L2x0 changes which have been appearing and disappearing on me
recently.

What I'm worried about is if unrelated functions can influence the
optimization of following functions, is it possible that some
optimizations are mis-applied, leading to incorrect code generation -
which would make gcc 4.3 an untrustworthy compiler.
