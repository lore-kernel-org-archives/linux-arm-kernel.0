From: wcohen@redhat.com (William Cohen)
Date: Thu, 28 May 2015 16:41:14 -0400
Subject: Kernel oops on 32-bit arm with syscall with invalid sysno
Message-ID: <55677D6A.1060008@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

When reviewing testsuite failures for systemtap I found that the
32-bit arm kernels (both 4.1.0-rc5 and 3.19.8) were not handling the
libc syscall with invalid sysno in the manner described by
http://www.gnu.org/software/libc/manual/html_node/System-Calls.html.
Rather than returning -1 and setting errno to ENOSYS the invalid
syscall gives segfault and a kernel oops.  Attached is a simple
program that demonstrates the behavior.  On x86_64 it has the expected
behavior, no segemntation value and returns the expected values:

[wcohen at santana ~]$ gcc -g -o invalid_syscall invalid_syscall.c 
[wcohen at santana ~]$ ./invalid_syscall 
rc = -1 (should be -1)
errno = Function not implemented(38) (should be Function not implemented(38))

arm64 behaves like x86_64.  However on 32-bit:

[wcohen at chromebook-f19 ~]$ gcc -g -o invalid_syscall invalid_syscall.c
[wcohen at chromebook-f19 ~]$ ./invalid_syscall 
Segmentation fault

Below is the portion of the 32-arm dmesg output related to the this:


[19943.564212] ------------[ cut here ]------------
[19943.564241] kernel BUG at kernel/auditsc.c:1504!
[19943.564262] Internal error: Oops - BUG: 0 [#9] SMP ARM
[19943.564280] Modules linked in: xt_CHECKSUM tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ebtable_nat ebtable_broute bridge stp llc ebtable_filter ebtables ip6table_mangle ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_mangle iptable_security iptable_raw bnep ses enclosure spi_s3c64xx mwifiex_sdio mwifiex phy_generic exynos_gsc cfg80211 btmrvl_sdio btmrvl v4l2_mem2mem bluetooth rfkill s5p_mfc joydev videobuf2_dma_contig videobuf2_memops videobuf2_core v4l2_common videodev phy_exynos_usb2 media s3c2410_wdt binfmt_misc nfsd [last unloaded: stap_53f7b815314cb289983f89e82ff656a5__5279]
[19943.564609] CPU: 1 PID: 22121 Comm: invalid_syscall Tainted: G      D    O    4.1.0-rc5-00009-gc0ccb46 #11
[19943.564636] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[19943.564657] task: ed9e9700 ti: e4bd2000 task.ti: e4bd2000
[19943.564683] PC is at __audit_syscall_entry+0x44/0x104
[19943.564708] LR is at syscall_trace_enter+0x170/0x190
[19943.564730] pc : [<c00beb68>]    lr : [<c0026678>]    psr: 20000013
sp : e4bd3f70  ip : 00000001  fp : 000086d8
[19943.564760] r10: 00000200  r9 : e4bd2000  r8 : c0024484
[19943.564778] r7 : 000000c5  r6 : 00000000  r5 : 000000c5  r4 : e1c62400
[19943.564797] r3 : bee60cb0  r2 : bee60cb0  r1 : 00000001  r0 : ed9e9700
[19943.564818] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[19943.564839] Control: 30c5387d  Table: 6b852080  DAC: 55555555
[19943.564858] Process invalid_syscall (pid: 22121, stack limit = 0xe4bd2218)
[19943.564877] Stack: (0xe4bd3f70 to 0xe4bd4000)
[19943.564896] 3f60:                                     000000c5 00000001 bee60cb0 e4bd3f90
[19943.564925] 3f80: 000000c5 00000000 000000c5 c0026678 00000001 000000c5 b6f72b50 ffffffff
[19943.564953] 3fa0: 00000000 c0024444 b6f72b50 ffffffff 00000001 bee60cb0 bee60cb0 00000001
[19943.564981] 3fc0: b6f72b50 ffffffff 00000000 000000c5 b6f72b50 00000005 00000005 000086d8
[19943.565010] 3fe0: 000086dd bee60ca4 b6e89ad8 b6ef6aec 20000010 00000001 00000017 0029abc8
[19943.565050] [<c00beb68>] (__audit_syscall_entry) from [<c0026678>] (syscall_trace_enter+0x170/0x190)
[19943.565089] [<c0026678>] (syscall_trace_enter) from [<c0024444>] (__sys_trace+0xc/0x38)
[19943.565121] Code: 1a000002 e594c1d4 e35c0000 0a000000 (e7f001f2) 
[19943.565143] ---[ end trace 768bc3879e5251d5 ]---


-Will Cohen
-------------- next part --------------
A non-text attachment was scrubbed...
Name: invalid_syscall.c
Type: text/x-csrc
Size: 578 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150528/16561f79/attachment.bin>
