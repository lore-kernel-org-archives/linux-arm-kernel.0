From: wuqixuan@huawei.com (Wuqixuan)
Date: Wed, 9 Apr 2014 01:22:04 +0000
Subject: Help for doubt about why update SCTLR by cr_alignment every
 syscall,IRQ,exception ?
Message-ID: <BB7C62C2B0732E4DA93834A501E846456C8F16B0@szxema505-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 05, 2014 at 5:43:00 PM +0800, Russell King wrote:

> This code in arch/arm/kernel/head-common.S:
> 
>         bicne   r4, r0, #CR_A                   @ Clear 'A' bit
>         stmneia r7, {r0, r4}                    @ Save control register values
> saves different values to cr_alignment and cr_no_alignment.  One always
> has the A bit cleared, the other may have the A bit set.
> For ARMv5 and older, we must have the A bit set while in the kernel so
> misaligned loads are aborted, so that they can be fixed up.  This
> behaviour is relied upon by the networking code amongst other places.

Thank you very much for your reply, King. 

Our chip is ARMv7, as per our observation, the cr_alignment and cr_no_alignment are the same, i think it's below code cause it: 

static int __init alignment_init(void) {
...
 /*
  * ARMv6 and later CPUs can perform unaligned accesses for
  * most single load and store instructions up to word size.
  * LDM, STM, LDRD and STRD still need to be handled.
  *
  * Ignoring the alignment fault is not an option on these
  * CPUs since we spin re-faulting the instruction without
  * making any progress.
  */         /*Actually, above comments are copied from 2.6.34, and code is from 3.10.18 */
#ifdef CONFIG_CPU_CP15
 if (cpu_is_v6_unaligned()) {
  cr_alignment &= ~CR_A;
  cr_no_alignment &= ~CR_A;
  set_cr(cr_alignment);
  ai_usermode = safe_usermode(ai_usermode, false);
 }
#endif
...
}

static bool cpu_is_v6_unaligned(void){
 return cpu_architecture() >= CPU_ARCH_ARMv6 && (cr_alignment & CR_U);
}

So whether it means:

1. In ARMv7 or later CPUs, CPU has the ability to handle the alignment automatically for some case, so cr_alignment and cr_no_alignment are the same, both clearing the A bit. 

2. Remove the updation for SCTLR every syscall,IRQ,exception has no risk. 
Second question is important for us, because the instruction of updation is too slow(about 100 cycles) in our chip, we want to remove the updation instruction for low latency reason, so need your opinion. 

Regards and Thanks a lot.
Wuqixuan. 
