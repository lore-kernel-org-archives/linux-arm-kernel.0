From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Tue, 28 Jun 2011 01:03:41 +0200
Subject: Missing volatile in hard_smp_processor_id.
Message-ID: <4E090C4D.1000309@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

all the versions of codesourcery from 2009q1 to 2010.09 optimize too
eagerly the calls to hard_smp_processor_id.

The following code:
#define hard_smp_processor_id()                                         \
	({                                                              \
		unsigned int cpunum;                                    \
		__asm__("\n"                                            \
			"1:     mrc p15, 0, %0, c0, c0, 5\n"            \
			"       .pushsection \".alt.smp.init\", \"a\"\n"\
			"       .long   1b\n"                           \
			"       mov     %0, #0\n"                       \
			"       .popsection"                            \
			: "=r" (cpunum));                               \
		cpunum &= 0x0F;                                         \
	})

static inline unsigned long arch_local_irq_save(void)
{
	unsigned long flags;

	asm volatile(
		"       mrs     %0, cpsr        @ arch_local_irq_save\n"
		"       cpsid   i"
		: "=r" (flags) : : "memory", "cc");
	return flags;
}

static inline void arch_local_irq_restore(unsigned long flags)
{
	asm volatile(
		"       msr     cpsr_c, %0      @ local_irq_restore"
		:
		: "r" (flags)
		: "memory", "cc");
}

struct thread_info {
	unsigned long flags;          /* low level flags */
	int           preempt_count;  /* 0 => preemptable, <0 => bug */
	unsigned      cpu;            /* cpu */
};

static inline struct thread_info *current_thread_info(void) __attribute__((const));

static inline struct thread_info *current_thread_info(void)
{
	register unsigned long sp asm ("sp");
	return (struct thread_info *)(sp & ~8191);
}

extern int printk(const char *fmt, ...);

void f(void)
{
	unsigned long flags;
	unsigned cpu0, cpu1;

	flags = arch_local_irq_save();
	cpu0 = hard_smp_processor_id();
	cpu1 = current_thread_info()->cpu;
	arch_local_irq_restore(flags);
	printk("cpu %d, %d\n", cpu0, cpu1);

	flags = arch_local_irq_save();
	cpu0 = hard_smp_processor_id();
	cpu1 = current_thread_info()->cpu;
	arch_local_irq_restore(flags);
	printk("cpu %d\n", cpu0, cpu1);
}

gives:
00000024 <f>:
  24:   e92d41f0        push    {r4, r5, r6, r7, r8, lr}
  28:   ebfffff4        bl      0 <arch_local_irq_save>
  2c:   ee104fb0        mrc     15, 0, r4, cr0, cr0, {5}
  30:   e204400f        and     r4, r4, #15
  34:   e1a07000        mov     r7, r0
  38:   ebfffff5        bl      14 <current_thread_info>
  3c:   e5906008        ldr     r6, [r0, #8]
  40:   e1a05000        mov     r5, r0
  44:   e1a00007        mov     r0, r7
  48:   ebffffef        bl      c <arch_local_irq_restore>
  4c:   e1a01004        mov     r1, r4
  50:   e1a02006        mov     r2, r6
  54:   e59f0020        ldr     r0, [pc, #32]   ; 7c <f+0x58>
  58:   ebfffffe        bl      0 <printk>
  5c:   ebffffe7        bl      0 <arch_local_irq_save>
  60:   e5955008        ldr     r5, [r5, #8]
  64:   ebffffe8        bl      c <arch_local_irq_restore>
  68:   e59f0010        ldr     r0, [pc, #16]   ; 80 <f+0x5c>
  6c:   e1a01004        mov     r1, r4
  70:   e1a02005        mov     r2, r5
  74:   e8bd41f0        pop     {r4, r5, r6, r7, r8, lr}
  78:   eafffffe        b       0 <printk>
  7c:   00000000        .word   0x00000000
  80:   0000000c        .word   0x0000000c

Where we see that the cpu number is read only once from cp15. This
is problematic, as a task may migrate as soon as irqs are on.

Adding a "volatile" to the inline assembly in hard_smp_processor_id()
fixes it.

I know hard_smp_processor_id() disappeared after Linux 2.6.37, but this
may be interesting for the stable and long term support branches. This
issue is suspected to cause random segmentation faults on OMAP4 with 
CONFIG_HIGHMEM on.

Regards.

-- 
                                                                Gilles.
