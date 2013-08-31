From: jochen.armkernel@leahnim.org (Jochen De Smet)
Date: Sat, 31 Aug 2013 12:31:44 -0400
Subject: Undefined instruction (ldrshtgt?) on mirabox with 3.11-rc7
Message-ID: <52221A70.5060707@leahnim.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Not subscribed, so please keep me on CC]

Running on a mirabox (armada-370), stock 3.11-rc7 kernel, on fedora 19
with gcc:

$ gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/armv7hl-redhat-linux-gnueabi/4.7.2/lto-wrapper
Target: armv7hl-redhat-linux-gnueabi
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man 
--infodir=/usr/share/info 
--with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-bootstrap 
--enable-shared --enable-threads=posix --enable-checking=release 
--disable-build-with-cxx --disable-build-poststage1-with-cxx 
--with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions 
--enable-gnu-unique-object --enable-linker-build-id 
--with-linker-hash-style=gnu 
--enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto 
--enable-plugin --enable-initfini-array --enable-java-awt=gtk 
--disable-dssi --with-java-home=/usr/lib/jvm/java-1.5.0-gcj-1.5.0.0/jre 
--enable-libgcj-multifile --enable-java-maintainer-mode 
--with-ecj-jar=/usr/share/java/eclipse-ecj.jar 
--disable-libjava-multilib --with-ppl --with-cloog 
--disable-sjlj-exceptions --with-cpu=cortex-a8 --with-tune=cortex-a8 
--with-arch=armv7-a --with-float=hard --with-fpu=vfpv3-d16 
--with-abi=aapcs-linux --build=armv7hl-redhat-linux-gnueabi
Thread model: posix
gcc version 4.7.2 20121109 (Red Hat 4.7.2-8) (GCC)


Running into this oops:

