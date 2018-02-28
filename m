From: kieran.bingham@ideasonboard.com (Kieran Bingham)
Date: Wed, 28 Feb 2018 20:42:57 +0000
Subject: RCar-H3-ES2.0: v4.16-rc1 (media tree) __handle_irq_event_percpu page
 fault
Message-ID: <f8fded28-3a59-3238-0768-7d81f089d365@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linux-ARM / Linux-Renesas-SoC

I had this page fault occur once, during testing of my current series.

It occurred once, and hasn't happened since, so perhaps just the direction the
wind was blowing. Posting to see if there is a known regression - or if anyone
else has hit similar, or so that it will come up in a google search if someone
else does :D


Has anyone else had a back trace similar to this on v4.16-rc1 ?


HW: RCar-H3 ES-2.0 platform.
SW: Linux media master branch + my development branch:

   git://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git
   tags/vsp1/tlb-optimise/v6

Don't be confused by the tag name 'tlb-optimise' - I'm not playing around with
any TLB code here - just reducing the number of allocations by creating a single
larger dma buffer in a media driver.

===========================================================


Welcome to Ubuntu 16.04 LTS (GNU/Linux
4.16.0-rc1-arm64-renesas-00166-ge0ad4e839fff aarch64)

root at Ubuntu-ARM64:~# [ 3894.054525] Unable to handle kernel paging request at
virtual address ffff000008ee7070
[ 3894.062527] Mem abort info:
[ 3894.065334]   ESR = 0x96000007
[ 3894.068403]   Exception class = DABT (current EL), IL = 32 bits
[ 3894.074348]   SET = 0, FnV = 0
[ 3894.077416]   EA = 0, S1PTW = 0
[ 3894.080573] Data abort info:
[ 3894.083469]   ISV = 0, ISS = 0x00000007
[ 3894.087323]   CM = 0, WnR = 0
[ 3894.090306] swapper pgtable: 4k pages, 48-bit VAs, pgd = 000000003440d0b1
[ 3894.097123] [ffff000008ee7070] *pgd=000000073fffe003, *pud=000000073fffd003,
*pmd=000000073fffa003, *pte=0000000000000000
[ 3894.108469] Internal error: Oops: 96000007 [#1] PREEMPT SMP
[ 3894.114070] Modules linked in:
[ 3894.117143] CPU: 0 PID: 15500 Comm: stress Tainted: G        W
4.16.0-rc1-arm64-renesas-00166-ge0ad4e839fff #240
[ 3894.127957] Hardware name: Renesas Salvator-X 2nd version board based on
r8a7795 ES2.0+ (DT)
[ 3894.136420] pstate: 60000085 (nZCv daIf -PAN -UAO)
[ 3894.141243] pc : __handle_irq_event_percpu+0x3e0/0x468
[ 3894.146403] lr : __handle_irq_event_percpu+0x3e0/0x468
[ 3894.151557] sp : ffff000008003e60
[ 3894.154880] x29: ffff000008003e60 x28: 0000000000000001
[ 3894.160213] x27: ffff8006fa99ac00 x26: ffff000009015000
[ 3894.165545] x25: ffff000008ee7010 x24: ffff000008003efc
[ 3894.170877] x23: ffff000008ee7010 x22: 0000000000000000
[ 3894.176210] x21: ffff000008f0fac0 x20: 0000000000000085
[ 3894.181543] x19: ffff8006f93e6e00 x18: 0000000000000a03
[ 3894.186876] x17: 0000ffff97c65e58 x16: 0000aaaad6f3ef00
[ 3894.192209] x15: 0000ffff97e5f000 x14: 00000000000003f3
[ 3894.197540] x13: 0000000000000000 x12: 00000000000003f3
[ 3894.202872] x11: 0000000000000018 x10: 0000000000000000
[ 3894.208206] x9 : ffff000009bfc000 x8 : ffff000008fb0000
[ 3894.213539] x7 : ffff0000087058d4 x6 : 00000000cbbdd6ed
[ 3894.218870] x5 : ffff8006f9976d68 x4 : ffff8006ffef0a80
[ 3894.224204] x3 : 0000000000000000 x2 : 0000000000000001
[ 3894.229536] x1 : 00000000ffffffff x0 : 0000000000000001
[ 3894.234871] Process stress (pid: 15500, stack limit = 0x00000000bee2ce9d)
[ 3894.241680] Call trace:
[ 3894.244143]  __handle_irq_event_percpu+0x3e0/0x468
[ 3894.248950]  handle_irq_event_percpu+0x28/0x60
[ 3894.253407]  handle_irq_event+0x50/0x80
[ 3894.257257]  handle_fasteoi_irq+0xa8/0x188
[ 3894.261369]  generic_handle_irq+0x34/0x50
[ 3894.265393]  __handle_domain_irq+0x68/0xc0
[ 3894.269505]  gic_handle_irq+0x60/0xb8
[ 3894.273181]  el0_irq_naked+0x50/0x5c
[ 3894.276771] Code: 97fff84d 17ffff4d f90033a1 94003205 (f94033a1)
[ 3894.282906] ---[ end trace 05f4c46a627d8e19 ]---
[ 3894.287540] Kernel panic - not syncing: Fatal exception in interrupt
[ 3894.293923] SMP: stopping secondary CPUs
[ 3894.297864] Kernel Offset: disabled
[ 3894.301364] CPU features: 0x1802000
[ 3894.304861] Memory Limit: none
[ 3894.307939] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
