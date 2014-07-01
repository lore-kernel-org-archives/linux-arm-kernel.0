From: loeliger@gmail.com (Jon Loeliger)
Date: Tue, 1 Jul 2014 10:59:45 -0500
Subject: Some Large Address Space Ponders on A9
Message-ID: <CAJgR-BhNHYVYJo+jXAOCy+xzXP-AMjJ7LhuzssrQSEPQN4W=2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Folks,

I have a classic Cortex A9 based SoC in which I will need to
do some device driver development that will be capable of
addressing a physical address space larger than 32-bits.
I understand that the A9 doesn't support LPAE and that
pretending that it does and config'ing LPAE "on" will just
break six-ways-to-hell.

But I need to be able to specify some 64-bit addresses in
the Device Tree, and allow my device driver to manipulate
64-bit resource_size_t ranges.

Here's the problem.  Over in include/linux/types.h we find:

    #ifdef CONFIG_PHYS_ADDR_T_64BIT
    typedef u64 phys_addr_t;
    #else
    typedef u32 phys_addr_t;
    #endif

    typedef phys_addr_t resource_size_t;

So that means on my A9 system, phys_addr_t and resource_size_t
are either both 32-bit or both 64-bit.  I can't get just resource_size_t
to be 64-bit without some surgery here.

I've tried the obvious experiment of just config'ing up a
selection defining CONFIG_PHYS_ADDR_T_64BIT and seeing
if things work.  They don't; details below.

So, a few questions...

Should using a 64-bit phys_addr_t on an A9 "just work"?  Or is
this a new scenario never considered before?  Maybe a bug
due to this odd configuration that might need to be fixed?
Maybe some assumption of alignment, packed-ness
or sizes in some structure relating to context switching?

I think the device-tree handling code is able to grok and process
64-bit addresses.  Does it make sense to allow the phys_addr_t and
the resource_size_t to take on different sizes?  That is, to break the
above definition of resource_size_t from types.h and allow its size
to be determined independently of phys_addr_t?

Is there some easier (obvious even?) way to allow some DT devices to
use 64-bit resources and I've just missed it?

Thanks,
jdl


Failure mode details:

During boot, cpu_v7_switch_mm() gets handed an r1 with 0 in it
and dereferences it.  Here, in proc-v7-2level.S:

/*
 *    cpu_v7_switch_mm(pgd_phys, tsk)
 *
 *    Set the translation table base pointer to be pgd_phys
 *
 *    - pgd_phys - physical address of new TTB
 *
 *    It is assumed that:
 *    - we are not using split page tables
 */
ENTRY(cpu_v7_switch_mm)
#ifdef CONFIG_MMU
    mov    r2, #0
    mmid    r1, r1                @ get mm->context.id
    ALT_SMP(orr    r0, r0, #TTB_FLAGS_SMP)
    ALT_UP(orr    r0, r0, #TTB_FLAGS_UP)
#ifdef CONFIG_ARM_ERRATA_430973
    mcr    p15, 0, r2, c7, c5, 6        @ flush BTAC/BTB
#endif
#ifdef CONFIG_PID_IN_CONTEXTIDR
    mrc    p15, 0, r2, c13, c0, 1        @ read current context ID
    lsr    r2, r2, #8            @ extract the PID
    bfi    r1, r2, #8, #24            @ insert into new context ID
#endif
#ifdef CONFIG_ARM_ERRATA_754322
    dsb
#endif
    mcr    p15, 0, r1, c13, c0, 1        @ set context ID
    isb
    mcr    p15, 0, r0, c2, c0, 0        @ set TTB 0
    isb
#endif
    mov    pc, lr
ENDPROC(cpu_v7_switch_mm)



[    2.724891] devtmpfs: mounted
[    2.728262] Freeing unused kernel memory: 152K (c03df000 - c0405000)
[    2.736104] Unable to handle kernel NULL pointer dereference at
virtual address 00000178
[    2.744293] pgd = ede00000
[    2.747010] [00000178] *pgd=00000000
[    2.750637] Internal error: Oops: 5 [#1] SMP ARM
[    2.755259] Modules linked in:
[    2.758338] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
3.14.0-00019-g5f79c4b-dirty #380
[    2.766264] task: ee84c000 ti: ee858000 task.ti: ee858000
[    2.771679] PC is at cpu_v7_switch_mm+0x4/0x24
[    2.776139] LR is at flush_old_exec+0x3f0/0x514
[    2.780682] pc : [<c0018f64>]    lr : [<c00a8d5c>]    psr: 20000113
[    2.780682] sp : ee859ea8  ip : ede00000  fp : c0429698
[    2.792167] r10: ee84c314  r9 : eea4c800  r8 : eddf4000
[    2.797399] r7 : eeb78400  r6 : 00000000  r5 : ee84c000  r4 : c0415840
[    2.803932] r3 : 00000001  r2 : 00000000  r1 : 00000000  r0 : 2de00000
[    2.810466] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[    2.817782] Control: 10c5387d  Table: 0000404a  DAC: 00000015
[    2.823534] Process swapper/0 (pid: 1, stack limit = 0xee858240)
[    2.829547] Stack: (0xee859ea8 to 0xee85a000)
[    2.833917] 9ea0:                   05000002 ee8b96b4 ee8b9680
eeb78400 00000001 00000002
[    2.842109] 9ec0: ee004100 c00e1950 eeb78400 00000080 00000001
ee858000 00000000 eeb78400
[    2.850301] 9ee0: 00000001 beffffd3 ee004f00 eeff0075 eeb78400
c00a7d3c 00000017 ee859f0c
[    2.858491] 9f00: 00000000 0000000b befff000 ee859ec8 beffffc8
c0400fc8 0000000b 00000000
[    2.866683] 9f20: ef003000 eeb78400 c04177a4 c00e1698 00000001
c0417168 eddf4044 eddf4000
[    2.874874] 9f40: c0429698 c00a7e9c eeb78400 ee858000 ee81c000
00000000 00000001 c00a9498
[    2.883065] 9f60: c0410258 c04102e0 00000000 ee84c1fc 00000000
c04291c0 c0364a08 00000000
[    2.891255] 9f80: 00000000 00000000 00000000 00000000 00000000
c00086d4 00000000 c04291c0
[    2.899444] 9fa0: c02cb744 c02cb7bc 00000000 c000d918 00000000
00000000 00000000 00000000
[    2.907633] 9fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    2.915822] 9fe0: 00000000 00000000 00000000 00000000 00000013
00000000 ffffffff ffffffff
[    2.924029] [<c0018f64>] (cpu_v7_switch_mm) from [<ee858000>] (0xee858000)
[    2.930920] Code: 00000000 00000000 00000000 e3a02000 (e5911178)
[    2.937053] ---[ end trace 41f2c02886b01a23 ]---