[54580.094832] Internal error: Oops - undefined instruction: 0 [#1] ARM
[54580.101207] Modules linked in: sha1_generic drbd lru_cache dlm sctp 
configfs raid1 md_mod iscsi_tcp libiscsi_tcp libiscsi 
scsi_transport_iscsi ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat 
iptable_mangle ipt_REJECT xt_conntrack ebtable_filter ebtables 
iptable_filter ip_tables ext3 jbd ftdi_sio usbserial autofs4 ext4 jbd2 
mbcache sd_mod usb_storage mmc_block xhci_hcd mvsdio mmc_core ehci_orion
[54580.136437] CPU: 0 PID: 0 Comm: swapper Not tainted 3.11.0-rc7-stock2 #30
[54580.143239] task: c03f9540 ti: c03ee000 task.ti: c03ee000
[54580.148658] PC is at quirk_usb_early_handoff+0x7d0/0x7f4
[54580.153983] LR is at start_unlink_async+0x20/0x2c
[54580.158697] pc : [<c020837c>]    lr : [<c020c014>] psr: 00000193
[54580.158697] sp : c03efd98  ip : ef2735d0  fp : c03efda4
[54580.170194] r10: 60000193  r9 : 00000006  r8 : c03013ec
[54580.175427] r7 : 000031ac  r6 : d77d6a38  r5 : 00000001  r4 : 00000ef4
[54580.181965] r3 : ee817c00  r2 : ef2de8c0  r1 : ee804600  r0 : ef273500
[54580.188504] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM 
Segment kernel
[54580.195912] Control: 10c5387d  Table: 2cb6c019  DAC: 00000015
[54580.201666] Process swapper (pid: 0, stack limit = 0xc03ee230)
[54580.207509] Stack: (0xc03efd98 to 0xc03f0000)
[54580.211874] 
fd80:                                                       c03efdbc 
c03efda8
[54580.220068] fda0: c020c014 c020874c ef2735d0 ef273500 c03efdd4 
c03efdc0 c020c0e0 c020c000
[54580.228262] fdc0: d7860e21 00000000 c03efe34 c03efdd8 c020949c 
c020c02c c03efe04 ef273558
[54580.236456] fde0: c0151cf4 c0150578 ef273500 00000000 d7860e21 
000031ac d7860e21 000031ac
[54580.244650] fe00: c003ad54 00000220 00000000 ef273558 c03ffab8 
c03ffab8 00000000 00000003
[54580.252844] fe20: c03ffa88 c03ffa88 c03efe54 c03efe38 c003af08 
c0209428 c0e33044 00000010
[54580.261038] fe40: d785ff4c 000031ac c03efeb4 c03efe58 c003b658 
c003aec0 00000000 00000000
[54580.269232] fe60: d785ff4c 000031ac d785ff4c 000031ac d785ff4c 
000031ac ffffffff 7fffffff
[54580.277426] fe80: d785ff4c 000031ac 00000000 c0412240 c0406400 
ef007cc0 c0e33044 00000010
[54580.285621] fea0: c03ee000 c03f60c8 c03efecc c03efeb8 c0222558 
c003b574 c0222514 ef0048c0
[54580.293815] fec0: c03efef4 c03efed0 c006a5b4 c0222520 c006a550 
00000010 00000010 00000000
[54580.302011] fee0: c03eff50 00000001 c03eff0c c03efef8 c0067450 
c006a55c 0000006e c0406088
[54580.310206] ff00: c03eff2c c03eff10 c000f520 c0067434 00000074 
c0433100 000003ff c0433100
[54580.318401] ff20: c03eff4c c03eff30 c0008554 c000f4f4 c0049954 
60000013 ffffffff c03eff84
[54580.326596] ff40: c03effac c03eff50 c02df7a0 c0008514 ffffffed 
00000000 c0411c48 c001b4e4
[54580.334791] ff60: c03ee000 c0417a87 c0417a87 c03ee000 00000001 
c03ee000 c03f60c8 c03effac
[54580.342986] ff80: c03eff88 c03eff98 c000f700 c0049954 60000013 
ffffffff 00000000 c0e31cc0
[54580.351180] ffa0: c03effbc c03effb0 c02d8700 c0049914 c03efff4 
c03effc0 c03c6a54 c02d86a8
[54580.359374] ffc0: ffffffff ffffffff c03c6544 00000000 00000000 
c03e54b8 10c53c7d c03f6070
[54580.367568] ffe0: c03e54b4 c03fa640 00000000 c03efff8 00008070 
c03c67c0 00000000 00000000
[54580.375757] Backtrace:
[54580.378225] [<c0208740>] (single_unlink_async+0x0/0x74) from 
[<c020c014>] (start_unlink_async+0x20/0x2c)
[54580.387726] [<c020bff4>] (start_unlink_async+0x0/0x2c) from 
[<c020c0e0>] (unlink_empty_async+0xc0/0xcc)
[54580.397134]  r4:ef273500 r3:ef2735d0
[54580.400741] [<c020c020>] (unlink_empty_async+0x0/0xcc) from 
[<c020949c>] (ehci_hrtimer_func+0x80/0xe8)
[54580.410061]  r5:00000000 r4:d7860e21
[54580.413673] [<c020941c>] (ehci_hrtimer_func+0x0/0xe8) from 
[<c003af08>] (__run_hrtimer.isra.20+0x54/0x104)
[54580.423348] [<c003aeb4>] (__run_hrtimer.isra.20+0x0/0x104) from 
[<c003b658>] (hrtimer_interrupt+0xf0/0x288)
[54580.433102]  r5:000031ac r4:d785ff4c
[54580.436715] [<c003b568>] (hrtimer_interrupt+0x0/0x288) from 
[<c0222558>] (armada_370_xp_timer_interrupt+0x44/0x54)
[54580.447086] [<c0222514>] (armada_370_xp_timer_interrupt+0x0/0x54) 
from [<c006a5b4>] (handle_percpu_devid_irq+0x64/0x80)
[54580.457884]  r4:ef0048c0 r3:c0222514
[54580.461497] [<c006a550>] (handle_percpu_devid_irq+0x0/0x80) from 
[<c0067450>] (generic_handle_irq+0x28/0x38)
[54580.471338]  r8:00000001 r7:c03eff50 r6:00000000 r5:00000010 r4:00000010
r3:c006a550
[54580.479258] [<c0067428>] (generic_handle_irq+0x0/0x38) from 
[<c000f520>] (handle_IRQ+0x38/0x8c)
[54580.487970]  r4:c0406088 r3:0000006e
[54580.491578] [<c000f4e8>] (handle_IRQ+0x0/0x8c) from [<c0008554>] 
(armada_370_xp_handle_irq+0x4c/0x54)
[54580.500810]  r6:c0433100 r5:000003ff r4:c0433100 r3:00000074
[54580.506527] [<c0008508>] (armada_370_xp_handle_irq+0x0/0x54) from 
[<c02df7a0>] (__irq_svc+0x40/0x50)
[54580.515674] Exception stack(0xc03eff50 to 0xc03eff98)
[54580.520735] ff40:                                     ffffffed 
00000000 c0411c48 c001b4e4
[54580.528929] ff60: c03ee000 c0417a87 c0417a87 c03ee000 00000001 
c03ee000 c03f60c8 c03effac
[54580.537123] ff80: c03eff88 c03eff98 c000f700 c0049954 60000013 ffffffff
[54580.543747]  r7:c03eff84 r6:ffffffff r5:60000013 r4:c0049954
[54580.549469] [<c0049908>] (cpu_startup_entry+0x0/0xe8) from 
[<c02d8700>] (rest_init+0x64/0x7c)
[54580.558006]  r7:c0e31cc0 r3:00000000
[54580.561618] [<c02d869c>] (rest_init+0x0/0x7c) from [<c03c6a54>] 
(start_kernel+0x2a0/0x2f4)
[54580.569904] [<c03c67b4>] (start_kernel+0x0/0x2f4) from [<00008070>] 
(0x8070)
[54580.576967] Code: eaffffcc c03f6040 c0406068 c0394a20 (c03949f0)
[54580.583077] ---[ end trace 7ff80fa55787f992 ]---
[54580.587702] Kernel panic - not syncing: Fatal exception in interrupt


Didn't have debug symbols enabled (compiling with them now), but both 
decodecode and
gdb seem to track the problem here:

All code
========
    0:   eaffffcc        b       0xffffff38
    4:   c03f6040        eorsgt  r6, pc, r0, asr #32
    8:   c0406068        subgt   r6, r0, r8, rrx
    c:   c0394a20        eorsgt  r4, r9, r0, lsr #20
   10:*  c03949f0        ldrshtgt        r4, [r9], -r0 <-- trapping 
instruction

from gdb with a bit more context:

    0xc020836c <+1984>:  b       0xc02082a4 <quirk_usb_early_handoff+1784>
    0xc0208370 <+1988>:  eorsgt  r6, pc, r0, asr #32
    0xc0208374 <+1992>:  subgt   r6, r0, r8, rrx
    0xc0208378 <+1996>:  eorsgt  r4, r9, r0, lsr #20
    0xc020837c <+2000>:  ldrshtgt        r4, [r9], -r0
    0xc0208380 <+2004>:  eorsgt  r4, r9, r4, asr #20
    0xc0208384 <+2008>:  eorsgt  r4, r9, r0, asr #21
    0xc0208388 <+2012>:  eorsgt  sp, r7, r12, lsl #4
    0xc020838c <+2016>:  mlasgt  r9, r4, r10, r4
    0xc0208390 <+2020>:  eorsgt  r4, r9, r8, ror #20
    0xc0208394 <+2024>:  eorsgt  r4, r9, r4, lsl #22
    0xc0208398 <+2028>:  eorsgt  r4, r9, r12, lsr r11
    0xc020839c <+2032>:  ldrsbtgt        r4, [r9], -r8


The oops is relatively sporadic, perhaps 1-3 times a day.

Would appreciate any help in getting this fixed.

J.
