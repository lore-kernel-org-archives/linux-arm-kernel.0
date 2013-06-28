From: jonathan@jonmasters.org (Jon Masters)
Date: Thu, 27 Jun 2013 23:48:14 -0400
Subject: dummy_flush_tlb_a15_erratum in check_and_switch_context
Message-ID: <51CD077E.7040207@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Folks,

Post mostly for Google's benefit. Fedora folks were reporting the
following backtrace on Cortex-A8 OMAP:

[   12.182873] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
[   12.189971] Modules linked in: drm_kms_helper drm
[   12.194965] CPU: 0 PID: 153 Comm: dracut-initqueu Not tainted
3.10.0-0.rc7.git0.2.fc20.armv7hl #1
[   12.204317] task: c9ee9b80 ti: c9f50000 task.ti: c9f50000
[   12.210025] PC is at check_and_switch_context+0x3c0/0x44c
[   12.215724] LR is at check_and_switch_context+0x364/0x44c
[   12.221424] pc : [<c001dbd4>]    lr : [<c001db78>]    psr: 400f0093
[   12.221424] sp : c9f51e40  ip : 00000000  fp : c9ebe860
[   12.233532] r10: c08cb470  r9 : c08d97c8  r8 : c9ebe700
[   12.239044] r7 : 00000000  r6 : 00000200  r5 : 00000000  r4 : 00000201
[   12.245929] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000001
[   12.252817] Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment user
[   12.260436] Control: 10c5387d  Table: 80004019  DAC: 00000015
[   12.266497] Process dracut-initqueu (pid: 153, stack limit = 0xc9f50240)
[   12.273568] Stack: (0xc9f51e40 to 0xc9f52000)
[   12.278174] 1e40: c08cb478 00000000 00000200 00000000 200f0093
c08d853c c9f41e00 c9ebe380
[   12.286808] 1e60: 00000000 c9ee9b80 c0c7db80 c9f50000 c9eeb700
c9ebe700 c9f51f24 c05994b8
[   12.295440] 1e80: 00000004 c0250920 00000004 c0047954 d6266cd2
00000002 00000000 00000000
[   12.304074] 1ea0: 00000000 c0048854 c08cdb80 003b0000 d6266cd2
00000002 00006ae1 c007a670
[   12.312708] 1ec0: 00000139 00000000 0000b40e 0000b40e 00006a0d
c007a670 f5257d14 c0079274
[   12.321342] 1ee0: c9f41e00 00000000 00000003 0000081f c08ded98
bea94f88 c9f51fb0 000cf704
[   12.329976] 1f00: c9f51f84 c9f51f60 c9f50028 c9ee9b80 00000000
c9f51f78 fffffff6 c9f50000
[   12.338598] 1f20: c9f50000 c0048854 c9ee9dcc c9eeb700 c9f51f38
c9ee9e14 00000000 00000000
[   12.347220] 1f40: 00000004 00000000 00000000 bea951a8 c9f50000
00000000 000d6d64 c004988c
[   12.355841] 1f60: 00000003 00000004 00000000 00000000 bea951a8
00000000 00000000 c9ee9b80
[   12.364463] 1f80: c0047438 c9eeedd0 c9eeedd0 00000000 00000000
bea951a8 ffffffff 00000072
[   12.373084] 1fa0: c000e344 c000e1a0 00000000 bea951a8 ffffffff
bea951a8 00000000 00000000
[   12.381705] 1fc0: 00000000 bea951a8 ffffffff 00000072 000cf704
000d6094 00000000 000d6d64
[   12.390328] 1fe0: 000cf164 bea95158 00045180 b6e37ae0 600f0010
ffffffff 2d10a02c c8542a0a
[   12.398987] [<c001dbd4>] (check_and_switch_context+0x3c0/0x44c) from
[<c05994b8>] (__schedule+0x4ac/0x750)
[   12.409193] [<c05994b8>] (__schedule+0x4ac/0x750) from [<c0048854>]
(do_wait+0x1ec/0x244)
[   12.417834] [<c0048854>] (do_wait+0x1ec/0x244) from [<c004988c>]
(SyS_wait4+0xa8/0xc8)
[   12.426206] [<c004988c>] (SyS_wait4+0xa8/0xc8) from [<c000e1a0>]
(ret_fast_syscall+0x0/0x30)
[   12.435116] Code: 1e082f13 f57ff04f f57ff06f e3a03000 (ee083f33)
[   12.441552] ---[ end trace c0816de7f5b496a8 ]---

I disassembled that faulting instruction manually just now, and it
appears to be:

1110 1110 000  0 1000 0011 1111   001  1  0011
          opc1   CRn  Rt   coproc opc2    CRm

MCR cp15, 0, r3, c8, c3, 1

Which maps back to the call to dummt_flush_tlb_a15_erratum in
check_and_switch_context:

#ifdef CONFIG_ARM_ERRATA_798181
static inline void dummy_flush_tlb_a15_erratum(void)
{
        /*
         * Dummy TLBIMVAIS. Using the unmapped address 0 and ASID 0.
         */
        asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (0));
        dsb();
}
#else
static inline void dummy_flush_tlb_a15_erratum(void)
{
}
#endif

Now I think it's personally just easier to only turn on that errata on
LPAE/A15 kernels and just leave it at that (I've requested this get
moved to the lpae config and out of the base config so this is what
should happen shortly - clearly the intention), but some folks out there
want to do exciting things...I got asked if this could be runtime
patched (which I guess in theory is possible), but I'm not going there.

Anyway, in addition, does this kind of thing need fixing with a more
specific Kconfig so that there's an explicit A15 dependency in there?
Rather just "depends on CPU_V7 && SMP"?

Jon.
