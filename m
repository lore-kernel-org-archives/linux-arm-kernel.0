From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sun, 29 Jan 2017 15:42:55 +0530
Subject: next-20170125 hangs on aarch64
Message-ID: <20170129101255.GA29415@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I pulled next-20170125 kernel, and found it hanged on boot. The exact reason is
panic on dereferencing of the 0xffffffc8 address, which is most probably the
attempt to dereference the ENOSYS error code as the address. next-20170124 works
fine, at least it boots.

Does anyone have details on that?

Yury

#0  arch_counter_get_cntvct () at
./arch/arm64/include/asm/arch_timer.h:151
#1  __delay (cycles=1024) at arch/arm64/lib/delay.c:31
#2  0xffff00000838b430 in __const_udelay (xloops=<optimized out>) at
arch/arm64/lib/delay.c:41
#3  0xffff00000816a894 in panic (fmt=<optimized out>) at
kernel/panic.c:295
#4  0xffff0000080c1238 in do_exit (code=11) at kernel/exit.c:780
#5  0xffff0000080888f0 in die (str=<optimized out>, 
    regs=0xffff000008d63d30 <init_thread_union+15664>, err=<optimized out>)
    at arch/arm64/kernel/traps.c:295
#6  0xffff0000080998c4 in __do_kernel_fault (mm=0x0, addr=4294967240, esr=2483027972, 
    regs=0xffff000008d63d30 <init_thread_union+15664>) at arch/arm64/mm/fault.c:185
#7  0xffff000008097244 in __do_kernel_fault (regs=<optimized out>, esr=<optimized out>, 
     addr=<optimized out>, mm=<optimized out>) at arch/arm64/mm/fault.c:419
#8  do_page_fault (addr=4294967240, esr=2483027972, 
    regs=0xffff000008d63d30 <init_thread_union+15664>) at arch/arm64/mm/fault.c:443
#9  0xffff000008097334 in do_translation_fault (addr=<optimized out>, esr=<optimized out>, 
    regs=<optimized out>) at arch/arm64/mm/fault.c:469
#10 0xffff000008081298 in do_mem_abort (addr=4294967240, esr=2483027972, 
    regs=0xffff000008d63d30 <init_thread_union+15664>) at arch/arm64/mm/fault.c:577
#11 0xffff000008082604 in el1_sync () at arch/arm64/kernel/entry.S:438
#12 0xffff000008082604 in el1_sync () at arch/arm64/kernel/entry.S:438
[...]
